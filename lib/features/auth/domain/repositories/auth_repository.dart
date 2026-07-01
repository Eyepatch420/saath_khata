import '../../data/models/auth_response_model.dart';
import '../../data/models/upi_id_model.dart';
import '../../data/models/user_model.dart';

abstract class AuthRepository {
  // ─── OTP ──────────────────────────────────────────────────────────────────

  Future<void> sendOtp({required String phone});

  Future<OtpVerifyResponseModel> verifyOtp({
    required String phone,
    required String otp,
  });

  // ─── Email + password login ───────────────────────────────────────────────

  Future<AuthResponseModel> emailLogin({
    required String email,
    required String password,
    required String role,
  });

  // ─── Signup (OTP-based) ───────────────────────────────────────────────────

  Future<AuthResponseModel> signup({
    required String signupToken,
    required String name,
    required String role,
    String? email,
    String? upiId,
    String? businessName,
    String? businessCategory,
    List<String>? businessCategories,
    String? businessAddress,
    double? customerLatitude,
    double? customerLongitude,
    String? customerAddress,
  });

  // ─── Session ──────────────────────────────────────────────────────────────

  Future<void> logout({required String refreshToken});

  Future<void> deleteAccount();

  Future<UserModel> updateProfile({
    String? name,
    String? mobile,
    String? upiId,
    String? businessName,
    String? businessCategory,
    List<String>? businessCategories,
    String? businessAddress,
    double? businessLatitude,
    double? businessLongitude,
    List<UpiIdModel>? upiIds,
    double? customerLatitude,
    double? customerLongitude,
    String? customerAddress,
  });
}
