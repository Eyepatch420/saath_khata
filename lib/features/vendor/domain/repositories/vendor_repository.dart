import '../../../../shared/models/link_model.dart';
import '../../../../shared/models/report_models.dart';

abstract class VendorRepository {
  Future<List<CustomerLinkItem>> getLinkedCustomers();
  /// Links where this vendor user is the customer (vendor-to-vendor connections).
  Future<List<VendorLinkItem>> getLinkedVendors();
  /// Link a customer by their email OR 10-digit phone number.
  Future<CustomerLinkItem> linkCustomer(String identifier);
  Future<void> deactivateLink(String linkId);
  Future<VendorSummaryReport> getVendorSummary();
  Future<RemindAllResult> remindAll();

  /// GET /api/v1/reports/collected-today — payments received today (paginated)
  Future<PaginatedList<CollectedTodayItem>> getCollectedToday({
    required int page,
    required int limit,
  });

  /// GET /api/v1/reports/outstanding — customers with positive balance (paginated)
  Future<PaginatedList<CustomerReportItem>> getOutstandingCustomers({
    required int page,
    required int limit,
  });

  /// GET /api/v1/reports/customers — all customers ranked by balance (for reports)
  Future<List<CustomerReportItem>> getAllCustomersReport();

  /// GET /api/v1/reports/customers/:linkId — full customer detail with monthly breakdown
  Future<CustomerDetailReport> getCustomerDetail(String linkId);

  /// GET /api/v1/reports/monthly?year= — 12-month revenue trend
  Future<MonthlyRevenueReport> getMonthlyRevenue(int year);
}
