import 'package:flutter/material.dart';
import '../../../../../../core/constants/app_colors.dart';
import '../../../../../../core/constants/app_typography.dart';

class BalanceCheck extends StatelessWidget {
  final double billed;
  final double received;
  final double balance;

  const BalanceCheck({
    super.key,
    required this.billed,
    required this.received,
    required this.balance,
  });

  @override
  Widget build(BuildContext context) {
    final computed = billed - received;
    final matches = (computed - balance).abs() < 0.5;
    return Container(
      padding: const EdgeInsets.symmetric(horizontal: 14, vertical: 10),
      decoration: BoxDecoration(
        color: Theme.of(context).colorScheme.surface,
        borderRadius: BorderRadius.circular(12),
      ),
      child: Row(
        mainAxisAlignment: MainAxisAlignment.center,
        children: [
          Text(
            '₹${billed.toStringAsFixed(0)} − ₹${received.toStringAsFixed(0)} = ₹${computed.toStringAsFixed(0)}',
            style: AppTypography.bodySmall
                .copyWith(color: AppColors.textSecondary),
          ),
          const SizedBox(width: 6),
          Icon(
            matches
                ? Icons.check_circle_rounded
                : Icons.warning_amber_rounded,
            size: 14,
            color: matches ? AppColors.success : AppColors.warning,
          ),
        ],
      ),
    );
  }
}
