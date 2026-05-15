import '../../domain/repositories/customer_repository.dart';
import '../../../../shared/models/link_model.dart';

class MockCustomerRepository implements CustomerRepository {
  @override
  Future<List<VendorLinkItem>> getLinkedVendors() async {
    await Future.delayed(const Duration(milliseconds: 500));
    return [
      VendorLinkItem(
        linkId: 'link1',
        balance: 1250.0,
        vendor: const VendorSummary(
          id: 'v1',
          name: 'Krishna Dairy',
          mobile: '9876543210',
          businessName: 'Krishna Dairy',
          businessCategory: 'Milk / Dairy',
        ),
        createdAt: '2026-01-15T00:00:00.000Z',
      ),
      VendorLinkItem(
        linkId: 'link2',
        balance: 320.0,
        vendor: const VendorSummary(
          id: 'v2',
          name: 'Ramesh Newspaper',
          mobile: '9988776655',
          businessName: 'Ramesh Newspaper',
          businessCategory: 'Newspaper',
        ),
        createdAt: '2026-02-01T00:00:00.000Z',
      ),
    ];
  }
}
