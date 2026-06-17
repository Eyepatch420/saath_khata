import 'package:equatable/equatable.dart';

class ProductTemplate extends Equatable {
  final String id;
  final String vendorId;
  final String name;
  final String unit;
  final double pricePerUnit;
  final bool isActive;
  final DateTime createdAt;

  const ProductTemplate({
    required this.id,
    required this.vendorId,
    required this.name,
    required this.unit,
    required this.pricePerUnit,
    required this.isActive,
    required this.createdAt,
  });

  factory ProductTemplate.fromJson(Map<String, dynamic> json) => ProductTemplate(
        id: json['id'] as String,
        vendorId: json['vendorId'] as String,
        name: json['name'] as String,
        unit: json['unit'] as String,
        pricePerUnit: (json['pricePerUnit'] as num).toDouble(),
        isActive: json['isActive'] as bool? ?? true,
        createdAt: DateTime.parse(json['createdAt'] as String),
      );

  @override
  List<Object?> get props => [id, vendorId, name, unit, pricePerUnit, isActive, createdAt];
}

class BulkChargeItem extends Equatable {
  final String linkId;
  final double quantity;

  const BulkChargeItem({required this.linkId, required this.quantity});

  Map<String, dynamic> toJson() => {'linkId': linkId, 'quantity': quantity};

  @override
  List<Object?> get props => [linkId, quantity];
}

class BulkChargeResult extends Equatable {
  final List<BulkChargeSuccess> succeeded;
  final List<BulkChargeFailure> failed;

  const BulkChargeResult({required this.succeeded, required this.failed});

  factory BulkChargeResult.fromJson(Map<String, dynamic> json) {
    final raw = json;
    return BulkChargeResult(
      succeeded: (raw['succeeded'] as List<dynamic>? ?? [])
          .map((e) => BulkChargeSuccess.fromJson(e as Map<String, dynamic>))
          .toList(),
      failed: (raw['failed'] as List<dynamic>? ?? [])
          .map((e) => BulkChargeFailure.fromJson(e as Map<String, dynamic>))
          .toList(),
    );
  }

  @override
  List<Object?> get props => [succeeded, failed];
}

class BulkChargeSuccess extends Equatable {
  final String linkId;
  final String entryId;
  final double amount;

  const BulkChargeSuccess({
    required this.linkId,
    required this.entryId,
    required this.amount,
  });

  factory BulkChargeSuccess.fromJson(Map<String, dynamic> json) => BulkChargeSuccess(
        linkId: json['linkId'] as String,
        entryId: json['entryId'] as String,
        amount: (json['amount'] as num).toDouble(),
      );

  @override
  List<Object?> get props => [linkId, entryId, amount];
}

class BulkChargeFailure extends Equatable {
  final String linkId;
  final String reason;

  const BulkChargeFailure({required this.linkId, required this.reason});

  factory BulkChargeFailure.fromJson(Map<String, dynamic> json) => BulkChargeFailure(
        linkId: json['linkId'] as String,
        reason: json['reason'] as String,
      );

  @override
  List<Object?> get props => [linkId, reason];
}
