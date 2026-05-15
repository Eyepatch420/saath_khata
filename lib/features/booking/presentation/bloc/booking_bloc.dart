import 'package:flutter_bloc/flutter_bloc.dart';
import '../../domain/repositories/booking_repository.dart';
import '../../../../shared/models/booking_model.dart';
import 'booking_event.dart';
import 'booking_state.dart';

String _toDateString(DateTime dt) =>
    '${dt.year}-${dt.month.toString().padLeft(2, '0')}-${dt.day.toString().padLeft(2, '0')}';

class BookingBloc extends Bloc<BookingEvent, BookingState> {
  final BookingRepository _repository;

  BookingBloc(this._repository) : super(BookingInitial()) {
    on<LoadVendorBookings>(_onLoadVendor);
    on<LoadCustomerBookings>(_onLoadCustomer);
    on<LoadAvailableSlots>(_onLoadSlots);
    on<CreateBooking>(_onCreate);
    on<CancelBooking>(_onCancel);
    on<SelectBookingDate>(_onSelectDate);
  }

  Future<void> _onLoadVendor(
      LoadVendorBookings event, Emitter<BookingState> emit) async {
    emit(BookingLoading());
    try {
      final bookings =
          await _repository.getVendorBookings(_toDateString(event.date));
      emit(BookingLoaded(bookings: bookings, selectedDate: event.date));
    } catch (_) {
      emit(const BookingError('Failed to load bookings'));
    }
  }

  Future<void> _onLoadCustomer(
      LoadCustomerBookings event, Emitter<BookingState> emit) async {
    emit(BookingLoading());
    try {
      final bookings = await _repository.getCustomerBookings();
      emit(BookingLoaded(bookings: bookings, selectedDate: DateTime.now()));
    } catch (_) {
      emit(const BookingError('Failed to load bookings'));
    }
  }

  Future<void> _onLoadSlots(
      LoadAvailableSlots event, Emitter<BookingState> emit) async {
    emit(BookingLoading());
    try {
      final slots = await _repository.getAvailableSlots(
          event.vendorId, _toDateString(event.date));
      emit(SlotsLoaded(slots: slots, date: event.date));
    } catch (_) {
      emit(const BookingError('Failed to load slots'));
    }
  }

  Future<void> _onCreate(
      CreateBooking event, Emitter<BookingState> emit) async {
    emit(BookingLoading());
    try {
      final booking = await _repository.createBooking(event.booking);
      emit(BookingCreated(booking));
    } catch (_) {
      emit(const BookingError('Failed to create booking'));
    }
  }

  Future<void> _onCancel(
      CancelBooking event, Emitter<BookingState> emit) async {
    try {
      await _repository.updateBookingStatus(
          event.bookingId, BookingStatus.cancelled);
      add(LoadCustomerBookings());
    } catch (_) {}
  }

  void _onSelectDate(SelectBookingDate event, Emitter<BookingState> emit) {
    add(LoadVendorBookings(event.date));
  }
}
