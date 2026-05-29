import 'dart:async';
import 'dart:io';
import 'package:firebase_messaging/firebase_messaging.dart';
import 'package:flutter_local_notifications/flutter_local_notifications.dart';
import '../network/api_client.dart';
import '../network/api_endpoints.dart';
import '../utils/app_logger.dart';

/// Lightweight payload emitted on every inbound notification the app handles
/// in the foreground — whether it arrives via FCM or WebSocket.
class InboundNotification {
  final String title;
  final String body;
  final Map<String, dynamic> data;

  const InboundNotification({
    required this.title,
    required this.body,
    required this.data,
  });
}

/// Top-level FCM background handler — runs in a separate isolate.
/// Must be a top-level function (not a class method).
/// The OS shows the notification automatically from the FCM payload; no UI
/// work is done here. When the user taps it, `onMessageOpenedApp` fires.
@pragma('vm:entry-point')
Future<void> _firebaseBackgroundHandler(RemoteMessage message) async {
  AppLogger.i('FCM', 'Background message: ${message.messageId}');
}

/// Single source of truth for all notification display and delivery.
///
/// Delivery paths:
///   FOREGROUND  — FCM `onMessage`          → show local notification + emit [notifications]
///   FOREGROUND  — WebSocket `notification:new` → [handleWebSocketNotification] → show + emit
///   BACKGROUND  — FCM data/notification msg → OS displays natively (no code needed)
///   TERMINATED  — FCM data/notification msg → OS displays natively; tap opens app
///
/// Consumers subscribe to [notifications] to react (e.g. increment badge,
/// refresh notification list) without coupling to the display logic.
class PushNotificationService {
  final ApiClient _apiClient;

  PushNotificationService(this._apiClient);

  final _messaging = FirebaseMessaging.instance;
  final _localNotifications = FlutterLocalNotificationsPlugin();

  // Broadcast stream — any number of listeners (NotificationBloc, badge widget, etc.)
  final _notifController = StreamController<InboundNotification>.broadcast();

  /// Stream of notifications that arrived while the app was in the foreground.
  /// Subscribe to this to update badge counts or refresh notification lists.
  Stream<InboundNotification> get notifications => _notifController.stream;

  static const _channel = AndroidNotificationChannel(
    'reminders',
    'Payment Reminders',
    description: 'Notifications for payment reminders from vendors',
    importance: Importance.high,
  );

  // ─── Initialisation ────────────────────────────────────────────────────────

  /// Call once from main() after Firebase.initializeApp().
  Future<void> initialize() async {
    FirebaseMessaging.onBackgroundMessage(_firebaseBackgroundHandler);
    await _setupLocalNotifications();
    await requestPermission();
    _setupFcmHandlers();
    await _registerToken();
  }

  Future<void> requestPermission() async {
    final settings = await _messaging.requestPermission(
      alert: true,
      badge: true,
      sound: true,
      provisional: false,
    );
    AppLogger.i('FCM', 'Permission: ${settings.authorizationStatus}');
  }

  Future<void> _setupLocalNotifications() async {
    await _localNotifications
        .resolvePlatformSpecificImplementation<AndroidFlutterLocalNotificationsPlugin>()
        ?.createNotificationChannel(_channel);

    const android = AndroidInitializationSettings('@mipmap/ic_launcher');
    const ios = DarwinInitializationSettings();
    await _localNotifications.initialize(
      const InitializationSettings(android: android, iOS: ios),
    );

    // iOS: show alert/badge/sound even when app is in foreground
    await _messaging.setForegroundNotificationPresentationOptions(
      alert: true,
      badge: true,
      sound: true,
    );
  }

  // ─── FCM handlers ──────────────────────────────────────────────────────────

