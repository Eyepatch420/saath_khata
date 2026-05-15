import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:go_router/go_router.dart';
import '../../../../core/constants/app_colors.dart';
import '../../../../core/constants/app_typography.dart';
import '../../../../core/di/injection.dart';
import '../../../../core/router/app_router.dart';
import '../../../../shared/models/staff_model.dart';
import '../bloc/staff_bloc.dart';
import '../bloc/staff_event.dart';
import '../bloc/staff_state.dart';

class StaffDetailScreen extends StatelessWidget {
  final StaffModel staff;
  const StaffDetailScreen({super.key, required this.staff});

  @override
  Widget build(BuildContext context) {
    final now = DateTime.now();
    return BlocProvider(
      create: (context) => StaffBloc(getIt())
        ..add(LoadAttendance(
          staffId: staff.id,
          year: now.year,
          month: now.month,
        )),
      child: _StaffDetailView(initialStaff: staff),
    );
  }
}

class _StaffDetailView extends StatelessWidget {
  final StaffModel initialStaff;
  const _StaffDetailView({required this.initialStaff});

  @override
  Widget build(BuildContext context) {
    return BlocBuilder<StaffBloc, StaffState>(
      builder: (context, state) {
        final staff = state is StaffDetailLoaded ? state.staff : initialStaff;
        final attendance = state is StaffDetailLoaded ? state.attendance : <String, AttendanceStatus>{};
        final year = state is StaffDetailLoaded ? state.year : DateTime.now().year;
        final month = state is StaffDetailLoaded ? state.month : DateTime.now().month;

        return Scaffold(
          backgroundColor: AppColors.background,
          appBar: AppBar(
            title: Text(staff.name),
            actions: [
              if (staff.unpaidSalary > 0)
                TextButton.icon(
                  onPressed: () => _showPaySalarySheet(context, staff),
                  icon: const Icon(Icons.payment_rounded, size: 18),
                  label: const Text('Pay'),
                  style: TextButton.styleFrom(foregroundColor: AppColors.primary),
                ),
            ],
          ),
          body: state is StaffLoading
              ? const Center(child: CircularProgressIndicator())
              : SingleChildScrollView(
                  padding: const EdgeInsets.all(16),
                  child: Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      _ProfileCard(staff: staff),
                      const SizedBox(height: 16),
                      _SalaryCard(staff: staff, attendance: attendance, year: year, month: month),
                      const SizedBox(height: 16),
                      _AttendanceCalendar(
                        attendance: attendance,
                        year: year,
                        month: month,
                        onMonthChanged: (y, m) => context.read<StaffBloc>().add(
                              LoadAttendance(staffId: staff.id, year: y, month: m),
                            ),
                      ),
                      const SizedBox(height: 16),
                      _ActionButtons(staff: staff),
                      const SizedBox(height: 24),
                    ],
                  ),
                ),
        );
      },
    );
  }

  void _showPaySalarySheet(BuildContext context, StaffModel staff) {
    final bloc = context.read<StaffBloc>();
    final router = GoRouter.of(context);
    final amountCtrl = TextEditingController(text: staff.unpaidSalary.toStringAsFixed(0));
    final upiCtrl = TextEditingController();

    showModalBottomSheet(
      context: context,
      isScrollControlled: true,
      shape: const RoundedRectangleBorder(
        borderRadius: BorderRadius.vertical(top: Radius.circular(24)),
      ),
      builder: (ctx) => Padding(
        padding: EdgeInsets.only(
          left: 24,
          right: 24,
          top: 24,
          bottom: MediaQuery.of(ctx).viewInsets.bottom + 24,
        ),
        child: Column(
          mainAxisSize: MainAxisSize.min,
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Text('Pay Salary', style: AppTypography.h3),
            const SizedBox(height: 4),
            Text(
              'Unpaid: ₹${staff.unpaidSalary.toStringAsFixed(0)}',
              style: AppTypography.bodySmall.copyWith(color: AppColors.textSecondary),
            ),
            const SizedBox(height: 20),
            TextField(
              controller: amountCtrl,
              keyboardType: TextInputType.number,
              decoration: const InputDecoration(
                labelText: 'Amount (₹)',
                prefixIcon: Icon(Icons.currency_rupee_rounded),
              ),
            ),
            const SizedBox(height: 14),
            TextField(
              controller: upiCtrl,
              decoration: const InputDecoration(
                labelText: 'UPI Transaction ID (optional)',
                prefixIcon: Icon(Icons.qr_code_rounded),
              ),
            ),
            const SizedBox(height: 24),
            SizedBox(
              width: double.infinity,
              child: ElevatedButton(
                onPressed: () {
                  final amount = double.tryParse(amountCtrl.text) ?? 0;
                  if (amount <= 0) return;
                  Navigator.pop(ctx);
                  bloc.add(PaySalary(
                    staffId: staff.id,
                    amount: amount,
                    upiTransactionId: upiCtrl.text.trim().isEmpty ? null : upiCtrl.text.trim(),
                  ));
                  router.push(AppRouter.upiPayment, extra: {
                    'amount': amount,
                    'recipientName': staff.name,
                    'upiId': null,
                  });
                },
                style: ElevatedButton.styleFrom(
                  backgroundColor: AppColors.primary,
                  padding: const EdgeInsets.symmetric(vertical: 14),
                ),
                child: const Text('CONFIRM PAYMENT', style: TextStyle(color: Colors.white)),
              ),
            ),
          ],
        ),
      ),
    );
  }
}

