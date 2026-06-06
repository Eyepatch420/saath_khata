import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:go_router/go_router.dart';
import 'package:intl/intl.dart';
import '../../../../core/constants/app_colors.dart';
import '../../../../core/constants/app_typography.dart';
import '../../../../core/di/injection.dart';
import '../../../../core/router/app_router.dart';
import '../../../../l10n/app_localizations.dart';
import '../../../../shared/models/notification_model.dart';
import '../../../../shared/widgets/empty_state_widget.dart';
import '../../../../shared/widgets/error_state_widget.dart';
import '../bloc/notification_bloc.dart';
import '../bloc/notification_event.dart';
import '../bloc/notification_state.dart';

class NotificationsScreen extends StatelessWidget {
  const NotificationsScreen({super.key});

  @override
  Widget build(BuildContext context) {
    // Use the singleton NotificationBloc from DI so the badge count on dashboards
    // stays in sync with what's shown in this screen.
    return BlocProvider.value(
      value: getIt<NotificationBloc>()..add(LoadNotifications()),
      child: const _NotificationsView(),
    );
  }
}

class _NotificationsView extends StatelessWidget {
  const _NotificationsView();

  @override
  Widget build(BuildContext context) {
    final l10n = AppLocalizations.of(context)!;
    return Scaffold(

      appBar: AppBar(
        title: Text(l10n.notifications),
        actions: [
          BlocBuilder<NotificationBloc, NotificationState>(
            builder: (context, state) {
              if (state is NotificationLoaded && state.unreadCount > 0) {
                return TextButton(
                  onPressed: () =>
                      context.read<NotificationBloc>().add(MarkAllNotificationsRead()),
                  child: Text(
                    l10n.markAllRead,
                    style: AppTypography.bodySmall.copyWith(color: AppColors.primary),
                  ),
                );
              }
              return const SizedBox();
            },
          ),
        ],
      ),
      body: SafeArea(child: BlocBuilder<NotificationBloc, NotificationState>(
        builder: (context, state) {
          if (state is NotificationLoading) {
            return const Center(child: CircularProgressIndicator());
          }
          if (state is NotificationError) {
            return ErrorStateWidget(
              message: state.message,
              onRetry: () =>
                  context.read<NotificationBloc>().add(LoadNotifications()),
            );
          }
          if (state is NotificationLoaded) {
            if (state.notifications.isEmpty) {
              return EmptyStateWidget(
                icon: Icons.notifications_none_rounded,
                title: l10n.noNotificationsTitle,
                subtitle: l10n.noNotificationsSubtitle,
              );
            }
            return _NotificationsList(notifications: state.notifications);
          }
          return const SizedBox();
        },
      ),
      ),
    );
  }
}

class _NotificationsList extends StatelessWidget {
  final List<AppNotification> notifications;
  const _NotificationsList({required this.notifications});

  @override
  Widget build(BuildContext context) {
    final l10n = AppLocalizations.of(context)!;
    final grouped = _groupByDate(notifications, l10n);
    final dates = grouped.keys.toList();

    return ListView.builder(
      padding: const EdgeInsets.symmetric(vertical: 8),
      itemCount: dates.length,
      itemBuilder: (context, index) {
        final dateLabel = dates[index];
        final items = grouped[dateLabel]!;
        return Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Padding(
              padding: const EdgeInsets.symmetric(horizontal: 20, vertical: 8),
              child: Text(
                dateLabel,
                style: AppTypography.bodySmall.copyWith(
                  color: AppColors.textHint,
                  fontWeight: FontWeight.w600,
                ),
              ),
            ),
            ...items.map((n) => _NotificationCard(notification: n)),
          ],
        );
      },
    );
  }

  Map<String, List<AppNotification>> _groupByDate(
      List<AppNotification> notifications, AppLocalizations l10n) {
    final now = DateTime.now();
    final today = DateTime(now.year, now.month, now.day);
    final yesterday = today.subtract(const Duration(days: 1));
    final result = <String, List<AppNotification>>{};

    for (final n in notifications) {
      final nDate = DateTime(n.createdAt.year, n.createdAt.month, n.createdAt.day);
      final String label;
      if (nDate == today) {
        label = l10n.today;
      } else if (nDate == yesterday) {
        label = l10n.yesterday;
      } else {
        label = DateFormat('dd MMM yyyy').format(n.createdAt);
      }
      result.putIfAbsent(label, () => []).add(n);
    }
    return result;
  }
}

class _NotificationCard extends StatelessWidget {
  final AppNotification notification;
  const _NotificationCard({required this.notification});

  void _handleTap(BuildContext context) {
    if (!notification.isRead) {
      context.read<NotificationBloc>().add(MarkNotificationRead(notification.id));
    }
    final data = notification.data;
    switch (notification.type) {
      case NotificationType.linkRequestReceived:
        // Vendor taps → go to approval screen
        final requestId = data?['requestId'] as String?;
        if (requestId != null) {
          context.push(AppRouter.linkRequestDetail, extra: requestId);
        }
      case NotificationType.linkRequestAccepted:
      case NotificationType.linkRequestDeclined:
        // Customer taps → no specific deep-link yet, just mark read
        break;
      default:
        // Ledger/payment notifications — no deep-link for now
        break;
    }
  }

