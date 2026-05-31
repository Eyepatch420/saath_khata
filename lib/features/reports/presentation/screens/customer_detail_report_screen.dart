import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import '../../../../core/constants/app_colors.dart';
import '../../../../core/constants/app_typography.dart';
import '../../../../core/di/injection.dart';
import '../../../../features/vendor/domain/repositories/vendor_repository.dart';
import '../../../../shared/models/report_models.dart';
import '../bloc/customer_detail_cubit.dart';

class CustomerDetailReportScreen extends StatelessWidget {
  final String linkId;
  final String customerName;

  const CustomerDetailReportScreen({
    super.key,
    required this.linkId,
    required this.customerName,
  });

  @override
  Widget build(BuildContext context) {
    return BlocProvider(
      create: (_) =>
          CustomerDetailCubit(getIt<VendorRepository>())..load(linkId),
      child: _CustomerDetailView(linkId: linkId, customerName: customerName),
    );
  }
}

class _CustomerDetailView extends StatelessWidget {
  final String linkId;
  final String customerName;
  const _CustomerDetailView(
      {required this.linkId, required this.customerName});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Text(customerName, style: AppTypography.h3),
            Text('Customer Report',
                style: AppTypography.bodySmall
                    .copyWith(color: AppColors.primary)),
          ],
        ),
      ),
      body: SafeArea(
        child: BlocBuilder<CustomerDetailCubit, CustomerDetailState>(
          builder: (context, state) {
            if (state is CustomerDetailLoading) {
              return const Center(child: CircularProgressIndicator());
            }
            if (state is CustomerDetailError) {
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
                          context.read<CustomerDetailCubit>().load(linkId),
                      child: const Text('Retry'),
                    ),
                  ],
                ),
              );
            }
            if (state is CustomerDetailLoaded) {
              return _DetailBody(detail: state.detail);
            }
            return const SizedBox();
          },
        ),
      ),
    );
  }
}

// ─── Detail Body ──────────────────────────────────────────────────────────────

class _DetailBody extends StatelessWidget {
  final CustomerDetailReport detail;
  const _DetailBody({required this.detail});

  @override
  Widget build(BuildContext context) {
    return SingleChildScrollView(
      padding: EdgeInsets.fromLTRB(
          20, 20, 20, MediaQuery.of(context).viewPadding.bottom + 24),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          _BalanceHero(balance: detail.balance),
          const SizedBox(height: 20),
          Text('Overview', style: AppTypography.h3),
          const SizedBox(height: 12),
          Row(
            children: [
              Expanded(
                child: _StatCard(
                  title: 'Total Billed',
                  value: '₹${detail.totalCredit.toStringAsFixed(0)}',
                  color: AppColors.error,
                  icon: Icons.receipt_long_rounded,
                ),
              ),
              const SizedBox(width: 12),
              Expanded(
                child: _StatCard(
                  title: 'Total Paid',
                  value: '₹${detail.totalPaid.toStringAsFixed(0)}',
                  color: AppColors.success,
                  icon: Icons.payments_rounded,
                ),
              ),
            ],
          ),
          const SizedBox(height: 12),
          _EntryCountsRow(
            pending: detail.pendingCount,
            confirmed: detail.confirmedCount,
            disputed: detail.disputedCount,
          ),
          if (detail.monthlyBreakdown.isNotEmpty) ...[
            const SizedBox(height: 24),
            Text('Payment History (6 months)', style: AppTypography.h3),
            const SizedBox(height: 12),
            ...detail.monthlyBreakdown.map((m) => _MonthlyRow(data: m)),
          ],
        ],
      ),
    );
  }
}

// ─── Balance Hero Card ────────────────────────────────────────────────────────

class _BalanceHero extends StatelessWidget {
  final double balance;
  const _BalanceHero({required this.balance});

  @override
  Widget build(BuildContext context) {
    final hasBalance = balance > 0;
    return Container(
      width: double.infinity,
      padding: const EdgeInsets.all(20),
      decoration: BoxDecoration(
        gradient: LinearGradient(
          colors: hasBalance
              ? [const Color(0xFFD32F2F), const Color(0xFFB71C1C)]
              : [const Color(0xFF1B5E20), const Color(0xFF2E7D32)],
          begin: Alignment.topLeft,
          end: Alignment.bottomRight,
        ),
        borderRadius: BorderRadius.circular(20),
      ),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Text(
            'Current Balance',
            style: AppTypography.bodySmall.copyWith(color: Colors.white70),
          ),
          const SizedBox(height: 8),
          Text(
            '₹${balance.toStringAsFixed(0)}',
            style: AppTypography.h1.copyWith(
                color: Colors.white, fontWeight: FontWeight.bold),
          ),
          const SizedBox(height: 4),
          Text(
            hasBalance ? 'Outstanding' : 'Settled',
            style: AppTypography.bodySmall.copyWith(color: Colors.white60),
          ),
        ],
      ),
    );
  }
}

