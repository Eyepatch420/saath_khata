import 'package:flutter/material.dart';
import 'package:go_router/go_router.dart';
import '../../../../core/constants/app_colors.dart';
import '../../../../core/constants/app_typography.dart';
import '../../../../core/router/app_router.dart';
import '../../../../l10n/app_localizations.dart';

class VendorTile extends StatelessWidget {
  final dynamic vendor;
  const VendorTile({super.key, required this.vendor});

  @override
  Widget build(BuildContext context) {
    final info = vendor.vendor; // VendorLinkItem.vendor → VendorSummary
    final surface = Theme.of(context).colorScheme.surface;
    return InkWell(
      onTap: () => context.push(
        AppRouter.sharedLedger,
        extra: {'linkId': vendor.linkId, 'name': info.name},
      ),
      borderRadius: BorderRadius.circular(16),
      child: Container(
        padding: const EdgeInsets.all(16),
        decoration: BoxDecoration(
          color: surface,
          borderRadius: BorderRadius.circular(16),
        ),
        child: Row(
          children: [
            CircleAvatar(
              backgroundColor: AppColors.primary.withValues(alpha: 0.15),
              child: Text(info.name[0],
                  style: const TextStyle(
                      color: AppColors.primary, fontWeight: FontWeight.bold)),
            ),
            const SizedBox(width: 16),
            Expanded(
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  Text(info.name, style: AppTypography.labelLarge),
                  const Text('Last delivery: Today, 7:30 AM',
                      style: TextStyle(fontSize: 10, color: AppColors.textHint)),
                ],
              ),
            ),
            Column(
              crossAxisAlignment: CrossAxisAlignment.end,
              children: [
                Text('₹${vendor.balance.toStringAsFixed(0)}',
                    style: AppTypography.labelLarge.copyWith(color: AppColors.error)),
                Text(AppLocalizations.of(context)!.outstanding,
                    style: const TextStyle(fontSize: 10, color: AppColors.textHint)),
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
