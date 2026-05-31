import 'package:equatable/equatable.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import '../../../../features/vendor/domain/repositories/vendor_repository.dart';
import '../../../../shared/models/report_models.dart';

// ─── States ───────────────────────────────────────────────────────────────────

abstract class ReportsDashboardState extends Equatable {
  const ReportsDashboardState();

  @override
  List<Object?> get props => [];
}

class ReportsDashboardInitial extends ReportsDashboardState {}

class ReportsDashboardLoading extends ReportsDashboardState {}

class ReportsDashboardLoaded extends ReportsDashboardState {
  final VendorSummaryReport summary;
  final MonthlyRevenueReport monthlyRevenue;
  final int year;
  final bool yearChanging;

  const ReportsDashboardLoaded({
    required this.summary,
    required this.monthlyRevenue,
    required this.year,
    this.yearChanging = false,
  });

  ReportsDashboardLoaded copyWith({
    VendorSummaryReport? summary,
    MonthlyRevenueReport? monthlyRevenue,
    int? year,
    bool? yearChanging,
  }) =>
      ReportsDashboardLoaded(
        summary: summary ?? this.summary,
        monthlyRevenue: monthlyRevenue ?? this.monthlyRevenue,
        year: year ?? this.year,
        yearChanging: yearChanging ?? this.yearChanging,
      );

  @override
  List<Object?> get props => [summary, monthlyRevenue, year, yearChanging];
}

class ReportsDashboardError extends ReportsDashboardState {
  final String message;

  const ReportsDashboardError(this.message);

  @override
  List<Object?> get props => [message];
}

// ─── Cubit ────────────────────────────────────────────────────────────────────

class ReportsDashboardCubit extends Cubit<ReportsDashboardState> {
  final VendorRepository _repository;

  ReportsDashboardCubit(this._repository) : super(ReportsDashboardInitial());

  Future<void> loadDashboard() async {
    emit(ReportsDashboardLoading());
    final year = DateTime.now().year;
    try {
      final results = await Future.wait([
        _repository.getVendorSummary(),
        _repository.getMonthlyRevenue(year),
      ]);
      emit(ReportsDashboardLoaded(
        summary: results[0] as VendorSummaryReport,
        monthlyRevenue: results[1] as MonthlyRevenueReport,
        year: year,
      ));
    } catch (e) {
      emit(ReportsDashboardError(e.toString().replaceFirst('Exception: ', '')));
    }
  }

  Future<void> changeYear(int year) async {
    final current = state;
    if (current is! ReportsDashboardLoaded) return;
    emit(current.copyWith(yearChanging: true));
    try {
      final monthly = await _repository.getMonthlyRevenue(year);
      emit(current.copyWith(monthlyRevenue: monthly, year: year, yearChanging: false));
    } catch (e) {
      // Non-fatal: keep existing data, year reverts
      emit(current.copyWith(yearChanging: false));
    }
  }
}
