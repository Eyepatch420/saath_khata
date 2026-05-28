import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import '../../../../core/constants/app_colors.dart';
import '../../../../core/constants/app_typography.dart';
import '../../../../core/di/injection.dart';
import 'package:intl/intl.dart';
import '../../../../l10n/app_localizations.dart';
import '../../../../shared/models/booking_model.dart';
import '../../../../shared/widgets/empty_state_widget.dart';
import '../../../../shared/widgets/error_state_widget.dart';
import '../bloc/booking_bloc.dart';
import '../bloc/booking_event.dart';
import '../bloc/booking_state.dart';

class VendorBookingsScreen extends StatelessWidget {
  const VendorBookingsScreen({super.key});

  @override
  Widget build(BuildContext context) {
    return BlocProvider(
      create: (context) => BookingBloc(getIt())..add(LoadVendorBookings(DateTime.now())),
      child: const _VendorBookingsView(),
    );
  }
}

class _VendorBookingsView extends StatelessWidget {
  const _VendorBookingsView();

  @override
  Widget build(BuildContext context) {
    final l10n = AppLocalizations.of(context)!;
    return Scaffold(
      appBar: AppBar(title: Text(l10n.appointments)),
      body: BlocConsumer<BookingBloc, BookingState>(
        listener: (context, state) {
          if (state is BookingActionError) {
            ScaffoldMessenger.of(context).showSnackBar(
              SnackBar(
                content: Text(state.message),
                backgroundColor: AppColors.error,
              ),
            );
          }
        },
        builder: (context, state) {
          if (state is BookingLoading) {
            return const Center(child: CircularProgressIndicator());
          }
          if (state is BookingError) {
            return ErrorStateWidget(
              message: state.message,
              onRetry: () => context.read<BookingBloc>().add(LoadVendorBookings(DateTime.now())),
            );
          }
          if (state is BookingLoaded) {
            return _BookingsContent(state: state);
          }
          if (state is BookingActionError) {
            // Show list with reverted bookings while error snackbar shows
            return _BookingsContent(
              state: BookingLoaded(
                bookings: state.bookings,
                selectedDate: state.selectedDate,
              ),
            );
          }
          return const SizedBox();
        },
      ),
    );
  }
}

class _BookingsContent extends StatelessWidget {
  final BookingLoaded state;
  const _BookingsContent({required this.state});

  @override
  Widget build(BuildContext context) {
    final l10n = AppLocalizations.of(context)!;
    return Column(
      children: [
        _DateSelector(selected: state.selectedDate),
        Expanded(
          child: state.bookings.isEmpty
              ? EmptyStateWidget(
                  icon: Icons.event_available_rounded,
                  title: l10n.noBookingsToday,
                  subtitle: l10n.noBookingsTodaySubtitle,
                )
              : ListView.separated(
                  padding: EdgeInsets.fromLTRB(16, 16, 16, MediaQuery.of(context).viewPadding.bottom + 96),
                  itemCount: state.bookings.length,
                  separatorBuilder: (context, index) => const SizedBox(height: 12),
                  itemBuilder: (context, index) =>
                      _BookingCard(booking: state.bookings[index]),
                ),
        ),
      ],
    );
  }
}

class _DateSelector extends StatelessWidget {
  final DateTime selected;
  const _DateSelector({required this.selected});

  @override
  Widget build(BuildContext context) {
    final locale = Localizations.localeOf(context).toString();
    final now = DateTime.now();
    final days = List.generate(7, (i) => now.add(Duration(days: i - 1)));

    return Container(
      color: Theme.of(context).colorScheme.surface,
      padding: const EdgeInsets.symmetric(vertical: 12),
      child: SingleChildScrollView(
        scrollDirection: Axis.horizontal,
        padding: const EdgeInsets.symmetric(horizontal: 16),
        child: Row(
          children: days.map((day) {
            final isSelected = _isSameDay(day, selected);
            final isToday = _isSameDay(day, now);
            return GestureDetector(
              onTap: () => context.read<BookingBloc>().add(SelectBookingDate(day)),
              child: Container(
                margin: const EdgeInsets.only(right: 8),
                padding: const EdgeInsets.symmetric(horizontal: 14, vertical: 10),
                decoration: BoxDecoration(
                  color: isSelected ? AppColors.primary : Colors.transparent,
                  borderRadius: BorderRadius.circular(12),
                  border: isToday && !isSelected
                      ? Border.all(color: AppColors.primary, width: 1.5)
                      : null,
                ),
                child: Column(
                  mainAxisSize: MainAxisSize.min,
                  children: [
                    Text(
                      DateFormat('E', locale).format(day),
                      style: AppTypography.bodySmall.copyWith(
                        color: isSelected ? Colors.white : AppColors.textHint,
                        fontSize: 11,
                      ),
                    ),
                    const SizedBox(height: 4),
                    Text(
                      '${day.day}',
                      style: AppTypography.labelLarge.copyWith(
                        color: isSelected
                            ? Colors.white
                            : Theme.of(context).colorScheme.onSurface,
                      ),
                    ),
                  ],
                ),
              ),
            );
          }).toList(),
        ),
      ),
    );
  }

