import 'package:flutter/material.dart';
import 'package:go_router/go_router.dart';
import '../../../../../../core/constants/app_colors.dart';
import '../../../../../../core/constants/app_typography.dart';
import '../../../../../../core/router/app_router.dart';

class TopCustomerItem extends StatelessWidget {
  final String name;
  final double balance;
  final String linkId;

  const TopCustomerItem({
    super.key,
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
              backgroundColor:
                  AppColors.primary.withValues(alpha: 0.12),
              child: Text(
                name[0].toUpperCase(),
                style: const TextStyle(
                    color: AppColors.primary,
                    fontWeight: FontWeight.bold),
              ),
            ),
            const SizedBox(width: 12),
            Expanded(child: Text(name, style: AppTypography.bodyMedium)),
            Text(
              '₹${balance.toStringAsFixed(0)}',
              style:
                  AppTypography.labelLarge.copyWith(color: AppColors.error),
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
