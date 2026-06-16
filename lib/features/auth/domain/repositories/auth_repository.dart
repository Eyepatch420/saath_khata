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

  // ─── Signup (OTP-based) ───────────────────────────────────────────────────

  Future<AuthResponseModel> signup({
    required String signupToken,
    required String name,
    required String role,
    String? email,
    String? upiId,
    String? businessName,
    String? businessCategory,
    String? businessAddress,
  });

  // ─── Session ──────────────────────────────────────────────────────────────

  Future<void> logout({required String refreshToken});

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
