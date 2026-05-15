import 'package:equatable/equatable.dart';
import '../../../../shared/models/payment_transaction.dart';

abstract class PaymentState extends Equatable {
  const PaymentState();
  @override
  List<Object?> get props => [];
}

class PaymentInitial extends PaymentState {}

class PaymentLoading extends PaymentState {}

class PaymentLoaded extends PaymentState {
  final List<PaymentTransaction> transactions;
  final double totalPaid;
  final double totalPending;

  const PaymentLoaded({
    required this.transactions,
    required this.totalPaid,
    required this.totalPending,
  });

  @override
  List<Object?> get props => [transactions, totalPaid, totalPending];
}

class PaymentError extends PaymentState {
  final String message;
  const PaymentError(this.message);
  @override
  List<Object?> get props => [message];
}
