import 'package:flutter/material.dart';
import 'package:intl/intl.dart';
import '../../../../core/constants/app_colors.dart';
import '../../../../core/constants/app_typography.dart';

class CustomerDetailReportScreen extends StatelessWidget {
  final Map<String, dynamic> customer;

  const CustomerDetailReportScreen({super.key, required this.customer});

  @override
  Widget build(BuildContext context) {
    // Mock history data
    final List<Map<String, dynamic>> history = [
      {'date': DateTime(2024, 5, 25), 'type': 'Payment', 'amount': 5000.0, 'status': 'Confirmed'},
      {'date': DateTime(2024, 5, 20), 'type': 'Credit', 'amount': 1200.0, 'status': 'Confirmed'},
      {'date': DateTime(2024, 5, 15), 'type': 'Payment', 'amount': 3000.0, 'status': 'Confirmed'},
      {'date': DateTime(2024, 5, 10), 'type': 'Credit', 'amount': 4500.0, 'status': 'Confirmed'},
      {'date': DateTime(2024, 5, 5), 'type': 'Payment', 'amount': 4400.0, 'status': 'Confirmed'},
    ];

    return Scaffold(

      appBar: AppBar(
        title: Text('${customer['name']} Report'),
      ),
      body: SingleChildScrollView(
        padding: const EdgeInsets.all(20),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Text('Revenue Overview', style: AppTypography.h3),
            const SizedBox(height: 16),
            Row(
              children: [
                Expanded(
                  child: _MiniStatCard(
                    title: 'Total Sales',
                    value: '₹15,700',
                    color: AppColors.primary,
                  ),
                ),
                const SizedBox(width: 16),
                Expanded(
                  child: _MiniStatCard(
                    title: 'Total Paid',
                    value: '₹${customer['collected'].toStringAsFixed(0)}',
                    color: AppColors.success,
                  ),
                ),
              ],
            ),
            const SizedBox(height: 12),
            _MiniStatCard(
              title: 'Current Outstanding',
              value: '₹3,300',
              color: AppColors.error,
              isWide: true,
            ),
            const SizedBox(height: 32),
            Text('Payment History', style: AppTypography.h3),
            const SizedBox(height: 16),
            ListView.separated(
              shrinkWrap: true,
              physics: const NeverScrollableScrollPhysics(),
              itemCount: history.length,
              separatorBuilder: (context, index) => const SizedBox(height: 12),
              itemBuilder: (context, index) {
                final item = history[index];
                return _HistoryItem(item: item);
              },
            ),
          ],
        ),
      ),
    );
  }
}

class _MiniStatCard extends StatelessWidget {
  final String title;
  final String value;
  final Color color;
  final bool isWide;

  const _MiniStatCard({
    required this.title,
    required this.value,
    required this.color,
    this.isWide = false,
  });

  @override
  Widget build(BuildContext context) {
    return Container(
      padding: const EdgeInsets.all(16),
      width: isWide ? double.infinity : null,
      decoration: BoxDecoration(
        color: Theme.of(context).colorScheme.surface,
        borderRadius: BorderRadius.circular(16),
      ),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Text(title, style: AppTypography.bodySmall),
          const SizedBox(height: 8),
          Text(value, style: AppTypography.h2.copyWith(color: color)),
        ],
      ),
    );
  }
}

class _HistoryItem extends StatelessWidget {
  final Map<String, dynamic> item;

  const _HistoryItem({required this.item});

  @override
  Widget build(BuildContext context) {
    final isCredit = item['type'] == 'Credit';

    return Container(
      padding: const EdgeInsets.all(16),
      decoration: BoxDecoration(
        color: Theme.of(context).colorScheme.surface,
        borderRadius: BorderRadius.circular(16),
      ),
      child: Row(
        children: [
          Icon(
            isCredit ? Icons.arrow_upward_rounded : Icons.arrow_downward_rounded,
            color: isCredit ? AppColors.error : AppColors.success,
          ),
          const SizedBox(width: 16),
          Expanded(
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Text(item['type'], style: AppTypography.labelLarge),
                Text(
                  DateFormat('dd MMM yyyy').format(item['date']),
                  style: AppTypography.bodySmall,
                ),
              ],
            ),
          ),
          Text(
            '₹${item['amount'].toStringAsFixed(0)}',
            style: AppTypography.labelLarge.copyWith(
              color: isCredit ? AppColors.error : AppColors.success,
            ),
          ),
        ],
      ),
    );
  }
}
