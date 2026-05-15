import 'package:flutter_bloc/flutter_bloc.dart';
import '../../domain/repositories/notification_repository.dart';
import 'notification_event.dart';
import 'notification_state.dart';

class NotificationBloc extends Bloc<NotificationEvent, NotificationState> {
  final NotificationRepository _repository;

  NotificationBloc(this._repository) : super(NotificationInitial()) {
    on<LoadNotifications>(_onLoad);
    on<MarkNotificationRead>(_onMarkRead);
    on<MarkAllNotificationsRead>(_onMarkAllRead);
  }

  Future<void> _onLoad(LoadNotifications event, Emitter<NotificationState> emit) async {
    emit(NotificationLoading());
    try {
      final notifications = await _repository.getNotifications();
      final unread = notifications.where((n) => !n.isRead).length;
      emit(NotificationLoaded(notifications: notifications, unreadCount: unread));
    } catch (_) {
      emit(const NotificationError('Failed to load notifications'));
    }
  }

  Future<void> _onMarkRead(MarkNotificationRead event, Emitter<NotificationState> emit) async {
    final current = state;
    if (current is! NotificationLoaded) return;
    await _repository.markAsRead(event.notificationId);
    final updated = current.notifications
        .map((n) => n.id == event.notificationId ? n.copyWith(isRead: true) : n)
        .toList();
    emit(NotificationLoaded(
      notifications: updated,
      unreadCount: updated.where((n) => !n.isRead).length,
    ));
  }

  Future<void> _onMarkAllRead(MarkAllNotificationsRead event, Emitter<NotificationState> emit) async {
    final current = state;
    if (current is! NotificationLoaded) return;
    await _repository.markAllAsRead();
    final updated = current.notifications.map((n) => n.copyWith(isRead: true)).toList();
    emit(NotificationLoaded(notifications: updated, unreadCount: 0));
  }
}
