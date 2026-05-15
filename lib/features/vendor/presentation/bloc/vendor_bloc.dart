import 'package:flutter_bloc/flutter_bloc.dart';
import 'vendor_event.dart';
import 'vendor_state.dart';
import '../../domain/repositories/vendor_repository.dart';

class VendorBloc extends Bloc<VendorEvent, VendorState> {
  final VendorRepository _repository;

  VendorBloc(this._repository) : super(VendorInitial()) {
    on<LoadVendorDashboard>((event, emit) async {
      emit(VendorLoading());
      try {
        final customers = await _repository.getLinkedCustomers();
        // Calculate dummy totals
        double total = 0;
        for (var _ in customers) {
          total += 1250.0; // Dummy outstanding per customer
        }
        emit(VendorLoaded(
          customers: customers,
          totalOutstanding: total,
          todayCollection: 450.0,
        ));
      } catch (e) {
        emit(const VendorError('Failed to load dashboard'));
      }
    });
  }
}
