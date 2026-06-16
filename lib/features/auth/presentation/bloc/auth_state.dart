import 'package:equatable/equatable.dart';
import '../../data/models/user_model.dart';

abstract class AuthState extends Equatable {
  const AuthState();

  @override
  List<Object?> get props => [];
}

class AuthInitial extends AuthState {
  const AuthInitial();
}

class AuthLoading extends AuthState {
  const AuthLoading();
}

class AuthAuthenticated extends AuthState {
  final UserModel user;
  const AuthAuthenticated(this.user);

  @override
  List<Object?> get props => [user];
}

class AuthUnauthenticated extends AuthState {
  const AuthUnauthenticated();
}

class AuthError extends AuthState {
  final String message;
  const AuthError(this.message);

  @override
  List<Object?> get props => [message];
}

// OTP send succeeded — navigate to OTP input screen
class AuthOtpSent extends AuthState {
  final String phone;
  const AuthOtpSent({required this.phone});

  @override
  List<Object?> get props => [phone];
}

// OTP verified for a NEW user — navigate to ProfileSetupScreen with signupToken
class AuthOtpVerifiedNewUser extends AuthState {
  final String phone;
  final String signupToken;
  const AuthOtpVerifiedNewUser({required this.phone, required this.signupToken});

  @override
  List<Object?> get props => [phone, signupToken];
}
