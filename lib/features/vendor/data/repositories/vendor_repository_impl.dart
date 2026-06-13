import 'package:dio/dio.dart';
import '../../../../core/network/api_client.dart';
import '../../../../core/network/api_endpoints.dart';
import '../../domain/repositories/vendor_repository.dart';
import '../../../../shared/models/link_model.dart';
import '../../../../shared/models/report_models.dart';

class VendorRepositoryImpl implements VendorRepository {
  final ApiClient _api;

  VendorRepositoryImpl(this._api);

  @override
  Future<List<CustomerLinkItem>> getLinkedCustomers() async {
    try {
      final response = await _api.get(ApiEndpoints.myCustomers);
      // data is a JSON array directly, not a map
      final list = (response.data as Map<String, dynamic>)['data'] as List;
      return list
          .map((e) => CustomerLinkItem.fromJson(e as Map<String, dynamic>))
          .toList();
    } on DioException catch (e) {
      throw Exception(ApiClient.extractErrorMessage(e));
    }
  }

  @override
  Future<CustomerLinkItem> linkCustomer(String identifier) async {
    try {
      // Detect whether the vendor entered an email or a 10-digit phone number
      // and send the matching field — the backend accepts either.
      final trimmed = identifier.trim();
      final isPhone = RegExp(r'^[6-9]\d{9}$').hasMatch(trimmed);
      final body = isPhone
          ? {'customerPhone': trimmed}
          : {'customerEmail': trimmed};
      final response = await _api.post(ApiEndpoints.links, data: body);
      final data = ApiClient.extractData(response);
      // Backend returns full LinkResponse; we reshape to CustomerLinkItem
      return CustomerLinkItem(
        linkId: data['id'] as String,
        balance: (data['balance'] as num).toDouble(),
        customer: UserSummary.fromJson(data['customer'] as Map<String, dynamic>),
        createdAt: data['createdAt'] as String,
      );
    } on DioException catch (e) {
      throw Exception(ApiClient.extractErrorMessage(e));
    }
  }

  @override
  Future<void> deactivateLink(String linkId) async {
    try {
      await _api.delete(ApiEndpoints.linkById(linkId));
    } on DioException catch (e) {
      throw Exception(ApiClient.extractErrorMessage(e));
    }
  }

  @override
  Future<VendorSummaryReport> getVendorSummary() async {
    try {
      final response = await _api.get(ApiEndpoints.reportSummary);
      return VendorSummaryReport.fromJson(ApiClient.extractData(response));
    } on DioException catch (e) {
      throw Exception(ApiClient.extractErrorMessage(e));
    }
  }

  @override
  Future<RemindAllResult> remindAll() async {
    try {
      final response = await _api.post(ApiEndpoints.remindAll);
      return RemindAllResult.fromJson(ApiClient.extractData(response));
    } on DioException catch (e) {
      throw Exception(ApiClient.extractErrorMessage(e));
    }
  }

  @override
  Future<PaginatedList<CollectedTodayItem>> getCollectedToday({
    required int page,
    required int limit,
  }) async {
    try {
      final response = await _api.get(
        ApiEndpoints.reportCollectedToday,
        queryParameters: {'page': page, 'limit': limit},
      );
      final data = ApiClient.extractData(response);
      final items = (data['items'] as List)
          .map((e) => CollectedTodayItem.fromJson(e as Map<String, dynamic>))
          .toList();
      return PaginatedList(items: items, hasMore: data['hasMore'] as bool? ?? false);
    } on DioException catch (e) {
      throw Exception(ApiClient.extractErrorMessage(e));
    }
  }

  @override
  Future<PaginatedList<CustomerReportItem>> getOutstandingCustomers({
    required int page,
    required int limit,
  }) async {
    try {
      final response = await _api.get(
        ApiEndpoints.reportOutstanding,
        queryParameters: {'page': page, 'limit': limit},
      );
      final data = ApiClient.extractData(response);
      final items = (data['items'] as List)
          .map((e) => CustomerReportItem.fromJson(e as Map<String, dynamic>))
          .toList();
      return PaginatedList(items: items, hasMore: data['hasMore'] as bool? ?? false);
    } on DioException catch (e) {
      throw Exception(ApiClient.extractErrorMessage(e));
    }
  }

  @override
  Future<List<CustomerReportItem>> getAllCustomersReport() async {
    try {
      final response = await _api.get(ApiEndpoints.reportCustomers);
      // The /reports/customers endpoint returns data as a JSON array, not an
      // object — extractData() casts to Map which would throw. Read the list
      // directly from the response body instead.
      final list =
          (response.data as Map<String, dynamic>)['data'] as List;
      return list
          .map((e) => CustomerReportItem.fromJson(e as Map<String, dynamic>))
          .toList();
    } on DioException catch (e) {
      throw Exception(ApiClient.extractErrorMessage(e));
    }
  }

  @override
  Future<CustomerDetailReport> getCustomerDetail(String linkId) async {
    try {
      final response = await _api.get(ApiEndpoints.reportCustomerDetail(linkId));
      return CustomerDetailReport.fromJson(ApiClient.extractData(response));
    } on DioException catch (e) {
      throw Exception(ApiClient.extractErrorMessage(e));
    }
  }

  @override
  Future<MonthlyRevenueReport> getMonthlyRevenue(int year) async {
    try {
      final response = await _api.get(
        ApiEndpoints.reportMonthly,
        queryParameters: {'year': year},
      );
      return MonthlyRevenueReport.fromJson(ApiClient.extractData(response));
    } on DioException catch (e) {
      throw Exception(ApiClient.extractErrorMessage(e));
    }
  }
}
