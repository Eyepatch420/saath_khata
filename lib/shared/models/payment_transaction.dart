import 'package:equatable/equatable.dart';

// Backend payment transactions always have status 'success'.
// pending/failed/refunded are kept for potential future use but never returned by the API.
enum PaymentStatus { success, pending, failed, refunded }

enum PaymentMethod { upi, cash, bankTransfer, cheque }

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
