import 'package:equatable/equatable.dart';

/// Compact user info embedded in link responses (backend: UserSummary)
class UserSummary extends Equatable {
  final String id;
  final String name;
  final String? mobile;
  final String? profilePhotoUrl;
  final String? upiId;

  const UserSummary({
    required this.id,
    required this.name,
    this.mobile,
    this.profilePhotoUrl,
    this.upiId,
  });

  @override
  List<Object?> get props => [id, name, mobile, profilePhotoUrl, upiId];
}

/// Vendor summary adds business fields on top of UserSummary
class VendorSummary extends UserSummary {
  final String? businessName;
  final String? businessCategory;

  const VendorSummary({
    required super.id,
    required super.name,
    super.mobile,
    super.profilePhotoUrl,
    super.upiId,
    this.businessName,
    this.businessCategory,
  });

  @override
  List<Object?> get props => [
        ...super.props,
        businessName,
        businessCategory,
      ];
}

/// What a vendor sees in GET /api/v1/links/customers
class CustomerLinkItem extends Equatable {
  final String linkId;
  final double balance;
  final UserSummary customer;
  final String createdAt;

  const CustomerLinkItem({
    required this.linkId,
    required this.balance,
    required this.customer,
    required this.createdAt,
  });

  @override
  List<Object?> get props => [linkId, balance, customer, createdAt];
}

/// What a customer sees in GET /api/v1/links/vendors
class VendorLinkItem extends Equatable {
  final String linkId;
  final double balance;
  final VendorSummary vendor;
  final String createdAt;

  const VendorLinkItem({
    required this.linkId,
    required this.balance,
    required this.vendor,
    required this.createdAt,
  });

  @override
  List<Object?> get props => [linkId, balance, vendor, createdAt];
}
