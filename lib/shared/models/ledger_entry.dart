import 'package:equatable/equatable.dart';

enum EntryType { credit, payment, advance, adjustment }
enum EntryStatus { pending, confirmed, disputed, autoConfirmed }

extension EntryTypeX on EntryType {
  String toJson() => name; // credit, payment, advance, adjustment — all match
}

extension EntryStatusX on EntryStatus {
  String toJson() => this == EntryStatus.autoConfirmed ? 'auto_confirmed' : name;
}

EntryType _entryTypeFromJson(String v) =>
    EntryType.values.firstWhere((e) => e.name == v,
        orElse: () => EntryType.credit);

EntryStatus _entryStatusFromJson(String v) {
  if (v == 'auto_confirmed') return EntryStatus.autoConfirmed;
  return EntryStatus.values.firstWhere((e) => e.name == v,
      orElse: () => EntryStatus.pending);
}

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

  factory LedgerEntry.fromJson(Map<String, dynamic> json) => LedgerEntry(
        id: json['id'] as String,
        linkId: json['linkId'] as String,
        vendorId: json['vendorId'] as String?,
        customerId: json['customerId'] as String?,
        amount: (json['amount'] as num).toDouble(),
        type: _entryTypeFromJson(json['type'] as String),
        date: DateTime.parse(json['date'] as String),
        description: json['description'] as String?,
        quantity: json['quantity'] != null
            ? (json['quantity'] as num).toDouble()
            : null,
        unit: json['unit'] as String?,
        status: _entryStatusFromJson(json['status'] as String),
        confirmedAt: json['confirmedAt'] != null
            ? DateTime.parse(json['confirmedAt'] as String)
            : null,
        isLocked: json['isLocked'] as bool? ?? false,
        disputeReason: json['disputeReason'] as String?,
        attachmentUrl: json['attachmentUrl'] as String?,
      );

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
