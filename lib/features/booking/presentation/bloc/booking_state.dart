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

  @override
  List<Object?> get props => [slots, date];
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

/// Non-fatal error for a status update action — list remains visible.
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