class _ProfileCard extends StatelessWidget {
  final StaffModel staff;
  const _ProfileCard({required this.staff});

  @override
  Widget build(BuildContext context) {
    return Container(
      padding: const EdgeInsets.all(20),
      decoration: BoxDecoration(
        color: AppColors.surface,
        borderRadius: BorderRadius.circular(16),
      ),
      child: Row(
        children: [
          CircleAvatar(
            radius: 32,
            backgroundColor: AppColors.primary.withValues(alpha: 0.1),
            child: Text(
              staff.name[0],
              style: const TextStyle(
                color: AppColors.primary,
                fontWeight: FontWeight.bold,
                fontSize: 24,
              ),
            ),
          ),
          const SizedBox(width: 16),
          Expanded(
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Text(staff.name, style: AppTypography.h3),
                const SizedBox(height: 2),
                Text(staff.role, style: AppTypography.bodySmall.copyWith(color: AppColors.textSecondary)),
                const SizedBox(height: 6),
                Row(
                  children: [
                    const Icon(Icons.phone_rounded, size: 14, color: AppColors.textHint),
                    const SizedBox(width: 4),
                    Text(staff.phone.isEmpty ? 'No phone' : staff.phone,
                        style: AppTypography.bodySmall),
                  ],
                ),
                const SizedBox(height: 2),
                Row(
                  children: [
                    const Icon(Icons.calendar_month_rounded, size: 14, color: AppColors.textHint),
                    const SizedBox(width: 4),
                    Text(
                      'Joined ${_formatDate(staff.joinDate)}',
                      style: AppTypography.bodySmall,
                    ),
                  ],
                ),
              ],
            ),
          ),
          Container(
            padding: const EdgeInsets.symmetric(horizontal: 10, vertical: 6),
            decoration: BoxDecoration(
              color: staff.isActive
                  ? AppColors.success.withValues(alpha: 0.1)
                  : AppColors.error.withValues(alpha: 0.1),
              borderRadius: BorderRadius.circular(20),
            ),
            child: Text(
              staff.isActive ? 'Active' : 'Inactive',
              style: AppTypography.bodySmall.copyWith(
                color: staff.isActive ? AppColors.success : AppColors.error,
                fontWeight: FontWeight.w600,
              ),
            ),
          ),
        ],
      ),
    );
  }

  String _formatDate(DateTime dt) {
    const months = ['Jan', 'Feb', 'Mar', 'Apr', 'May', 'Jun', 'Jul', 'Aug', 'Sep', 'Oct', 'Nov', 'Dec'];
    return '${months[dt.month - 1]} ${dt.year}';
  }
}

