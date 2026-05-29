import 'package:equatable/equatable.dart';

abstract class VendorEvent extends Equatable {
  const VendorEvent();

  @override
  List<Object> get props => [];
}

class LoadVendorDashboard extends VendorEvent {}

class RemindAllRequested extends VendorEvent {}
