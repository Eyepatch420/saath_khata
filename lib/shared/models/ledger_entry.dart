import 'package:equatable/equatable.dart';

enum EntryType { credit, payment, advance, adjustment }
enum EntryStatus { pending, confirmed, disputed, autoConfirmed }

class LedgerEntry extends Equatable {
  final String id;
  final String linkId;
  final String? vendorId;
  final String? customerId;
  final double amount;
  final EntryType type;
  final DateTime date;
  final String? description;
  final double? quantity;
  final String? unit;
  final EntryStatus status;
  final DateTime? confirmedAt;
  final bool isLocked;
  final String? disputeReason;
  final String? attachmentUrl;

  const LedgerEntry({
    required this.id,
    required this.linkId,
    this.vendorId,
    this.customerId,
    required this.amount,
    required this.type,
    required this.date,
    this.description,
    this.quantity,
    this.unit,
    required this.status,
    this.confirmedAt,
    this.isLocked = false,
    this.disputeReason,
    this.attachmentUrl,
  });

  LedgerEntry copyWith({
    EntryStatus? status,
    bool? isLocked,
    DateTime? confirmedAt,
    String? disputeReason,
  }) {
    return LedgerEntry(
      id: id,
      linkId: linkId,
      vendorId: vendorId,
      customerId: customerId,
      amount: amount,
      type: type,
      date: date,
      description: description,
      quantity: quantity,
      unit: unit,
      status: status ?? this.status,
      confirmedAt: confirmedAt ?? this.confirmedAt,
      isLocked: isLocked ?? this.isLocked,
      disputeReason: disputeReason ?? this.disputeReason,
      attachmentUrl: attachmentUrl,
    );
  }

  @override
  List<Object?> get props => [
        id,
        linkId,
        vendorId,
        customerId,
        amount,
        type,
        date,
        description,
        quantity,
        unit,
        status,
        confirmedAt,
        isLocked,
        disputeReason,
        attachmentUrl,
      ];
}
