import 'package:flutter_bloc/flutter_bloc.dart';
import '../../../../shared/models/payment_transaction.dart';
import '../../domain/repositories/payment_repository.dart';
import 'payment_event.dart';
import 'payment_state.dart';

class PaymentBloc extends Bloc<PaymentEvent, PaymentState> {
  final PaymentRepository _repository;

  PaymentBloc(this._repository) : super(PaymentInitial()) {
    on<LoadPayments>(_onLoad);
    on<RecordPayment>(_onRecord);
  }

  Future<void> _onLoad(LoadPayments event, Emitter<PaymentState> emit) async {
    emit(PaymentLoading());
    try {
      final txns = await _repository.getCustomerTransactions(event.customerId);
      emit(PaymentLoaded(
        transactions: txns,
        totalPaid: txns
            .where((t) => t.status == PaymentStatus.success)
            .fold(0, (s, t) => s + t.amount),
        totalPending: txns
            .where((t) => t.status == PaymentStatus.pending)
            .fold(0, (s, t) => s + t.amount),
      ));
    } catch (_) {
      emit(const PaymentError('Failed to load payment history'));
    }
  }

  Future<void> _onRecord(RecordPayment event, Emitter<PaymentState> emit) async {
    try {
      await _repository.recordPayment(event.transaction);
      add(LoadPayments(event.transaction.customerId));
    } catch (_) {}
  }
}