class _SalaryCard extends StatelessWidget {
  final StaffModel staff;
  final Map<String, AttendanceStatus> attendance;
  final int year;
  final int month;

  const _SalaryCard({
    required this.staff,
    required this.attendance,
    required this.year,
    required this.month,
  });

  @override
  Widget build(BuildContext context) {
    final daysPresent = attendance.values.where((s) => s == AttendanceStatus.present).length;
    final halfDays = attendance.values.where((s) => s == AttendanceStatus.halfDay).length;
    final effectiveDays = daysPresent + (halfDays * 0.5);

    final earned = staff.salaryType == SalaryType.daily
        ? effectiveDays * staff.salaryAmount
        : staff.salaryAmount;

    return Container(
      padding: const EdgeInsets.all(20),
      decoration: BoxDecoration(
        color: AppColors.surface,
        borderRadius: BorderRadius.circular(16),
      ),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Text('Salary Summary', style: AppTypography.labelLarge),
          const SizedBox(height: 16),
          Row(
            children: [
              _SalaryStat(
                label: 'Rate',
                value: staff.salaryType == SalaryType.daily
                    ? '₹${staff.salaryAmount.toStringAsFixed(0)}/day'
                    : '₹${staff.salaryAmount.toStringAsFixed(0)}/mo',
                color: AppColors.primary,
              ),
              const SizedBox(width: 12),
              _SalaryStat(
                label: 'Days Present',
                value: daysPresent + halfDays > 0 ? effectiveDays.toStringAsFixed(1) : '0',
                color: AppColors.success,
              ),
              const SizedBox(width: 12),
              _SalaryStat(
                label: 'Earned',
                value: '₹${earned.toStringAsFixed(0)}',
                color: AppColors.textPrimary,
              ),
            ],
          ),
          if (staff.unpaidSalary > 0 || staff.advanceTaken > 0) ...[
            const Divider(height: 24),
            Row(
              children: [
                if (staff.unpaidSalary > 0)
                  Expanded(
                    child: _SalaryStat(
                      label: 'Unpaid',
                      value: '₹${staff.unpaidSalary.toStringAsFixed(0)}',
                      color: AppColors.error,
                    ),
                  ),
                if (staff.advanceTaken > 0)
                  Expanded(
                    child: _SalaryStat(
                      label: 'Advance Taken',
                      value: '₹${staff.advanceTaken.toStringAsFixed(0)}',
                      color: AppColors.warning,
                    ),
                  ),
              ],
            ),
          ],
        ],
      ),
    );
  }
}

class _SalaryStat extends StatelessWidget {
  final String label;
  final String value;
  final Color color;

  const _SalaryStat({required this.label, required this.value, required this.color});

  @override
  Widget build(BuildContext context) {
    return Expanded(
      child: Container(
        padding: const EdgeInsets.symmetric(horizontal: 12, vertical: 10),
        decoration: BoxDecoration(
          color: AppColors.background,
          borderRadius: BorderRadius.circular(10),
        ),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Text(label, style: AppTypography.bodySmall.copyWith(color: AppColors.textHint)),
            const SizedBox(height: 4),
            Text(value, style: AppTypography.labelLarge.copyWith(color: color)),
          ],
        ),
      ),
    );
  }
}

class _AttendanceCalendar extends StatelessWidget {
  final Map<String, AttendanceStatus> attendance;
  final int year;
  final int month;
  final void Function(int year, int month) onMonthChanged;

  const _AttendanceCalendar({
    required this.attendance,
    required this.year,
    required this.month,
    required this.onMonthChanged,
  });

