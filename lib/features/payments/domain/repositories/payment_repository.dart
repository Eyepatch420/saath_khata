import '../../../../shared/models/payment_transaction.dart';

abstract class PaymentRepository {
  /// Load ALL payments for the logged-in customer across every linked vendor.
  /// [customerId] is accepted for BLoC compatibility but the impl fans out to
  /// all link IDs under the hood — the backend is link-scoped.
  Future<List<PaymentTransaction>> getCustomerTransactions(String customerId);

  /// Record a payment; uses [transaction.linkId] to route the API call.
  /// No real payment gateway — payment is considered recorded on submission.
  Future<PaymentTransaction> recordPayment(PaymentTransaction transaction);

  /// Fetch payments for a single link (vendor or customer view).
  Future<List<PaymentTransaction>> getPaymentsForLink(String linkId);

  /// Settle the full outstanding balance on a link in one call.
  Future<PaymentTransaction> settleBalance(String linkId);
}
