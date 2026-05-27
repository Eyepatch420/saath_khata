import 'package:flutter_bloc/flutter_bloc.dart';
import '../../domain/repositories/booking_repository.dart';
import '../../../../shared/models/booking_model.dart';
import 'booking_event.dart';
import 'booking_state.dart';
import '../../../../core/utils/app_logger.dart';

String _toDateString(DateTime dt) =>
    '${dt.year}-${dt.month.toString().padLeft(2, '0')}-${dt.day.toString().padLeft(2, '0')}';

class BookingBloc extends Bloc<BookingEvent, BookingState> {
  final BookingRepository _repository;

  static const _m = 'Booking';

  BookingBloc(this._repository) : super(BookingInitial()) {
    on<LoadVendorBookings>(_onLoadVendor);
    on<LoadCustomerBookings>(_onLoadCustomer);
    on<LoadAvailableSlots>(_onLoadSlots);
    on<CreateBooking>(_onCreate);
    on<CancelBooking>(_onCancel);
    on<UpdateBookingStatus>(_onUpdateStatus);
    on<SelectBookingDate>(_onSelectDate);
  }

  Future<void> _onLoadVendor(
      LoadVendorBookings event, Emitter<BookingState> emit) async {
    AppLogger.i(_m, 'Loading vendor bookings for date:${_toDateString(event.date)}');
    emit(BookingLoading());
    try {
      final bookings =
          await _repository.getVendorBookings(_toDateString(event.date));
      AppLogger.i(_m, 'Vendor bookings loaded — ${bookings.length} bookings');
      emit(BookingLoaded(bookings: bookings, selectedDate: event.date));
    } catch (e) {
      AppLogger.e(_m, 'Load vendor bookings failed', e);
      emit(const BookingError('Failed to load bookings'));
    }
  }

  Future<void> _onLoadCustomer(
      LoadCustomerBookings event, Emitter<BookingState> emit) async {
    AppLogger.i(_m, 'Loading customer bookings...');
    emit(BookingLoading());
    try {
      final bookings = await _repository.getCustomerBookings();
      AppLogger.i(_m, 'Customer bookings loaded — ${bookings.length} bookings');
      emit(BookingLoaded(bookings: bookings, selectedDate: DateTime.now()));
    } catch (e) {
      AppLogger.e(_m, 'Load customer bookings failed', e);
      emit(const BookingError('Failed to load bookings'));
    }
  }

  Future<void> _onLoadSlots(
      LoadAvailableSlots event, Emitter<BookingState> emit) async {
    AppLogger.i(_m, 'Loading slots — vendorId:${event.vendorId} date:${_toDateString(event.date)}');
    emit(BookingLoading());
    try {
      final slots = await _repository.getAvailableSlots(
          event.vendorId, _toDateString(event.date));
      AppLogger.i(_m, 'Slots loaded — ${slots.length} available');
      emit(SlotsLoaded(slots: slots, date: event.date));
    } catch (e) {
      AppLogger.e(_m, 'Load slots failed', e);
      emit(const BookingError('Failed to load slots'));
    }
  }

  Future<void> _onCreate(
      CreateBooking event, Emitter<BookingState> emit) async {
    AppLogger.i(_m, 'Creating booking — vendorId:${event.booking.vendorId} date:${event.booking.date}');
    emit(BookingLoading());
    try {
      final booking = await _repository.createBooking(event.booking);
      AppLogger.i(_m, 'Booking created — id:${booking.id} status:${booking.status.name}');
      emit(BookingCreated(booking));
    } catch (e) {
      AppLogger.e(_m, 'Create booking failed', e);
      emit(const BookingError('Failed to create booking'));
    }
  }

  Future<void> _onCancel(
      CancelBooking event, Emitter<BookingState> emit) async {
    AppLogger.i(_m, 'Cancelling booking id:${event.bookingId}');
    try {
      await _repository.updateBookingStatus(
          event.bookingId, BookingStatus.cancelled);
      AppLogger.i(_m, 'Booking cancelled — refreshing list');
      add(LoadCustomerBookings());
    } catch (e) {
      AppLogger.e(_m, 'Cancel booking failed id:${event.bookingId}', e);
    }
  }

  Future<void> _onUpdateStatus(
      UpdateBookingStatus event, Emitter<BookingState> emit) async {
    final current = state;
    if (current is! BookingLoaded) return;

    AppLogger.i(_m, 'Updating booking id:${event.bookingId} → ${event.status.name}');

    // Optimistic update
    final optimistic = current.bookings
        .map((b) => b.id == event.bookingId ? b.copyWith(status: event.status) : b)
        .toList();
    emit(current.copyWith(bookings: optimistic));

    try {
      final updated = await _repository.updateBookingStatus(event.bookingId, event.status);
      AppLogger.i(_m, 'Booking status confirmed by server — ${updated.status.name}');
      final confirmed = current.bookings
          .map((b) => b.id == updated.id ? updated : b)
          .toList();
      emit(current.copyWith(bookings: confirmed));
    } catch (e) {
      AppLogger.e(_m, 'Booking status update failed — reverting', e);
      // Revert optimistic update and surface the error
      emit(BookingActionError(
        bookings: current.bookings,
        selectedDate: current.selectedDate,
        message: e.toString().replaceFirst('Exception: ', ''),
      ));
    }
  }

  void _onSelectDate(SelectBookingDate event, Emitter<BookingState> emit) {
    AppLogger.v(_m, 'Date selected: ${_toDateString(event.date)}');
    add(LoadVendorBookings(event.date));
  }
}
