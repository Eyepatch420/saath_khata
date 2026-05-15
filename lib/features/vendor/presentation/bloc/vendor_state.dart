import 'package:equatable/equatable.dart';
import '../../../../shared/models/link_model.dart';

abstract class VendorState extends Equatable {
  const VendorState();

  @override
  List<Object?> get props => [];
}

class VendorInitial extends VendorState {}

class VendorLoading extends VendorState {}

class VendorLoaded extends VendorState {
  final List<CustomerLinkItem> customers;
  final double totalOutstanding;
  final double todayCollection;

  const VendorLoaded({
    required this.customers,
    required this.totalOutstanding,
    required this.todayCollection,
  });

  @override
  List<Object?> get props => [customers, totalOutstanding, todayCollection];
}

class VendorError extends VendorState {
  final String message;

  const VendorError(this.message);

  @override
  List<Object?> get props => [message];
}
