import '../../../../shared/models/link_model.dart';

abstract class CustomerRepository {
  /// GET /api/v1/links/vendors — all linked vendors with balances
  Future<List<VendorLinkItem>> getLinkedVendors();
}
