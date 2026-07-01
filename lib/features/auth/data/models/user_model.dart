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
  // Customer-only fields (null for vendors)
  final double? customerLatitude;
  final double? customerLongitude;
  final String? customerAddress;

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
    this.customerLatitude,
    this.customerLongitude,
    this.customerAddress,
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
      customerLatitude: (json['customerLocation']?['latitude'] as num?)?.toDouble(),
      customerLongitude: (json['customerLocation']?['longitude'] as num?)?.toDouble(),
      customerAddress: json['customerLocation']?['address'] as String?,
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
    double? customerLatitude,
    double? customerLongitude,
    String? customerAddress,
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
        customerLatitude: customerLatitude ?? this.customerLatitude,
        customerLongitude: customerLongitude ?? this.customerLongitude,
        customerAddress: customerAddress ?? this.customerAddress,
      );

  bool get isVendor => role == 'vendor';

  UpiIdModel? get primaryUpiId =>
      upiIds?.firstWhere((u) => u.isPrimary, orElse: () => upiIds!.first);

  @override
  List<Object?> get props => [
        id, name, email, role, mobile, upiId, profilePhotoUrl,
        businessName, businessCategory, businessAddress,
        businessLatitude, businessLongitude, upiIds,
        customerLatitude, customerLongitude, customerAddress,
      ];
}
