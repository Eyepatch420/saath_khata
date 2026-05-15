import 'package:flutter_bloc/flutter_bloc.dart';
import '../../domain/repositories/ledger_repository.dart';
import 'ledger_event.dart';
import 'ledger_state.dart';
import '../../../../shared/models/ledger_entry.dart';

class LedgerBloc extends Bloc<LedgerEvent, LedgerState> {
  final LedgerRepository _repository;

  LedgerBloc(this._repository) : super(LedgerInitial()) {
    on<LoadLedger>(_onLoadLedger);
    on<AddLedgerEntry>(_onAddEntry);
    on<ConfirmLedgerEntry>(_onConfirmEntry);
    on<DisputeLedgerEntry>(_onDisputeEntry);
    on<FilterLedger>(_onFilterLedger);
  }

  double _calcBalance(List<LedgerEntry> entries) {
    double balance = 0;
    for (final entry in entries) {
      if (entry.type == EntryType.credit) {
        balance += entry.amount;
      } else if (entry.type == EntryType.payment) {
        balance -= entry.amount;
      }
    }
    return balance;
  }

  List<LedgerEntry> _applyFilter(List<LedgerEntry> all, EntryStatus? filter) {
    if (filter == null) return all;
    return all.where((e) => e.status == filter).toList();
  }

  Future<void> _onLoadLedger(LoadLedger event, Emitter<LedgerState> emit) async {
    emit(LedgerLoading());
    try {
      final entries = await _repository.getEntries(event.linkId);
      emit(LedgerLoaded(
        allEntries: entries,
        entries: entries,
        balance: _calcBalance(entries),
      ));
    } catch (_) {
      emit(const LedgerError('Failed to load ledger'));
    }
  }

  Future<void> _onAddEntry(AddLedgerEntry event, Emitter<LedgerState> emit) async {
    final current = state;
    if (current is! LedgerLoaded) return;

    emit(LedgerActionLoading(entries: current.entries, balance: current.balance));
    try {
      final newEntry = LedgerEntry(
        id: '',
        linkId: event.linkId,
        vendorId: event.vendorId,
        customerId: event.customerId,
        amount: event.amount,
        type: event.type,
        date: DateTime.now(),
        description: event.description,
        quantity: event.quantity,
        unit: event.unit,
        status: EntryStatus.pending,
      );
      final created = await _repository.addEntry(newEntry);
      final updatedAll = [created, ...current.allEntries];
      emit(LedgerLoaded(
        allEntries: updatedAll,
        entries: _applyFilter(updatedAll, current.activeFilter),
        balance: _calcBalance(updatedAll),
        activeFilter: current.activeFilter,
      ));
    } catch (_) {
      emit(LedgerLoaded(
        allEntries: current.allEntries,
        entries: current.entries,
        balance: current.balance,
        activeFilter: current.activeFilter,
      ));
    }
  }

  Future<void> _onConfirmEntry(ConfirmLedgerEntry event, Emitter<LedgerState> emit) async {
    final current = state;
    if (current is! LedgerLoaded) return;

    emit(LedgerActionLoading(entries: current.entries, balance: current.balance));
    try {
      final confirmed = await _repository.confirmEntry(event.entryId);
      final updatedAll = current.allEntries.map((e) => e.id == confirmed.id ? confirmed : e).toList();
      emit(LedgerLoaded(
        allEntries: updatedAll,
        entries: _applyFilter(updatedAll, current.activeFilter),
        balance: _calcBalance(updatedAll),
        activeFilter: current.activeFilter,
      ));
    } catch (_) {
      emit(LedgerLoaded(
        allEntries: current.allEntries,
        entries: current.entries,
        balance: current.balance,
        activeFilter: current.activeFilter,
      ));
    }
  }

  Future<void> _onDisputeEntry(DisputeLedgerEntry event, Emitter<LedgerState> emit) async {
    final current = state;
    if (current is! LedgerLoaded) return;

    emit(LedgerActionLoading(entries: current.entries, balance: current.balance));
    try {
      final disputed = await _repository.disputeEntry(event.entryId, event.reason);
      final updatedAll = current.allEntries.map((e) => e.id == disputed.id ? disputed : e).toList();
      emit(LedgerLoaded(
        allEntries: updatedAll,
        entries: _applyFilter(updatedAll, current.activeFilter),
        balance: _calcBalance(updatedAll),
        activeFilter: current.activeFilter,
      ));
    } catch (_) {
      emit(LedgerLoaded(
        allEntries: current.allEntries,
        entries: current.entries,
        balance: current.balance,
        activeFilter: current.activeFilter,
      ));
    }
  }

  void _onFilterLedger(FilterLedger event, Emitter<LedgerState> emit) {
    final current = state;
    if (current is! LedgerLoaded) return;
    emit(LedgerLoaded(
      allEntries: current.allEntries,
      entries: _applyFilter(current.allEntries, event.filterStatus),
      balance: current.balance,
      activeFilter: event.filterStatus,
    ));
  }
}