  bool _isSameDay(DateTime a, DateTime b) =>
      a.year == b.year && a.month == b.month && a.day == b.day;
}

class _BookingCard extends StatelessWidget {
  final BookingModel booking;
  const _BookingCard({required this.booking});

  @override
  Widget build(BuildContext context) {
    final statusColor = _statusColor(booking.status);
    final isActionable = booking.status == BookingStatus.pending ||
        booking.status == BookingStatus.confirmed;

    return GestureDetector(
      onTap: isActionable ? () => _showActionSheet(context, booking) : null,
      child: Container(
        padding: const EdgeInsets.all(16),
        decoration: BoxDecoration(
          color: Theme.of(context).colorScheme.surface,
          borderRadius: BorderRadius.circular(16),
          border: Border(left: BorderSide(color: statusColor, width: 4)),
        ),
        child: Row(
          children: [
            Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Text(booking.startTime, style: AppTypography.h3.copyWith(fontSize: 16)),
                Text(
                  '${DateTime.parse(booking.date).day}/${DateTime.parse(booking.date).month}',
                  style: AppTypography.bodySmall.copyWith(color: AppColors.textHint),
                ),
              ],
            ),
            const SizedBox(width: 16),
            Container(width: 1, height: 44, color: AppColors.divider),
            const SizedBox(width: 16),
            Expanded(
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  Text(booking.customerName, style: AppTypography.labelLarge),
                  if (booking.serviceType != null)
                    Text(booking.serviceType!, style: AppTypography.bodySmall),
                  if (booking.notes != null && booking.notes!.isNotEmpty)
                    Text(
                      booking.notes!,
                      style: AppTypography.bodySmall.copyWith(color: AppColors.textHint),
                      maxLines: 1,
                      overflow: TextOverflow.ellipsis,
                    ),
                ],
              ),
            ),
            Row(
              mainAxisSize: MainAxisSize.min,
              children: [
                _StatusBadge(status: booking.status),
                if (isActionable) ...[
                  const SizedBox(width: 4),
                  Icon(
                    Icons.chevron_right_rounded,
                    size: 18,
                    color: AppColors.textHint,
                  ),
                ],
              ],
            ),
          ],
        ),
      ),
    );
  }

  void _showActionSheet(BuildContext context, BookingModel booking) {
    final l10n = AppLocalizations.of(context)!;
    final bloc = context.read<BookingBloc>();
    final dateStr =
        '${DateTime.parse(booking.date).day}/${DateTime.parse(booking.date).month}';

    showModalBottomSheet(
      context: context,
      useRootNavigator: true,
      shape: const RoundedRectangleBorder(
        borderRadius: BorderRadius.vertical(top: Radius.circular(20)),
      ),
      builder: (ctx) => SafeArea(
        child: Padding(
          padding: const EdgeInsets.fromLTRB(16, 12, 16, 8),
          child: Column(
            mainAxisSize: MainAxisSize.min,
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              Center(
                child: Container(
                  width: 40,
                  height: 4,
                  decoration: BoxDecoration(
                    color: AppColors.divider,
                    borderRadius: BorderRadius.circular(2),
                  ),
                ),
              ),
              const SizedBox(height: 16),
              Text(
                booking.customerName,
                style: AppTypography.h3,
              ),
              Text(
                '$dateStr  •  ${booking.startTime}'
                '${booking.serviceType != null ? '  •  ${booking.serviceType}' : ''}',
                style: AppTypography.bodySmall.copyWith(color: AppColors.textSecondary),
              ),
              const SizedBox(height: 20),
              if (booking.status == BookingStatus.pending) ...[
                _ActionTile(
                  icon: Icons.check_circle_outline_rounded,
                  label: l10n.confirmBooking,
                  color: AppColors.success,
                  onTap: () {
                    Navigator.pop(ctx);
                    bloc.add(UpdateBookingStatus(
                      bookingId: booking.id,
                      status: BookingStatus.confirmed,
                    ));
                  },
                ),
                const SizedBox(height: 8),
              ],
              if (booking.status == BookingStatus.confirmed) ...[
                _ActionTile(
                  icon: Icons.task_alt_rounded,
                  label: l10n.markComplete,
                  color: AppColors.primary,
                  onTap: () {
                    Navigator.pop(ctx);
                    bloc.add(UpdateBookingStatus(
                      bookingId: booking.id,
                      status: BookingStatus.completed,
                    ));
                  },
                ),
                const SizedBox(height: 8),
              ],
              _ActionTile(
                icon: Icons.cancel_outlined,
                label: l10n.cancelBooking,
                color: AppColors.error,
                onTap: () {
                  Navigator.pop(ctx);
                  _confirmCancel(context, bloc, booking, dateStr, l10n);
                },
              ),
              const SizedBox(height: 8),
            ],
          ),
        ),
      ),
    );
  }

  void _confirmCancel(
    BuildContext context,
    BookingBloc bloc,
    BookingModel booking,
    String dateStr,
    AppLocalizations l10n,
  ) {
    showDialog(
      context: context,
      builder: (ctx) => AlertDialog(
        title: Text(l10n.cancelAppointmentTitle),
        content: Text(
          l10n.cancelAppointmentMessage(dateStr, booking.startTime),
        ),
        actions: [
          TextButton(
            onPressed: () => Navigator.pop(ctx),
            child: Text(l10n.keepBooking),
          ),
          TextButton(
            onPressed: () {
              Navigator.pop(ctx);
              bloc.add(UpdateBookingStatus(
                bookingId: booking.id,
                status: BookingStatus.cancelled,
              ));
            },
            style: TextButton.styleFrom(foregroundColor: AppColors.error),
            child: Text(l10n.cancelBooking),
          ),
        ],
      ),
    );
  }

  Color _statusColor(BookingStatus s) {
    switch (s) {
      case BookingStatus.confirmed:
        return AppColors.success;
      case BookingStatus.pending:
        return AppColors.warning;
      case BookingStatus.cancelled:
        return AppColors.error;
      case BookingStatus.completed:
        return AppColors.primary;
    }
  }
}

