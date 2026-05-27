import 'package:equatable/equatable.dart';

enum BookingStatus { pending, confirmed, cancelled, completed }

extension BookingStatusX on BookingStatus {
  String toJson() => name;
}

BookingStatus _bookingStatusFromJson(String v) =>
    BookingStatus.values.firstWhere((e) => e.name == v,
        orElse: () => BookingStatus.pending);

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

  factory AppointmentSlot.fromJson(Map<String, dynamic> json) =>
      AppointmentSlot(
        id: json['id'] as String,
        vendorId: json['vendorId'] as String,
        startTime: json['startTime'] as String,
        endTime: json['endTime'] as String,
        durationMinutes: json['durationMinutes'] as int,
        isAvailable: json['isAvailable'] as bool? ?? true,
      );

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

  factory BookingModel.fromJson(Map<String, dynamic> json) => BookingModel(
        id: json['id'] as String,
        vendorId: json['vendorId'] as String,
        vendorName: json['vendorName'] as String,
        customerId: json['customerId'] as String,
        customerName: json['customerName'] as String,
        slotId: json['slotId'] as String?,
        date: json['date'] as String,
        startTime: json['startTime'] as String,
        endTime: json['endTime'] as String,
        serviceType: json['serviceType'] as String?,
        status: _bookingStatusFromJson(json['status'] as String),
        notes: json['notes'] as String?,
        createdAt: json['createdAt'] as String,
      );

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
