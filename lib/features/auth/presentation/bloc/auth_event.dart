import 'package:equatable/equatable.dart';
import '../../data/models/user_model.dart';

abstract class AuthEvent extends Equatable {
  const AuthEvent();

  @override
  List<Object?> get props => [];
}

class AuthCheckStatusRequested extends AuthEvent {
  const AuthCheckStatusRequested();
}

// ─── OTP flow ─────────────────────────────────────────────────────────────────

class AuthOtpSendRequested extends AuthEvent {
  final String phone;
  const AuthOtpSendRequested({required this.phone});

  @override
  List<Object?> get props => [phone];
}

class AuthOtpVerifyRequested extends AuthEvent {
  final String phone;
  final String otp;
  final String role;
  const AuthOtpVerifyRequested({
    required this.phone,
    required this.otp,
    required this.role,
  });

  @override
  List<Object?> get props => [phone, otp, role];
}

// ─── Signup (OTP-based — no password) ────────────────────────────────────────

class AuthSignupRequested extends AuthEvent {
  final String signupToken;
  final String name;
  final String role;
  final String? email;
  final String? upiId;
  final String? businessName;
  final String? businessCategory;
  final List<String>? businessCategories;
  final String? businessAddress;
  final double? customerLatitude;
  final double? customerLongitude;
  final String? customerAddress;

  const AuthSignupRequested({
    required this.signupToken,
    required this.name,
    required this.role,
    this.email,
    this.upiId,
    this.businessName,
    this.businessCategory,
    this.businessCategories,
    this.businessAddress,
    this.customerLatitude,
    this.customerLongitude,
    this.customerAddress,
  });

  @override
  List<Object?> get props => [signupToken, name, role];
}

// ─── Email signup (no OTP required) ──────────────────────────────────────────

class AuthEmailSignupRequested extends AuthEvent {
  final String email;
  final String password;
  final String name;
  final String role;
  final String? upiId;
  final String? businessName;
  final String? businessCategory;
  final List<String>? businessCategories;
  final String? businessAddress;
  final double? customerLatitude;
  final double? customerLongitude;
  final String? customerAddress;

  const AuthEmailSignupRequested({
    required this.email,
    required this.password,
    required this.name,
    required this.role,
    this.upiId,
    this.businessName,
    this.businessCategory,
    this.businessCategories,
    this.businessAddress,
    this.customerLatitude,
    this.customerLongitude,
    this.customerAddress,
  });

  @override
  List<Object?> get props => [email, name, role];
}

// ─── Email + password login ───────────────────────────────────────────────────

class AuthEmailLoginRequested extends AuthEvent {
  final String email;
  final String password;
  final String role;
  const AuthEmailLoginRequested({
    required this.email,
    required this.password,
    required this.role,
  });

  @override
  List<Object?> get props => [email, role];
}

// ─── Other ────────────────────────────────────────────────────────────────────

class AuthLogoutRequested extends AuthEvent {
  const AuthLogoutRequested();
}

class AuthProfileUpdateRequested extends AuthEvent {
  final String? name;
  final String? mobile;
  final String? upiId;
  final String? businessName;
  final String? businessCategory;
  final List<String>? businessCategories;
  final String? businessAddress;
  final double? customerLatitude;
  final double? customerLongitude;
  final String? customerAddress;

  const AuthProfileUpdateRequested({
    this.name,
    this.mobile,
    this.upiId,
    this.businessName,
    this.businessCategory,
    this.businessCategories,
    this.businessAddress,
    this.customerLatitude,
    this.customerLongitude,
    this.customerAddress,
  });

  @override
  List<Object?> get props =>
      [name, mobile, upiId, businessName, businessCategory, businessAddress,
       customerLatitude, customerLongitude, customerAddress];
}

class AuthUserUpdated extends AuthEvent {
  final UserModel user;
  const AuthUserUpdated(this.user);

  @override
  List<Object?> get props => [user];
}

class AuthDeleteAccountRequested extends AuthEvent {
  const AuthDeleteAccountRequested();
}
