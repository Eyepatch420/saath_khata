import '../../../../shared/models/payment_transaction.dart';

abstract class PaymentRepository {
  Future<List<PaymentTransaction>> getCustomerTransactions(String customerId);
  Future<PaymentTransaction> recordPayment(PaymentTransaction transaction);
}
