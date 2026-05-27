import 'package:flutter_bloc/flutter_bloc.dart';
import '../../domain/repositories/staff_repository.dart';
import '../../../../shared/models/staff_model.dart';
import 'staff_event.dart';
import 'staff_state.dart';
import '../../../../core/utils/app_logger.dart';

class StaffBloc extends Bloc<StaffEvent, StaffState> {
  final StaffRepository _repository;

  static const _m = 'Staff';

  StaffBloc(this._repository) : super(StaffInitial()) {
    on<LoadStaff>(_onLoad);
    on<AddStaff>(_onAddStaff);
    on<MarkAttendance>(_onMarkAttendance);
    on<LoadAttendance>(_onLoadAttendance);
    on<PaySalary>(_onPaySalary);
    on<AddAdvance>(_onAddAdvance);
  }

  Future<void> _onLoad(LoadStaff event, Emitter<StaffState> emit) async {
    AppLogger.i(_m, 'Loading staff list...');
    emit(StaffLoading());
    try {
      final staff = await _repository.getStaffList();
      AppLogger.i(_m, 'Staff loaded — ${staff.length} members, ${staff.where((s) => s.presentToday).length} present today');
      emit(StaffLoaded(
        staffList: staff,
        presentCount: staff.where((s) => s.presentToday).length,
        totalUnpaidSalary: staff.fold(0, (sum, s) => sum + s.unpaidSalary),
      ));
    } catch (e) {
      AppLogger.e(_m, 'Staff load failed', e);
      emit(const StaffError('Failed to load staff'));
    }
  }

  Future<void> _onAddStaff(AddStaff event, Emitter<StaffState> emit) async {
    AppLogger.i(_m, 'Adding staff member: ${event.staff.name}');
    final current = state;
    emit(StaffActionLoading());
    try {
      final newStaff = await _repository.addStaff(event.staff);
      AppLogger.i(_m, 'Staff added — id:${newStaff.id} name:${newStaff.name}');
      if (current is StaffLoaded) {
        final updated = [...current.staffList, newStaff];
        emit(StaffLoaded(
          staffList: updated,
          presentCount: updated.where((s) => s.presentToday).length,
          totalUnpaidSalary: updated.fold(0, (sum, s) => sum + s.unpaidSalary),
        ));
      } else {
        add(LoadStaff());
      }
    } catch (e) {
      AppLogger.e(_m, 'Add staff failed', e);
      emit(const StaffError('Failed to add staff'));
    }
  }

  Future<void> _onMarkAttendance(MarkAttendance event, Emitter<StaffState> emit) async {
    final current = state;
    AppLogger.i(_m, 'Marking attendance — staffId:${event.staffId} date:${event.date} status:${event.status.name}');
    try {
      await _repository.markAttendance(event.staffId, event.date, event.status);
      AppLogger.i(_m, 'Attendance marked');

      if (current is StaffDetailLoaded) {
        // Optimistic in-place update keeps the calendar visible without a full reload
        final key =
            '${event.date.year}-${event.date.month.toString().padLeft(2, '0')}-${event.date.day.toString().padLeft(2, '0')}';
        final updated = Map<String, AttendanceStatus>.from(current.attendance)
          ..[key] = event.status;
        emit(StaffDetailLoaded(
          staff: current.staff,
          attendance: updated,
          year: current.year,
          month: current.month,
        ));
      }
    } catch (e) {
      AppLogger.e(_m, 'Mark attendance failed', e);
    }
  }

  Future<void> _onLoadAttendance(LoadAttendance event, Emitter<StaffState> emit) async {
    AppLogger.i(_m, 'Loading attendance — staffId:${event.staffId} ${event.year}/${event.month}');
    try {
      final staff = await _repository.getStaffList();
      final target = staff.firstWhere((s) => s.id == event.staffId);
      final attendance = await _repository.getAttendanceForMonth(event.staffId, event.year, event.month);
      AppLogger.i(_m, 'Attendance loaded — ${attendance.length} records for ${target.name}');
      emit(StaffDetailLoaded(
        staff: target,
        attendance: attendance,
        year: event.year,
        month: event.month,
      ));
    } catch (e) {
      AppLogger.e(_m, 'Load attendance failed for staffId:${event.staffId}', e);
      emit(const StaffError('Failed to load attendance'));
    }
  }

  Future<void> _onPaySalary(PaySalary event, Emitter<StaffState> emit) async {
    AppLogger.i(_m, 'Paying salary — staffId:${event.staffId} amount:${event.amount}');
    final current = state;
    emit(StaffActionLoading());
    try {
      await _repository.paySalary(event.staffId, event.amount, event.upiTransactionId);
      AppLogger.i(_m, 'Salary paid — staffId:${event.staffId}');
      if (current is StaffLoaded) {
        final updated = current.staffList.map((s) {
          return s.id == event.staffId ? s.copyWith(unpaidSalary: 0) : s;
        }).toList();
        emit(StaffLoaded(
          staffList: updated,
          presentCount: updated.where((s) => s.presentToday).length,
          totalUnpaidSalary: updated.fold(0, (sum, s) => sum + s.unpaidSalary),
        ));
      } else {
        add(LoadStaff());
      }
    } catch (e) {
      AppLogger.e(_m, 'Pay salary failed for staffId:${event.staffId}', e);
      emit(const StaffError('Failed to pay salary'));
    }
  }

  Future<void> _onAddAdvance(AddAdvance event, Emitter<StaffState> emit) async {
    AppLogger.i(_m, 'Adding advance — staffId:${event.staffId} amount:${event.amount}');
    try {
      await _repository.addAdvance(event.staffId, event.amount, event.note);
      AppLogger.i(_m, 'Advance recorded');
      add(LoadStaff());
    } catch (e) {
      AppLogger.e(_m, 'Add advance failed', e);
    }
  }
}
