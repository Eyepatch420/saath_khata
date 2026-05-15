import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import '../../../../core/constants/app_colors.dart';
import '../../../../core/constants/app_typography.dart';
import '../../../../core/di/injection.dart';
import '../../../../shared/models/staff_model.dart';
import '../../../../shared/widgets/empty_state_widget.dart';
import '../../../../shared/widgets/error_state_widget.dart';
import '../bloc/staff_bloc.dart';
import '../bloc/staff_event.dart';
import '../bloc/staff_state.dart';
import 'staff_detail_screen.dart';

class StaffManagementScreen extends StatelessWidget {
  const StaffManagementScreen({super.key});

  @override
  Widget build(BuildContext context) {
    return BlocProvider(
      create: (context) => StaffBloc(getIt())..add(LoadStaff()),
      child: const _StaffView(),
    );
  }
}

class _StaffView extends StatelessWidget {
  const _StaffView();

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: AppColors.background,
      appBar: AppBar(title: const Text('Staff & Labour')),
      body: BlocBuilder<StaffBloc, StaffState>(
        builder: (context, state) {
          if (state is StaffLoading || state is StaffActionLoading) {
            return const Center(child: CircularProgressIndicator());
          }
          if (state is StaffError) {
            return ErrorStateWidget(
              message: state.message,
              onRetry: () => context.read<StaffBloc>().add(LoadStaff()),
            );
          }
          if (state is StaffLoaded) {
            return _StaffContent(state: state);
          }
          return const SizedBox();
        },
      ),
      floatingActionButton: FloatingActionButton.extended(
        onPressed: () => _showAddStaffSheet(context),
        label: const Text('Add Staff'),
        icon: const Icon(Icons.person_add_rounded),
        backgroundColor: AppColors.primary,
      ),
    );
  }

  void _showAddStaffSheet(BuildContext context) {
    final bloc = context.read<StaffBloc>();
    final nameCtrl = TextEditingController();
    final phoneCtrl = TextEditingController();
    final salaryCtrl = TextEditingController();
    String selectedRole = 'Helper';
    SalaryType selectedType = SalaryType.daily;

    showModalBottomSheet(
      context: context,
      isScrollControlled: true,
      shape: const RoundedRectangleBorder(
        borderRadius: BorderRadius.vertical(top: Radius.circular(24)),
      ),
      builder: (ctx) => StatefulBuilder(
        builder: (ctx, setState) => Padding(
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
              Text('Add New Staff', style: AppTypography.h3),
              const SizedBox(height: 20),
              TextField(
                controller: nameCtrl,
                decoration: const InputDecoration(
                  labelText: 'Full Name',
                  prefixIcon: Icon(Icons.person_rounded),
                ),
              ),
              const SizedBox(height: 14),
              TextField(
                controller: phoneCtrl,
                keyboardType: TextInputType.phone,
                decoration: const InputDecoration(
                  labelText: 'Phone Number',
                  prefixIcon: Icon(Icons.phone_rounded),
                ),
              ),
              const SizedBox(height: 14),
              DropdownButtonFormField<String>(
                initialValue: selectedRole,
                decoration: const InputDecoration(
                  labelText: 'Role',
                  prefixIcon: Icon(Icons.work_rounded),
                ),
                items: ['Helper', 'Cook', 'Delivery', 'Driver', 'Guard', 'Cleaner', 'Other']
                    .map((r) => DropdownMenuItem(value: r, child: Text(r)))
                    .toList(),
                onChanged: (v) => setState(() => selectedRole = v!),
              ),
              const SizedBox(height: 14),
              DropdownButtonFormField<SalaryType>(
                initialValue: selectedType,
                decoration: const InputDecoration(
                  labelText: 'Salary Type',
                  prefixIcon: Icon(Icons.calendar_today_rounded),
                ),
                items: const [
                  DropdownMenuItem(value: SalaryType.daily, child: Text('Daily Wage')),
                  DropdownMenuItem(value: SalaryType.monthly, child: Text('Monthly Salary')),
                ],
                onChanged: (v) => setState(() => selectedType = v!),
              ),
              const SizedBox(height: 14),
              TextField(
                controller: salaryCtrl,
                keyboardType: TextInputType.number,
                decoration: InputDecoration(
                  labelText: selectedType == SalaryType.daily ? 'Daily Wage (₹)' : 'Monthly Salary (₹)',
                  prefixIcon: const Icon(Icons.currency_rupee_rounded),
                ),
              ),
              const SizedBox(height: 24),
              SizedBox(
                width: double.infinity,
                child: ElevatedButton(
                  onPressed: () {
                    if (nameCtrl.text.trim().isEmpty) return;
                    final salary = double.tryParse(salaryCtrl.text) ?? 0;
                    Navigator.pop(ctx);
                    bloc.add(AddStaff(StaffModel(
                      id: '',
                      vendorId: 'v1',
                      name: nameCtrl.text.trim(),
                      phone: phoneCtrl.text.trim(),
                      role: selectedRole,
                      salaryType: selectedType,
                      salaryAmount: salary,
                      joinDate: DateTime.now(),
                    )));
                  },
                  style: ElevatedButton.styleFrom(
                    backgroundColor: AppColors.primary,
                    padding: const EdgeInsets.symmetric(vertical: 14),
                  ),
                  child: const Text('ADD STAFF', style: TextStyle(color: Colors.white)),
                ),
              ),
            ],
          ),
        ),
      ),
    );
  }
}

