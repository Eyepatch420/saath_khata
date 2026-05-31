import 'package:equatable/equatable.dart';
import '../../../../shared/models/staff_model.dart';

abstract class StaffEvent extends Equatable {
  const StaffEvent();
  @override
  List<Object?> get props => [];
}

class LoadStaff extends StaffEvent {}

class AddStaff extends StaffEvent {
  final StaffModel staff;
  const AddStaff(this.staff);
  @override
  List<Object?> get props => [staff];
}

class MarkAttendance extends StaffEvent {
  final String staffId;
  final DateTime date;
  final AttendanceStatus status;
  const MarkAttendance({required this.staffId, required this.date, required this.status});
  @override
  List<Object?> get props => [staffId, date, status];
}

class LoadAttendance extends StaffEvent {
  final String staffId;
  final int year;
  final int month;
  // Optionally provide the staff model to skip the extra list fetch
  final StaffModel? staff;
  const LoadAttendance({required this.staffId, required this.year, required this.month, this.staff});
  @override
  List<Object?> get props => [staffId, year, month];
}

class PaySalary extends StaffEvent {
  final String staffId;
  final double amount;
  final String? upiTransactionId;
  const PaySalary({required this.staffId, required this.amount, this.upiTransactionId});
  @override
  List<Object?> get props => [staffId, amount];
}

class AddAdvance extends StaffEvent {
  final String staffId;
  final double amount;
  final String? note;
  const AddAdvance({required this.staffId, required this.amount, this.note});
  @override
  List<Object?> get props => [staffId, amount];
}
