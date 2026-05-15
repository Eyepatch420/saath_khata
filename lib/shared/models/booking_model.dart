import 'package:equatable/equatable.dart';

enum BookingStatus { pending, confirmed, cancelled, completed }

class AppointmentSlot extends Equatable {
  final String id;
  final String vendorId;
  final String startTime; // 'HH:MM'
  final String endTime;   // 'HH:MM'
  final int durationMinutes;
  final bool isAvailable;

  const AppointmentSlot({
    required this.id,
    required this.vendorId,
    required this.startTime,
    required this.endTime,
    required this.durationMinutes,
    this.isAvailable = true,
  });

  @override
  List<Object?> get props =>
      [id, vendorId, startTime, endTime, durationMinutes, isAvailable];
}

class BookingModel extends Equatable {
  final String id;
  final String vendorId;
  final String vendorName;
  final String customerId;
  final String customerName;
  final String? slotId;
  /// ISO date string 'YYYY-MM-DD' — backend stores and returns dates as strings.
  final String date;
  final String startTime;  // 'HH:MM'
  final String endTime;    // 'HH:MM' — computed from slot duration on backend
  final String? serviceType;
  final BookingStatus status;
  final String? notes;
  final String createdAt; // ISO 8601

  const BookingModel({
    required this.id,
    required this.vendorId,
    required this.vendorName,
    required this.customerId,
    required this.customerName,
    this.slotId,
    required this.date,
    required this.startTime,
    required this.endTime,
    this.serviceType,
    required this.status,
    this.notes,
    required this.createdAt,
  });

  BookingModel copyWith({BookingStatus? status}) {
    return BookingModel(
      id: id,
      vendorId: vendorId,
      vendorName: vendorName,
      customerId: customerId,
      customerName: customerName,
      slotId: slotId,
      date: date,
      startTime: startTime,
      endTime: endTime,
      serviceType: serviceType,
      status: status ?? this.status,
      notes: notes,
      createdAt: createdAt,
    );
  }

  @override
  List<Object?> get props => [
        id,
        vendorId,
        vendorName,
        customerId,
        customerName,
        slotId,
        date,
        startTime,
        endTime,
        serviceType,
        status,
        notes,
        createdAt,
      ];
}
