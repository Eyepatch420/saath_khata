import 'package:equatable/equatable.dart';
import '../../../../shared/models/ledger_entry.dart';

abstract class LedgerEvent extends Equatable {
  const LedgerEvent();

  @override
  List<Object?> get props => [];
}

class LoadLedger extends LedgerEvent {
  final String linkId;
  const LoadLedger(this.linkId);

  @override
  List<Object?> get props => [linkId];
}

class AddLedgerEntry extends LedgerEvent {
  final double amount;
  final EntryType type;
  final String? description;
  final double? quantity;
  final String? unit;
  final String linkId;
  final String vendorId;
  final String customerId;

  const AddLedgerEntry({
    required this.amount,
    required this.type,
    required this.linkId,
    required this.vendorId,
    required this.customerId,
    this.description,
    this.quantity,
    this.unit,
  });

  @override
  List<Object?> get props => [amount, type, description, quantity, unit, linkId];
}

class ConfirmLedgerEntry extends LedgerEvent {
  final String entryId;
  const ConfirmLedgerEntry(this.entryId);
  @override
  List<Object?> get props => [entryId];
}

class DisputeLedgerEntry extends LedgerEvent {
  final String entryId;
  final String reason;
  const DisputeLedgerEntry({required this.entryId, required this.reason});
  @override
  List<Object?> get props => [entryId, reason];
}

class FilterLedger extends LedgerEvent {
  final EntryStatus? filterStatus;
  const FilterLedger(this.filterStatus);
  @override
  List<Object?> get props => [filterStatus];
}
