import '../../domain/repositories/vendor_repository.dart';
import '../../../../shared/models/link_model.dart';

class MockVendorRepository implements VendorRepository {
  final List<CustomerLinkItem> _links = [
    CustomerLinkItem(
      linkId: 'link1',
      balance: 1250.0,
      customer: const UserSummary(
        id: 'c1',
        name: 'Sujeet Kumar',
        mobile: '9876543210',
      ),
      createdAt: '2026-01-15T00:00:00.000Z',
    ),
    CustomerLinkItem(
      linkId: 'link2',
      balance: 3400.0,
      customer: const UserSummary(
        id: 'c2',
        name: 'Ramesh Singh',
        mobile: '9988776655',
      ),
      createdAt: '2026-02-01T00:00:00.000Z',
    ),
    CustomerLinkItem(
      linkId: 'link3',
      balance: 0.0,
      customer: const UserSummary(
        id: 'c3',
        name: 'Anjali Sharma',
        mobile: '9123456789',
      ),
      createdAt: '2026-03-10T00:00:00.000Z',
    ),
  ];

  @override
  Future<List<CustomerLinkItem>> getLinkedCustomers() async {
    await Future.delayed(const Duration(milliseconds: 500));
    return List.from(_links);
  }

  @override
  Future<CustomerLinkItem> linkCustomer(String customerEmail) async {
    await Future.delayed(const Duration(milliseconds: 400));
    final newLink = CustomerLinkItem(
      linkId: 'link${_links.length + 1}',
      balance: 0.0,
      customer: UserSummary(
        id: 'c${_links.length + 1}',
        name: customerEmail.split('@').first,
        mobile: null,
      ),
      createdAt: DateTime.now().toIso8601String(),
    );
    _links.add(newLink);
    return newLink;
  }

  @override
  Future<void> deactivateLink(String linkId) async {
    await Future.delayed(const Duration(milliseconds: 300));
    _links.removeWhere((l) => l.linkId == linkId);
  }
}
