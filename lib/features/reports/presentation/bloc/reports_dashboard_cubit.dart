import 'package:equatable/equatable.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import '../../../../core/utils/app_logger.dart';
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

  static const _m = 'ReportsDashboard';

  ReportsDashboardCubit(this._repository) : super(ReportsDashboardInitial());

  Future<void> loadDashboard() async {
    AppLogger.i(_m, 'Loading dashboard — summary + monthly revenue');
    emit(ReportsDashboardLoading());
    final year = DateTime.now().year;
    try {
      final results = await Future.wait([
        _repository.getVendorSummary(),
        _repository.getMonthlyRevenue(year),
      ]);
      final summary = results[0] as VendorSummaryReport;
      final monthly = results[1] as MonthlyRevenueReport;
      AppLogger.i(_m,
          'Loaded — outstanding:${summary.totalOutstanding} '
          'collectedToday:${summary.totalCollectedToday} '
          'months:${monthly.months.length}');
      emit(ReportsDashboardLoaded(
        summary: summary,
        monthlyRevenue: monthly,
        year: year,
      ));
    } catch (e, st) {
      AppLogger.e(_m, 'Load failed', e);
      emit(ReportsDashboardError(
          e.toString().replaceFirst('Exception: ', '')));
    }
  }

  Future<void> changeYear(int year) async {
    final current = state;
    if (current is! ReportsDashboardLoaded) return;
    AppLogger.i(_m, 'Changing year to $year');
    emit(current.copyWith(yearChanging: true));
    try {
      final monthly = await _repository.getMonthlyRevenue(year);
      AppLogger.i(_m, 'Year changed — months:${monthly.months.length}');
      emit(current.copyWith(
          monthlyRevenue: monthly, year: year, yearChanging: false));
    } catch (e, st) {
      AppLogger.e(_m, 'Year change failed', e);
      emit(current.copyWith(yearChanging: false));
    }
  }
}
