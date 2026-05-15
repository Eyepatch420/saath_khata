import '../../domain/repositories/ledger_repository.dart';
import '../../../../shared/models/ledger_entry.dart';

class MockLedgerRepository implements LedgerRepository {
  final List<LedgerEntry> _entries = [
    LedgerEntry(
      id: 'e1',
      linkId: 'link1',
      vendorId: 'v1',
      customerId: 'c1',
      amount: 60.0,
      type: EntryType.credit,
      date: DateTime.now().subtract(const Duration(days: 2)),
      description: '2L Milk',
      quantity: 2,
      unit: 'litre',
      status: EntryStatus.confirmed,
      isLocked: true,
      confirmedAt: DateTime.now().subtract(const Duration(days: 1)),
    ),
    LedgerEntry(
      id: 'e2',
      linkId: 'link1',
      vendorId: 'v1',
      customerId: 'c1',
      amount: 120.0,
      type: EntryType.credit,
      date: DateTime.now().subtract(const Duration(days: 1)),
      description: '4L Milk + Curd',
      quantity: 4,
      unit: 'litre',
      status: EntryStatus.pending,
      isLocked: false,
    ),
    LedgerEntry(
      id: 'e3',
      linkId: 'link1',
      vendorId: 'v1',
      customerId: 'c1',
      amount: 500.0,
      type: EntryType.payment,
      date: DateTime.now().subtract(const Duration(days: 3)),
      description: 'Monthly payment',
      status: EntryStatus.confirmed,
      isLocked: true,
      confirmedAt: DateTime.now().subtract(const Duration(days: 2)),
    ),
    LedgerEntry(
      id: 'e4',
      linkId: 'link1',
      vendorId: 'v1',
      customerId: 'c1',
      amount: 80.0,
      type: EntryType.credit,
      date: DateTime.now(),
      description: '2L Milk + Paneer 100g',
      status: EntryStatus.pending,
      isLocked: false,
    ),
    LedgerEntry(
      id: 'e5',
      linkId: 'link1',
      vendorId: 'v1',
      customerId: 'c1',
      amount: 45.0,
      type: EntryType.credit,
      date: DateTime.now().subtract(const Duration(days: 5)),
      description: '1.5L Milk',
      status: EntryStatus.disputed,
      isLocked: false,
      disputeReason: 'Amount should be ₹40, not ₹45',
    ),
  ];

  @override
  Future<List<LedgerEntry>> getEntries(String linkId) async {
    await Future.delayed(const Duration(milliseconds: 600));
    return _entries.where((e) => e.linkId == linkId || linkId == e.linkId).toList()
      ..sort((a, b) => b.date.compareTo(a.date));
  }

  @override
  Future<LedgerEntry> addEntry(LedgerEntry entry) async {
    await Future.delayed(const Duration(milliseconds: 400));
    final newEntry = LedgerEntry(
      id: 'e${_entries.length + 1}',
      linkId: entry.linkId,
      vendorId: entry.vendorId,
      customerId: entry.customerId,
      amount: entry.amount,
      type: entry.type,
      date: entry.date,
      description: entry.description,
      quantity: entry.quantity,
      unit: entry.unit,
      status: EntryStatus.pending,
      isLocked: false,
    );
    _entries.add(newEntry);
    return newEntry;
  }

  @override
  Future<LedgerEntry> confirmEntry(String entryId) async {
    await Future.delayed(const Duration(milliseconds: 400));
    final index = _entries.indexWhere((e) => e.id == entryId);
    if (index == -1) throw Exception('Entry not found');
    final confirmed = LedgerEntry(
      id: _entries[index].id,
      linkId: _entries[index].linkId,
      vendorId: _entries[index].vendorId,
      customerId: _entries[index].customerId,
      amount: _entries[index].amount,
      type: _entries[index].type,
      date: _entries[index].date,
      description: _entries[index].description,
      quantity: _entries[index].quantity,
      unit: _entries[index].unit,
      status: EntryStatus.confirmed,
      isLocked: true,
      confirmedAt: DateTime.now(),
    );
    _entries[index] = confirmed;
    return confirmed;
  }

  @override
  Future<LedgerEntry> disputeEntry(String entryId, String reason) async {
    await Future.delayed(const Duration(milliseconds: 400));
    final index = _entries.indexWhere((e) => e.id == entryId);
    if (index == -1) throw Exception('Entry not found');
    final disputed = LedgerEntry(
      id: _entries[index].id,
      linkId: _entries[index].linkId,
      vendorId: _entries[index].vendorId,
      customerId: _entries[index].customerId,
      amount: _entries[index].amount,
      type: _entries[index].type,
      date: _entries[index].date,
      description: _entries[index].description,
      quantity: _entries[index].quantity,
      unit: _entries[index].unit,
      status: EntryStatus.disputed,
      isLocked: false,
      disputeReason: reason,
    );
    _entries[index] = disputed;
    return disputed;
  }
}
