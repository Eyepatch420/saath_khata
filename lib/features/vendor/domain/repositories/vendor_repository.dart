import '../../../../shared/models/link_model.dart';
import '../../../../shared/models/report_models.dart';

abstract class VendorRepository {
  Future<List<CustomerLinkItem>> getLinkedCustomers();
  Future<CustomerLinkItem> linkCustomer(String customerEmail);
  Future<void> deactivateLink(String linkId);
  Future<VendorSummaryReport> getVendorSummary();

  /// GET /api/v1/reports/collected-today — payments received today (paginated)
  Future<PaginatedList<CollectedTodayItem>> getCollectedToday({
    required int page,
    required int limit,
  });

  /// GET /api/v1/reports/customers — customers with outstanding balances (paginated)
  Future<PaginatedList<CustomerReportItem>> getOutstandingCustomers({
    required int page,
    required int limit,
  });
}
