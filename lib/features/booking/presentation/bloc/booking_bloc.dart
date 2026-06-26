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
    on<LoadBookingConfig>(_onLoadConfig);
    on<SaveBookingConfig>(_onSaveConfig);
    on<ToggleSlotFull>(_onToggleSlotFull);
  }

  Future<void> _onLoadVendor(LoadVendorBookings event, Emitter<BookingState> emit) async {
    AppLogger.i(_m, 'Loading vendor bookings for date:${_toDateString(event.date)}');
    emit(BookingLoading());
    try {
      final bookings = await _repository.getVendorBookings(_toDateString(event.date));
      emit(BookingLoaded(bookings: bookings, selectedDate: event.date));
    } catch (e) {
      AppLogger.e(_m, 'Load vendor bookings failed', e);
      emit(const BookingError('Failed to load bookings'));
    }
  }

  Future<void> _onLoadCustomer(LoadCustomerBookings event, Emitter<BookingState> emit) async {
    AppLogger.i(_m, 'Loading customer bookings...');
    emit(BookingLoading());
    try {
      final bookings = await _repository.getCustomerBookings();
      emit(BookingLoaded(bookings: bookings, selectedDate: DateTime.now()));
    } catch (e) {
      AppLogger.e(_m, 'Load customer bookings failed', e);
      emit(const BookingError('Failed to load bookings'));
    }
  }

  Future<void> _onLoadSlots(LoadAvailableSlots event, Emitter<BookingState> emit) async {
    final dateStr = _toDateString(event.date);
    AppLogger.i(_m, 'Loading slots — vendorId:${event.vendorId} date:$dateStr');
    emit(BookingLoading());
    try {
      // Fetch slots and customer's existing bookings concurrently
      final results = await Future.wait([
        _repository.getAvailableSlots(event.vendorId, dateStr),
        _repository.getCustomerBookings(),
      ]);

      final slots = results[0] as List<AppointmentSlot>;
      final myBookings = results[1] as List<BookingModel>;

      // Find start times the customer already has active on this vendor+date
      final bookedTimes = myBookings
          .where((b) =>
              b.vendorId == event.vendorId &&
              b.date == dateStr &&
              (b.status == BookingStatus.pending || b.status == BookingStatus.confirmed))
          .map((b) => b.startTime)
          .toSet();

      final markedSlots = bookedTimes.isEmpty
          ? slots
          : slots
              .map((s) => bookedTimes.contains(s.startTime) ? s.copyWith(isAlreadyBooked: true) : s)
              .toList();

      emit(SlotsLoaded(slots: markedSlots, date: event.date));
    } catch (e) {
      AppLogger.e(_m, 'Load slots failed', e);
      emit(const BookingError('Failed to load slots'));
    }
  }

  Future<void> _onCreate(CreateBooking event, Emitter<BookingState> emit) async {
    AppLogger.i(_m, 'Creating booking — vendorId:${event.booking.vendorId} date:${event.booking.date}');
    // Remember slot state so we can restore it on failure
    final prevState = state;
    emit(BookingLoading());
    try {
      final booking = await _repository.createBooking(event.booking);
      emit(BookingCreated(booking));
    } catch (e) {
      AppLogger.e(_m, 'Create booking failed', e);
      final msg = e.toString().replaceFirst('Exception: ', '');
      // Restore the slot grid on failure so the user can still see the screen
      if (prevState is SlotsLoaded) {
        emit(BookingCreateError(
          slots: prevState.slots,
          date: prevState.date,
          message: msg,
        ));
      } else {
        emit(BookingError(msg));
      }
    }
  }

  Future<void> _onCancel(CancelBooking event, Emitter<BookingState> emit) async {
    AppLogger.i(_m, 'Cancelling booking id:${event.bookingId}');
    try {
      await _repository.updateBookingStatus(event.bookingId, BookingStatus.cancelled);
      add(LoadCustomerBookings());
    } catch (e) {
      AppLogger.e(_m, 'Cancel booking failed id:${event.bookingId}', e);
    }
  }

  Future<void> _onUpdateStatus(UpdateBookingStatus event, Emitter<BookingState> emit) async {
    final current = state;
    if (current is! BookingLoaded) return;

    AppLogger.i(_m, 'Updating booking id:${event.bookingId} → ${event.status.name}');

    final optimistic = current.bookings
        .map((b) => b.id == event.bookingId ? b.copyWith(status: event.status) : b)
        .toList();
    emit(current.copyWith(bookings: optimistic));

    try {
      final updated = await _repository.updateBookingStatus(event.bookingId, event.status);
      final confirmed = current.bookings
          .map((b) => b.id == updated.id ? updated : b)
          .toList();
      emit(current.copyWith(bookings: confirmed));
    } catch (e) {
      AppLogger.e(_m, 'Booking status update failed — reverting', e);
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

  // ─── Config handlers ─────────────────────────────────────────────────────────

  Future<void> _onLoadConfig(LoadBookingConfig event, Emitter<BookingState> emit) async {
    AppLogger.i(_m, 'Loading booking config');
    emit(BookingConfigLoading());
    try {
      final config = await _repository.getBookingConfig();
      emit(BookingConfigLoaded(config ?? BookingConfig.empty()));
    } catch (e) {
      AppLogger.e(_m, 'Load booking config failed', e);
      emit(const BookingConfigError('Failed to load schedule'));
    }
  }

  Future<void> _onSaveConfig(SaveBookingConfig event, Emitter<BookingState> emit) async {
    AppLogger.i(_m, 'Saving booking config');
    emit(BookingConfigLoading());
    try {
      final saved = await _repository.saveBookingConfig(event.config);
      emit(BookingConfigSaved(saved));
    } catch (e) {
      AppLogger.e(_m, 'Save booking config failed', e);
      emit(BookingConfigError(
        e.toString().replaceFirst('Exception: ', ''),
        config: event.config,
      ));
    }
  }

  Future<void> _onToggleSlotFull(ToggleSlotFull event, Emitter<BookingState> emit) async {
    AppLogger.i(_m, 'Toggle slot full day:${event.dayOfWeek} time:${event.startTime} full:${event.isFull}');

    // Keep the current config visible while updating
    final current = state;
    final currentConfig = current is BookingConfigLoaded ? current.config : null;

    try {
      final updated = await _repository.toggleSlotFull(
        dayOfWeek: event.dayOfWeek,
        startTime: event.startTime,
        isFull: event.isFull,
      );
      emit(BookingConfigLoaded(updated));
    } catch (e) {
      AppLogger.e(_m, 'Toggle slot full failed', e);
      emit(BookingConfigError(
        e.toString().replaceFirst('Exception: ', ''),
        config: currentConfig,
      ));
    }
  }
}
