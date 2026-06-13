import 'package:equatable/equatable.dart';

/// Discount function attached to a membership tier.
enum DiscountType { none, percentage, flat }

DiscountType _discountTypeFromJson(String? v) {
  switch (v) {
    case 'percentage':
      return DiscountType.percentage;
    case 'flat':
      return DiscountType.flat;
    default:
      return DiscountType.none;
  }
}

extension DiscountTypeX on DiscountType {
  String toJson() => name; // none | percentage | flat

  /// Human-readable label for a tier's discount, e.g. "5% off (max ₹100)".
  String describe(double value, double? cap) {
    switch (this) {
      case DiscountType.none:
        return 'No discount';
      case DiscountType.percentage:
        final base = '${value.toStringAsFixed(value % 1 == 0 ? 0 : 1)}% off';
        return cap != null ? '$base (max ₹${cap.toStringAsFixed(0)})' : base;
      case DiscountType.flat:
        return '₹${value.toStringAsFixed(0)} off per due';
    }
  }
}

/// A vendor-owned membership tier. Each vendor has exactly three (levels 1..3),
/// with editable names (default Bronze / Silver / Gold) and an optional discount.
class MembershipTier extends Equatable {
  final String id;
  final int level; // 1 = lowest, 3 = highest
  final String name;
  final DiscountType discountType;
  final double discountValue; // percent points or flat rupees
  final double? discountCap; // max discount (₹) per due; percentage only

  const MembershipTier({
    required this.id,
    required this.level,
    required this.name,
    this.discountType = DiscountType.none,
    this.discountValue = 0,
    this.discountCap,
  });

  factory MembershipTier.fromJson(Map<String, dynamic> json) => MembershipTier(
        id: json['id'] as String,
        level: (json['level'] as num).toInt(),
        name: json['name'] as String,
        discountType: _discountTypeFromJson(json['discountType'] as String?),
        discountValue: (json['discountValue'] as num?)?.toDouble() ?? 0,
        discountCap: (json['discountCap'] as num?)?.toDouble(),
      );

  /// True if this tier grants any discount.
  bool get hasDiscount =>
      discountType != DiscountType.none && discountValue > 0;

  /// Short label for the discount, e.g. "5% off (max ₹100)".
  String get discountLabel => discountType.describe(discountValue, discountCap);

  @override
  List<Object?> get props =>
      [id, level, name, discountType, discountValue, discountCap];
}
