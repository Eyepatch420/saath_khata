import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:go_router/go_router.dart';
import 'package:intl/intl.dart';
import '../../../../core/constants/app_colors.dart';
import '../../../../shared/widgets/app_toast.dart';
import '../../../../core/constants/app_typography.dart';
import '../../../../core/di/injection.dart';
import '../../../../core/router/app_router.dart';
import '../../../../shared/models/booking_model.dart';
import '../../../../shared/widgets/empty_state_widget.dart';
import '../../../../shared/widgets/error_state_widget.dart';
import '../../../auth/presentation/bloc/auth_bloc.dart';
import '../../../auth/presentation/bloc/auth_state.dart';
import '../bloc/booking_bloc.dart';
import '../bloc/booking_event.dart';
import '../bloc/booking_state.dart';
import '../widgets/booking_confirmation_sheet.dart';

class BookAppointmentScreen extends StatelessWidget {
  final String vendorId;
  final String vendorName;

  const BookAppointmentScreen({
    super.key,
    required this.vendorId,
    required this.vendorName,
  });

  @override
  Widget build(BuildContext context) {
    return BlocProvider(
      create: (_) => BookingBloc(getIt()),
      child: _BookAppointmentBody(vendorId: vendorId, vendorName: vendorName),
    );
  }
}

class _BookAppointmentBody extends StatefulWidget {
  final String vendorId;
  final String vendorName;

  const _BookAppointmentBody({
    required this.vendorId,
    required this.vendorName,
  });

  @override
  State<_BookAppointmentBody> createState() => _BookAppointmentBodyState();
}

class _BookAppointmentBodyState extends State<_BookAppointmentBody> {
  late DateTime _selectedDate;
  static const _daysToShow = 14;

  @override
  void initState() {
    super.initState();
    final now = DateTime.now();
    _selectedDate = DateTime(now.year, now.month, now.day);
    context
        .read<BookingBloc>()
        .add(LoadAvailableSlots(vendorId: widget.vendorId, date: _selectedDate));
  }

  void _selectDate(DateTime date) {
    if (_sameDay(_selectedDate, date)) return;
    setState(() => _selectedDate = date);
    context
        .read<BookingBloc>()
        .add(LoadAvailableSlots(vendorId: widget.vendorId, date: date));
  }

  void _onSlotTapped(AppointmentSlot slot) {
    final authState = context.read<AuthBloc>().state;
    if (authState is! AuthAuthenticated) return;

    showModalBottomSheet<void>(
      context: context,
      isScrollControlled: true,
      backgroundColor: Colors.transparent,
      builder: (_) => BlocProvider.value(
        value: context.read<BookingBloc>(),
        child: BookingConfirmationSheet(
          slot: slot,
          date: _selectedDate,
          vendorId: widget.vendorId,
          vendorName: widget.vendorName,
          customerId: authState.user.id,
          customerName: authState.user.name,
        ),
      ),
    );
  }

  bool _sameDay(DateTime a, DateTime b) =>
      a.year == b.year && a.month == b.month && a.day == b.day;

  @override
  Widget build(BuildContext context) {
    final now = DateTime.now();
    final today = DateTime(now.year, now.month, now.day);
    final dates = List.generate(_daysToShow, (i) => today.add(Duration(days: i)));

    return BlocListener<BookingBloc, BookingState>(
      listenWhen: (_, c) => c is BookingCreated || c is BookingError,
      listener: (context, state) {
        if (state is BookingCreated) {
          AppToast.show(context, 'Booking confirmed!', type: ToastType.success);
          context.go(AppRouter.customerBookings);
        } else if (state is BookingError) {
          AppToast.show(context, state.message, type: ToastType.error);
        }
      },
      child: Scaffold(
        appBar: AppBar(
          title: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              Text(widget.vendorName, style: AppTypography.h3),
              Text(
                'Book an Appointment',
                style: AppTypography.bodySmall
                    .copyWith(color: AppColors.textSecondary),
              ),
            ],
          ),
          titleSpacing: 0,
        ),
        body: SafeArea(child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            _DateStrip(
              dates: dates,
              selectedDate: _selectedDate,
              onDateSelected: _selectDate,
            ),
            const Divider(height: 1),
            Expanded(
              child: BlocBuilder<BookingBloc, BookingState>(
                builder: (context, state) {
                  if (state is BookingLoading) {
                    return const Center(child: CircularProgressIndicator());
                  }
                  if (state is BookingError) {
                    return ErrorStateWidget(
                      message: state.message,
                      onRetry: () => context.read<BookingBloc>().add(
                            LoadAvailableSlots(
                              vendorId: widget.vendorId,
                              date: _selectedDate,
                            ),
                          ),
                    );
                  }
                  if (state is SlotsLoaded) {
                    final available =
                        state.slots.where((s) => s.isAvailable).toList();
                    if (available.isEmpty) {
                      return const EmptyStateWidget(
                        icon: Icons.event_busy_rounded,
                        title: 'No slots available',
                        subtitle: 'Try selecting a different date',
                      );
                    }
                    return _SlotGrid(
                      slots: available,
                      onSlotTapped: _onSlotTapped,
                    );
                  }
                  return const SizedBox.shrink();
                },
              ),
            ),
          ],
        ),
        ),
      ),
    );
  }
}

