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

class AuthLoginRequested extends AuthEvent {
  final String email;
  final String password;

  /// The role the user chose on the role-selection screen ('vendor' or 'customer').
  /// After the API responds we verify the account role matches — if not, we reject.
  final String expectedRole;

  const AuthLoginRequested({
    required this.email,
    required this.password,
    required this.expectedRole,
  });

  @override
  List<Object?> get props => [email, password, expectedRole];
}

class AuthSignupRequested extends AuthEvent {
  final String name;
  final String email;
  final String password;
  final String role;
  final String? mobile;
  final String? upiId;
  final String? businessName;
  final String? businessCategory;
  final String? businessAddress;

  const AuthSignupRequested({
    required this.name,
    required this.email,
    required this.password,
    required this.role,
    this.mobile,
    this.upiId,
    this.businessName,
    this.businessCategory,
    this.businessAddress,
  });

  @override
  List<Object?> get props => [name, email, role];
}

class AuthLogoutRequested extends AuthEvent {
  const AuthLogoutRequested();
}

class AuthProfileUpdateRequested extends AuthEvent {
  final String? name;
  final String? mobile;
  final String? upiId;
  final String? businessName;
  final String? businessCategory;
  final String? businessAddress;

  const AuthProfileUpdateRequested({
    this.name,
    this.mobile,
    this.upiId,
    this.businessName,
    this.businessCategory,
    this.businessAddress,
  });

  @override
  List<Object?> get props =>
      [name, mobile, upiId, businessName, businessCategory, businessAddress];
}

/// Lightweight event: used after a direct API call succeeds to sync
/// the in-memory bloc state without re-triggering the full update flow.
class AuthUserUpdated extends AuthEvent {
  final UserModel user;
  const AuthUserUpdated(this.user);

  @override
  List<Object?> get props => [user];
}
