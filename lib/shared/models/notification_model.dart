import 'package:equatable/equatable.dart';

// Must match backend notification type strings (snake_case):
// entry_added, entry_confirmed, entry_disputed, payment_received,
// booking_confirmed, booking_cancelled, salary_paid, reminder_due, monthly_summary
enum NotificationType {
  entryAdded,
  entryConfirmed,
  entryDisputed,
  paymentReceived,
  bookingConfirmed,
  bookingCancelled,
  salaryPaid,
  reminderDue,
  monthlySummary,
}

class AppNotification extends Equatable {
  final String id;
  final String userId;
  final NotificationType type;
  final String title;
  final String body;
  final Map<String, dynamic>? data;
  final bool isRead;
  final DateTime createdAt;

  const AppNotification({
    required this.id,
    required this.userId,
    required this.type,
    required this.title,
    required this.body,
    this.data,
    required this.isRead,
    required this.createdAt,
  });

  AppNotification copyWith({bool? isRead}) {
    return AppNotification(
      id: id,
      userId: userId,
      type: type,
      title: title,
      body: body,
      data: data,
      isRead: isRead ?? this.isRead,
      createdAt: createdAt,
    );
  }

  @override
  List<Object?> get props => [id, userId, type, title, body, data, isRead, createdAt];
}
