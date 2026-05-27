import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:go_router/go_router.dart';
import 'package:intl/intl.dart';
import '../../../../core/constants/app_colors.dart';
import '../../../../core/constants/app_typography.dart';
import '../../../../core/di/injection.dart';
import '../../../../core/router/app_router.dart';
import '../../../../l10n/app_localizations.dart';
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
    final l10n = AppLocalizations.of(context)!;
    return BlocBuilder<StaffBloc, StaffState>(
      builder: (context, state) {
        final staff = state is StaffDetailLoaded ? state.staff : initialStaff;
        final attendance =
            state is StaffDetailLoaded ? state.attendance : <String, AttendanceStatus>{};
        final year = state is StaffDetailLoaded ? state.year : DateTime.now().year;
        final month = state is StaffDetailLoaded ? state.month : DateTime.now().month;

        return Scaffold(

          appBar: AppBar(
            title: Text(staff.name),
            actions: [
              if (staff.unpaidSalary > 0)
                TextButton.icon(
                  onPressed: () => _showPaySalarySheet(context, staff),
                  icon: const Icon(Icons.payment_rounded, size: 18),
                  label: Text(l10n.staffPayButton),
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
                      _SalaryCard(
                          staff: staff, attendance: attendance, year: year, month: month),
                      const SizedBox(height: 16),
                      _AttendanceCalendar(
                        staffId: staff.id,
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
    final l10n = AppLocalizations.of(context)!;
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
            Text(l10n.paySalaryTitle, style: AppTypography.h3),
            const SizedBox(height: 4),
            Text(
              l10n.unpaidLabel(staff.unpaidSalary.toStringAsFixed(0)),
              style: AppTypography.bodySmall.copyWith(color: AppColors.textSecondary),
            ),
            const SizedBox(height: 20),
            TextField(
              controller: amountCtrl,
              keyboardType: TextInputType.number,
              decoration: InputDecoration(
                labelText: l10n.amountRupees,
                prefixIcon: const Icon(Icons.currency_rupee_rounded),
              ),
            ),
            const SizedBox(height: 14),
            TextField(
              controller: upiCtrl,
              decoration: InputDecoration(
                labelText: l10n.upiTransactionIdOptional,
                prefixIcon: const Icon(Icons.qr_code_rounded),
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
                    upiTransactionId:
                        upiCtrl.text.trim().isEmpty ? null : upiCtrl.text.trim(),
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
                child: Text(l10n.paymentConfirmed,
                    style: const TextStyle(color: Colors.white)),
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
    final l10n = AppLocalizations.of(context)!;
    final locale = Localizations.localeOf(context).toString();
    final joinedDate = DateFormat('MMM yyyy', locale).format(staff.joinDate);

    return Container(
      padding: const EdgeInsets.all(20),
      decoration: BoxDecoration(
        color: Theme.of(context).colorScheme.surface,
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
                Text(staff.role,
                    style:
                        AppTypography.bodySmall.copyWith(color: AppColors.textSecondary)),
                const SizedBox(height: 6),
                Row(
                  children: [
                    const Icon(Icons.phone_rounded, size: 14, color: AppColors.textHint),
                    const SizedBox(width: 4),
                    Text(staff.phone.isEmpty ? l10n.noPhone : staff.phone,
                        style: AppTypography.bodySmall),
                  ],
                ),
                const SizedBox(height: 2),
                Row(
                  children: [
                    const Icon(Icons.calendar_month_rounded,
                        size: 14, color: AppColors.textHint),
                    const SizedBox(width: 4),
                    Text(l10n.staffJoined(joinedDate), style: AppTypography.bodySmall),
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
              staff.isActive ? l10n.active : l10n.inactive,
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
    final l10n = AppLocalizations.of(context)!;
    final daysPresent =
        attendance.values.where((s) => s == AttendanceStatus.present).length;
    final halfDays =
        attendance.values.where((s) => s == AttendanceStatus.halfDay).length;
    final effectiveDays = daysPresent + (halfDays * 0.5);

    final earned = staff.salaryType == SalaryType.daily
        ? effectiveDays * staff.salaryAmount
        : staff.salaryAmount;

    return Container(
      padding: const EdgeInsets.all(20),
      decoration: BoxDecoration(
        color: Theme.of(context).colorScheme.surface,
        borderRadius: BorderRadius.circular(16),
      ),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Text(l10n.salaryTitle, style: AppTypography.labelLarge),
          const SizedBox(height: 16),
          Row(
            children: [
              _SalaryStat(
                label: l10n.rate,
                value: staff.salaryType == SalaryType.daily
                    ? l10n.staffSalaryPerDay(staff.salaryAmount.toStringAsFixed(0))
                    : l10n.staffSalaryPerMonth(staff.salaryAmount.toStringAsFixed(0)),
                color: AppColors.primary,
              ),
              const SizedBox(width: 12),
              _SalaryStat(
                label: l10n.daysPresent,
                value: daysPresent + halfDays > 0 ? effectiveDays.toStringAsFixed(1) : '0',
                color: AppColors.success,
              ),
              const SizedBox(width: 12),
              _SalaryStat(
                label: l10n.earned,
                value: '₹${earned.toStringAsFixed(0)}',
                color: Theme.of(context).colorScheme.onSurface,
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
                      label: l10n.unpaid,
                      value: '₹${staff.unpaidSalary.toStringAsFixed(0)}',
                      color: AppColors.error,
                    ),
                  ),
                if (staff.advanceTaken > 0)
                  Expanded(
                    child: _SalaryStat(
                      label: l10n.advanceTaken,
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
          color: Theme.of(context).scaffoldBackgroundColor,
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
  final String staffId;
  final Map<String, AttendanceStatus> attendance;
  final int year;
  final int month;
  final void Function(int year, int month) onMonthChanged;

  const _AttendanceCalendar({
    required this.staffId,
    required this.attendance,
    required this.year,
    required this.month,
    required this.onMonthChanged,
  });

  @override
  Widget build(BuildContext context) {
    final l10n = AppLocalizations.of(context)!;
    final locale = Localizations.localeOf(context).toString();
    final monthLabel = DateFormat('MMMM yyyy', locale).format(DateTime(year, month));
    final daysInMonth = DateTime(year, month + 1, 0).day;
    final firstWeekday = DateTime(year, month, 1).weekday % 7;

    return Container(
      padding: const EdgeInsets.all(20),
      decoration: BoxDecoration(
        color: Theme.of(context).colorScheme.surface,
        borderRadius: BorderRadius.circular(16),
      ),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Row(
            children: [
              Text(l10n.attendanceTitle, style: AppTypography.labelLarge),
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
                monthLabel,
                style: AppTypography.bodySmall.copyWith(fontWeight: FontWeight.w600),
              ),
              const SizedBox(width: 8),
              IconButton(
                icon: const Icon(Icons.chevron_right_rounded, size: 20),
                onPressed: () {
                  final next = DateTime(year, month + 1);
                  final now = DateTime.now();
                  if (next.year < now.year ||
                      (next.year == now.year && next.month <= now.month)) {
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
              final key =
                  '$year-${month.toString().padLeft(2, '0')}-${day.toString().padLeft(2, '0')}';
              final status = attendance[key];
              final now = DateTime.now();
              final cellDate = DateTime(year, month, day);
              final isToday = now.year == year && now.month == month && now.day == day;
              // Only allow marking attendance for today or past dates
              final isFuture = cellDate.isAfter(DateTime(now.year, now.month, now.day));
              return _DayCell(
                day: day,
                status: status,
                isToday: isToday,
                onTap: isFuture
                    ? null
                    : () => _showMarkSheet(context, staffId, cellDate, status),
              );
            },
          ),
          const SizedBox(height: 12),
          const _CalendarLegend(),
        ],
      ),
    );
  }

  void _showMarkSheet(
    BuildContext context,
    String staffId,
    DateTime date,
    AttendanceStatus? current,
  ) {
    final l10n = AppLocalizations.of(context)!;
    final bloc = context.read<StaffBloc>();
    final dateLabel =
        '${date.day}/${date.month}/${date.year}';

    showModalBottomSheet(
      context: context,
      shape: const RoundedRectangleBorder(
        borderRadius: BorderRadius.vertical(top: Radius.circular(20)),
      ),
      builder: (ctx) => SafeArea(
        child: Padding(
          padding: const EdgeInsets.fromLTRB(16, 12, 16, 8),
          child: Column(
            mainAxisSize: MainAxisSize.min,
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              Center(
                child: Container(
                  width: 40,
                  height: 4,
                  decoration: BoxDecoration(
                    color: AppColors.divider,
                    borderRadius: BorderRadius.circular(2),
                  ),
                ),
              ),
              const SizedBox(height: 16),
              Text(
                l10n.markAttendanceFor(dateLabel),
                style: AppTypography.labelLarge,
              ),
              const SizedBox(height: 16),
              _AttendanceOption(
                label: l10n.present,
                color: AppColors.success,
                icon: Icons.check_circle_outline_rounded,
                selected: current == AttendanceStatus.present,
                onTap: () {
                  Navigator.pop(ctx);
                  bloc.add(MarkAttendance(
                    staffId: staffId,
                    date: date,
                    status: AttendanceStatus.present,
                  ));
                },
              ),
              const SizedBox(height: 8),
              _AttendanceOption(
                label: l10n.halfDay,
                color: AppColors.warning,
                icon: Icons.timelapse_rounded,
                selected: current == AttendanceStatus.halfDay,
                onTap: () {
                  Navigator.pop(ctx);
                  bloc.add(MarkAttendance(
                    staffId: staffId,
                    date: date,
                    status: AttendanceStatus.halfDay,
                  ));
                },
              ),
              const SizedBox(height: 8),
              _AttendanceOption(
                label: l10n.absent,
                color: AppColors.error,
                icon: Icons.cancel_outlined,
                selected: current == AttendanceStatus.absent,
                onTap: () {
                  Navigator.pop(ctx);
                  bloc.add(MarkAttendance(
                    staffId: staffId,
                    date: date,
                    status: AttendanceStatus.absent,
                  ));
                },
              ),
              const SizedBox(height: 8),
            ],
          ),
        ),
      ),
    );
  }
}

class _AttendanceOption extends StatelessWidget {
  final String label;
  final Color color;
  final IconData icon;
  final bool selected;
  final VoidCallback onTap;

  const _AttendanceOption({
    required this.label,
    required this.color,
    required this.icon,
    required this.selected,
    required this.onTap,
  });

  @override
  Widget build(BuildContext context) {
    return InkWell(
      onTap: onTap,
      borderRadius: BorderRadius.circular(12),
      child: Container(
        padding: const EdgeInsets.symmetric(horizontal: 16, vertical: 12),
        decoration: BoxDecoration(
          color: color.withValues(alpha: selected ? 0.18 : 0.07),
          borderRadius: BorderRadius.circular(12),
          border: selected ? Border.all(color: color, width: 1.5) : null,
        ),
        child: Row(
          children: [
            Icon(icon, color: color, size: 20),
            const SizedBox(width: 12),
            Text(
              label,
              style: AppTypography.labelLarge.copyWith(color: color),
            ),
            if (selected) ...[
              const Spacer(),
              Icon(Icons.check_rounded, color: color, size: 18),
            ],
          ],
        ),
      ),
    );
  }
}

class _DayCell extends StatelessWidget {
  final int day;
  final AttendanceStatus? status;
  final bool isToday;
  final VoidCallback? onTap;

  const _DayCell({
    required this.day,
    required this.status,
    required this.isToday,
    this.onTap,
  });

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
        text = isToday ? AppColors.primary : Theme.of(context).colorScheme.onSurface;
    }

    return GestureDetector(
      onTap: onTap,
      child: Container(
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
      ),
    );
  }
}

class _CalendarLegend extends StatelessWidget {
  const _CalendarLegend();

  @override
  Widget build(BuildContext context) {
    final l10n = AppLocalizations.of(context)!;
    return Row(
      children: [
        _LegendItem(color: AppColors.success, label: l10n.present),
        const SizedBox(width: 12),
        _LegendItem(color: AppColors.error, label: l10n.absent),
        const SizedBox(width: 12),
        _LegendItem(color: AppColors.warning, label: l10n.halfDay),
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
    final l10n = AppLocalizations.of(context)!;
    return Row(
      children: [
        Expanded(
          child: OutlinedButton.icon(
            onPressed: () => _showAdvanceSheet(context, staff),
            icon: const Icon(Icons.add_card_rounded, size: 18),
            label: Text(l10n.addAdvance),
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
                ? l10n.staffPayAmount(staff.unpaidSalary.toStringAsFixed(0))
                : l10n.noDues),
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
    final l10n = AppLocalizations.of(context)!;
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
            Text(l10n.addAdvance, style: AppTypography.h3),
            const SizedBox(height: 20),
            TextField(
              controller: amountCtrl,
              keyboardType: TextInputType.number,
              decoration: InputDecoration(
                labelText: l10n.amountRupees,
                prefixIcon: const Icon(Icons.currency_rupee_rounded),
              ),
            ),
            const SizedBox(height: 14),
            TextField(
              controller: noteCtrl,
              decoration: InputDecoration(
                labelText: l10n.noteOptional,
                prefixIcon: const Icon(Icons.note_rounded),
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
                child: Text(l10n.addAdvanceTitle, style: const TextStyle(color: Colors.white)),
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
    final l10n = AppLocalizations.of(context)!;
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
            Text(l10n.paySalaryTitle, style: AppTypography.h3),
            const SizedBox(height: 4),
            Text(
              l10n.unpaidLabel(staff.unpaidSalary.toStringAsFixed(0)),
              style: AppTypography.bodySmall.copyWith(color: AppColors.textSecondary),
            ),
            const SizedBox(height: 20),
            TextField(
              controller: amountCtrl,
              keyboardType: TextInputType.number,
              decoration: InputDecoration(
                labelText: l10n.amountRupees,
                prefixIcon: const Icon(Icons.currency_rupee_rounded),
              ),
            ),
            const SizedBox(height: 14),
            TextField(
              controller: upiCtrl,
              decoration: InputDecoration(
                labelText: l10n.upiTransactionIdOptional,
                prefixIcon: const Icon(Icons.qr_code_rounded),
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
                    upiTransactionId:
                        upiCtrl.text.trim().isEmpty ? null : upiCtrl.text.trim(),
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
                child: Text(l10n.paymentConfirmed,
                    style: const TextStyle(color: Colors.white)),
              ),
            ),
          ],
        ),
      ),
    );
  }
}
