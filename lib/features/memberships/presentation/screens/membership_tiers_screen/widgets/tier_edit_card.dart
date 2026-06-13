import 'package:flutter/material.dart';
import '../../../../../../core/constants/app_colors.dart';
import '../../../../../../core/constants/app_typography.dart';
import '../../../../domain/models/membership_tier.dart';

/// One membership tier shown on the management screen: its name, level badge,
/// and current discount, with Edit name / Edit discount actions.
class TierEditCard extends StatelessWidget {
  final MembershipTier tier;
  final VoidCallback onRename;
  final VoidCallback onEditDiscount;

  const TierEditCard({
    super.key,
    required this.tier,
    required this.onRename,
    required this.onEditDiscount,
  });

  // Bronze / Silver / Gold accent by level.
  Color get _accent => switch (tier.level) {
        3 => const Color(0xFFD4AF37), // gold
        2 => const Color(0xFF9E9E9E), // silver
        _ => const Color(0xFFCD7F32), // bronze
      };

  @override
  Widget build(BuildContext context) {
    final surface = Theme.of(context).colorScheme.surface;
    return Container(
      padding: const EdgeInsets.all(16),
      decoration: BoxDecoration(
        color: surface,
        borderRadius: BorderRadius.circular(16),
        border: Border.all(color: _accent.withValues(alpha: 0.35)),
      ),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Row(
            children: [
              Container(
                width: 40,
                height: 40,
                decoration: BoxDecoration(
                  color: _accent.withValues(alpha: 0.15),
                  shape: BoxShape.circle,
                ),
                alignment: Alignment.center,
                child: Icon(Icons.workspace_premium_rounded,
                    color: _accent, size: 22),
              ),
              const SizedBox(width: 12),
              Expanded(
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    Text(tier.name, style: AppTypography.labelLarge),
                    Text('Level ${tier.level}',
                        style: AppTypography.bodySmall
                            .copyWith(color: AppColors.textHint)),
                  ],
                ),
              ),
              IconButton(
                tooltip: 'Rename',
                icon: const Icon(Icons.edit_rounded, size: 18),
                color: AppColors.textSecondary,
                onPressed: onRename,
              ),
            ],
          ),
          const SizedBox(height: 12),
          // Discount row
          InkWell(
            onTap: onEditDiscount,
            borderRadius: BorderRadius.circular(12),
            child: Container(
              width: double.infinity,
              padding: const EdgeInsets.all(12),
              decoration: BoxDecoration(
                color: tier.hasDiscount
                    ? AppColors.success.withValues(alpha: 0.08)
                    : AppColors.textHint.withValues(alpha: 0.06),
                borderRadius: BorderRadius.circular(12),
                border: Border.all(
                  color: tier.hasDiscount
                      ? AppColors.success.withValues(alpha: 0.3)
                      : Theme.of(context).dividerColor,
                ),
              ),
              child: Row(
                children: [
                  Icon(
                    tier.hasDiscount
                        ? Icons.local_offer_rounded
                        : Icons.local_offer_outlined,
                    size: 18,
                    color: tier.hasDiscount
                        ? AppColors.success
                        : AppColors.textHint,
                  ),
                  const SizedBox(width: 10),
                  Expanded(
                    child: Column(
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children: [
                        Text('Member discount',
                            style: AppTypography.bodySmall
                                .copyWith(color: AppColors.textHint)),
                        const SizedBox(height: 2),
                        Text(
                          tier.discountLabel,
                          style: AppTypography.bodyMedium.copyWith(
                            color: tier.hasDiscount
                                ? AppColors.success
                                : AppColors.textSecondary,
                            fontWeight: FontWeight.w600,
                          ),
                        ),
                      ],
                    ),
                  ),
                  Icon(Icons.chevron_right_rounded,
                      size: 18, color: AppColors.textHint),
                ],
              ),
            ),
          ),
        ],
      ),
    );
  }
}
