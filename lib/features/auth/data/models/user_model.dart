import 'package:equatable/equatable.dart';
import 'upi_id_model.dart';

/// Staff app-access context — present only when role == 'staff'.
/// Identifies the owner vendor whose data this staff login acts on.
class StaffProfile extends Equatable {
  final String staffId;
  final String vendorId;
  final String? businessName;
  final String? businessCategory;
  final String? qrCodeUrl;

  const StaffProfile({
    required this.staffId,
    required this.vendorId,
    this.businessName,
    this.businessCategory,
    this.qrCodeUrl,
  });

  factory StaffProfile.fromJson(Map<String, dynamic> json) => StaffProfile(
        staffId: json['staffId'] as String,
        vendorId: json['vendorId'] as String,
        businessName: json['businessName'] as String?,
        businessCategory: json['businessCategory'] as String?,
        qrCodeUrl: json['qrCodeUrl'] as String?,
      );

  StaffProfile copyWith({String? qrCodeUrl}) => StaffProfile(
        staffId: staffId,
        vendorId: vendorId,
        businessName: businessName,
        businessCategory: businessCategory,
        qrCodeUrl: qrCodeUrl ?? this.qrCodeUrl,
      );

  @override
  List<Object?> get props =>
      [staffId, vendorId, businessName, businessCategory, qrCodeUrl];
}

class UserModel extends Equatable {
  final String id;
  final String name;
  final String? email; // null for OTP-only and staff accounts
  final String role; // 'vendor' | 'customer' | 'staff'
  final String? mobile;
  final String? upiId; // customer single-UPI only; null for vendors
  final String? profilePhotoUrl;
  // Vendor-only fields (null for customers)
  final String? businessName;
  final String? businessCategory;
  final String? businessAddress;
  final double? businessLatitude;
  final double? businessLongitude;
  final List<UpiIdModel>? upiIds; // vendor multi-UPI; null for customers
  final StaffProfile? staffProfile; // present only when role == 'staff'

  const UserModel({
    required this.id,
    required this.name,
    this.email,
    required this.role,
    this.mobile,
    this.upiId,
    this.profilePhotoUrl,
    this.businessName,
    this.businessCategory,
    this.businessAddress,
    this.businessLatitude,
    this.businessLongitude,
    this.upiIds,
    this.staffProfile,
  });

  factory UserModel.fromJson(Map<String, dynamic> json) {
    final vendorProfile = json['vendorProfile'] as Map<String, dynamic>?;
    final rawUpiIds = vendorProfile?['upiIds'] as List<dynamic>?;
    final staff = json['staffProfile'] as Map<String, dynamic>?;
    return UserModel(
      id: json['id'] as String,
      name: json['name'] as String,
      email: json['email'] as String?,
      role: json['role'] as String,
      mobile: json['mobile'] as String?,
      upiId: json['upiId'] as String?,
      profilePhotoUrl: json['profilePhotoUrl'] as String?,
      businessName: vendorProfile?['businessName'] as String?,
      businessCategory: vendorProfile?['businessCategory'] as String?,
      businessAddress: vendorProfile?['businessAddress'] as String?,
      businessLatitude: (vendorProfile?['businessLatitude'] as num?)?.toDouble(),
      businessLongitude: (vendorProfile?['businessLongitude'] as num?)?.toDouble(),
      upiIds: rawUpiIds
          ?.map((e) => UpiIdModel.fromJson(e as Map<String, dynamic>))
          .toList(),
      staffProfile: staff != null ? StaffProfile.fromJson(staff) : null,
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
    double? businessLatitude,
    double? businessLongitude,
    List<UpiIdModel>? upiIds,
    StaffProfile? staffProfile,
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
        businessLatitude: businessLatitude ?? this.businessLatitude,
        businessLongitude: businessLongitude ?? this.businessLongitude,
        upiIds: upiIds ?? this.upiIds,
        staffProfile: staffProfile ?? this.staffProfile,
      );

  bool get isVendor => role == 'vendor';
  bool get isStaff => role == 'staff';

  /// The business this account belongs to — own business for a vendor, the
  /// owner's business for a staff member.
  String? get effectiveBusinessName =>
      isStaff ? staffProfile?.businessName : businessName;

  UpiIdModel? get primaryUpiId =>
      upiIds?.firstWhere((u) => u.isPrimary, orElse: () => upiIds!.first);

  @override
  List<Object?> get props => [
        id, name, email, role, mobile, upiId, profilePhotoUrl,
        businessName, businessCategory, businessAddress,
        businessLatitude, businessLongitude, upiIds, staffProfile,
      ];
}
