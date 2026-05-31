import 'dart:async';
import 'package:socket_io_client/socket_io_client.dart' as io;
import '../network/api_endpoints.dart';
import '../utils/app_logger.dart';

/// Manages a single Socket.IO connection for real-time ledger updates.
/// One instance per app session — registered as a lazy singleton in DI.
class LedgerSocketService {
  static const _m = 'LedgerWS';

  io.Socket? _socket;
  bool _connected = false;

  // Broadcast stream of raw 'notification:new' payloads from the server.
  // PushNotificationService subscribes to this to parse and deliver notifications.
  final _notifController =
      StreamController<Map<String, dynamic>>.broadcast();
  Stream<Map<String, dynamic>> get notificationStream =>
      _notifController.stream;

  static String get _socketUrl =>
      // Strip /api/v1 — socket.io runs at the root of the HTTP server
      ApiEndpoints.baseUrl.replaceFirst('/api/v1', '');

  /// Connect to the WebSocket server using the user's access token.
  void connect(String accessToken) {
    if (_connected) return;

    AppLogger.i(_m, 'Connecting to $_socketUrl...');

    _socket = io.io(
      _socketUrl,
      io.OptionBuilder()
          .setTransports(['websocket'])
          .setAuth({'token': accessToken})
          .disableAutoConnect()
          .enableReconnection()
          .setReconnectionAttempts(5)
          .setReconnectionDelay(2000)
          .build(),
    );

    _socket!
      ..onConnect((_) {
        _connected = true;
        AppLogger.i(_m, 'Connected');
      })
      ..on('notification:new', (raw) {
        if (raw is Map<String, dynamic>) {
          AppLogger.v(_m, 'Received notification:new');
          _notifController.add(raw);
        }
      })
      ..onDisconnect((reason) {
        _connected = false;
        AppLogger.w(_m, 'Disconnected: $reason');
      })
      ..onConnectError((err) => AppLogger.e(_m, 'Connect error', err))
      ..onError((err) => AppLogger.e(_m, 'Socket error', err))
      ..connect();
  }

  /// Join a ledger room so this socket receives updates for that link.
  void joinLedger(String linkId) {
    AppLogger.i(_m, 'Joining room link:$linkId');
    _socket?.emit('ledger:join', {'linkId': linkId});
  }

  /// Leave a ledger room (called when the ledger screen is disposed).
  void leaveLedger(String linkId) {
    AppLogger.i(_m, 'Leaving room link:$linkId');
    _socket?.emit('ledger:leave', {'linkId': linkId});
  }

  /// Listen for a new entry being added to the ledger.
  /// Returns a callback handle — call `off('ledger:entry_added', handle)` to remove.
  void onEntryAdded(void Function(Map<String, dynamic> data) handler) {
    _socket?.on('ledger:entry_added', (raw) {
      AppLogger.v(_m, 'Received ledger:entry_added');
      if (raw is Map<String, dynamic>) handler(raw);
    });
  }

  /// Listen for an existing entry being updated (confirm / dispute).
  void onEntryUpdated(void Function(Map<String, dynamic> data) handler) {
    _socket?.on('ledger:entry_updated', (raw) {
      AppLogger.v(_m, 'Received ledger:entry_updated');
      if (raw is Map<String, dynamic>) handler(raw);
    });
  }

  /// Remove all listeners for a given event (call on screen dispose).
  void off(String event) {
    _socket?.off(event);
  }

  /// Disconnect — call on logout.
  void disconnect() {
    AppLogger.i(_m, 'Disconnecting');
    _socket?.disconnect();
    _socket = null;
    _connected = false;
  }

  void dispose() {
    _notifController.close();
    disconnect();
  }

  bool get isConnected => _connected;
}
