import 'package:equatable/equatable.dart';
import 'upi_id_model.dart';

class UserModel extends Equatable {
  final String id;
  final String name;
  final String email;
  final String role; // 'vendor' | 'customer'
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
    this.businessLatitude,
    this.businessLongitude,
    this.upiIds,
  });

  factory UserModel.fromJson(Map<String, dynamic> json) {
    final vendorProfile = json['vendorProfile'] as Map<String, dynamic>?;
    final rawUpiIds = vendorProfile?['upiIds'] as List<dynamic>?;
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
      businessLatitude: (vendorProfile?['businessLatitude'] as num?)?.toDouble(),
      businessLongitude: (vendorProfile?['businessLongitude'] as num?)?.toDouble(),
      upiIds: rawUpiIds
          ?.map((e) => UpiIdModel.fromJson(e as Map<String, dynamic>))
          .toList(),
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
      );

  bool get isVendor => role == 'vendor';

  UpiIdModel? get primaryUpiId =>
      upiIds?.firstWhere((u) => u.isPrimary, orElse: () => upiIds!.first);

  @override
  List<Object?> get props => [
        id, name, email, role, mobile, upiId, profilePhotoUrl,
        businessName, businessCategory, businessAddress,
        businessLatitude, businessLongitude, upiIds,
      ];
}
