import 'package:flutter_bloc/flutter_bloc.dart';
import '../../../../shared/models/payment_transaction.dart';
import '../../domain/repositories/payment_repository.dart';
import 'payment_event.dart';
import 'payment_state.dart';
import '../../../../core/utils/app_logger.dart';

class PaymentBloc extends Bloc<PaymentEvent, PaymentState> {
  final PaymentRepository _repository;

  static const _m = 'Payment';

  PaymentBloc(this._repository) : super(PaymentInitial()) {
    on<LoadPayments>(_onLoad);
    on<RecordPayment>(_onRecord);
  }

  Future<void> _onLoad(LoadPayments event, Emitter<PaymentState> emit) async {
    AppLogger.i(_m, 'Loading payments for customerId:${event.customerId}');
    emit(PaymentLoading());
    try {
      final txns = await _repository.getCustomerTransactions(event.customerId);
      final paid = txns.where((t) => t.status == PaymentStatus.success).fold<double>(0, (s, t) => s + t.amount);
      final pending = txns.where((t) => t.status == PaymentStatus.pending).fold<double>(0, (s, t) => s + t.amount);
      AppLogger.i(_m, 'Payments loaded — ${txns.length} txns, paid:$paid pending:$pending');
      emit(PaymentLoaded(
        transactions: txns,
        totalPaid: paid,
        totalPending: pending,
      ));
    } catch (e) {
      AppLogger.e(_m, 'Load payments failed for customerId:${event.customerId}', e);
      emit(const PaymentError('Failed to load payment history'));
    }
  }

  Future<void> _onRecord(RecordPayment event, Emitter<PaymentState> emit) async {
    AppLogger.i(_m, 'Recording payment — amount:${event.transaction.amount} customerId:${event.transaction.customerId}');
    try {
      await _repository.recordPayment(event.transaction);
      AppLogger.i(_m, 'Payment recorded — refreshing list');
      add(LoadPayments(event.transaction.customerId));
    } catch (e) {
      AppLogger.e(_m, 'Record payment failed', e);
    }
  }
}
