import 'package:equatable/equatable.dart';
import '../../../../shared/models/booking_model.dart';

abstract class BookingState extends Equatable {
  const BookingState();
  @override
  List<Object?> get props => [];
}

class BookingInitial extends BookingState {}

class BookingLoading extends BookingState {}

class BookingLoaded extends BookingState {
  final List<BookingModel> bookings;
  final DateTime selectedDate;

  const BookingLoaded({required this.bookings, required this.selectedDate});

  BookingLoaded copyWith({List<BookingModel>? bookings, DateTime? selectedDate}) =>
      BookingLoaded(
        bookings: bookings ?? this.bookings,
        selectedDate: selectedDate ?? this.selectedDate,
      );

  @override
  List<Object?> get props => [bookings, selectedDate];
}

class SlotsLoaded extends BookingState {
  final List<AppointmentSlot> slots;
  final DateTime date;

  const SlotsLoaded({required this.slots, required this.date});

  SlotsLoaded copyWith({List<AppointmentSlot>? slots}) =>
      SlotsLoaded(slots: slots ?? this.slots, date: date);

  @override
  List<Object?> get props => [slots, date];
}

/// Booking creation failed but we still have the slot grid to show.
class BookingCreateError extends BookingState {
  final List<AppointmentSlot> slots;
  final DateTime date;
  final String message;

  const BookingCreateError({
    required this.slots,
    required this.date,
    required this.message,
  });

  @override
  List<Object?> get props => [slots, date, message];
}

class BookingCreated extends BookingState {
  final BookingModel booking;
  const BookingCreated(this.booking);
  @override
  List<Object?> get props => [booking];
}

class BookingError extends BookingState {
  final String message;
  const BookingError(this.message);
  @override
  List<Object?> get props => [message];
}

class BookingActionError extends BookingState {
  final List<BookingModel> bookings;
  final DateTime selectedDate;
  final String message;
  const BookingActionError({
    required this.bookings,
    required this.selectedDate,
    required this.message,
  });
  @override
  List<Object?> get props => [bookings, selectedDate, message];
}

// ─── Config states ────────────────────────────────────────────────────────────

class BookingConfigLoading extends BookingState {}

class BookingConfigLoaded extends BookingState {
  final BookingConfig config;
  const BookingConfigLoaded(this.config);
  @override
  List<Object?> get props => [config];
}

class BookingConfigSaved extends BookingState {
  final BookingConfig config;
  const BookingConfigSaved(this.config);
  @override
  List<Object?> get props => [config];
}

class BookingConfigError extends BookingState {
  final String message;
  final BookingConfig? config;
  const BookingConfigError(this.message, {this.config});
  @override
  List<Object?> get props => [message, config];
}
