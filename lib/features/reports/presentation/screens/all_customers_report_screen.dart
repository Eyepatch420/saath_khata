import 'package:flutter/material.dart';
import 'package:go_router/go_router.dart';
import '../../../../core/constants/app_colors.dart';
import '../../../../core/constants/app_typography.dart';
import '../../../../core/router/app_router.dart';
import '../../../../l10n/app_localizations.dart';

class AllCustomersReportScreen extends StatelessWidget {
  const AllCustomersReportScreen({super.key});

  @override
  Widget build(BuildContext context) {
    final l10n = AppLocalizations.of(context)!;
    final List<Map<String, dynamic>> customers = [
      {'id': '1', 'name': 'Sujeet Kumar', 'collected': 12400.0, 'month': 'May'},
      {'id': '2', 'name': 'Ramesh Singh', 'collected': 8200.0, 'month': 'May'},
      {'id': '3', 'name': 'Anjali Sharma', 'collected': 5500.0, 'month': 'May'},
      {'id': '4', 'name': 'Vikram Mehra', 'collected': 4200.0, 'month': 'May'},
      {'id': '5', 'name': 'Priya Das', 'collected': 3100.0, 'month': 'May'},
      {'id': '6', 'name': 'Sanjay Gupta', 'collected': 2800.0, 'month': 'May'},
      {'id': '7', 'name': 'Amit Patel', 'collected': 2500.0, 'month': 'May'},
      {'id': '8', 'name': 'Neha Kapoor', 'collected': 2100.0, 'month': 'May'},
    ];

    return Scaffold(

      appBar: AppBar(
        title: Text(l10n.allCustomersReport),
      ),
      body: SafeArea(child: Column(
        children: [
          Container(
            padding: const EdgeInsets.all(16),
            color: Theme.of(context).colorScheme.surface,
            child: Row(
              mainAxisAlignment: MainAxisAlignment.spaceBetween,
              children: [
                Text('Month: May 2024', style: AppTypography.labelLarge),
                const Icon(Icons.calendar_month_rounded, color: AppColors.primary),
              ],
            ),
          ),
          Expanded(
            child: ListView.separated(
              padding: const EdgeInsets.all(16),
              itemCount: customers.length,
              separatorBuilder: (context, index) => const SizedBox(height: 12),
              itemBuilder: (context, index) {
                final customer = customers[index];
                return _CustomerReportTile(customer: customer);
              },
            ),
          ),
        ],
      ),
      ),
    );
  }
}

class _CustomerReportTile extends StatelessWidget {
  final Map<String, dynamic> customer;

  const _CustomerReportTile({required this.customer});

  @override
  Widget build(BuildContext context) {
    final l10n = AppLocalizations.of(context)!;
    return InkWell(
      onTap: () => context.push(
        AppRouter.customerDetailReport,
        extra: customer,
      ),
      borderRadius: BorderRadius.circular(16),
      child: Container(
        padding: const EdgeInsets.all(16),
        decoration: BoxDecoration(
          color: Theme.of(context).colorScheme.surface,
          borderRadius: BorderRadius.circular(16),
        ),
        child: Row(
          children: [
            CircleAvatar(
              backgroundColor: AppColors.primary.withValues(alpha: 0.1),
              child: Text(
                customer['name'][0],
                style: const TextStyle(
                    color: AppColors.primary, fontWeight: FontWeight.bold),
              ),
            ),
            const SizedBox(width: 16),
            Expanded(
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  Text(customer['name'], style: AppTypography.labelLarge),
                  Text(l10n.collectedInMonth(customer['month']),
                      style: AppTypography.bodySmall),
                ],
              ),
            ),
            Column(
              crossAxisAlignment: CrossAxisAlignment.end,
              children: [
                Text(
                  '₹${customer['collected'].toStringAsFixed(0)}',
                  style: AppTypography.labelLarge.copyWith(color: AppColors.success),
                ),
                const Icon(Icons.chevron_right_rounded,
                    color: AppColors.textHint, size: 20),
              ],
            ),
          ],
        ),
      ),
    );
  }
}
