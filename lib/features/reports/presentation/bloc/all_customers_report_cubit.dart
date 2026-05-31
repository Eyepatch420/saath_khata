import 'package:equatable/equatable.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import '../../../../core/utils/app_logger.dart';
import '../../../../features/vendor/domain/repositories/vendor_repository.dart';
import '../../../../shared/models/report_models.dart';

// ─── States ───────────────────────────────────────────────────────────────────

abstract class AllCustomersReportState extends Equatable {
  const AllCustomersReportState();

  @override
  List<Object?> get props => [];
}

class AllCustomersReportInitial extends AllCustomersReportState {}

class AllCustomersReportLoading extends AllCustomersReportState {}

class AllCustomersReportLoaded extends AllCustomersReportState {
  final List<CustomerReportItem> customers;

  const AllCustomersReportLoaded(this.customers);

  @override
  List<Object?> get props => [customers];
}

class AllCustomersReportError extends AllCustomersReportState {
  final String message;

  const AllCustomersReportError(this.message);

  @override
  List<Object?> get props => [message];
}

// ─── Cubit ────────────────────────────────────────────────────────────────────

class AllCustomersReportCubit extends Cubit<AllCustomersReportState> {
  final VendorRepository _repository;

  static const _m = 'AllCustomersReport';

  AllCustomersReportCubit(this._repository) : super(AllCustomersReportInitial());

  Future<void> load() async {
    AppLogger.i(_m, 'Loading all customers report');
    emit(AllCustomersReportLoading());
    try {
      final customers = await _repository.getAllCustomersReport();
      AppLogger.i(_m, 'Loaded ${customers.length} customers');
      emit(AllCustomersReportLoaded(customers));
    } catch (e, st) {
      AppLogger.e(_m, 'Load failed', e);
      emit(AllCustomersReportError(
          e.toString().replaceFirst('Exception: ', '')));
    }
  }
}
