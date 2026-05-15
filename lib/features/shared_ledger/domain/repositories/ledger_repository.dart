import '../../../../shared/models/ledger_entry.dart';

abstract class LedgerRepository {
  Future<List<LedgerEntry>> getEntries(String linkId);
  Future<LedgerEntry> addEntry(LedgerEntry entry);
  Future<LedgerEntry> confirmEntry(String entryId);
  Future<LedgerEntry> disputeEntry(String entryId, String reason);
}
