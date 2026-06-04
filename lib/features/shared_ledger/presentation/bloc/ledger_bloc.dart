import 'package:flutter_bloc/flutter_bloc.dart';
import '../../domain/repositories/ledger_repository.dart';
import 'ledger_event.dart';
import 'ledger_state.dart';
import '../../../../shared/models/ledger_entry.dart';
import '../../../../core/utils/app_logger.dart';

class LedgerBloc extends Bloc<LedgerEvent, LedgerState> {
  final LedgerRepository _repository;

  static const _m = 'Ledger';

  LedgerBloc(this._repository) : super(LedgerInitial()) {
    on<LoadLedger>(_onLoadLedger);
    on<AddLedgerEntry>(_onAddEntry);
    on<ConfirmLedgerEntry>(_onConfirmEntry);
    on<DisputeLedgerEntry>(_onDisputeEntry);
    on<FilterLedger>(_onFilterLedger);
    on<RefreshLedger>(_onRefreshLedger);
    on<SocketLedgerEntryAdded>(_onSocketEntryAdded);
    on<SocketLedgerEntryUpdated>(_onSocketEntryUpdated);
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
    AppLogger.i(_m, 'Loading ledger for linkId:${event.linkId}');
    emit(LedgerLoading());
    try {
      final entries = await _repository.getEntries(event.linkId);
      AppLogger.i(_m, 'Ledger loaded — ${entries.length} entries, balance:${_calcBalance(entries)}');
      emit(LedgerLoaded(
        allEntries: entries,
        entries: entries,
        balance: _calcBalance(entries),
      ));
    } catch (e) {
      AppLogger.e(_m, 'Ledger load failed for linkId:${event.linkId}', e);
      emit(const LedgerError('Failed to load ledger'));
    }
  }

  Future<void> _onAddEntry(AddLedgerEntry event, Emitter<LedgerState> emit) async {
    AppLogger.i(_m, 'Adding entry — amount:${event.amount} type:${event.type.name}');
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
        createdBy: '',
      );
      final created = await _repository.addEntry(newEntry);
      AppLogger.i(_m, 'Entry added — id:${created.id} amount:${created.amount}');
      final updatedAll = [created, ...current.allEntries];
      emit(LedgerLoaded(
        allEntries: updatedAll,
        entries: _applyFilter(updatedAll, current.activeFilter),
        balance: _calcBalance(updatedAll),
        activeFilter: current.activeFilter,
      ));
    } catch (e) {
      AppLogger.e(_m, 'Add entry failed', e);
      emit(LedgerLoaded(
        allEntries: current.allEntries,
        entries: current.entries,
        balance: current.balance,
        activeFilter: current.activeFilter,
      ));
    }
  }

  Future<void> _onConfirmEntry(ConfirmLedgerEntry event, Emitter<LedgerState> emit) async {
    AppLogger.i(_m, 'Confirming entry id:${event.entryId}');
    final current = state;
    if (current is! LedgerLoaded) return;

    emit(LedgerActionLoading(entries: current.entries, balance: current.balance));
    try {
      final confirmed = await _repository.confirmEntry(event.entryId);
      AppLogger.i(_m, 'Entry confirmed — id:${confirmed.id} status:${confirmed.status.name}');
      final updatedAll = current.allEntries.map((e) => e.id == confirmed.id ? confirmed : e).toList();
      emit(LedgerLoaded(
        allEntries: updatedAll,
        entries: _applyFilter(updatedAll, current.activeFilter),
        balance: _calcBalance(updatedAll),
        activeFilter: current.activeFilter,
      ));
    } catch (e) {
      AppLogger.e(_m, 'Confirm entry failed id:${event.entryId}', e);
      emit(LedgerLoaded(
        allEntries: current.allEntries,
        entries: current.entries,
        balance: current.balance,
        activeFilter: current.activeFilter,
      ));
    }
  }

  Future<void> _onDisputeEntry(DisputeLedgerEntry event, Emitter<LedgerState> emit) async {
    AppLogger.i(_m, 'Disputing entry id:${event.entryId}');
    final current = state;
    if (current is! LedgerLoaded) return;

    emit(LedgerActionLoading(entries: current.entries, balance: current.balance));
    try {
      final disputed = await _repository.disputeEntry(event.entryId, event.reason);
      AppLogger.i(_m, 'Entry disputed — id:${disputed.id} status:${disputed.status.name}');
      final updatedAll = current.allEntries.map((e) => e.id == disputed.id ? disputed : e).toList();
      emit(LedgerLoaded(
        allEntries: updatedAll,
        entries: _applyFilter(updatedAll, current.activeFilter),
        balance: _calcBalance(updatedAll),
        activeFilter: current.activeFilter,
      ));
    } catch (e) {
      AppLogger.e(_m, 'Dispute entry failed id:${event.entryId}', e);
      emit(LedgerLoaded(
        allEntries: current.allEntries,
        entries: current.entries,
        balance: current.balance,
        activeFilter: current.activeFilter,
      ));
    }
  }

  Future<void> _onRefreshLedger(
      RefreshLedger event, Emitter<LedgerState> emit) async {
    AppLogger.i(_m, 'Pull-to-refresh for linkId:${event.linkId}');
    final current = state;
    // Keep the existing entries visible — do NOT emit LedgerLoading
    try {
      final entries = await _repository.getEntries(event.linkId);
      AppLogger.i(_m, 'Refresh done — ${entries.length} entries');
      emit(LedgerLoaded(
        allEntries: entries,
        entries: current is LedgerLoaded
            ? _applyFilter(entries, current.activeFilter)
            : entries,
        balance: _calcBalance(entries),
        activeFilter: current is LedgerLoaded ? current.activeFilter : null,
      ));
    } catch (e) {
      AppLogger.e(_m, 'Refresh failed', e);
      // On failure keep existing state — don't wipe the visible data
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

  void _onSocketEntryAdded(SocketLedgerEntryAdded event, Emitter<LedgerState> emit) {
    final current = state;
    if (current is! LedgerLoaded) return;
    // Ignore if we already have this entry (our own optimistic update)
    if (current.allEntries.any((e) => e.id == event.entry.id)) return;
    AppLogger.i(_m, 'Socket: entry added id:${event.entry.id}');
    final updatedAll = [event.entry, ...current.allEntries];
    emit(LedgerLoaded(
      allEntries: updatedAll,
      entries: _applyFilter(updatedAll, current.activeFilter),
      balance: _calcBalance(updatedAll),
      activeFilter: current.activeFilter,
    ));
  }

  void _onSocketEntryUpdated(SocketLedgerEntryUpdated event, Emitter<LedgerState> emit) {
    final current = state;
    if (current is! LedgerLoaded) return;
    AppLogger.i(_m, 'Socket: entry updated id:${event.entry.id} status:${event.entry.status.name}');
    final updatedAll = current.allEntries
        .map((e) => e.id == event.entry.id ? event.entry : e)
        .toList();
    emit(LedgerLoaded(
      allEntries: updatedAll,
      entries: _applyFilter(updatedAll, current.activeFilter),
      balance: _calcBalance(updatedAll),
      activeFilter: current.activeFilter,
    ));
  }
}