  @override
  Widget build(BuildContext context) {
    const monthNames = [
      'January', 'February', 'March', 'April', 'May', 'June',
      'July', 'August', 'September', 'October', 'November', 'December'
    ];

    final daysInMonth = DateTime(year, month + 1, 0).day;
    final firstWeekday = DateTime(year, month, 1).weekday % 7;

    return Container(
      padding: const EdgeInsets.all(20),
      decoration: BoxDecoration(
        color: AppColors.surface,
        borderRadius: BorderRadius.circular(16),
      ),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Row(
            children: [
              Text('Attendance', style: AppTypography.labelLarge),
              const Spacer(),
              IconButton(
                icon: const Icon(Icons.chevron_left_rounded, size: 20),
                onPressed: () {
                  final prev = DateTime(year, month - 1);
                  onMonthChanged(prev.year, prev.month);
                },
                padding: EdgeInsets.zero,
                constraints: const BoxConstraints(),
              ),
              const SizedBox(width: 8),
              Text(
                '${monthNames[month - 1]} $year',
                style: AppTypography.bodySmall.copyWith(fontWeight: FontWeight.w600),
              ),
              const SizedBox(width: 8),
              IconButton(
                icon: const Icon(Icons.chevron_right_rounded, size: 20),
                onPressed: () {
                  final next = DateTime(year, month + 1);
                  final now = DateTime.now();
                  if (next.year < now.year || (next.year == now.year && next.month <= now.month)) {
                    onMonthChanged(next.year, next.month);
                  }
                },
                padding: EdgeInsets.zero,
                constraints: const BoxConstraints(),
              ),
            ],
          ),
          const SizedBox(height: 12),
          Row(
            children: ['Su', 'Mo', 'Tu', 'We', 'Th', 'Fr', 'Sa']
                .map((d) => Expanded(
                      child: Center(
                        child: Text(d,
                            style: AppTypography.bodySmall.copyWith(
                              color: AppColors.textHint,
                              fontWeight: FontWeight.w600,
                            )),
                      ),
                    ))
                .toList(),
          ),
          const SizedBox(height: 8),
          GridView.builder(
            shrinkWrap: true,
            physics: const NeverScrollableScrollPhysics(),
            gridDelegate: const SliverGridDelegateWithFixedCrossAxisCount(
              crossAxisCount: 7,
              mainAxisSpacing: 4,
              crossAxisSpacing: 4,
              childAspectRatio: 1,
            ),
            itemCount: firstWeekday + daysInMonth,
            itemBuilder: (context, index) {
              if (index < firstWeekday) return const SizedBox();
              final day = index - firstWeekday + 1;
              final key = '$year-${month.toString().padLeft(2, '0')}-${day.toString().padLeft(2, '0')}';
              final status = attendance[key];
              final isToday = DateTime.now().year == year &&
                  DateTime.now().month == month &&
                  DateTime.now().day == day;
              return _DayCell(day: day, status: status, isToday: isToday);
            },
          ),
          const SizedBox(height: 12),
          const _CalendarLegend(),
        ],
      ),
    );
  }
}

class _DayCell extends StatelessWidget {
  final int day;
  final AttendanceStatus? status;
  final bool isToday;

  const _DayCell({required this.day, required this.status, required this.isToday});

