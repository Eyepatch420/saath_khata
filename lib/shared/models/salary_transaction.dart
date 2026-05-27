import 'package:equatable/equatable.dart';

enum SalaryTransactionType { salary, advance }

SalaryTransactionType _typeFromJson(String v) =>
    SalaryTransactionType.values.firstWhere((e) => e.name == v,
        orElse: () => SalaryTransactionType.salary);

/// One entry in GET /staff/:id/salary-history
class SalaryTransaction extends Equatable {
  final String id;
  final String staffId;
  final double amount;
  final SalaryTransactionType type;
  final String? upiTransactionId;
  final String? note;
  final String createdAt;

  const SalaryTransaction({
    required this.id,
    required this.staffId,
    required this.amount,
    required this.type,
    this.upiTransactionId,
    this.note,
    required this.createdAt,
  });

  factory SalaryTransaction.fromJson(Map<String, dynamic> json) =>
      SalaryTransaction(
        id: json['id'] as String,
        staffId: json['staffId'] as String,
        amount: (json['amount'] as num).toDouble(),
        type: _typeFromJson(json['type'] as String),
        upiTransactionId: json['upiTransactionId'] as String?,
        note: json['note'] as String?,
        createdAt: json['createdAt'] as String,
      );

  @override
  List<Object?> get props =>
      [id, staffId, amount, type, upiTransactionId, note, createdAt];
}
