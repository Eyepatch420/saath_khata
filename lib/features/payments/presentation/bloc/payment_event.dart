import 'package:equatable/equatable.dart';
import '../../../../shared/models/payment_transaction.dart';

abstract class PaymentEvent extends Equatable {
  const PaymentEvent();
  @override
  List<Object?> get props => [];
}

class LoadPayments extends PaymentEvent {
  final String customerId;
  const LoadPayments(this.customerId);
  @override
  List<Object?> get props => [customerId];
}

class RecordPayment extends PaymentEvent {
  final PaymentTransaction transaction;
  const RecordPayment(this.transaction);
  @override
  List<Object?> get props => [transaction];
}
