import 'package:equatable/equatable.dart';

class UserModel extends Equatable {
  final String id;
  final String name;
  final String email;
  final String role; // 'vendor' | 'customer'
  final String? mobile;
  final String? upiId;
  final String? profilePhotoUrl;
  // Vendor-only (null for customers)
  final String? businessName;
  final String? businessCategory;
  final String? businessAddress;

  const UserModel({
    required this.id,
    required this.name,
    required this.email,
    required this.role,
    this.mobile,
    this.upiId,
    this.profilePhotoUrl,
    this.businessName,
    this.businessCategory,
    this.businessAddress,
  });

  factory UserModel.fromJson(Map<String, dynamic> json) {
    // Backend returns vendor-specific fields nested under 'vendorProfile'
    final vendorProfile = json['vendorProfile'] as Map<String, dynamic>?;
    return UserModel(
      id: json['id'] as String,
      name: json['name'] as String,
      email: json['email'] as String,
      role: json['role'] as String,
      mobile: json['mobile'] as String?,
      upiId: json['upiId'] as String?,
      profilePhotoUrl: json['profilePhotoUrl'] as String?,
      businessName: vendorProfile?['businessName'] as String?,
      businessCategory: vendorProfile?['businessCategory'] as String?,
      businessAddress: vendorProfile?['businessAddress'] as String?,
    );
  }

  UserModel copyWith({
    String? name,
    String? mobile,
    String? upiId,
    String? profilePhotoUrl,
    String? businessName,
    String? businessCategory,
    String? businessAddress,
  }) =>
      UserModel(
        id: id,
        email: email,
        role: role,
        name: name ?? this.name,
        mobile: mobile ?? this.mobile,
        upiId: upiId ?? this.upiId,
        profilePhotoUrl: profilePhotoUrl ?? this.profilePhotoUrl,
        businessName: businessName ?? this.businessName,
        businessCategory: businessCategory ?? this.businessCategory,
        businessAddress: businessAddress ?? this.businessAddress,
      );

  bool get isVendor => role == 'vendor';

  @override
  List<Object?> get props =>
      [id, name, email, role, mobile, upiId, profilePhotoUrl,
       businessName, businessCategory, businessAddress];
}
