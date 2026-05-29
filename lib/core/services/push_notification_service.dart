import 'dart:async';
import '../utils/app_logger.dart';

/// Lightweight payload emitted on every inbound notification the app handles
/// in the foreground — whether it arrives via WebSocket or any future push path.
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

/// Notification service that handles foreground notifications via WebSocket.
///
/// Firebase / FCM is not wired up yet (no google-services.json). When FCM is
/// added, re-introduce firebase_messaging + flutter_local_notifications here.
class PushNotificationService {
  final _notifController = StreamController<InboundNotification>.broadcast();

  /// Stream of notifications that arrived while the app was in the foreground.
  Stream<InboundNotification> get notifications => _notifController.stream;

  Future<void> initialize() async {
    AppLogger.i('PushNotification', 'Service initialised (WebSocket-only mode)');
  }

  /// Called by [LedgerSocketService] when a `notification:new` WebSocket event
  /// arrives. This is the foreground real-time notification path.
  ///
  /// [raw] shape: { id, type, title, body, data, createdAt }
  void handleWebSocketNotification(Map<String, dynamic> raw) {
    final title = raw['title'] as String? ?? '';
    final body = raw['body'] as String? ?? '';
    final data = (raw['data'] as Map?)?.cast<String, dynamic>() ?? {};
    AppLogger.i('PushNotification', 'WebSocket foreground notification: $title');
    _notifController.add(InboundNotification(title: title, body: body, data: data));
  }

  void dispose() {
    _notifController.close();
  }
}
