import 'package:dio/dio.dart';
import '../../../../core/network/api_client.dart';
import '../../../../core/network/api_endpoints.dart';
import '../../domain/repositories/payment_repository.dart';
import '../../../../shared/models/payment_transaction.dart';

class PaymentRepositoryImpl implements PaymentRepository {
  final ApiClient _api;

  PaymentRepositoryImpl(this._api);

  // ─── Helpers ───────────────────────────────────────────────────────────────

  Future<List<PaymentTransaction>> _fetchForLink(String linkId) async {
    final response = await _api.get(
      ApiEndpoints.linkPayments(linkId),
      queryParameters: {'page': 1, 'limit': 100},
    );
    final data = ApiClient.extractData(response);
    final list = (data['payments'] as List?) ?? [];
    return list
        .map((e) => PaymentTransaction.fromJson(e as Map<String, dynamic>))
        .toList();
  }

  // ─── Interface ─────────────────────────────────────────────────────────────

  /// Fan-out: fetches all vendor links then loads payments for each.
  /// The backend scopes payments to a linkId so we aggregate here.
  @override
  Future<List<PaymentTransaction>> getCustomerTransactions(
      String customerId) async {
    try {
      // Step 1 — get the list of links for this customer
      final linksRes = await _api.get(ApiEndpoints.myVendors);
      final linksList =
          (linksRes.data as Map<String, dynamic>)['data'] as List;

      if (linksList.isEmpty) return [];

      // Step 2 — fetch payments for each link in parallel
      final futures = linksList.map((link) async {
        final linkId = link['linkId'] as String?;
        if (linkId == null) return <PaymentTransaction>[];
        try {
          return await _fetchForLink(linkId);
        } catch (_) {
          return <PaymentTransaction>[];
        }
      }).toList();

      final nested = await Future.wait(futures);
      final all = nested.expand((e) => e).toList()
        ..sort((a, b) => b.createdAt.compareTo(a.createdAt));
      return all;
    } on DioException catch (e) {
      throw Exception(ApiClient.extractErrorMessage(e));
    }
  }

  /// Records a payment directly to the backend — no gateway involved.
  /// The UPI app selection / transaction ID is purely informational.
  @override
  Future<PaymentTransaction> recordPayment(
      PaymentTransaction transaction) async {
    try {
      final body = <String, dynamic>{
        'amount': transaction.amount,
        'paymentMethod': transaction.paymentMethod.toJson(),
      };
      if (transaction.upiTransactionId != null) {
        body['upiTransactionId'] = transaction.upiTransactionId;
      }
      if (transaction.note != null) body['note'] = transaction.note;

      final response = await _api.post(
        ApiEndpoints.linkPayments(transaction.linkId),
        data: body,
      );
      return PaymentTransaction.fromJson(ApiClient.extractData(response));
    } on DioException catch (e) {
      throw Exception(ApiClient.extractErrorMessage(e));
    }
  }

  @override
  Future<List<PaymentTransaction>> getPaymentsForLink(String linkId) async {
    try {
      return await _fetchForLink(linkId);
    } on DioException catch (e) {
      throw Exception(ApiClient.extractErrorMessage(e));
    }
  }

  @override
  Future<PaymentTransaction> settleBalance(String linkId) async {
    try {
      final response = await _api.post(ApiEndpoints.settleLink(linkId));
      // settleLink returns { payment: {...}, settledAmount, previousBalance }
      final data = ApiClient.extractData(response);
      return PaymentTransaction.fromJson(
          data['payment'] as Map<String, dynamic>);
    } on DioException catch (e) {
      throw Exception(ApiClient.extractErrorMessage(e));
    }
  }
}
