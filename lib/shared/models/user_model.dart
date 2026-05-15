import 'package:equatable/equatable.dart';

enum UserRole { vendor, customer }

class VendorProfile extends Equatable {
  final String? businessName;
  final String? businessCategory;
  final String? businessAddress;

  const VendorProfile({
    this.businessName,
    this.businessCategory,
    this.businessAddress,
  });

  @override
  List<Object?> get props => [businessName, businessCategory, businessAddress];
}

class UserModel extends Equatable {
  final String id;
  final String name;
  final String email;
  final String? mobile;
  final UserRole role;
  final String? upiId;
  final String? profilePhotoUrl;
  final VendorProfile? vendorProfile;

  const UserModel({
    required this.id,
    required this.name,
    required this.email,
    required this.role,
    this.mobile,
    this.upiId,
    this.profilePhotoUrl,
    this.vendorProfile,
  });

  @override
  List<Object?> get props => [
        id,
        name,
        email,
        mobile,
        role,
        upiId,
        profilePhotoUrl,
        vendorProfile,
      ];
}
