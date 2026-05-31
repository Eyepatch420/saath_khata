import 'dart:async';
import '../utils/app_logger.dart';
import 'ledger_socket_service.dart';
import '../../shared/models/notification_model.dart';

/// Delivers foreground notifications to the app via WebSocket.
///
/// Architecture:
///   LedgerSocketService.notificationStream (raw Map)
///     → PushNotificationService (parses to AppNotification)
///     → notifications stream (AppNotification)
///     → NotificationBloc subscribes (prepends to list, increments badge)
///
/// Firebase / FCM (background push) is handled server-side — the backend sends
/// FCM to registered device tokens. To activate background push:
///   1. Add firebase_messaging + flutter_local_notifications to pubspec.yaml
///   2. Add google-services.json (Android) / GoogleService-Info.plist (iOS)
///   3. Replace the `initialize()` body below with Firebase initialization
///   4. Register device token via POST /api/v1/devices/token after login
class PushNotificationService {
  static const _m = 'PushNotif';

  final LedgerSocketService _socketService;
  StreamSubscription<Map<String, dynamic>>? _socketSub;
  final _notifController = StreamController<AppNotification>.broadcast();

  PushNotificationService(this._socketService);

  /// Stream of AppNotification objects that arrived while the app was in the
  /// foreground via WebSocket. NotificationBloc subscribes to this.
  Stream<AppNotification> get notifications => _notifController.stream;

  /// Call once after the socket connects (or at app startup — the broadcast
  /// stream simply won't emit until the socket actually delivers events).
  Future<void> initialize() async {
    AppLogger.i(_m, 'Initialising (WebSocket-only mode)');
    _socketSub = _socketService.notificationStream.listen(_handleRaw);

    // ── Firebase placeholder ──────────────────────────────────────────────
    // When firebase_messaging is added:
    //   await Firebase.initializeApp();
    //   final messaging = FirebaseMessaging.instance;
    //   await messaging.requestPermission();
    //   final token = await messaging.getToken();
    //   if (token != null) _registerDeviceToken(token);
    //   FirebaseMessaging.onMessage.listen((message) {
    //     final notif = message.notification;
    //     if (notif != null) { ... parse and add to _notifController ... }
    //   });
    // ─────────────────────────────────────────────────────────────────────
  }

  void _handleRaw(Map<String, dynamic> raw) {
    try {
      // The server emits the exact NotificationResponse shape (camelCase)
      // which matches AppNotification.fromJson() directly.
      final notification = AppNotification.fromJson(raw);
      AppLogger.i(_m, 'Foreground notification: ${notification.title}');
      _notifController.add(notification);
    } catch (e) {
      AppLogger.w(_m, 'Failed to parse notification:new payload: $e');
    }
  }

  void dispose() {
    _socketSub?.cancel();
    _notifController.close();
  }
}