  void _setupFcmHandlers() {
    // FOREGROUND: Android doesn't show FCM notifications automatically.
    // We display them via flutter_local_notifications and broadcast to listeners.
    FirebaseMessaging.onMessage.listen((message) {
      AppLogger.i('FCM', 'Foreground: ${message.notification?.title}');
      final n = message.notification;
      if (n == null) return;
      _displayAndBroadcast(
        title: n.title ?? '',
        body: n.body ?? '',
        data: message.data,
        id: message.hashCode,
      );
    });

    // BACKGROUND → FOREGROUND tap: user tapped the OS notification to open app.
    // Broadcast so the app can refresh the notification list / navigate.
    FirebaseMessaging.onMessageOpenedApp.listen((message) {
      AppLogger.i('FCM', 'Tapped from background: ${message.messageId}');
      final n = message.notification;
      if (n == null) return;
      _notifController.add(InboundNotification(
        title: n.title ?? '',
        body: n.body ?? '',
        data: message.data,
      ));
    });

    // TERMINATED → opened via notification: check for an initial message
    // (fires once after app cold-start from a notification tap).
    _messaging.getInitialMessage().then((message) {
      if (message == null) return;
      AppLogger.i('FCM', 'Cold-start from notification: ${message.messageId}');
      final n = message.notification;
      if (n == null) return;
      _notifController.add(InboundNotification(
        title: n.title ?? '',
        body: n.body ?? '',
        data: message.data,
      ));
    });

    // Token refresh: re-register with backend when FCM rotates the token.
    _messaging.onTokenRefresh.listen(_registerTokenString);
  }

  // ─── WebSocket bridge ──────────────────────────────────────────────────────

  /// Called by [LedgerSocketService.onNotification] when a `notification:new`
  /// WebSocket event arrives. This is the foreground real-time path.
  ///
  /// [raw] shape: { id, type, title, body, data, createdAt }
  void handleWebSocketNotification(Map<String, dynamic> raw) {
    final title = raw['title'] as String? ?? '';
    final body = raw['body'] as String? ?? '';
    final data = (raw['data'] as Map?)?.cast<String, dynamic>() ?? {};
    AppLogger.i('FCM', 'WS foreground notification: $title');
    _displayAndBroadcast(
      title: title,
      body: body,
      data: data,
      // Use the server-assigned id as the local notification id (hash it to int)
      id: (raw['id'] as String? ?? '').hashCode,
    );
  }

  // ─── Shared display + broadcast ────────────────────────────────────────────

  void _displayAndBroadcast({
    required String title,
    required String body,
    required Map<String, dynamic> data,
    required int id,
  }) {
    // Show OS notification
    _localNotifications.show(
      id,
      title,
      body,
      NotificationDetails(
        android: AndroidNotificationDetails(
          _channel.id,
          _channel.name,
          channelDescription: _channel.description,
          importance: Importance.high,
          priority: Priority.high,
          icon: '@mipmap/ic_launcher',
        ),
        iOS: const DarwinNotificationDetails(badgeNumber: 1),
      ),
    );

    // Broadcast to all subscribers (NotificationBloc, badge widgets, etc.)
    _notifController.add(InboundNotification(title: title, body: body, data: data));
  }

  // ─── Device token management ───────────────────────────────────────────────

  Future<void> _registerToken() async {
    try {
      final token = await _messaging.getToken();
      if (token == null) {
        AppLogger.w('FCM', 'No token — permission denied or simulator');
        return;
      }
      await _registerTokenString(token);
    } catch (e) {
      AppLogger.e('FCM', 'Failed to get FCM token: $e');
    }
  }

  Future<void> _registerTokenString(String token) async {
    try {
      final platform = Platform.isIOS ? 'ios' : 'android';
      await _apiClient.post<void>(
        ApiEndpoints.registerDevice,
        data: {'token': token, 'platform': platform},
      );
      AppLogger.i('FCM', 'Device token registered ($platform)');
    } catch (e) {
      AppLogger.w('FCM', 'Token registration failed (will retry next launch): $e');
    }
  }

  /// Call on logout to remove the device token from the backend.
  Future<void> unregisterToken() async {
    try {
      final token = await _messaging.getToken();
      if (token == null) return;
      await _apiClient.delete<void>(
        ApiEndpoints.registerDevice,
        data: {'token': token},
      );
      AppLogger.i('FCM', 'Device token unregistered');
    } catch (e) {
      AppLogger.w('FCM', 'Unregister failed: $e');
    }
  }

  void dispose() {
    _notifController.close();
  }
}
