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

NotificationType _notifTypeFromJson(String v) {
  const map = {
    'entry_added': NotificationType.entryAdded,
    'entry_confirmed': NotificationType.entryConfirmed,
    'entry_disputed': NotificationType.entryDisputed,
    'payment_received': NotificationType.paymentReceived,
    'booking_confirmed': NotificationType.bookingConfirmed,
    'booking_cancelled': NotificationType.bookingCancelled,
    'salary_paid': NotificationType.salaryPaid,
    'reminder_due': NotificationType.reminderDue,
    'monthly_summary': NotificationType.monthlySummary,
  };
  return map[v] ?? NotificationType.entryAdded;
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

  factory AppNotification.fromJson(Map<String, dynamic> json) => AppNotification(
        id: json['id'] as String,
        userId: json['userId'] as String,
        type: _notifTypeFromJson(json['type'] as String),
        title: json['title'] as String,
        body: json['body'] as String,
        data: json['data'] != null
            ? Map<String, dynamic>.from(json['data'] as Map)
            : null,
        isRead: json['isRead'] as bool,
        createdAt: DateTime.parse(json['createdAt'] as String),
      );

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
