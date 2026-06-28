import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import '../../../../core/constants/app_colors.dart';
import '../../domain/models/membership_status.dart';
import '../bloc/membership_cubit.dart';
import '../bloc/membership_state.dart';
import 'membership_banner.dart';

/// Compact membership indicator for the shared-ledger AppBar, visible to all
/// three roles. Tapping shows the tier + discount details.
///
/// Staff are strictly read-only — they can SEE the customer's membership but the
/// info sheet never offers change/assign/apply actions. Vendor and customer act
/// through the body banner below; this chip is an at-a-glance indicator + detail.
class MembershipAppBarChip extends StatelessWidget {
  const MembershipAppBarChip({super.key});

  @override
  Widget build(BuildContext context) {
    return BlocBuilder<MembershipCubit, MembershipState>(
      builder: (context, state) {
        if (state is! MembershipLoaded) return const SizedBox.shrink();
        final status = state.status;
        final tier = status.currentTier;
        final color = tier != null
            ? MembershipBanner.tierColor(tier.level)
            : AppColors.textHint;

        return Padding(
          padding: const EdgeInsets.symmetric(vertical: 8, horizontal: 4),
          child: InkWell(
            borderRadius: BorderRadius.circular(20),
            onTap: () => _showInfo(context, status),
            child: Container(
              padding: const EdgeInsets.symmetric(horizontal: 10, vertical: 6),
              decoration: BoxDecoration(
                color: color.withValues(alpha: 0.15),
                borderRadius: BorderRadius.circular(20),
                border: Border.all(color: color.withValues(alpha: 0.4)),
              ),
              child: Row(
                mainAxisSize: MainAxisSize.min,
                children: [
                  Icon(Icons.workspace_premium_rounded, size: 14, color: color),
                  const SizedBox(width: 4),
                  Text(
                    tier?.name ?? 'No tier',
                    style: TextStyle(
                      color: color,
                      fontWeight: FontWeight.w700,
                      fontSize: 12,
                    ),
                  ),
                ],
              ),
            ),
          ),
        );
      },
    );
  }

  void _showInfo(BuildContext context, MembershipStatus status) {
    final tier = status.currentTier;
    final color = tier != null
        ? MembershipBanner.tierColor(tier.level)
        : AppColors.textHint;

    showDialog<void>(
      context: context,
      builder: (ctx) => AlertDialog(
        title: Row(
          children: [
            Icon(Icons.workspace_premium_rounded, color: color),
            const SizedBox(width: 8),
            const Text('Membership'),
          ],
        ),
        content: Column(
          mainAxisSize: MainAxisSize.min,
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Text(
              tier?.name ?? 'No membership',
              style: TextStyle(
                  fontSize: 18, fontWeight: FontWeight.bold, color: color),
            ),
            if (tier != null) ...[
              const SizedBox(height: 6),
              Text('Level ${tier.level}',
                  style: const TextStyle(color: AppColors.textSecondary)),
              const SizedBox(height: 8),
              Row(
                children: [
                  const Icon(Icons.local_offer_rounded,
                      size: 14, color: AppColors.success),
                  const SizedBox(width: 6),
                  Expanded(
                    child: Text(
                      tier.hasDiscount ? tier.discountLabel : 'No discount',
                      style: const TextStyle(color: AppColors.textSecondary),
                    ),
                  ),
                ],
              ),
            ],
            if (status.pendingRequest != null) ...[
              const SizedBox(height: 10),
              Text(
                'Pending request: ${status.pendingRequest!.requestedTier.name}',
                style: const TextStyle(
                    color: AppColors.warning, fontWeight: FontWeight.w600),
              ),
            ],
          ],
        ),
        actions: [
          TextButton(
            onPressed: () => Navigator.pop(ctx),
            child: const Text('Close'),
          ),
        ],
      ),
    );
  }
}
