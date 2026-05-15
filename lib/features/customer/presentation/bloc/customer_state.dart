import 'package:equatable/equatable.dart';
import '../../../../shared/models/link_model.dart';

abstract class CustomerState extends Equatable {
  const CustomerState();

  @override
  List<Object?> get props => [];
}

class CustomerInitial extends CustomerState {}

class CustomerLoading extends CustomerState {}

class CustomerLoaded extends CustomerState {
  final List<VendorLinkItem> vendors;
  final double totalDue;

  const CustomerLoaded({required this.vendors, required this.totalDue});

  @override
  List<Object?> get props => [vendors, totalDue];
}

class CustomerError extends CustomerState {
  final String message;
  const CustomerError(this.message);

  @override
  List<Object?> get props => [message];
}
