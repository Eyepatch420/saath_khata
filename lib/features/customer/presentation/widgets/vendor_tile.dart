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
        extra: {'linkId': vendor.linkId, 'name': info.name, 'isVendorView': false},
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
                const SizedBox(height: 6),
                GestureDetector(
                  behavior: HitTestBehavior.opaque,
                  onTap: () => context.push(
                    AppRouter.bookAppointment,
                    extra: {'vendorId': info.id, 'vendorName': info.name},
                  ),
                  child: Container(
                    padding: const EdgeInsets.symmetric(horizontal: 10, vertical: 4),
                    decoration: BoxDecoration(
                      color: AppColors.primary.withValues(alpha: 0.1),
                      borderRadius: BorderRadius.circular(8),
                      border: Border.all(
                        color: AppColors.primary.withValues(alpha: 0.35),
                      ),
                    ),
                    child: Row(
                      mainAxisSize: MainAxisSize.min,
                      children: [
                        const Icon(Icons.calendar_today_rounded,
                            size: 11, color: AppColors.primary),
                        const SizedBox(width: 4),
                        Text(
                          'Book',
                          style: AppTypography.bodySmall.copyWith(
                            color: AppColors.primary,
                            fontWeight: FontWeight.w600,
                            fontSize: 11,
                          ),
                        ),
                      ],
                    ),
                  ),
                ),
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
