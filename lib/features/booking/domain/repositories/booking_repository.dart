import '../../../../shared/models/booking_model.dart';

abstract class BookingRepository {
  /// GET /api/v1/bookings?date=YYYY-MM-DD  (vendor view)
  Future<List<BookingModel>> getVendorBookings(String date);

  /// GET /api/v1/bookings  (customer view — all own bookings)
  Future<List<BookingModel>> getCustomerBookings();

  /// GET /api/v1/bookings/slots?vendorId=...&date=YYYY-MM-DD
  Future<List<AppointmentSlot>> getAvailableSlots(String vendorId, String date);

  /// POST /api/v1/bookings
  Future<BookingModel> createBooking(BookingModel booking);

  /// PATCH /api/v1/bookings/:bookingId/status
  Future<BookingModel> updateBookingStatus(String bookingId, BookingStatus status);
}
