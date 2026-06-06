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

  factory UserSummary.fromJson(Map<String, dynamic> json) => UserSummary(
        id: json['id'] as String,
        name: json['name'] as String,
        mobile: json['mobile'] as String?,
        profilePhotoUrl: json['profilePhotoUrl'] as String?,
        upiId: json['upiId'] as String?,
      );

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

  factory VendorSummary.fromJson(Map<String, dynamic> json) => VendorSummary(
        id: json['id'] as String,
        name: json['name'] as String,
        mobile: json['mobile'] as String?,
        profilePhotoUrl: json['profilePhotoUrl'] as String?,
        upiId: json['upiId'] as String?,
        businessName: json['businessName'] as String?,
        businessCategory: json['businessCategory'] as String?,
      );

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

  /// Membership tier this customer holds with the vendor, null if none.
  final int? tierLevel; // 1 = lowest, 3 = highest
  final String? tierName;

  const CustomerLinkItem({
    required this.linkId,
    required this.balance,
    required this.customer,
    required this.createdAt,
    this.tierLevel,
    this.tierName,
  });

  factory CustomerLinkItem.fromJson(Map<String, dynamic> json) {
    final tier = json['tier'] as Map<String, dynamic>?;
    return CustomerLinkItem(
      linkId: json['linkId'] as String,
      balance: (json['balance'] as num? ?? 0).toDouble(),
      customer: UserSummary.fromJson(json['customer'] as Map<String, dynamic>),
      createdAt: json['createdAt'] as String,
      tierLevel: (tier?['level'] as num?)?.toInt(),
      tierName: tier?['name'] as String?,
    );
  }

  @override
  List<Object?> get props =>
      [linkId, balance, customer, createdAt, tierLevel, tierName];
}

/// Response from POST /api/v1/links/remind-all
class RemindAllResult extends Equatable {
  final int queued;
  final int customersCount;

  const RemindAllResult({required this.queued, required this.customersCount});

  factory RemindAllResult.fromJson(Map<String, dynamic> json) => RemindAllResult(
        queued: json['queued'] as int,
        customersCount: json['customersCount'] as int? ?? json['queued'] as int,
      );

  @override
  List<Object?> get props => [queued, customersCount];
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

  factory VendorLinkItem.fromJson(Map<String, dynamic> json) => VendorLinkItem(
        linkId: json['linkId'] as String,
        balance: (json['balance'] as num? ?? 0).toDouble(),
        vendor: VendorSummary.fromJson(json['vendor'] as Map<String, dynamic>),
        createdAt: json['createdAt'] as String,
      );

  @override
  List<Object?> get props => [linkId, balance, vendor, createdAt];
}
