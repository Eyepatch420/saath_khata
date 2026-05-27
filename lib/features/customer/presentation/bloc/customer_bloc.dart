import 'package:flutter_bloc/flutter_bloc.dart';
import 'customer_event.dart';
import 'customer_state.dart';
import '../../domain/repositories/customer_repository.dart';
import '../../../../core/utils/app_logger.dart';

class CustomerBloc extends Bloc<CustomerEvent, CustomerState> {
  final CustomerRepository _repository;

  static const _m = 'Customer';

  CustomerBloc(this._repository) : super(CustomerInitial()) {
    on<LoadCustomerDashboard>((event, emit) async {
      AppLogger.i(_m, 'Loading customer dashboard...');
      emit(CustomerLoading());
      try {
        final vendors = await _repository.getLinkedVendors();
        AppLogger.i(_m, 'Dashboard loaded — ${vendors.length} linked vendors');
        emit(CustomerLoaded(vendors: vendors, totalDue: 2450.0));
      } catch (e) {
        AppLogger.e(_m, 'Dashboard load failed', e);
        emit(const CustomerError('Failed to load dashboard'));
      }
    });
  }
}