// ─── Stat Card ────────────────────────────────────────────────────────────────

class _StatCard extends StatelessWidget {
  final String title;
  final String value;
  final Color color;
  final IconData icon;

  const _StatCard({
    required this.title,
    required this.value,
    required this.color,
    required this.icon,
  });

  @override
  Widget build(BuildContext context) {
    return Container(
      padding: const EdgeInsets.all(16),
      decoration: BoxDecoration(
        color: Theme.of(context).colorScheme.surface,
        borderRadius: BorderRadius.circular(16),
      ),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Icon(icon, color: color, size: 20),
          const SizedBox(height: 10),
          Text(value,
              style: AppTypography.h3.copyWith(color: color)),
          const SizedBox(height: 4),
          Text(title,
              style: AppTypography.bodySmall
                  .copyWith(color: AppColors.textHint)),
        ],
      ),
    );
  }
}

// ─── Entry Counts Row ─────────────────────────────────────────────────────────

class _EntryCountsRow extends StatelessWidget {
  final int pending;
  final int confirmed;
  final int disputed;

  const _EntryCountsRow({
    required this.pending,
    required this.confirmed,
    required this.disputed,
  });

  @override
  Widget build(BuildContext context) {
    return Container(
      padding: const EdgeInsets.symmetric(vertical: 12, horizontal: 16),
      decoration: BoxDecoration(
        color: Theme.of(context).colorScheme.surface,
        borderRadius: BorderRadius.circular(16),
      ),
      child: Row(
        mainAxisAlignment: MainAxisAlignment.spaceAround,
        children: [
          _CountChip(label: 'Pending', count: pending, color: Colors.orange),
          _Divider(),
          _CountChip(
              label: 'Confirmed', count: confirmed, color: AppColors.success),
          _Divider(),
          _CountChip(
              label: 'Disputed', count: disputed, color: AppColors.error),
        ],
      ),
    );
  }
}

class _CountChip extends StatelessWidget {
  final String label;
  final int count;
  final Color color;

  const _CountChip(
      {required this.label, required this.count, required this.color});

  @override
  Widget build(BuildContext context) {
    return Column(
      children: [
        Text('$count',
            style: AppTypography.h3.copyWith(color: color)),
        Text(label,
            style: AppTypography.bodySmall
                .copyWith(color: AppColors.textHint)),
      ],
    );
  }
}

class _Divider extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return Container(
        width: 1, height: 36, color: AppColors.textHint.withValues(alpha: 0.2));
  }
}

// ─── Monthly Row ──────────────────────────────────────────────────────────────

class _MonthlyRow extends StatelessWidget {
  final MonthlyPaymentData data;
  const _MonthlyRow({required this.data});

  static const _months = [
    '', 'Jan', 'Feb', 'Mar', 'Apr', 'May', 'Jun',
    'Jul', 'Aug', 'Sep', 'Oct', 'Nov', 'Dec'
  ];

  String _formatMonth(String yyyyMm) {
    final parts = yyyyMm.split('-');
    if (parts.length != 2) return yyyyMm;
    final m = int.tryParse(parts[1]) ?? 0;
    final y = parts[0];
    return '${(m >= 0 && m < _months.length) ? _months[m] : ''} $y';
  }

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.only(bottom: 10),
      child: Container(
        padding: const EdgeInsets.symmetric(horizontal: 16, vertical: 14),
        decoration: BoxDecoration(
          color: Theme.of(context).colorScheme.surface,
          borderRadius: BorderRadius.circular(14),
        ),
        child: Row(
          children: [
            Container(
              width: 40,
              height: 40,
              decoration: BoxDecoration(
                color: AppColors.success.withValues(alpha: 0.12),
                borderRadius: BorderRadius.circular(10),
              ),
              child: const Icon(Icons.payments_rounded,
                  color: AppColors.success, size: 20),
            ),
            const SizedBox(width: 14),
            Expanded(
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  Text(_formatMonth(data.month),
                      style: AppTypography.labelLarge),
                  Text(
                      '${data.transactionCount} payment${data.transactionCount == 1 ? '' : 's'}',
                      style: AppTypography.bodySmall
                          .copyWith(color: AppColors.textHint)),
                ],
              ),
            ),
            Text(
              '₹${data.totalPaid.toStringAsFixed(0)}',
              style: AppTypography.labelLarge
                  .copyWith(color: AppColors.success),
            ),
          ],
        ),
      ),
    );
  }
}
