import '../../../../shared/models/ledger_entry.dart';
import '../../../../shared/models/ledger_balance.dart';

abstract class LedgerRepository {
  Future<List<LedgerEntry>> getEntries(String linkId);
  Future<LedgerEntry> addEntry(LedgerEntry entry);
  Future<LedgerEntry> confirmEntry(String entryId);
  Future<LedgerEntry> disputeEntry(String entryId, String reason);

  /// Fetch O(1) balance + stats from the denormalized link column.
  Future<LedgerBalance> getBalance(String linkId);
}
