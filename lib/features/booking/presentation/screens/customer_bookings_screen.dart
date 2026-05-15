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

class CustomerBookingsScreen extends StatelessWidget {
  const CustomerBookingsScreen({super.key});

  @override
  Widget build(BuildContext context) {
    return BlocProvider(
      create: (context) => BookingBloc(getIt())..add(LoadCustomerBookings()),
      child: const _CustomerBookingsView(),
    );
  }
}

class _CustomerBookingsView extends StatelessWidget {
  const _CustomerBookingsView();

  @override
  Widget build(BuildContext context) {
    final l10n = AppLocalizations.of(context)!;
    return Scaffold(
      backgroundColor: AppColors.background,
      appBar: AppBar(title: Text(l10n.myAppointments)),
      body: BlocBuilder<BookingBloc, BookingState>(
        builder: (context, state) {
          if (state is BookingLoading) {
            return const Center(child: CircularProgressIndicator());
          }
          if (state is BookingError) {
            return ErrorStateWidget(
              message: state.message,
              onRetry: () => context.read<BookingBloc>().add(LoadCustomerBookings()),
            );
          }
          if (state is BookingLoaded) {
            if (state.bookings.isEmpty) {
              return EmptyStateWidget(
                icon: Icons.calendar_today_rounded,
                title: l10n.noAppointmentsTitle,
                subtitle: l10n.noAppointmentsSubtitle,
              );
            }
            return _BookingsList(bookings: state.bookings);
          }
          return const SizedBox();
        },
      ),
    );
  }
}

class _BookingsList extends StatelessWidget {
  final List<BookingModel> bookings;
  const _BookingsList({required this.bookings});

  @override
  Widget build(BuildContext context) {
    final upcoming = bookings
        .where((b) =>
            b.status != BookingStatus.cancelled && b.status != BookingStatus.completed)
        .toList()
      ..sort((a, b) => a.date.compareTo(b.date));
    final past = bookings
        .where((b) =>
            b.status == BookingStatus.cancelled || b.status == BookingStatus.completed)
        .toList()
      ..sort((a, b) => b.date.compareTo(a.date));

    return ListView(
      padding: const EdgeInsets.all(16),
      children: [
        if (upcoming.isNotEmpty) ...[
          Text('Upcoming', style: AppTypography.labelLarge),
          const SizedBox(height: 12),
          ...upcoming.map((b) => Padding(
                padding: const EdgeInsets.only(bottom: 12),
                child: _CustomerBookingCard(booking: b),
              )),
        ],
        if (past.isNotEmpty) ...[
          const SizedBox(height: 8),
          Text('Past', style: AppTypography.labelLarge.copyWith(color: AppColors.textSecondary)),
          const SizedBox(height: 12),
          ...past.map((b) => Padding(
                padding: const EdgeInsets.only(bottom: 12),
                child: _CustomerBookingCard(booking: b),
              )),
        ],
      ],
    );
  }
}

class _CustomerBookingCard extends StatelessWidget {
  final BookingModel booking;
  const _CustomerBookingCard({required this.booking});

  @override
  Widget build(BuildContext context) {
    final isUpcoming = booking.status == BookingStatus.pending ||
        booking.status == BookingStatus.confirmed;

    return Container(
      padding: const EdgeInsets.all(16),
      decoration: BoxDecoration(
        color: AppColors.surface,
        borderRadius: BorderRadius.circular(16),
        boxShadow: [
          BoxShadow(
            color: Colors.black.withValues(alpha: 0.04),
            blurRadius: 8,
            offset: const Offset(0, 2),
          ),
        ],
      ),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Row(
            children: [
              Container(
                padding: const EdgeInsets.all(10),
                decoration: BoxDecoration(
                  color: AppColors.primary.withValues(alpha: 0.1),
                  borderRadius: BorderRadius.circular(10),
                ),
                child: const Icon(Icons.calendar_today_rounded, color: AppColors.primary, size: 20),
              ),
              const SizedBox(width: 12),
              Expanded(
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    Text(booking.vendorName, style: AppTypography.labelLarge),
                    if (booking.serviceType != null)
                      Text(booking.serviceType!, style: AppTypography.bodySmall),
                  ],
                ),
              ),
              _StatusChip(status: booking.status),
            ],
          ),
          const Divider(height: 20),
          Row(
            children: [
              const Icon(Icons.access_time_rounded, size: 14, color: AppColors.textHint),
              const SizedBox(width: 6),
              Text(
                '${_formatDate(booking.date)} at ${booking.startTime}',
                style: AppTypography.bodySmall,
              ),
            ],
          ),
          if (booking.notes != null && booking.notes!.isNotEmpty) ...[
            const SizedBox(height: 6),
            Row(
              children: [
                const Icon(Icons.notes_rounded, size: 14, color: AppColors.textHint),
                const SizedBox(width: 6),
                Expanded(
                  child: Text(
                    booking.notes!,
                    style: AppTypography.bodySmall.copyWith(color: AppColors.textSecondary),
                    maxLines: 2,
                    overflow: TextOverflow.ellipsis,
                  ),
                ),
              ],
            ),
          ],
          if (isUpcoming) ...[
            const SizedBox(height: 12),
            Align(
              alignment: Alignment.centerRight,
              child: TextButton.icon(
                onPressed: () => _confirmCancel(context, booking),
                icon: const Icon(Icons.cancel_outlined, size: 16),
                label: const Text('Cancel'),
                style: TextButton.styleFrom(
                  foregroundColor: AppColors.error,
                  padding: const EdgeInsets.symmetric(horizontal: 12, vertical: 6),
                ),
              ),
            ),
          ],
        ],
      ),
    );
  }

  void _confirmCancel(BuildContext context, BookingModel booking) {
    showDialog(
      context: context,
      builder: (ctx) => AlertDialog(
        title: const Text('Cancel Appointment?'),
        content: Text('Cancel your appointment on ${_formatDate(booking.date)} at ${booking.startTime}?'),
        actions: [
          TextButton(
            onPressed: () => Navigator.pop(ctx),
            child: const Text('Keep'),
          ),
          TextButton(
            onPressed: () {
              Navigator.pop(ctx);
              context.read<BookingBloc>().add(CancelBooking(booking.id));
            },
            style: TextButton.styleFrom(foregroundColor: AppColors.error),
            child: const Text('Cancel Booking'),
          ),
        ],
      ),
    );
  }

  String _formatDate(String dateStr) {
    final dt = DateTime.parse(dateStr);
    const months = ['Jan', 'Feb', 'Mar', 'Apr', 'May', 'Jun', 'Jul', 'Aug', 'Sep', 'Oct', 'Nov', 'Dec'];
    return '${dt.day} ${months[dt.month - 1]}';
  }
}

class _StatusChip extends StatelessWidget {
  final BookingStatus status;
  const _StatusChip({required this.status});

  @override
  Widget build(BuildContext context) {
    final (label, color) = switch (status) {
      BookingStatus.confirmed => ('Confirmed', AppColors.success),
      BookingStatus.pending => ('Pending', AppColors.warning),
      BookingStatus.cancelled => ('Cancelled', AppColors.error),
      BookingStatus.completed => ('Completed', AppColors.primary),
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
