import 'package:equatable/equatable.dart';

// Backend supports only 'daily' and 'monthly' — 'weekly' is not a valid value.
enum SalaryType { daily, monthly }

// JSON serialization: halfDay → "half_day", others are lowercase as-is.
enum AttendanceStatus { present, absent, halfDay, holiday }

class StaffModel extends Equatable {
  final String id;
  final String vendorId;
  final String name;
  final String phone;
  final String role;
  final SalaryType salaryType;
  final double salaryAmount;
  final String? upiId;
  final DateTime joinDate;
  final bool isActive;
  final bool presentToday;
  final double unpaidSalary;
  final double advanceTaken;

  const StaffModel({
    required this.id,
    required this.vendorId,
    required this.name,
    required this.phone,
    required this.role,
    required this.salaryType,
    required this.salaryAmount,
    this.upiId,
    required this.joinDate,
    this.isActive = true,
    this.presentToday = false,
    this.unpaidSalary = 0,
    this.advanceTaken = 0,
  });

  StaffModel copyWith({
    bool? presentToday,
    double? unpaidSalary,
    double? advanceTaken,
    bool? isActive,
  }) {
    return StaffModel(
      id: id,
      vendorId: vendorId,
      name: name,
      phone: phone,
      role: role,
      salaryType: salaryType,
      salaryAmount: salaryAmount,
      upiId: upiId,
      joinDate: joinDate,
      isActive: isActive ?? this.isActive,
      presentToday: presentToday ?? this.presentToday,
      unpaidSalary: unpaidSalary ?? this.unpaidSalary,
      advanceTaken: advanceTaken ?? this.advanceTaken,
    );
  }

  @override
  List<Object?> get props => [
        id,
        vendorId,
        name,
        phone,
        role,
        salaryType,
        salaryAmount,
        upiId,
        joinDate,
        isActive,
        presentToday,
        unpaidSalary,
        advanceTaken,
      ];
}

class AttendanceRecord extends Equatable {
  final String staffId;
  final DateTime date;
  final AttendanceStatus status;

  const AttendanceRecord({
    required this.staffId,
    required this.date,
    required this.status,
  });

  @override
  List<Object?> get props => [staffId, date, status];
}