class _StaffContent extends StatelessWidget {
  final StaffLoaded state;
  const _StaffContent({required this.state});

  @override
  Widget build(BuildContext context) {
    if (state.staffList.isEmpty) {
      return const EmptyStateWidget(
        icon: Icons.people_outline_rounded,
        title: 'No staff added yet',
        subtitle: 'Tap the button below to add your first staff member.',
      );
    }

    return Column(
      children: [
        _StaffSummaryBar(state: state),
        Expanded(
          child: ListView.separated(
            padding: const EdgeInsets.all(16),
            itemCount: state.staffList.length,
            separatorBuilder: (context, index) => const SizedBox(height: 12),
            itemBuilder: (context, index) {
              return _StaffCard(staff: state.staffList[index]);
            },
          ),
        ),
      ],
    );
  }
}

class _StaffSummaryBar extends StatelessWidget {
  final StaffLoaded state;
  const _StaffSummaryBar({required this.state});

  @override
  Widget build(BuildContext context) {
    return Container(
      padding: const EdgeInsets.symmetric(horizontal: 20, vertical: 12),
      color: AppColors.surface,
      child: Row(
        children: [
          _SummaryItem(
            label: 'Present Today',
            value: '${state.presentCount}/${state.staffList.length}',
            color: AppColors.success,
            icon: Icons.check_circle_rounded,
          ),
          const SizedBox(width: 16),
          Container(width: 1, height: 40, color: AppColors.divider),
          const SizedBox(width: 16),
          _SummaryItem(
            label: 'Unpaid Salary',
            value: '₹${state.totalUnpaidSalary.toStringAsFixed(0)}',
            color: AppColors.error,
            icon: Icons.account_balance_wallet_rounded,
          ),
        ],
      ),
    );
  }
}

class _SummaryItem extends StatelessWidget {
  final String label;
  final String value;
  final Color color;
  final IconData icon;

  const _SummaryItem({
    required this.label,
    required this.value,
    required this.color,
    required this.icon,
  });

  @override
  Widget build(BuildContext context) {
    return Row(
      children: [
        Icon(icon, color: color, size: 18),
        const SizedBox(width: 8),
        Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Text(label, style: AppTypography.bodySmall),
            Text(value, style: AppTypography.labelLarge.copyWith(color: color)),
          ],
        ),
      ],
    );
  }
}

class _StaffCard extends StatelessWidget {
  final StaffModel staff;
  const _StaffCard({required this.staff});

