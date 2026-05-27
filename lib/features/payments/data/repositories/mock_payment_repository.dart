import '../../../../shared/models/payment_transaction.dart';
import '../../domain/repositories/payment_repository.dart';

class MockPaymentRepository implements PaymentRepository {
  final List<PaymentTransaction> _transactions = [
    PaymentTransaction(
      id: 'pt1',
      linkId: 'lnk1',
      vendorId: 'v1',
      vendorName: 'Krishna Dairy',
      customerId: 'c1',
      amount: 500,
      upiTransactionId: 'UPI123456789',
      paymentMethod: PaymentMethod.upi,
      status: PaymentStatus.success,
      note: 'Monthly settlement',
      createdAt: DateTime.now().subtract(const Duration(days: 2)).toIso8601String(),
    ),
    PaymentTransaction(
      id: 'pt2',
      linkId: 'lnk2',
      vendorId: 'v2',
      vendorName: 'Newspaper Agency',
      customerId: 'c1',
      amount: 250,
      upiTransactionId: 'UPI987654321',
      paymentMethod: PaymentMethod.upi,
      status: PaymentStatus.success,
      createdAt: DateTime.now().subtract(const Duration(days: 7)).toIso8601String(),
    ),
    PaymentTransaction(
      id: 'pt3',
      linkId: 'lnk1',
      vendorId: 'v1',
      vendorName: 'Krishna Dairy',
      customerId: 'c1',
      amount: 1200,
      paymentMethod: PaymentMethod.cash,
      status: PaymentStatus.pending,
      note: 'Pending payment',
      createdAt: DateTime.now().subtract(const Duration(hours: 3)).toIso8601String(),
    ),
  ];

  @override
  Future<List<PaymentTransaction>> getCustomerTransactions(String customerId) async {
    await Future.delayed(const Duration(milliseconds: 400));
    return List.unmodifiable(_transactions.where((t) => t.customerId == customerId));
  }

  @override
  Future<List<PaymentTransaction>> getPaymentsForLink(String linkId) async {
    await Future.delayed(const Duration(milliseconds: 300));
    return List.unmodifiable(_transactions.where((t) => t.linkId == linkId));
  }

  @override
  Future<PaymentTransaction> settleBalance(String linkId) async {
    await Future.delayed(const Duration(milliseconds: 400));
    final settled = PaymentTransaction(
      id: 'settle${DateTime.now().millisecondsSinceEpoch}',
      linkId: linkId,
      vendorId: 'v_mock',
      customerId: 'c_mock',
      amount: 0,
      paymentMethod: PaymentMethod.upi,
      status: PaymentStatus.success,
      createdAt: DateTime.now().toIso8601String(),
    );
    _transactions.insert(0, settled);
    return settled;
  }

  @override
  Future<PaymentTransaction> recordPayment(PaymentTransaction transaction) async {
    await Future.delayed(const Duration(milliseconds: 300));
    final saved = PaymentTransaction(
      id: 'pt${DateTime.now().millisecondsSinceEpoch}',
      linkId: transaction.linkId,
      vendorId: transaction.vendorId,
      vendorName: transaction.vendorName,
      customerId: transaction.customerId,
      amount: transaction.amount,
      upiTransactionId: transaction.upiTransactionId,
      paymentMethod: transaction.paymentMethod,
      status: PaymentStatus.success,
      note: transaction.note,
      createdAt: DateTime.now().toIso8601String(),
    );
    _transactions.insert(0, saved);
    return saved;
  }
}
