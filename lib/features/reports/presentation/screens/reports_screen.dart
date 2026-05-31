import 'package:flutter/material.dart';
import 'package:go_router/go_router.dart';
import '../../../../core/constants/app_colors.dart';
import '../../../../core/constants/app_typography.dart';
import '../../../../core/router/app_router.dart';
import '../../../../l10n/app_localizations.dart';

class ReportsScreen extends StatelessWidget {
  const ReportsScreen({super.key});

  @override
  Widget build(BuildContext context) {
    final l10n = AppLocalizations.of(context)!;
    return Scaffold(

      appBar: AppBar(title: Text(l10n.businessReports)),
      body: SafeArea(child: SingleChildScrollView(
        padding: EdgeInsets.fromLTRB(20, 20, 20, MediaQuery.of(context).viewPadding.bottom + 96),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            _RevenueChart(),
            const SizedBox(height: 24),
            Text(l10n.collectionSummary, style: AppTypography.h3),
            const SizedBox(height: 16),
            _SummaryCard(label: l10n.totalOutstanding, value: '₹45,200', color: AppColors.error),
            const SizedBox(height: 12),
            _SummaryCard(label: l10n.totalCollected, value: '₹1,12,000', color: AppColors.success),
            const SizedBox(height: 24),
            Row(
              mainAxisAlignment: MainAxisAlignment.spaceBetween,
              children: [
                Text(l10n.topCustomers, style: AppTypography.h3),
                TextButton(
                  onPressed: () => context.push(AppRouter.allCustomersReport),
                  child: Text(l10n.seeAll),
                ),
              ],
            ),
            const SizedBox(height: 12),
            _TopCustomerItem(name: 'Sujeet Kumar', value: '₹12,400'),
            _TopCustomerItem(name: 'Ramesh Singh', value: '₹8,200'),
          ],
        ),
      ),
      ),
    );
  }
}

class _RevenueChart extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    final l10n = AppLocalizations.of(context)!;
    return Container(
      height: 200,
      padding: const EdgeInsets.all(16),
      decoration: BoxDecoration(
        color: AppColors.secondary,
        borderRadius: BorderRadius.circular(16),
      ),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Text(l10n.revenueTrend, style: AppTypography.bodySmall.copyWith(color: Colors.white70)),
          const Spacer(),
          Row(
            mainAxisAlignment: MainAxisAlignment.spaceAround,
            crossAxisAlignment: CrossAxisAlignment.end,
            children: List.generate(
              7,
              (index) => Container(
                width: 20,
                height: (index % 3 + 2) * 20.0,
                decoration: BoxDecoration(
                  color: AppColors.primary,
                  borderRadius: BorderRadius.circular(4),
                ),
              ),
            ),
          ),
          const SizedBox(height: 8),
          Row(
            mainAxisAlignment: MainAxisAlignment.spaceAround,
            children: const [
              Text('M', style: TextStyle(color: Colors.white54, fontSize: 10)),
              Text('T', style: TextStyle(color: Colors.white54, fontSize: 10)),
              Text('W', style: TextStyle(color: Colors.white54, fontSize: 10)),
              Text('T', style: TextStyle(color: Colors.white54, fontSize: 10)),
              Text('F', style: TextStyle(color: Colors.white54, fontSize: 10)),
              Text('S', style: TextStyle(color: Colors.white54, fontSize: 10)),
              Text('S', style: TextStyle(color: Colors.white54, fontSize: 10)),
            ],
          ),
        ],
      ),
    );
  }
}

class _SummaryCard extends StatelessWidget {
  final String label;
  final String value;
  final Color color;

  const _SummaryCard({required this.label, required this.value, required this.color});

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
          Text(label, style: AppTypography.bodyMedium),
          Text(value, style: AppTypography.h3.copyWith(color: color)),
        ],
      ),
    );
  }
}

class _TopCustomerItem extends StatelessWidget {
  final String name;
  final String value;

  const _TopCustomerItem({required this.name, required this.value});

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.only(bottom: 12),
      child: Row(
        children: [
          const CircleAvatar(radius: 16, child: Icon(Icons.person, size: 16)),
          const SizedBox(width: 12),
          Text(name, style: AppTypography.bodyMedium),
          const Spacer(),
          Text(value, style: AppTypography.labelLarge),
        ],
      ),
    );
  }
}
