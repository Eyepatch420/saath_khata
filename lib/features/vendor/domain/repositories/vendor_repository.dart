import '../../../../shared/models/link_model.dart';
import '../../../../shared/models/report_models.dart';

abstract class VendorRepository {
  /// GET /api/v1/links/customers — all linked customers with balances
  Future<List<CustomerLinkItem>> getLinkedCustomers();

  /// POST /api/v1/links — link a customer by their email address
  Future<CustomerLinkItem> linkCustomer(String customerEmail);

  /// DELETE /api/v1/links/:linkId — deactivate a link
  Future<void> deactivateLink(String linkId);

  /// GET /api/v1/reports/summary — real outstanding + this-month collection
  Future<VendorSummaryReport> getVendorSummary();
}
