import '../../../../shared/models/booking_model.dart';

abstract class BookingRepository {
  Future<List<BookingModel>> getVendorBookings(String date);
  Future<List<BookingModel>> getCustomerBookings();
  Future<List<AppointmentSlot>> getAvailableSlots(String vendorId, String date);
  Future<BookingModel> createBooking(BookingModel booking);
  Future<BookingModel> updateBookingStatus(String bookingId, BookingStatus status);
  Future<BookingConfig> saveBookingConfig(BookingConfig config);
  Future<BookingConfig?> getBookingConfig();
  Future<BookingConfig> toggleSlotFull({
    required int dayOfWeek,
    required String startTime,
    required bool isFull,
  });
}
