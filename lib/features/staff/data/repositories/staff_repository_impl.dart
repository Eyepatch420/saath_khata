import 'package:dio/dio.dart';
import '../../../../core/network/api_client.dart';
import '../../../../core/network/api_endpoints.dart';
import '../../domain/repositories/staff_repository.dart';
import '../../../../shared/models/staff_model.dart';

class StaffRepositoryImpl implements StaffRepository {
  final ApiClient _api;

  StaffRepositoryImpl(this._api);

  // ─── Helpers ───────────────────────────────────────────────────────────────

  String _fmtDate(DateTime d) =>
      '${d.year}-${d.month.toString().padLeft(2, '0')}-${d.day.toString().padLeft(2, '0')}';

  // ─── Interface ─────────────────────────────────────────────────────────────

  @override
  Future<List<StaffModel>> getStaffList() async {
    try {
      final response = await _api.get(ApiEndpoints.staff);
      // data is a JSON array directly
      final list = (response.data as Map<String, dynamic>)['data'] as List;
      return list
          .map((e) => StaffModel.fromJson(e as Map<String, dynamic>))
          .toList();
    } on DioException catch (e) {
      throw Exception(ApiClient.extractErrorMessage(e));
    }
  }

  @override
  Future<StaffModel> addStaff(StaffModel staff) async {
    try {
      final body = <String, dynamic>{
        'name': staff.name,
        'phone': staff.phone,
        'role': staff.role,
        'salaryType': staff.salaryType.toJson(),
        'salaryAmount': staff.salaryAmount,
        'joinDate': _fmtDate(staff.joinDate),
      };
      if (staff.upiId != null && staff.upiId!.isNotEmpty) {
        body['upiId'] = staff.upiId;
      }

      final response = await _api.post(ApiEndpoints.staff, data: body);
      return StaffModel.fromJson(ApiClient.extractData(response));
    } on DioException catch (e) {
      throw Exception(ApiClient.extractErrorMessage(e));
    }
  }

  @override
  Future<StaffModel> updateStaff(StaffModel staff) async {
    try {
      final body = <String, dynamic>{
        'name': staff.name,
        'phone': staff.phone,
        'role': staff.role,
        'salaryType': staff.salaryType.toJson(),
        'salaryAmount': staff.salaryAmount,
      };
      if (staff.upiId != null) body['upiId'] = staff.upiId;

      final response =
          await _api.patch(ApiEndpoints.staffById(staff.id), data: body);
      return StaffModel.fromJson(ApiClient.extractData(response));
    } on DioException catch (e) {
      throw Exception(ApiClient.extractErrorMessage(e));
    }
  }

  @override
  Future<void> markAttendance(
      String staffId, DateTime date, AttendanceStatus status) async {
    try {
      await _api.put(
        ApiEndpoints.staffAttendance(staffId),
        data: {
          'date': _fmtDate(date),
          'status': status.toJson(),
        },
      );
    } on DioException catch (e) {
      throw Exception(ApiClient.extractErrorMessage(e));
    }
  }

  @override
  Future<Map<String, AttendanceStatus>> getAttendanceForMonth(
      String staffId, int year, int month) async {
    try {
      final response = await _api.get(
        ApiEndpoints.staffAttendance(staffId),
        queryParameters: {'year': year, 'month': month},
      );
      // data is a plain object: { "YYYY-MM-DD": "present"|"absent"|... }
      final raw = ApiClient.extractData(response);
      return raw.map(
        // Normalize keys: strip any accidental time component from DATE strings
        (key, value) => MapEntry(
          key.contains('T') ? key.split('T')[0] : key,
          AttendanceStatusX.fromString(value as String),
        ),
      );
    } on DioException catch (e) {
      throw Exception(ApiClient.extractErrorMessage(e));
    }
  }

  @override
  Future<void> paySalary(
      String staffId, double amount, String? upiTransactionId) async {
    try {
      final body = <String, dynamic>{'amount': amount};
      if (upiTransactionId != null && upiTransactionId.isNotEmpty) {
        body['upiTransactionId'] = upiTransactionId;
      }
      await _api.post(ApiEndpoints.staffPay(staffId), data: body);
    } on DioException catch (e) {
      throw Exception(ApiClient.extractErrorMessage(e));
    }
  }

  @override
  Future<void> addAdvance(String staffId, double amount, String? note) async {
    try {
      final body = <String, dynamic>{'amount': amount};
      if (note != null && note.isNotEmpty) body['note'] = note;
      await _api.post(ApiEndpoints.staffAdvance(staffId), data: body);
    } on DioException catch (e) {
      throw Exception(ApiClient.extractErrorMessage(e));
    }
  }
}
