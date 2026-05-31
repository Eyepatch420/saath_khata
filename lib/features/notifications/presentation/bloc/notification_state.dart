import 'package:equatable/equatable.dart';
import '../../../../shared/models/notification_model.dart';

abstract class NotificationState extends Equatable {
  const NotificationState();
  @override
  List<Object?> get props => [];
}

class NotificationInitial extends NotificationState {}

class NotificationLoading extends NotificationState {}

class NotificationLoaded extends NotificationState {
  final List<AppNotification> notifications;
  final int unreadCount;

  const NotificationLoaded({required this.notifications, required this.unreadCount});

  NotificationLoaded copyWith({
    List<AppNotification>? notifications,
    int? unreadCount,
  }) =>
      NotificationLoaded(
        notifications: notifications ?? this.notifications,
        unreadCount: unreadCount ?? this.unreadCount,
      );

  @override
  List<Object?> get props => [notifications, unreadCount];
}

class NotificationError extends NotificationState {
  final String message;
  const NotificationError(this.message);
  @override
  List<Object?> get props => [message];
}