  @override
  Widget build(BuildContext context) {
    return GestureDetector(
      onTap: () => _handleTap(context),
      child: Container(
        margin: const EdgeInsets.symmetric(horizontal: 16, vertical: 4),
        padding: const EdgeInsets.all(16),
        decoration: BoxDecoration(
          color: notification.isRead
              ? Theme.of(context).colorScheme.surface
              : AppColors.primary.withValues(alpha: 0.04),
          borderRadius: BorderRadius.circular(16),
          border: notification.isRead
              ? null
              : Border.all(color: AppColors.primary.withValues(alpha: 0.15)),
        ),
        child: Row(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Container(
              padding: const EdgeInsets.all(10),
              decoration: BoxDecoration(
                color: _iconColor(notification.type).withValues(alpha: 0.12),
                shape: BoxShape.circle,
              ),
              child: Icon(
                _icon(notification.type),
                color: _iconColor(notification.type),
                size: 20,
              ),
            ),
            const SizedBox(width: 12),
            Expanded(
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  Row(
                    children: [
                      Expanded(
                        child: Text(
                          notification.title,
                          style: AppTypography.labelLarge.copyWith(
                            fontWeight: notification.isRead
                                ? FontWeight.w500
                                : FontWeight.bold,
                          ),
                        ),
                      ),
                      if (!notification.isRead)
                        Container(
                          width: 8,
                          height: 8,
                          decoration: const BoxDecoration(
                            color: AppColors.primary,
                            shape: BoxShape.circle,
                          ),
                        ),
                    ],
                  ),
                  const SizedBox(height: 4),
                  Text(
                    notification.body,
                    style: AppTypography.bodySmall.copyWith(
                      color: AppColors.textSecondary,
                      height: 1.4,
                    ),
                  ),
                  const SizedBox(height: 6),
                  Text(
                    _formatTime(notification.createdAt, AppLocalizations.of(context)!),
                    style: AppTypography.bodySmall.copyWith(
                      fontSize: 11,
                      color: AppColors.textHint,
                    ),
                  ),
                ],
              ),
            ),
          ],
        ),
      ),
    );
  }

  IconData _icon(NotificationType type) {
    switch (type) {
      case NotificationType.entryAdded:
        return Icons.add_circle_outline_rounded;
      case NotificationType.entryConfirmed:
        return Icons.check_circle_outline_rounded;
      case NotificationType.entryDisputed:
        return Icons.warning_amber_rounded;
      case NotificationType.paymentReceived:
        return Icons.payments_rounded;
      case NotificationType.salaryPaid:
        return Icons.account_balance_wallet_rounded;
      case NotificationType.bookingConfirmed:
        return Icons.calendar_today_rounded;
      case NotificationType.bookingCancelled:
        return Icons.event_busy_rounded;
      case NotificationType.reminderDue:
        return Icons.notifications_active_rounded;
      case NotificationType.monthlySummary:
        return Icons.bar_chart_rounded;
      case NotificationType.linkRequestReceived:
        return Icons.person_add_rounded;
      case NotificationType.linkRequestAccepted:
        return Icons.handshake_rounded;
      case NotificationType.linkRequestDeclined:
        return Icons.person_remove_rounded;
      case NotificationType.membershipRequested:
        return Icons.upgrade_rounded;
      case NotificationType.membershipChanged:
        return Icons.workspace_premium_rounded;
      case NotificationType.membershipRequestDeclined:
        return Icons.do_not_disturb_on_rounded;
    }
  }

  Color _iconColor(NotificationType type) {
    switch (type) {
      case NotificationType.entryAdded:
        return AppColors.primary;
      case NotificationType.entryConfirmed:
        return AppColors.success;
      case NotificationType.entryDisputed:
        return AppColors.error;
      case NotificationType.paymentReceived:
        return AppColors.success;
      case NotificationType.salaryPaid:
        return AppColors.primary;
      case NotificationType.bookingConfirmed:
        return AppColors.primary;
      case NotificationType.bookingCancelled:
        return AppColors.error;
      case NotificationType.reminderDue:
        return AppColors.warning;
      case NotificationType.monthlySummary:
        return AppColors.secondary;
      case NotificationType.linkRequestReceived:
        return AppColors.primary;
      case NotificationType.linkRequestAccepted:
        return AppColors.success;
      case NotificationType.linkRequestDeclined:
        return AppColors.error;
      case NotificationType.membershipRequested:
        return AppColors.primary;
      case NotificationType.membershipChanged:
        return AppColors.success;
      case NotificationType.membershipRequestDeclined:
        return AppColors.error;
    }
  }

  String _formatTime(DateTime dt, AppLocalizations l10n) {
    final now = DateTime.now();
    final diff = now.difference(dt);
    if (diff.inMinutes < 60) return l10n.minutesAgo(diff.inMinutes);
    if (diff.inHours < 24) return l10n.hoursAgo(diff.inHours);
    return DateFormat('hh:mm a').format(dt);
  }
}