  @override
  Widget build(BuildContext context) {
    return GestureDetector(
      onTap: () => Navigator.push(
        context,
        MaterialPageRoute(builder: (_) => StaffDetailScreen(staff: staff)),
      ),
      child: Container(
        padding: const EdgeInsets.all(16),
        decoration: BoxDecoration(
          color: AppColors.surface,
          borderRadius: BorderRadius.circular(16),
        ),
        child: Column(
          children: [
            Row(
              children: [
                CircleAvatar(
                  backgroundColor: AppColors.primary.withValues(alpha: 0.1),
                  radius: 24,
                  child: Text(
                    staff.name[0],
                    style: const TextStyle(
                      color: AppColors.primary,
                      fontWeight: FontWeight.bold,
                      fontSize: 18,
                    ),
                  ),
                ),
                const SizedBox(width: 14),
                Expanded(
                  child: Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      Text(staff.name, style: AppTypography.labelLarge),
                      Text(
                        '${staff.role} • ${staff.salaryType == SalaryType.daily ? '₹${staff.salaryAmount.toStringAsFixed(0)}/day' : '₹${staff.salaryAmount.toStringAsFixed(0)}/month'}',
                        style: AppTypography.bodySmall,
                      ),
                    ],
                  ),
                ),
                Column(
                  crossAxisAlignment: CrossAxisAlignment.end,
                  children: [
                    Row(
                      mainAxisSize: MainAxisSize.min,
                      children: [
                        Icon(
                          staff.presentToday
                              ? Icons.check_circle_rounded
                              : Icons.cancel_rounded,
                          size: 14,
                          color: staff.presentToday ? AppColors.success : AppColors.error,
                        ),
                        const SizedBox(width: 4),
                        Text(
                          staff.presentToday ? 'Present' : 'Absent',
                          style: AppTypography.bodySmall.copyWith(
                            color: staff.presentToday ? AppColors.success : AppColors.error,
                          ),
                        ),
                      ],
                    ),
                    const SizedBox(height: 4),
                    const Icon(Icons.chevron_right_rounded, color: AppColors.textHint, size: 18),
                  ],
                ),
              ],
            ),
            const Divider(height: 20),
            Row(
              mainAxisAlignment: MainAxisAlignment.spaceBetween,
              children: [
                Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    Text('Unpaid Salary', style: AppTypography.bodySmall),
                    Text(
                      '₹${staff.unpaidSalary.toStringAsFixed(0)}',
                      style: AppTypography.h3.copyWith(color: AppColors.error),
                    ),
                  ],
                ),
                if (staff.advanceTaken > 0)
                  Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      Text('Advance Taken', style: AppTypography.bodySmall),
                      Text(
                        '₹${staff.advanceTaken.toStringAsFixed(0)}',
                        style: AppTypography.labelLarge.copyWith(color: AppColors.warning),
                      ),
                    ],
                  ),
                _AttendanceTodayButton(staff: staff),
              ],
            ),
          ],
        ),
      ),
    );
  }
}

class _AttendanceTodayButton extends StatelessWidget {
  final StaffModel staff;
  const _AttendanceTodayButton({required this.staff});

  @override
  Widget build(BuildContext context) {
    return PopupMenuButton<AttendanceStatus>(
      onSelected: (status) {
        context.read<StaffBloc>().add(MarkAttendance(
              staffId: staff.id,
              date: DateTime.now(),
              status: status,
            ));
      },
      itemBuilder: (context) => [
        const PopupMenuItem(
          value: AttendanceStatus.present,
          child: Row(children: [
            Icon(Icons.check_circle_rounded, color: AppColors.success, size: 18),
            SizedBox(width: 8),
            Text('Present'),
          ]),
        ),
        const PopupMenuItem(
          value: AttendanceStatus.absent,
          child: Row(children: [
            Icon(Icons.cancel_rounded, color: AppColors.error, size: 18),
            SizedBox(width: 8),
            Text('Absent'),
          ]),
        ),
        const PopupMenuItem(
          value: AttendanceStatus.halfDay,
          child: Row(children: [
            Icon(Icons.access_time_rounded, color: AppColors.warning, size: 18),
            SizedBox(width: 8),
            Text('Half Day'),
          ]),
        ),
      ],
      child: Container(
        padding: const EdgeInsets.symmetric(horizontal: 12, vertical: 8),
        decoration: BoxDecoration(
          color: AppColors.primary.withValues(alpha: 0.1),
          borderRadius: BorderRadius.circular(8),
        ),
        child: Row(
          mainAxisSize: MainAxisSize.min,
          children: [
            const Icon(Icons.edit_calendar_rounded, size: 14, color: AppColors.primary),
            const SizedBox(width: 4),
            Text('Attendance', style: AppTypography.bodySmall.copyWith(color: AppColors.primary)),
          ],
        ),
      ),
    );
  }
}
