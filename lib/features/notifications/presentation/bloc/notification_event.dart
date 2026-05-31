import 'package:equatable/equatable.dart';
import '../../../../shared/models/notification_model.dart';

abstract class NotificationEvent extends Equatable {
  const NotificationEvent();
  @override
  List<Object?> get props => [];
}

class LoadNotifications extends NotificationEvent {}

class MarkNotificationRead extends NotificationEvent {
  final String notificationId;
  const MarkNotificationRead(this.notificationId);
  @override
  List<Object?> get props => [notificationId];
}

class MarkAllNotificationsRead extends NotificationEvent {}

/// Fired when a new notification arrives via WebSocket (foreground delivery).
class NotificationArrived extends NotificationEvent {
  final AppNotification notification;
  const NotificationArrived(this.notification);
  @override
  List<Object?> get props => [notification];
}

/// Lightweight refresh of only the unread count — used on startup for the badge.
class LoadUnreadCount extends NotificationEvent {}
