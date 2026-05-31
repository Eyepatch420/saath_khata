import 'dart:math';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:go_router/go_router.dart';
import '../../../../core/constants/app_colors.dart';
import '../../../../core/constants/app_typography.dart';
import '../../../../core/di/injection.dart';
import '../../../../core/router/app_router.dart';
import '../../../../features/vendor/domain/repositories/vendor_repository.dart';
import '../../../../l10n/app_localizations.dart';
import '../../../../shared/models/report_models.dart';
import '../bloc/reports_dashboard_cubit.dart';

class ReportsScreen extends StatelessWidget {
  const ReportsScreen({super.key});

  @override
  Widget build(BuildContext context) {
    return BlocProvider(
      create: (_) => ReportsDashboardCubit(getIt<VendorRepository>())..loadDashboard(),
      child: const _ReportsView(),
    );
  }
}

class _ReportsView extends StatelessWidget {
  const _ReportsView();

  @override
  Widget build(BuildContext context) {
    final l10n = AppLocalizations.of(context)!;
    return Scaffold(
      appBar: AppBar(title: Text(l10n.businessReports)),
      body: SafeArea(
        child: BlocBuilder<ReportsDashboardCubit, ReportsDashboardState>(
          builder: (context, state) {
            if (state is ReportsDashboardLoading) {
              return const Center(child: CircularProgressIndicator());
            }
            if (state is ReportsDashboardError) {
              return Center(
                child: Column(
                  mainAxisSize: MainAxisSize.min,
                  children: [
                    Text(state.message,
                        style: AppTypography.bodyMedium
                            .copyWith(color: AppColors.error),
                        textAlign: TextAlign.center),
                    const SizedBox(height: 16),
                    ElevatedButton(
                      onPressed: () =>
                          context.read<ReportsDashboardCubit>().loadDashboard(),
                      child: const Text('Retry'),
                    ),
                  ],
                ),
              );
            }
            if (state is ReportsDashboardLoaded) {
              return RefreshIndicator(
                onRefresh: () =>
                    context.read<ReportsDashboardCubit>().loadDashboard(),
                child: SingleChildScrollView(
                  physics: const AlwaysScrollableScrollPhysics(),
                  padding: EdgeInsets.fromLTRB(
                      20, 20, 20, MediaQuery.of(context).viewPadding.bottom + 96),
                  child: Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      _RevenueChartCard(state: state),
                      const SizedBox(height: 24),
                      Text(l10n.collectionSummary, style: AppTypography.h3),
                      const SizedBox(height: 16),
                      _SummaryCard(
                        label: l10n.totalOutstanding,
                        value:
                            '₹${state.summary.totalOutstanding.toStringAsFixed(0)}',
                        color: AppColors.error,
                      ),
                      const SizedBox(height: 12),
                      _SummaryCard(
                        label: l10n.totalCollected,
                        value:
                            '₹${state.summary.totalCollectedThisMonth.toStringAsFixed(0)}',
                        color: AppColors.success,
                        subtitle: 'This month',
                      ),
                      const SizedBox(height: 24),
                      Row(
                        mainAxisAlignment: MainAxisAlignment.spaceBetween,
                        children: [
                          Text(l10n.topCustomers, style: AppTypography.h3),
                          TextButton(
                            onPressed: () =>
                                context.push(AppRouter.allCustomersReport),
                            child: Text(l10n.seeAll),
                          ),
                        ],
                      ),
                      const SizedBox(height: 12),
                      if (state.summary.topCustomers.isEmpty)
                        Padding(
                          padding: const EdgeInsets.symmetric(vertical: 24),
                          child: Center(
                            child: Text('No customers yet',
                                style: AppTypography.bodySmall
                                    .copyWith(color: AppColors.textHint)),
                          ),
                        )
                      else
                        ...state.summary.topCustomers.map(
                          (c) => _TopCustomerItem(
                            name: c.customerName,
                            balance: c.balance,
                            linkId: c.linkId,
                          ),
                        ),
                    ],
                  ),
                ),
              );
            }
            return const SizedBox();
          },
        ),
      ),
    );
  }
}

// ─── Revenue Chart Card ───────────────────────────────────────────────────────

class _RevenueChartCard extends StatelessWidget {
  final ReportsDashboardLoaded state;
  const _RevenueChartCard({required this.state});

  static const _monthAbbr = [
    'Jan', 'Feb', 'Mar', 'Apr', 'May', 'Jun',
    'Jul', 'Aug', 'Sep', 'Oct', 'Nov', 'Dec'
  ];

  // Fill all 12 months for the year, putting 0 where no data exists.
  List<_MonthBar> _buildBars(MonthlyRevenueReport report) {
    final map = <int, double>{};
    for (final m in report.months) {
      final idx = int.tryParse(m.month.substring(5)) ?? 0;
      if (idx >= 1 && idx <= 12) map[idx] = m.totalCollected;
    }
    return List.generate(
      12,
      (i) => _MonthBar(
        label: _monthAbbr[i],
        amount: map[i + 1] ?? 0,
        isCurrentMonth: (i + 1) == DateTime.now().month &&
            report.year == DateTime.now().year,
      ),
    );
  }

