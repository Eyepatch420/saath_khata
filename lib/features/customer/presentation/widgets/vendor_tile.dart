import 'package:flutter/material.dart';
import 'package:go_router/go_router.dart';
import '../../../../core/constants/app_colors.dart';
import '../../../../core/constants/app_typography.dart';
import '../../../../core/router/app_router.dart';

class VendorTile extends StatelessWidget {
  final dynamic vendor;
  const VendorTile({super.key, required this.vendor});

  @override
  Widget build(BuildContext context) {
    return InkWell(
      onTap: () => context.push(
        AppRouter.sharedLedger,
        extra: {'id': vendor.id, 'name': vendor.name},
      ),
      borderRadius: BorderRadius.circular(16),
      child: Container(
        padding: const EdgeInsets.all(16),
        decoration: BoxDecoration(
          color: AppColors.surface,
          borderRadius: BorderRadius.circular(16),
        ),
        child: Row(
          children: [
            CircleAvatar(
              backgroundColor: AppColors.secondary.withValues(alpha: 0.1),
              child: Text(vendor.name[0],
                  style: const TextStyle(
                      color: AppColors.secondary, fontWeight: FontWeight.bold)),
            ),
            const SizedBox(width: 16),
            Expanded(
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  Text(vendor.name, style: AppTypography.labelLarge),
                  const Text('Last delivery: Today, 7:30 AM',
                      style: TextStyle(fontSize: 10, color: AppColors.textHint)),
                ],
              ),
            ),
            Column(
              crossAxisAlignment: CrossAxisAlignment.end,
              children: [
                Text('₹850',
                    style: AppTypography.labelLarge.copyWith(color: AppColors.error)),
                const Text('Due',
                    style: TextStyle(fontSize: 10, color: AppColors.textHint)),
              ],
            ),
            const SizedBox(width: 8),
            const Icon(Icons.chevron_right_rounded, color: AppColors.textHint),
          ],
        ),
      ),
    );
  }
}
