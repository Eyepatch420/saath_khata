import 'package:equatable/equatable.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import '../../../../features/vendor/domain/repositories/vendor_repository.dart';
import '../../../../shared/models/report_models.dart';

// ─── States ───────────────────────────────────────────────────────────────────

abstract class CustomerDetailState extends Equatable {
  const CustomerDetailState();

  @override
  List<Object?> get props => [];
}

class CustomerDetailInitial extends CustomerDetailState {}

class CustomerDetailLoading extends CustomerDetailState {}

class CustomerDetailLoaded extends CustomerDetailState {
  final CustomerDetailReport detail;

  const CustomerDetailLoaded(this.detail);

  @override
  List<Object?> get props => [detail];
}

class CustomerDetailError extends CustomerDetailState {
  final String message;

  const CustomerDetailError(this.message);

  @override
  List<Object?> get props => [message];
}

// ─── Cubit ────────────────────────────────────────────────────────────────────

class CustomerDetailCubit extends Cubit<CustomerDetailState> {
  final VendorRepository _repository;

  CustomerDetailCubit(this._repository) : super(CustomerDetailInitial());

  Future<void> load(String linkId) async {
    emit(CustomerDetailLoading());
    try {
      final detail = await _repository.getCustomerDetail(linkId);
      emit(CustomerDetailLoaded(detail));
    } catch (e) {
      emit(CustomerDetailError(e.toString().replaceFirst('Exception: ', '')));
    }
  }
}
