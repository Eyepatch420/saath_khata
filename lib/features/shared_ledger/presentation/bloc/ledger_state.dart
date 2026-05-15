import 'package:equatable/equatable.dart';
import '../../../../shared/models/ledger_entry.dart';

abstract class LedgerState extends Equatable {
  const LedgerState();

  @override
  List<Object?> get props => [];
}

class LedgerInitial extends LedgerState {}

class LedgerLoading extends LedgerState {}

class LedgerActionLoading extends LedgerState {
  final List<LedgerEntry> entries;
  final double balance;
  final EntryStatus? activeFilter;

  const LedgerActionLoading({
    required this.entries,
    required this.balance,
    this.activeFilter,
  });

  @override
  List<Object?> get props => [entries, balance, activeFilter];
}

class LedgerLoaded extends LedgerState {
  final List<LedgerEntry> allEntries;
  final List<LedgerEntry> entries;
  final double balance;
  final EntryStatus? activeFilter;

  const LedgerLoaded({
    required this.allEntries,
    required this.entries,
    required this.balance,
    this.activeFilter,
  });

  @override
  List<Object?> get props => [allEntries, entries, balance, activeFilter];
}

class LedgerError extends LedgerState {
  final String message;
  const LedgerError(this.message);

  @override
  List<Object?> get props => [message];
}
