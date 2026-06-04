import 'package:flutter/material.dart';
import '../../../../../../core/constants/app_colors.dart';
import '../../../../../../core/constants/app_typography.dart';

class UpiEmptyState extends StatelessWidget {
  final VoidCallback onAdd;
  const UpiEmptyState({super.key, required this.onAdd});

  @override
  Widget build(BuildContext context) {
    return Center(
      child: Padding(
        padding: const EdgeInsets.all(32),
        child: Column(
          mainAxisSize: MainAxisSize.min,
          children: [
            Icon(Icons.account_balance_wallet_outlined,
                size: 64, color: AppColors.textHint),
            const SizedBox(height: 16),
            Text(
              'No UPI IDs yet',
              style: AppTypography.h3
                  .copyWith(color: AppColors.textSecondary),
            ),
            const SizedBox(height: 8),
            Text(
              'Add up to 5 UPI IDs. Your primary ID will be shared with customers for payment.',
              style: AppTypography.bodyMedium
                  .copyWith(color: AppColors.textHint),
              textAlign: TextAlign.center,
            ),
            const SizedBox(height: 24),
            ElevatedButton.icon(
              onPressed: onAdd,
              icon:
                  const Icon(Icons.add_rounded, color: Colors.white),
              label: const Text('Add UPI ID',
                  style: TextStyle(color: Colors.white)),
              style: ElevatedButton.styleFrom(
                backgroundColor: AppColors.primary,
                padding: const EdgeInsets.symmetric(
                    horizontal: 24, vertical: 12),
                shape: RoundedRectangleBorder(
                    borderRadius: BorderRadius.circular(12)),
              ),
            ),
          ],
        ),
      ),
    );
  }
}