// ─── Date Strip ───────────────────────────────────────────────────────────────

class _DateStrip extends StatelessWidget {
  final List<DateTime> dates;
  final DateTime selectedDate;
  final ValueChanged<DateTime> onDateSelected;

  const _DateStrip({
    required this.dates,
    required this.selectedDate,
    required this.onDateSelected,
  });

  bool _isSameDay(DateTime a, DateTime b) =>
      a.year == b.year && a.month == b.month && a.day == b.day;

  @override
  Widget build(BuildContext context) {
    final locale = Localizations.localeOf(context).toString();
    return Container(
      color: Theme.of(context).colorScheme.surface,
      padding: const EdgeInsets.symmetric(vertical: 12),
      child: SingleChildScrollView(
        scrollDirection: Axis.horizontal,
        padding: const EdgeInsets.symmetric(horizontal: 16),
        child: Row(
          children: dates.map((day) {
            final isSelected = _isSameDay(day, selectedDate);
            final isToday = _isSameDay(day, DateTime.now());
            return GestureDetector(
              onTap: () => onDateSelected(day),
              child: Container(
                margin: const EdgeInsets.only(right: 8),
                padding:
                    const EdgeInsets.symmetric(horizontal: 14, vertical: 10),
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
}

// ─── Slot Grid ────────────────────────────────────────────────────────────────

class _SlotGrid extends StatelessWidget {
  final List<AppointmentSlot> slots;
  final ValueChanged<AppointmentSlot> onSlotTapped;

  const _SlotGrid({required this.slots, required this.onSlotTapped});

  @override
  Widget build(BuildContext context) {
    return SingleChildScrollView(
      padding: const EdgeInsets.all(20),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Text(
            'Available Slots',
            style: AppTypography.labelLarge
                .copyWith(color: AppColors.textSecondary),
          ),
          const SizedBox(height: 16),
          Wrap(
            spacing: 12,
            runSpacing: 12,
            children: slots
                .map((s) => _SlotChip(slot: s, onTap: () => onSlotTapped(s)))
                .toList(),
          ),
        ],
      ),
    );
  }
}

class _SlotChip extends StatelessWidget {
  final AppointmentSlot slot;
  final VoidCallback onTap;

  const _SlotChip({required this.slot, required this.onTap});

  @override
  Widget build(BuildContext context) {
    return InkWell(
      onTap: onTap,
      borderRadius: BorderRadius.circular(12),
      child: Container(
        padding: const EdgeInsets.symmetric(horizontal: 16, vertical: 12),
        decoration: BoxDecoration(
          color: Theme.of(context).colorScheme.surface,
          borderRadius: BorderRadius.circular(12),
          border: Border.all(
            color: AppColors.primary.withValues(alpha: 0.4),
            width: 1.5,
          ),
          boxShadow: [
            BoxShadow(
              color: Colors.black.withValues(alpha: 0.05),
              blurRadius: 4,
              offset: const Offset(0, 2),
            ),
          ],
        ),
        child: Column(
          mainAxisSize: MainAxisSize.min,
          children: [
            Text(
              slot.startTime,
              style: AppTypography.labelLarge.copyWith(color: AppColors.primary),
            ),
            if (slot.durationMinutes > 0) ...[
              const SizedBox(height: 2),
              Text(
                '${slot.durationMinutes} min',
                style:
                    AppTypography.bodySmall.copyWith(color: AppColors.textHint),
              ),
            ],
          ],
        ),
      ),
    );
  }
}
