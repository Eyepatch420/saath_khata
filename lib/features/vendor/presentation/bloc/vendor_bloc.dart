import 'package:flutter_bloc/flutter_bloc.dart';
import 'vendor_event.dart';
import 'vendor_state.dart';
import '../../domain/repositories/vendor_repository.dart';
import '../../../../core/utils/app_logger.dart';

class VendorBloc extends Bloc<VendorEvent, VendorState> {
  final VendorRepository _repository;

  static const _m = 'Vendor';

  VendorBloc(this._repository) : super(VendorInitial()) {
    on<LoadVendorDashboard>((event, emit) async {
      AppLogger.i(_m, 'Loading vendor dashboard...');
      emit(VendorLoading());
      try {
        final results = await Future.wait([
          _repository.getLinkedCustomers(),
          _repository.getVendorSummary(),
        ]);
        final customers = results[0] as List;
        final summary = results[1] as dynamic;
        AppLogger.i(_m, 'Dashboard loaded — ${customers.length} customers, '
            'outstanding:${summary.totalOutstanding}, collected:${summary.totalCollectedThisMonth}');
        emit(VendorLoaded(
          customers: customers.cast(),
          totalOutstanding: summary.totalOutstanding as double,
          todayCollection: summary.totalCollectedThisMonth as double,
        ));
      } catch (e) {
        AppLogger.e(_m, 'Dashboard load failed', e);
        emit(const VendorError('Failed to load dashboard'));
      }
    });
  }
}