  @override
  Widget build(BuildContext context) {
    Color bg;
    Color text;

    switch (status) {
      case AttendanceStatus.present:
        bg = AppColors.success;
        text = Colors.white;
      case AttendanceStatus.absent:
        bg = AppColors.error;
        text = Colors.white;
      case AttendanceStatus.halfDay:
        bg = AppColors.warning;
        text = Colors.white;
      case AttendanceStatus.holiday:
        bg = AppColors.textHint.withValues(alpha: 0.3);
        text = AppColors.textSecondary;
      case null:
        bg = isToday ? AppColors.primary.withValues(alpha: 0.15) : Colors.transparent;
        text = isToday ? AppColors.primary : AppColors.textPrimary;
    }

    return Container(
      decoration: BoxDecoration(
        color: bg,
        borderRadius: BorderRadius.circular(6),
        border: isToday && status == null
            ? Border.all(color: AppColors.primary, width: 1.5)
            : null,
      ),
      child: Center(
        child: Text(
          '$day',
          style: AppTypography.bodySmall.copyWith(
            color: text,
            fontWeight: isToday ? FontWeight.bold : FontWeight.normal,
            fontSize: 11,
          ),
        ),
      ),
    );
  }
}

class _CalendarLegend extends StatelessWidget {
  const _CalendarLegend();

  @override
  Widget build(BuildContext context) {
    return Row(
      children: [
        _LegendItem(color: AppColors.success, label: 'Present'),
        const SizedBox(width: 12),
        _LegendItem(color: AppColors.error, label: 'Absent'),
        const SizedBox(width: 12),
        _LegendItem(color: AppColors.warning, label: 'Half Day'),
      ],
    );
  }
}

class _LegendItem extends StatelessWidget {
  final Color color;
  final String label;
  const _LegendItem({required this.color, required this.label});

  @override
  Widget build(BuildContext context) {
    return Row(
      mainAxisSize: MainAxisSize.min,
      children: [
        Container(
          width: 10,
          height: 10,
          decoration: BoxDecoration(color: color, borderRadius: BorderRadius.circular(3)),
        ),
        const SizedBox(width: 4),
        Text(label, style: AppTypography.bodySmall.copyWith(fontSize: 11)),
      ],
    );
  }
}

class _ActionButtons extends StatelessWidget {
  final StaffModel staff;
  const _ActionButtons({required this.staff});

  @override
  Widget build(BuildContext context) {
    return Row(
      children: [
        Expanded(
          child: OutlinedButton.icon(
            onPressed: () => _showAdvanceSheet(context, staff),
            icon: const Icon(Icons.add_card_rounded, size: 18),
            label: const Text('Add Advance'),
            style: OutlinedButton.styleFrom(
              foregroundColor: AppColors.warning,
              side: const BorderSide(color: AppColors.warning),
              padding: const EdgeInsets.symmetric(vertical: 12),
            ),
          ),
        ),
        const SizedBox(width: 12),
        Expanded(
          child: ElevatedButton.icon(
            onPressed: staff.unpaidSalary > 0
                ? () => _showPaySalaryFromButtons(context, staff)
                : null,
            icon: const Icon(Icons.payment_rounded, size: 18),
            label: Text(staff.unpaidSalary > 0
                ? 'Pay ₹${staff.unpaidSalary.toStringAsFixed(0)}'
                : 'No Dues'),
            style: ElevatedButton.styleFrom(
              backgroundColor: AppColors.primary,
              foregroundColor: Colors.white,
              padding: const EdgeInsets.symmetric(vertical: 12),
            ),
          ),
        ),
      ],
    );
  }

