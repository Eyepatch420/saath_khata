import 'package:equatable/equatable.dart';

// Backend payment transactions always have status 'success'.
// pending/failed/refunded are kept for potential future use but never returned by the API.
enum PaymentStatus { success, pending, failed, refunded }

enum PaymentMethod { upi, cash, bankTransfer, cheque }

extension PaymentMethodX on PaymentMethod {
  String toJson() {
    switch (this) {
      case PaymentMethod.bankTransfer:
        return 'bank_transfer';
      case PaymentMethod.cheque:
        return 'other';
      default:
        return name;
    }
  }
}

PaymentMethod _paymentMethodFromJson(String v) {
  switch (v) {
    case 'bank_transfer':
      return PaymentMethod.bankTransfer;
    case 'other':
      return PaymentMethod.cheque;
    default:
      return PaymentMethod.values.firstWhere((e) => e.name == v,
          orElse: () => PaymentMethod.cash);
  }
}

PaymentStatus _paymentStatusFromJson(String v) =>
    PaymentStatus.values.firstWhere((e) => e.name == v,
        orElse: () => PaymentStatus.success);

class PaymentTransaction extends Equatable {
  final String id;
  final String linkId;
  final String vendorId;
  final String? vendorName; // denormalized for display
  final String customerId;
  final double amount;
  final String? upiTransactionId;
  final PaymentMethod paymentMethod;
  final PaymentStatus status;
  final String? note;
  final String? ledgerEntryId;
  final String? recordedBy;
  final String createdAt; // ISO 8601

  factory PaymentTransaction.fromJson(Map<String, dynamic> json) =>
      PaymentTransaction(
        id: json['id'] as String,
        linkId: json['linkId'] as String,
        vendorId: json['vendorId'] as String,
        vendorName: json['vendorName'] as String?,
        customerId: json['customerId'] as String,
        amount: (json['amount'] as num).toDouble(),
        upiTransactionId: json['upiTransactionId'] as String?,
        paymentMethod:
            _paymentMethodFromJson(json['paymentMethod'] as String),
        status: _paymentStatusFromJson(json['status'] as String),
        note: json['note'] as String?,
        ledgerEntryId: json['ledgerEntryId'] as String?,
        recordedBy: json['recordedBy'] as String?,
        createdAt: json['createdAt'] as String,
      );

  const PaymentTransaction({
    required this.id,
    required this.linkId,
    required this.vendorId,
    this.vendorName,
    required this.customerId,
    required this.amount,
    this.upiTransactionId,
    required this.paymentMethod,
    required this.status,
    this.note,
    this.ledgerEntryId,
    this.recordedBy,
    required this.createdAt,
  });

  @override
  List<Object?> get props => [
        id,
        linkId,
        vendorId,
        vendorName,
        customerId,
        amount,
        upiTransactionId,
        paymentMethod,
        status,
        note,
        ledgerEntryId,
        recordedBy,
        createdAt,
      ];
}
