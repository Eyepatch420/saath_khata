import '../../domain/repositories/booking_repository.dart';
import '../../../../shared/models/booking_model.dart';

class MockBookingRepository implements BookingRepository {
  final List<BookingModel> _bookings = [
    BookingModel(
      id: 'b1',
      vendorId: 'v1',
      vendorName: 'Krishna Salon',
      customerId: 'c1',
      customerName: 'Sujeet Kumar',
      date: '2026-05-16',
      startTime: '10:00',
      endTime: '10:30',
      serviceType: 'Haircut',
      status: BookingStatus.confirmed,
      notes: 'Regular trim',
      createdAt: DateTime.now()
          .subtract(const Duration(hours: 2))
          .toIso8601String(),
    ),
    BookingModel(
      id: 'b2',
      vendorId: 'v2',
      vendorName: 'Ramesh Tailor',
      customerId: 'c1',
      customerName: 'Sujeet Kumar',
      date: '2026-05-18',
      startTime: '14:00',
      endTime: '14:30',
      serviceType: 'Alterations',
      status: BookingStatus.pending,
      createdAt: DateTime.now()
          .subtract(const Duration(hours: 5))
          .toIso8601String(),
    ),
    BookingModel(
      id: 'b3',
      vendorId: 'v1',
      vendorName: 'Krishna Salon',
      customerId: 'c2',
      customerName: 'Anjali Sharma',
      date: '2026-05-15',
      startTime: '11:30',
      endTime: '12:00',
      serviceType: 'Facial',
      status: BookingStatus.completed,
      createdAt: DateTime.now()
          .subtract(const Duration(days: 1))
          .toIso8601String(),
    ),
  ];

  @override
  Future<List<BookingModel>> getVendorBookings(String date) async {
    await Future.delayed(const Duration(milliseconds: 500));
    return _bookings.where((b) => b.date == date).toList();
  }

  @override
  Future<List<BookingModel>> getCustomerBookings() async {
    await Future.delayed(const Duration(milliseconds: 500));
    return List.from(_bookings)..sort((a, b) => a.date.compareTo(b.date));
  }

  @override
  Future<List<AppointmentSlot>> getAvailableSlots(
      String vendorId, String date) async {
    await Future.delayed(const Duration(milliseconds: 400));
    final bookedTimes = _bookings
        .where((b) =>
            b.vendorId == vendorId &&
            b.date == date &&
            b.status != BookingStatus.cancelled)
        .map((b) => b.startTime)
        .toSet();

    const allSlots = [
      '09:00', '09:30', '10:00', '10:30', '11:00', '11:30',
      '12:00', '14:00', '14:30', '15:00', '15:30', '16:00',
      '16:30', '17:00',
    ];

    return allSlots.asMap().entries.map((entry) {
      final start = entry.value;
      return AppointmentSlot(
        id: '${vendorId}_${date}_$start',
        vendorId: vendorId,
        startTime: start,
        endTime: _addMinutes(start, 30),
        durationMinutes: 30,
        isAvailable: !bookedTimes.contains(start),
      );
    }).toList();
  }

  String _addMinutes(String time, int minutes) {
    final parts = time.split(':');
    final total = int.parse(parts[0]) * 60 + int.parse(parts[1]) + minutes;
    final h = (total ~/ 60).toString().padLeft(2, '0');
    final m = (total % 60).toString().padLeft(2, '0');
    return '$h:$m';
  }

  @override
  Future<BookingModel> createBooking(BookingModel booking) async {
    await Future.delayed(const Duration(milliseconds: 500));
    final newBooking = BookingModel(
      id: 'b${_bookings.length + 1}',
      vendorId: booking.vendorId,
      vendorName: booking.vendorName,
      customerId: booking.customerId,
      customerName: booking.customerName,
      slotId: booking.slotId,
      date: booking.date,
      startTime: booking.startTime,
      endTime: booking.endTime,
      serviceType: booking.serviceType,
      status: BookingStatus.pending,
      notes: booking.notes,
      createdAt: DateTime.now().toIso8601String(),
    );
    _bookings.add(newBooking);
    return newBooking;
  }

  @override
  Future<BookingModel> updateBookingStatus(
      String bookingId, BookingStatus status) async {
    await Future.delayed(const Duration(milliseconds: 300));
    final index = _bookings.indexWhere((b) => b.id == bookingId);
    if (index == -1) throw Exception('Booking not found');
    _bookings[index] = _bookings[index].copyWith(status: status);
    return _bookings[index];
  }
}
