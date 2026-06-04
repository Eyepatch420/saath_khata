class VendorSearchResult {
  final String userId;
  final String name;
  final String? profilePhotoUrl;
  final String? upiId;
  final String? businessName;
  final String? businessCategory;
  final String? businessAddress;

  const VendorSearchResult({
    required this.userId,
    required this.name,
    this.profilePhotoUrl,
    this.upiId,
    this.businessName,
    this.businessCategory,
    this.businessAddress,
  });

  factory VendorSearchResult.fromJson(Map<String, dynamic> json) {
    return VendorSearchResult(
      userId: json['userId'] as String,
      name: json['name'] as String,
      profilePhotoUrl: json['profilePhotoUrl'] as String?,
      upiId: json['upiId'] as String?,
      businessName: json['businessName'] as String?,
      businessCategory: json['businessCategory'] as String?,
      businessAddress: json['businessAddress'] as String?,
    );
  }

  /// Display name: prefer business name, fall back to owner name.
  String get displayName => businessName?.isNotEmpty == true ? businessName! : name;
}
