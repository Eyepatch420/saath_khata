import 'package:flutter_bloc/flutter_bloc.dart';
import '../../domain/repositories/staff_repository.dart';
import 'staff_event.dart';
import 'staff_state.dart';

class StaffBloc extends Bloc<StaffEvent, StaffState> {
  final StaffRepository _repository;

  StaffBloc(this._repository) : super(StaffInitial()) {
    on<LoadStaff>(_onLoad);
    on<AddStaff>(_onAddStaff);
    on<MarkAttendance>(_onMarkAttendance);
    on<LoadAttendance>(_onLoadAttendance);
    on<PaySalary>(_onPaySalary);
    on<AddAdvance>(_onAddAdvance);
  }

  Future<void> _onLoad(LoadStaff event, Emitter<StaffState> emit) async {
    emit(StaffLoading());
    try {
      final staff = await _repository.getStaffList();
      emit(StaffLoaded(
        staffList: staff,
        presentCount: staff.where((s) => s.presentToday).length,
        totalUnpaidSalary: staff.fold(0, (sum, s) => sum + s.unpaidSalary),
      ));
    } catch (_) {
      emit(const StaffError('Failed to load staff'));
    }
  }

  Future<void> _onAddStaff(AddStaff event, Emitter<StaffState> emit) async {
    final current = state;
    emit(StaffActionLoading());
    try {
      final newStaff = await _repository.addStaff(event.staff);
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
    } catch (_) {
      emit(const StaffError('Failed to add staff'));
    }
  }

  Future<void> _onMarkAttendance(MarkAttendance event, Emitter<StaffState> emit) async {
    try {
      await _repository.markAttendance(event.staffId, event.date, event.status);
      add(LoadStaff());
    } catch (_) {}
  }

  Future<void> _onLoadAttendance(LoadAttendance event, Emitter<StaffState> emit) async {
    try {
      final staff = await _repository.getStaffList();
      final target = staff.firstWhere((s) => s.id == event.staffId);
      final attendance = await _repository.getAttendanceForMonth(event.staffId, event.year, event.month);
      emit(StaffDetailLoaded(
        staff: target,
        attendance: attendance,
        year: event.year,
        month: event.month,
      ));
    } catch (_) {
      emit(const StaffError('Failed to load attendance'));
    }
  }

  Future<void> _onPaySalary(PaySalary event, Emitter<StaffState> emit) async {
    final current = state;
    emit(StaffActionLoading());
    try {
      await _repository.paySalary(event.staffId, event.amount, event.upiTransactionId);
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
    } catch (_) {
      emit(const StaffError('Failed to pay salary'));
    }
  }

  Future<void> _onAddAdvance(AddAdvance event, Emitter<StaffState> emit) async {
    try {
      await _repository.addAdvance(event.staffId, event.amount, event.note);
      add(LoadStaff());
    } catch (_) {}
  }
}
