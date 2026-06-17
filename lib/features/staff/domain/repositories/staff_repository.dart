import '../../../../shared/models/staff_model.dart';

abstract class StaffRepository {
  Future<List<StaffModel>> getStaffList();
  Future<StaffModel> addStaff(StaffModel staff);
  Future<StaffModel> updateStaff(StaffModel staff);
  Future<void> markAttendance(String staffId, DateTime date, AttendanceStatus status);
  Future<Map<String, AttendanceStatus>> getAttendanceForMonth(String staffId, int year, int month);
  Future<void> paySalary(String staffId, double amount, String? upiTransactionId);
  Future<void> addAdvance(String staffId, double amount, String? note);
  Future<StaffModel> accrueSalary(String staffId);

  /// Grant or revoke a staff member's app login. Returns the updated staff record.
  Future<StaffModel> setAppAccess(String staffId, bool canLogin);
}
