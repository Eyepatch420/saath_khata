import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import '../../../../core/constants/app_colors.dart';
import '../../../../core/constants/app_typography.dart';
import '../../../../core/di/injection.dart';
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
      backgroundColor: AppColors.background,
      appBar: AppBar(title: Text(l10n.appointments)),
      body: BlocBuilder<BookingBloc, BookingState>(
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
                  padding: const EdgeInsets.all(16),
                  itemCount: state.bookings.length,
                  separatorBuilder: (context, index) => const SizedBox(height: 12),
                  itemBuilder: (context, index) => _BookingCard(booking: state.bookings[index]),
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
    final now = DateTime.now();
    final days = List.generate(7, (i) => now.add(Duration(days: i - 1)));

    return Container(
      color: AppColors.surface,
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
                      _weekday(day.weekday),
                      style: AppTypography.bodySmall.copyWith(
                        color: isSelected ? Colors.white : AppColors.textHint,
                        fontSize: 11,
                      ),
                    ),
                    const SizedBox(height: 4),
                    Text(
                      '${day.day}',
                      style: AppTypography.labelLarge.copyWith(
                        color: isSelected ? Colors.white : AppColors.textPrimary,
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

  String _weekday(int w) => ['Mon', 'Tue', 'Wed', 'Thu', 'Fri', 'Sat', 'Sun'][w - 1];
}

class _BookingCard extends StatelessWidget {
  final BookingModel booking;
  const _BookingCard({required this.booking});

  @override
  Widget build(BuildContext context) {
    final statusColor = _statusColor(booking.status);

    return Container(
      padding: const EdgeInsets.all(16),
      decoration: BoxDecoration(
        color: AppColors.surface,
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
          _StatusBadge(status: booking.status),
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

class _StatusBadge extends StatelessWidget {
  final BookingStatus status;
  const _StatusBadge({required this.status});

  @override
  Widget build(BuildContext context) {
    final (label, color) = switch (status) {
      BookingStatus.confirmed => ('Confirmed', AppColors.success),
      BookingStatus.pending => ('Pending', AppColors.warning),
      BookingStatus.cancelled => ('Cancelled', AppColors.error),
      BookingStatus.completed => ('Done', AppColors.primary),
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
