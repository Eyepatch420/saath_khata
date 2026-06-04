import '../../data/models/auth_response_model.dart';
import '../../data/models/upi_id_model.dart';
import '../../data/models/user_model.dart';

abstract class AuthRepository {
  Future<AuthResponseModel> login({
    required String email,
    required String password,
    required String role,
  });

  Future<AuthResponseModel> signup({
    required String name,
    required String email,
    required String password,
    required String role,
    String? mobile,
    String? upiId,
    String? businessName,
    String? businessCategory,
    String? businessAddress,
  });

  Future<void> logout({required String refreshToken});

  /// PATCH /auth/profile — updates editable fields, returns refreshed user.
  ///
  /// [upiId] is only used for customers (single UPI).
  /// [upiIds] is only used for vendors — replaces the entire UPI ID list atomically.
  Future<UserModel> updateProfile({
    String? name,
    String? mobile,
    String? upiId,
    String? businessName,
    String? businessCategory,
    String? businessAddress,
    double? businessLatitude,
    double? businessLongitude,
    List<UpiIdModel>? upiIds,
  });
}