  @override
  Widget build(BuildContext context) {
    final cubit = context.read<ReportsDashboardCubit>();
    final bars = _buildBars(state.monthlyRevenue);
    final maxAmount = bars.map((b) => b.amount).reduce(max);

    return Container(
      padding: const EdgeInsets.all(16),
      decoration: BoxDecoration(
        color: AppColors.secondary,
        borderRadius: BorderRadius.circular(16),
      ),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          // Header row with year selector
          Row(
            mainAxisAlignment: MainAxisAlignment.spaceBetween,
            children: [
              Text(
                'Revenue Trend',
                style: AppTypography.bodySmall.copyWith(color: Colors.white70),
              ),
              Row(
                children: [
                  IconButton(
                    constraints: const BoxConstraints(),
                    padding: const EdgeInsets.symmetric(horizontal: 4),
                    icon: const Icon(Icons.chevron_left_rounded,
                        color: Colors.white70, size: 20),
                    onPressed: state.yearChanging
                        ? null
                        : () => cubit.changeYear(state.year - 1),
                  ),
                  state.yearChanging
                      ? const SizedBox(
                          width: 16,
                          height: 16,
                          child: CircularProgressIndicator(
                              strokeWidth: 2, color: Colors.white70),
                        )
                      : Text(
                          '${state.year}',
                          style: AppTypography.labelLarge
                              .copyWith(color: Colors.white),
                        ),
                  IconButton(
                    constraints: const BoxConstraints(),
                    padding: const EdgeInsets.symmetric(horizontal: 4),
                    icon: const Icon(Icons.chevron_right_rounded,
                        color: Colors.white70, size: 20),
                    onPressed: state.yearChanging ||
                            state.year >= DateTime.now().year
                        ? null
                        : () => cubit.changeYear(state.year + 1),
                  ),
                ],
              ),
            ],
          ),
          const SizedBox(height: 12),
          // Bars
          SizedBox(
            height: 100,
            child: Row(
              mainAxisAlignment: MainAxisAlignment.spaceAround,
              crossAxisAlignment: CrossAxisAlignment.end,
              children: bars.map((bar) {
                final fraction =
                    maxAmount > 0 ? (bar.amount / maxAmount) : 0.0;
                final barH = (fraction * 80).clamp(3.0, 80.0);
                return Tooltip(
                  message: '₹${bar.amount.toStringAsFixed(0)}',
                  child: Column(
                    mainAxisAlignment: MainAxisAlignment.end,
                    children: [
                      Container(
                        width: 16,
                        height: barH,
                        decoration: BoxDecoration(
                          color: bar.isCurrentMonth
                              ? Colors.white
                              : AppColors.primary,
                          borderRadius: BorderRadius.circular(3),
                        ),
                      ),
                    ],
                  ),
                );
              }).toList(),
            ),
          ),
          const SizedBox(height: 6),
          // Month labels
          Row(
            mainAxisAlignment: MainAxisAlignment.spaceAround,
            children: bars
                .map((bar) => SizedBox(
                      width: 16,
                      child: Text(
                        bar.label.substring(0, 1),
                        textAlign: TextAlign.center,
                        style: TextStyle(
                          color: bar.isCurrentMonth
                              ? Colors.white
                              : Colors.white54,
                          fontSize: 9,
                          fontWeight: bar.isCurrentMonth
                              ? FontWeight.bold
                              : FontWeight.normal,
                        ),
                      ),
                    ))
                .toList(),
          ),
        ],
      ),
    );
  }
}

class _MonthBar {
  final String label;
  final double amount;
  final bool isCurrentMonth;
  const _MonthBar(
      {required this.label,
      required this.amount,
      required this.isCurrentMonth});
}

// ─── Summary Card ─────────────────────────────────────────────────────────────

class _SummaryCard extends StatelessWidget {
  final String label;
  final String value;
  final Color color;
  final String? subtitle;

  const _SummaryCard({
    required this.label,
    required this.value,
    required this.color,
    this.subtitle,
  });

  @override
  Widget build(BuildContext context) {
    return Container(
      padding: const EdgeInsets.all(16),
      decoration: BoxDecoration(
        color: Theme.of(context).colorScheme.surface,
        borderRadius: BorderRadius.circular(12),
      ),
      child: Row(
        mainAxisAlignment: MainAxisAlignment.spaceBetween,
        children: [
          Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              Text(label, style: AppTypography.bodyMedium),
              if (subtitle != null)
                Text(subtitle!,
                    style: AppTypography.bodySmall
                        .copyWith(color: AppColors.textHint)),
            ],
          ),
          Text(value, style: AppTypography.h3.copyWith(color: color)),
        ],
      ),
    );
  }
}

// ─── Top Customer Item ────────────────────────────────────────────────────────

class _TopCustomerItem extends StatelessWidget {
  final String name;
  final double balance;
  final String linkId;

  const _TopCustomerItem({
    required this.name,
    required this.balance,
    required this.linkId,
  });

  @override
  Widget build(BuildContext context) {
    return InkWell(
      onTap: () => context.push(
        AppRouter.customerDetailReport,
        extra: {'linkId': linkId, 'name': name},
      ),
      borderRadius: BorderRadius.circular(12),
      child: Padding(
        padding: const EdgeInsets.symmetric(vertical: 10, horizontal: 4),
        child: Row(
          children: [
            CircleAvatar(
              radius: 18,
              backgroundColor: AppColors.primary.withValues(alpha: 0.12),
              child: Text(
                name[0].toUpperCase(),
                style: const TextStyle(
                    color: AppColors.primary, fontWeight: FontWeight.bold),
              ),
            ),
            const SizedBox(width: 12),
            Expanded(child: Text(name, style: AppTypography.bodyMedium)),
            Text(
              '₹${balance.toStringAsFixed(0)}',
              style: AppTypography.labelLarge.copyWith(color: AppColors.error),
            ),
            const SizedBox(width: 4),
            const Icon(Icons.chevron_right_rounded,
                color: AppColors.textHint, size: 18),
          ],
        ),
      ),
    );
  }
}