  void _showAdvanceSheet(BuildContext context, StaffModel staff) {
    final bloc = context.read<StaffBloc>();
    final amountCtrl = TextEditingController();
    final noteCtrl = TextEditingController();

    showModalBottomSheet(
      context: context,
      isScrollControlled: true,
      shape: const RoundedRectangleBorder(
        borderRadius: BorderRadius.vertical(top: Radius.circular(24)),
      ),
      builder: (ctx) => Padding(
        padding: EdgeInsets.only(
          left: 24,
          right: 24,
          top: 24,
          bottom: MediaQuery.of(ctx).viewInsets.bottom + 24,
        ),
        child: Column(
          mainAxisSize: MainAxisSize.min,
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Text('Add Advance', style: AppTypography.h3),
            const SizedBox(height: 20),
            TextField(
              controller: amountCtrl,
              keyboardType: TextInputType.number,
              decoration: const InputDecoration(
                labelText: 'Amount (₹)',
                prefixIcon: Icon(Icons.currency_rupee_rounded),
              ),
            ),
            const SizedBox(height: 14),
            TextField(
              controller: noteCtrl,
              decoration: const InputDecoration(
                labelText: 'Note (optional)',
                prefixIcon: Icon(Icons.note_rounded),
              ),
            ),
            const SizedBox(height: 24),
            SizedBox(
              width: double.infinity,
              child: ElevatedButton(
                onPressed: () {
                  final amount = double.tryParse(amountCtrl.text) ?? 0;
                  if (amount <= 0) return;
                  Navigator.pop(ctx);
                  bloc.add(AddAdvance(
                    staffId: staff.id,
                    amount: amount,
                    note: noteCtrl.text.trim().isEmpty ? null : noteCtrl.text.trim(),
                  ));
                },
                style: ElevatedButton.styleFrom(
                  backgroundColor: AppColors.warning,
                  padding: const EdgeInsets.symmetric(vertical: 14),
                ),
                child: const Text('ADD ADVANCE', style: TextStyle(color: Colors.white)),
              ),
            ),
          ],
        ),
      ),
    );
  }

  void _showPaySalaryFromButtons(BuildContext context, StaffModel staff) {
    final bloc = context.read<StaffBloc>();
    final router = GoRouter.of(context);
    final amountCtrl = TextEditingController(text: staff.unpaidSalary.toStringAsFixed(0));
    final upiCtrl = TextEditingController();

    showModalBottomSheet(
      context: context,
      isScrollControlled: true,
      shape: const RoundedRectangleBorder(
        borderRadius: BorderRadius.vertical(top: Radius.circular(24)),
      ),
      builder: (ctx) => Padding(
        padding: EdgeInsets.only(
          left: 24,
          right: 24,
          top: 24,
          bottom: MediaQuery.of(ctx).viewInsets.bottom + 24,
        ),
        child: Column(
          mainAxisSize: MainAxisSize.min,
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Text('Pay Salary', style: AppTypography.h3),
            const SizedBox(height: 4),
            Text(
              'Unpaid: ₹${staff.unpaidSalary.toStringAsFixed(0)}',
              style: AppTypography.bodySmall.copyWith(color: AppColors.textSecondary),
            ),
            const SizedBox(height: 20),
            TextField(
              controller: amountCtrl,
              keyboardType: TextInputType.number,
              decoration: const InputDecoration(
                labelText: 'Amount (₹)',
                prefixIcon: Icon(Icons.currency_rupee_rounded),
              ),
            ),
            const SizedBox(height: 14),
            TextField(
              controller: upiCtrl,
              decoration: const InputDecoration(
                labelText: 'UPI Transaction ID (optional)',
                prefixIcon: Icon(Icons.qr_code_rounded),
              ),
            ),
            const SizedBox(height: 24),
            SizedBox(
              width: double.infinity,
              child: ElevatedButton(
                onPressed: () {
                  final amount = double.tryParse(amountCtrl.text) ?? 0;
                  if (amount <= 0) return;
                  Navigator.pop(ctx);
                  bloc.add(PaySalary(
                    staffId: staff.id,
                    amount: amount,
                    upiTransactionId: upiCtrl.text.trim().isEmpty ? null : upiCtrl.text.trim(),
                  ));
                  router.push(AppRouter.upiPayment, extra: {
                    'amount': amount,
                    'recipientName': staff.name,
                    'upiId': null,
                  });
                },
                style: ElevatedButton.styleFrom(
                  backgroundColor: AppColors.primary,
                  padding: const EdgeInsets.symmetric(vertical: 14),
                ),
                child: const Text('CONFIRM PAYMENT', style: TextStyle(color: Colors.white)),
              ),
            ),
          ],
        ),
      ),
    );
  }
}
