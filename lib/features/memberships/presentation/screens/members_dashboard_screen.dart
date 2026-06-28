import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import '../../../../core/constants/app_colors.dart';
import '../../../../core/di/injection.dart';
import '../../../../shared/widgets/error_state_widget.dart';
import '../../domain/models/members_dashboard.dart';
import '../bloc/members_dashboard_cubit.dart';
import '../membership_theme.dart';

/// Vendor: members dashboard — MRR, active count, expiring, filterable by plan.
class MembersDashboardScreen extends StatelessWidget {
  const MembersDashboardScreen({super.key});

  @override
  Widget build(BuildContext context) {
    return BlocProvider(
      create: (_) => MembersDashboardCubit(getIt())..load(),
      child: const _DashboardView(),
    );
  }
}

class _DashboardView extends StatefulWidget {
  const _DashboardView();
  @override
  State<_DashboardView> createState() => _DashboardViewState();
}

class _DashboardViewState extends State<_DashboardView> {
  String _planFilter = 'all'; // 'all' or a planId

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: AppColors.background,
      appBar: AppBar(
        title: const Text('Members'),
        backgroundColor: MembershipTheme.purple,
        foregroundColor: Colors.white,
      ),
      body: BlocBuilder<MembersDashboardCubit, MembersDashboardState>(
        builder: (context, state) {
          if (state is MembersDashboardLoading) {
            return const Center(child: CircularProgressIndicator());
          }
          if (state is MembersDashboardError) {
            return ErrorStateWidget(
              message: state.message,
              onRetry: () => context.read<MembersDashboardCubit>().load(),
            );
          }
          if (state is MembersDashboardLoaded) {
            return _content(context, state.data);
          }
          return const SizedBox();
        },
      ),
    );
  }

  Widget _content(BuildContext context, MembersDashboard data) {
    final members = _planFilter == 'all'
        ? data.members
        : data.members.where((m) => m.planId == _planFilter).toList();

    return RefreshIndicator(
      onRefresh: () => context.read<MembersDashboardCubit>().load(),
      child: ListView(
        padding: const EdgeInsets.fromLTRB(16, 16, 16, 24),
        children: [
          _statsRow(data),
          const SizedBox(height: 16),
          _planFilterChips(data),
          const SizedBox(height: 8),
          if (members.isEmpty)
            const Padding(
              padding: EdgeInsets.only(top: 48),
              child: Center(
                child: Text('No members in this view',
                    style: TextStyle(color: AppColors.textSecondary)),
              ),
            )
          else
            ...members.map((m) => Padding(
                  padding: const EdgeInsets.only(bottom: 10),
                  child: _MemberCard(member: m),
                )),
        ],
      ),
    );
  }

  Widget _statsRow(MembersDashboard data) {
    return Row(
      children: [
        _stat('${data.activeCount}', 'Active', MembershipTheme.purple),
        const SizedBox(width: 10),
        _stat('₹${data.mrr}', 'MRR', AppColors.success),
        const SizedBox(width: 10),
        _stat('${data.expiringSoon}', 'Expiring', AppColors.warning),
      ],
    );
  }

  Widget _stat(String value, String label, Color color) {
    return Expanded(
      child: Container(
        padding: const EdgeInsets.symmetric(vertical: 16),
        decoration: BoxDecoration(
          color: color.withValues(alpha: 0.10),
          borderRadius: BorderRadius.circular(14),
          border: Border.all(color: color.withValues(alpha: 0.25)),
        ),
        child: Column(
          children: [
            Text(value,
                style: TextStyle(
                    fontSize: 20, fontWeight: FontWeight.bold, color: color)),
            const SizedBox(height: 2),
            Text(label,
                style: const TextStyle(
                    fontSize: 12, color: AppColors.textSecondary)),
          ],
        ),
      ),
    );
  }

  Widget _planFilterChips(MembersDashboard data) {
    return SizedBox(
      height: 38,
      child: ListView(
        scrollDirection: Axis.horizontal,
        children: [
          _filterChip('All Plans', 'all'),
          ...data.plans.map((p) => _filterChip(p.name, p.id)),
        ],
      ),
    );
  }

  Widget _filterChip(String label, String value) {
    final selected = _planFilter == value;
    return Padding(
      padding: const EdgeInsets.only(right: 8),
      child: ChoiceChip(
        label: Text(label),
        selected: selected,
        selectedColor: MembershipTheme.purpleSoft,
        labelStyle: TextStyle(
          color: selected ? MembershipTheme.purpleDark : AppColors.textSecondary,
          fontWeight: selected ? FontWeight.w700 : FontWeight.normal,
        ),
        onSelected: (_) => setState(() => _planFilter = value),
      ),
    );
  }
}

class _MemberCard extends StatelessWidget {
  final MemberRow member;
  const _MemberCard({required this.member});

  @override
  Widget build(BuildContext context) {
    final expSoon = member.daysLeft <= 7;
    final usageColor = member.totalUsed >= member.totalQuota && member.totalQuota > 0
        ? AppColors.error
        : member.totalUsed > 0
            ? AppColors.warning
            : AppColors.success;

    return Container(
      padding: const EdgeInsets.all(14),
      decoration: BoxDecoration(
        color: AppColors.surface,
        borderRadius: BorderRadius.circular(14),
        border: Border.all(color: AppColors.divider),
      ),
      child: Row(
        children: [
          CircleAvatar(
            radius: 22,
            backgroundColor: MembershipTheme.purpleSoft,
            backgroundImage: member.customerPhotoUrl != null
                ? NetworkImage(member.customerPhotoUrl!)
                : null,
            child: member.customerPhotoUrl == null
                ? Text(member.customerName.isNotEmpty
                    ? member.customerName[0].toUpperCase()
                    : '?',
                    style: const TextStyle(
                        color: MembershipTheme.purpleDark,
                        fontWeight: FontWeight.bold))
                : null,
          ),
          const SizedBox(width: 12),
          Expanded(
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Text(member.customerName,
                    style: const TextStyle(
                        fontWeight: FontWeight.w600, fontSize: 15),
                    overflow: TextOverflow.ellipsis),
                const SizedBox(height: 2),
                Text(
                  '${member.planName} · Exp: ${_fmt(member.expiresAt)}',
                  style: const TextStyle(
                      color: AppColors.textSecondary, fontSize: 12),
                  overflow: TextOverflow.ellipsis,
                ),
              ],
            ),
          ),
          const SizedBox(width: 8),
          Column(
            crossAxisAlignment: CrossAxisAlignment.end,
            children: [
              if (member.hasQuota)
                Text('${member.totalUsed}/${member.totalQuota} used',
                    style: TextStyle(
                        color: usageColor,
                        fontWeight: FontWeight.w700,
                        fontSize: 13)),
              const SizedBox(height: 2),
              Text(
                expSoon ? '${member.daysLeft}d left' : '${member.daysLeft} days',
                style: TextStyle(
                  color: expSoon ? AppColors.warning : AppColors.textHint,
                  fontSize: 11,
                  fontWeight: expSoon ? FontWeight.w700 : FontWeight.normal,
                ),
              ),
            ],
          ),
        ],
      ),
    );
  }

  String _fmt(DateTime d) {
    const months = [
      'Jan', 'Feb', 'Mar', 'Apr', 'May', 'Jun',
      'Jul', 'Aug', 'Sep', 'Oct', 'Nov', 'Dec'
    ];
    return '${d.day} ${months[d.month - 1]}';
  }
}
