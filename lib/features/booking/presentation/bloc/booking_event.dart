import 'package:equatable/equatable.dart';
import '../../../../shared/models/booking_model.dart';

abstract class BookingEvent extends Equatable {
  const BookingEvent();
  @override
  List<Object?> get props => [];
}

class LoadVendorBookings extends BookingEvent {
  final DateTime date;
  const LoadVendorBookings(this.date);
  @override
  List<Object?> get props => [date];
}

class LoadCustomerBookings extends BookingEvent {}

class LoadAvailableSlots extends BookingEvent {
  final String vendorId;
  final DateTime date;
  const LoadAvailableSlots({required this.vendorId, required this.date});
  @override
  List<Object?> get props => [vendorId, date];
}

class CreateBooking extends BookingEvent {
  final BookingModel booking;
  const CreateBooking(this.booking);
  @override
  List<Object?> get props => [booking];
}

class CancelBooking extends BookingEvent {
  final String bookingId;
  const CancelBooking(this.bookingId);
  @override
  List<Object?> get props => [bookingId];
}

class UpdateBookingStatus extends BookingEvent {
  final String bookingId;
  final BookingStatus status;
  const UpdateBookingStatus({required this.bookingId, required this.status});
  @override
  List<Object?> get props => [bookingId, status];
}

class SelectBookingDate extends BookingEvent {
  final DateTime date;
  const SelectBookingDate(this.date);
  @override
  List<Object?> get props => [date];
}

// ─── Schedule / Config events ─────────────────────────────────────────────────

class LoadBookingConfig extends BookingEvent {}

class SaveBookingConfig extends BookingEvent {
  final BookingConfig config;
  const SaveBookingConfig(this.config);
  @override
  List<Object?> get props => [config];
}

class ToggleSlotFull extends BookingEvent {
  final int dayOfWeek;
  final String startTime;
  final bool isFull;
  const ToggleSlotFull({required this.dayOfWeek, required this.startTime, required this.isFull});
  @override
  List<Object?> get props => [dayOfWeek, startTime, isFull];
}
