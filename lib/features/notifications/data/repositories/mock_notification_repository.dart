import '../../domain/repositories/notification_repository.dart';
import '../../../../shared/models/notification_model.dart';

class MockNotificationRepository implements NotificationRepository {
  final List<AppNotification> _notifications = [
    AppNotification(
      id: 'n1',
      userId: 'u1',
      type: NotificationType.entryAdded,
      title: 'New Entry Added',
      body: 'Krishna Dairy added ₹60 for 2L Milk',
      data: {'entryId': 'e1', 'amount': 60.0},
      isRead: false,
      createdAt: DateTime.now().subtract(const Duration(minutes: 30)),
    ),
    AppNotification(
      id: 'n2',
      userId: 'u1',
      type: NotificationType.entryConfirmed,
      title: 'Entry Confirmed',
      body: 'Ramesh Singh confirmed the ₹500 payment entry',
      data: {'entryId': 'e3', 'amount': 500.0},
      isRead: false,
      createdAt: DateTime.now().subtract(const Duration(hours: 2)),
    ),
    AppNotification(
      id: 'n3',
      userId: 'u1',
      type: NotificationType.paymentReceived,
      title: 'Payment Received',
      body: 'Anjali Sharma paid ₹1,200 via UPI',
      data: {'transactionId': 'txn1', 'amount': 1200.0},
      isRead: true,
      createdAt: DateTime.now().subtract(const Duration(hours: 5)),
    ),
    AppNotification(
      id: 'n4',
      userId: 'u1',
      type: NotificationType.entryDisputed,
      title: 'Entry Disputed',
      body: 'Sujeet Kumar disputed the ₹45 milk entry',
      data: {'entryId': 'e5', 'amount': 45.0},
      isRead: true,
      createdAt: DateTime.now().subtract(const Duration(days: 1)),
    ),
    AppNotification(
      id: 'n5',
      userId: 'u1',
      type: NotificationType.reminderDue,
      title: 'Outstanding Dues Reminder',
      body: 'You have ₹3,750 outstanding with 3 vendors',
      data: {'totalDue': 3750.0},
      isRead: true,
      createdAt: DateTime.now().subtract(const Duration(days: 1, hours: 3)),
    ),
    AppNotification(
      id: 'n6',
      userId: 'u1',
      type: NotificationType.monthlySummary,
      title: 'April Monthly Summary',
      body: 'Total sales ₹1,12,000 | Collected ₹95,000 | Outstanding ₹17,000',
      data: {'month': 'April', 'totalSales': 112000.0},
      isRead: true,
      createdAt: DateTime.now().subtract(const Duration(days: 3)),
    ),
  ];

  @override
  Future<List<AppNotification>> getNotifications() async {
    await Future.delayed(const Duration(milliseconds: 500));
    return List.from(_notifications)
      ..sort((a, b) => b.createdAt.compareTo(a.createdAt));
  }

  @override
  Future<void> markAsRead(String notificationId) async {
    await Future.delayed(const Duration(milliseconds: 200));
    final index = _notifications.indexWhere((n) => n.id == notificationId);
    if (index != -1) {
      _notifications[index] = _notifications[index].copyWith(isRead: true);
    }
  }

  @override
  Future<void> markAllAsRead() async {
    await Future.delayed(const Duration(milliseconds: 300));
    for (int i = 0; i < _notifications.length; i++) {
      _notifications[i] = _notifications[i].copyWith(isRead: true);
    }
  }

  @override
  Future<int> getUnreadCount() async {
    await Future.delayed(const Duration(milliseconds: 100));
    return _notifications.where((n) => !n.isRead).length;
  }
}