class _ActionTile extends StatelessWidget {
  final IconData icon;
  final String label;
  final Color color;
  final VoidCallback onTap;

  const _ActionTile({
    required this.icon,
    required this.label,
    required this.color,
    required this.onTap,
  });

  @override
  Widget build(BuildContext context) {
    return InkWell(
      onTap: onTap,
      borderRadius: BorderRadius.circular(12),
      child: Container(
        padding: const EdgeInsets.symmetric(horizontal: 16, vertical: 14),
        decoration: BoxDecoration(
          color: color.withValues(alpha: 0.08),
          borderRadius: BorderRadius.circular(12),
        ),
        child: Row(
          children: [
            Icon(icon, color: color, size: 22),
            const SizedBox(width: 12),
            Text(
              label,
              style: AppTypography.labelLarge.copyWith(color: color),
            ),
          ],
        ),
      ),
    );
  }
}

class _StatusBadge extends StatelessWidget {
  final BookingStatus status;
  const _StatusBadge({required this.status});

  @override
  Widget build(BuildContext context) {
    final l10n = AppLocalizations.of(context)!;
    final (label, color) = switch (status) {
      BookingStatus.confirmed => (l10n.bookingStatusConfirmed, AppColors.success),
      BookingStatus.pending => (l10n.bookingStatusPending, AppColors.warning),
      BookingStatus.cancelled => (l10n.bookingStatusCancelled, AppColors.error),
      BookingStatus.completed => (l10n.bookingStatusDone, AppColors.primary),
    };

    return Container(
      padding: const EdgeInsets.symmetric(horizontal: 10, vertical: 4),
      decoration: BoxDecoration(
        color: color.withValues(alpha: 0.1),
        borderRadius: BorderRadius.circular(20),
      ),
      child: Text(
        label,
        style: AppTypography.bodySmall.copyWith(
          color: color,
          fontWeight: FontWeight.w600,
          fontSize: 11,
        ),
      ),
    );
  }
}
