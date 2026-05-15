import 'package:flutter_bloc/flutter_bloc.dart';
import 'customer_event.dart';
import 'customer_state.dart';
import '../../domain/repositories/customer_repository.dart';

class CustomerBloc extends Bloc<CustomerEvent, CustomerState> {
  final CustomerRepository _repository;

  CustomerBloc(this._repository) : super(CustomerInitial()) {
    on<LoadCustomerDashboard>((event, emit) async {
      emit(CustomerLoading());
      try {
        final vendors = await _repository.getLinkedVendors();
        emit(CustomerLoaded(vendors: vendors, totalDue: 2450.0));
      } catch (e) {
        emit(const CustomerError('Failed to load dashboard'));
      }
    });
  }
}
