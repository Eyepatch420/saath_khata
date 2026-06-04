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

  const AddLedgerEntry({
    required this.amount,
    required this.type,
    required this.linkId,
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

/// Silent pull-to-refresh — fetches from the API without emitting LedgerLoading,
/// so existing entries stay visible while the indicator spins at the top.
class RefreshLedger extends LedgerEvent {
  final String linkId;
  const RefreshLedger(this.linkId);

  @override
  List<Object?> get props => [linkId];
}

class SocketLedgerEntryAdded extends LedgerEvent {
  final LedgerEntry entry;
  const SocketLedgerEntryAdded(this.entry);
  @override
  List<Object?> get props => [entry];
}

class SocketLedgerEntryUpdated extends LedgerEvent {
  final LedgerEntry entry;
  const SocketLedgerEntryUpdated(this.entry);
  @override
  List<Object?> get props => [entry];
}
