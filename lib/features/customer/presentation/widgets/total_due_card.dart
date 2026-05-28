import 'package:flutter/material.dart';
import '../../../../core/constants/app_colors.dart';
import '../../../../core/constants/app_typography.dart';
import '../../../../l10n/app_localizations.dart';

class TotalDueCard extends StatelessWidget {
  final double amount;
  final VoidCallback? onPayAllDues;
  const TotalDueCard({super.key, required this.amount, this.onPayAllDues});

  @override
  Widget build(BuildContext context) {
    final l10n = AppLocalizations.of(context)!;
    return Container(
      padding: const EdgeInsets.all(24),
      decoration: BoxDecoration(
        color: AppColors.secondary,
        borderRadius: BorderRadius.circular(20),
        boxShadow: [
          BoxShadow(
              color: AppColors.secondary.withValues(alpha: 0.3),
              blurRadius: 10,
              offset: const Offset(0, 4)),
        ],
      ),
      child: Column(
        children: [
          Text(l10n.totalOutstandingBalance,
              style: AppTypography.bodySmall.copyWith(color: Colors.white70)),
          const SizedBox(height: 8),
          Text('₹${amount.toStringAsFixed(2)}',
              style: AppTypography.h1.copyWith(color: Colors.white, fontSize: 32)),
          const SizedBox(height: 20),
          SizedBox(
            width: double.infinity,
            child: ElevatedButton(
              onPressed: onPayAllDues,
              style: ElevatedButton.styleFrom(
                backgroundColor: AppColors.primary,
                foregroundColor: Colors.white,
              ),
              child: Text(l10n.payAllDues),
            ),
          ),
        ],
      ),
    );
  }
}
