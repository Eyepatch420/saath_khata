import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import '../../../../core/constants/app_colors.dart';
import '../../../../core/constants/app_typography.dart';
import '../../domain/models/membership_tier.dart';
import '../bloc/membership_cubit.dart';
import '../bloc/membership_state.dart';

/// Membership banner shown on the shared ledger screen, under the balance header.
/// Vendor: see/approve a pending request and change the customer's tier.
/// Customer: see current tier and apply for one.
class MembershipBanner extends StatelessWidget {
  final String customerName;
  final bool isVendorView;

  const MembershipBanner({
    super.key,
    required this.customerName,
    required this.isVendorView,
  });

  static Color tierColor(int level) => switch (level) {
        3 => const Color(0xFFFFC107), // gold
        2 => const Color(0xFF9E9E9E), // silver
        _ => const Color(0xFFCD7F32), // bronze
      };

  @override
  Widget build(BuildContext context) {
    return BlocConsumer<MembershipCubit, MembershipState>(
      listenWhen: (prev, curr) => curr is MembershipError,
      listener: (context, state) {
        if (state is MembershipError) {
          ScaffoldMessenger.of(context)
            ..hideCurrentSnackBar()
            ..showSnackBar(
              SnackBar(
                content: Text(state.message),
                backgroundColor: AppColors.error,
              ),
            );
        }
      },
      builder: (context, state) {
        if (state is! MembershipLoaded) {
          // Initial / loading / first error — stay out of the way.
          return const SizedBox.shrink();
        }
        final status = state.status;
        final busy = state.actionInProgress;
        final cubit = context.read<MembershipCubit>();

        return Container(
          margin: const EdgeInsets.fromLTRB(16, 4, 16, 4),
          padding: const EdgeInsets.all(14),
          decoration: BoxDecoration(
            color: Theme.of(context).colorScheme.surface,
            borderRadius: BorderRadius.circular(14),
            border: Border.all(color: AppColors.divider),
          ),
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              _CurrentTierRow(
                tier: status.currentTier,
                isVendorView: isVendorView,
                hasPendingRequest: status.pendingRequest != null,
                busy: busy,
                onChange: () => _openTierPicker(context, cubit, status.tiers,
                    status.currentTier, isVendorRequest: false),
                onApply: () => _openTierPicker(context, cubit, status.tiers,
                    status.currentTier, isVendorRequest: true),
              ),

              // Vendor only: an actionable card for the pending request.
              if (isVendorView && status.pendingRequest != null) ...[
                const SizedBox(height: 12),
                _PendingRequestCard(
                  tierName: status.pendingRequest!.requestedTier.name,
                  tierLevel: status.pendingRequest!.requestedTier.level,
                  message: status.pendingRequest!.message,
                  customerName: customerName,
                  busy: busy,
                  onApprove: () => cubit.approve(status.pendingRequest!.id),
                  onDecline: () => cubit.decline(status.pendingRequest!.id),
                ),
              ],

              // Customer only: awaiting-approval hint.
              if (!isVendorView && status.pendingRequest != null) ...[
                const SizedBox(height: 8),
                Text(
                  'Requested ${status.pendingRequest!.requestedTier.name} — awaiting approval',
                  style: AppTypography.bodySmall
                      .copyWith(color: AppColors.warning, fontWeight: FontWeight.w600),
                ),
              ],
            ],
          ),
        );
      },
    );
  }

  // ── Tier picker bottom sheet ────────────────────────────────────────────────
  void _openTierPicker(
    BuildContext context,
    MembershipCubit cubit,
    List<MembershipTier> tiers,
    MembershipTier? current, {
    required bool isVendorRequest, // true = customer applying, false = vendor assigning
  }) {
    showModalBottomSheet(
      context: context,
      useRootNavigator: true,
      shape: const RoundedRectangleBorder(
        borderRadius: BorderRadius.vertical(top: Radius.circular(24)),
      ),
      builder: (sheetCtx) => Padding(
        padding: const EdgeInsets.fromLTRB(20, 20, 20, 28),
        child: Column(
          mainAxisSize: MainAxisSize.min,
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Text(
              isVendorRequest ? 'Apply for membership' : 'Set membership tier',
              style: AppTypography.h3,
            ),
            const SizedBox(height: 4),
            Text(
              isVendorRequest
                  ? 'Choose a tier to request from this vendor'
                  : 'Choose a tier for $customerName',
              style: AppTypography.bodySmall
                  .copyWith(color: AppColors.textSecondary),
            ),
            const SizedBox(height: 16),
            ...tiers.map((t) {
              final isCurrent = current?.id == t.id;
              return ListTile(
                contentPadding: EdgeInsets.zero,
                leading: CircleAvatar(
                  backgroundColor: tierColor(t.level).withValues(alpha: 0.15),
                  child: Icon(Icons.workspace_premium_rounded,
                      color: tierColor(t.level)),
                ),
                title: Text(t.name, style: AppTypography.bodyLarge),
                subtitle: Text('Level ${t.level}',
                    style: AppTypography.bodySmall
                        .copyWith(color: AppColors.textSecondary)),
                trailing: isCurrent
                    ? const Icon(Icons.check_circle_rounded,
                        color: AppColors.success)
                    : null,
                onTap: isCurrent
                    ? null
                    : () {
                        Navigator.pop(sheetCtx);
                        if (isVendorRequest) {
                          cubit.requestTier(t.id);
                        } else {
                          cubit.assignTier(t.id);
                        }
                      },
              );
            }),
            // Vendor can remove an existing membership.
            if (!isVendorRequest && current != null) ...[
              const Divider(),
              ListTile(
                contentPadding: EdgeInsets.zero,
                leading: const CircleAvatar(
                  backgroundColor: Color(0x14E53935),
                  child: Icon(Icons.do_not_disturb_on_rounded,
                      color: AppColors.error),
                ),
                title: Text('Remove membership',
                    style: AppTypography.bodyLarge
                        .copyWith(color: AppColors.error)),
                onTap: () {
                  Navigator.pop(sheetCtx);
                  cubit.assignTier(null);
                },
              ),
            ],
          ],
        ),
      ),
    );
  }
}

class _CurrentTierRow extends StatelessWidget {
  final MembershipTier? tier;
  final bool isVendorView;
  final bool hasPendingRequest;
  final bool busy;
  final VoidCallback onChange;
  final VoidCallback onApply;

  const _CurrentTierRow({
    required this.tier,
    required this.isVendorView,
    required this.hasPendingRequest,
    required this.busy,
    required this.onChange,
    required this.onApply,
  });

  @override
  Widget build(BuildContext context) {
    final color =
        tier != null ? MembershipBanner.tierColor(tier!.level) : AppColors.textHint;

    return Row(
      children: [
        Icon(Icons.workspace_premium_rounded, color: color, size: 22),
        const SizedBox(width: 10),
        Expanded(
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              Text('Membership',
                  style: AppTypography.bodySmall
                      .copyWith(color: AppColors.textSecondary)),
              Text(
                tier?.name ?? 'No membership',
                style: AppTypography.bodyLarge.copyWith(
                  fontWeight: FontWeight.bold,
                  color: tier != null ? color : AppColors.textSecondary,
                ),
              ),
              if (tier != null && tier!.hasDiscount)
                Padding(
                  padding: const EdgeInsets.only(top: 2),
                  child: Row(
                    children: [
                      const Icon(Icons.local_offer_rounded,
                          size: 12, color: AppColors.success),
                      const SizedBox(width: 4),
                      Text(
                        tier!.discountLabel,
                        style: AppTypography.bodySmall
                            .copyWith(color: AppColors.success),
                      ),
                    ],
                  ),
                ),
            ],
          ),
        ),
        _trailingAction(),
      ],
    );
  }

  Widget _trailingAction() {
    if (busy) {
      return const SizedBox(
        width: 18,
        height: 18,
        child: CircularProgressIndicator(strokeWidth: 2),
      );
    }
    if (isVendorView) {
      return TextButton.icon(
        onPressed: onChange,
        icon: const Icon(Icons.edit_rounded, size: 16),
        label: Text(tier == null ? 'Set' : 'Change'),
      );
    }
    // Customer: only offer Apply when there's no pending request.
    if (hasPendingRequest) return const SizedBox.shrink();
    return TextButton.icon(
      onPressed: onApply,
      icon: const Icon(Icons.add_rounded, size: 16),
      label: const Text('Apply'),
    );
  }
}

class _PendingRequestCard extends StatelessWidget {
  final String tierName;
  final int tierLevel;
  final String? message;
  final String customerName;
  final bool busy;
  final VoidCallback onApprove;
  final VoidCallback onDecline;

  const _PendingRequestCard({
    required this.tierName,
    required this.tierLevel,
    required this.message,
    required this.customerName,
    required this.busy,
    required this.onApprove,
    required this.onDecline,
  });

  @override
  Widget build(BuildContext context) {
    final color = MembershipBanner.tierColor(tierLevel);
    return Container(
      padding: const EdgeInsets.all(12),
      decoration: BoxDecoration(
        color: color.withValues(alpha: 0.08),
        borderRadius: BorderRadius.circular(12),
        border: Border.all(color: color.withValues(alpha: 0.4)),
      ),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Row(
            children: [
              Icon(Icons.upgrade_rounded, color: color, size: 18),
              const SizedBox(width: 8),
              Expanded(
                child: Text(
                  '$customerName requested $tierName',
                  style: AppTypography.bodyMedium
                      .copyWith(fontWeight: FontWeight.w600),
                ),
              ),
            ],
          ),
          if (message != null && message!.isNotEmpty) ...[
            const SizedBox(height: 6),
            Text('“$message”',
                style: AppTypography.bodySmall
                    .copyWith(color: AppColors.textSecondary)),
          ],
          const SizedBox(height: 10),
          Row(
            children: [
              Expanded(
                child: OutlinedButton(
                  onPressed: busy ? null : onDecline,
                  style: OutlinedButton.styleFrom(
                    foregroundColor: AppColors.error,
                    side: const BorderSide(color: AppColors.error),
                  ),
                  child: const Text('Decline'),
                ),
              ),
              const SizedBox(width: 10),
              Expanded(
                child: ElevatedButton(
                  onPressed: busy ? null : onApprove,
                  style: ElevatedButton.styleFrom(
                    backgroundColor: AppColors.success,
                    foregroundColor: Colors.white,
                  ),
                  child: const Text('Approve'),
                ),
              ),
            ],
          ),
        ],
      ),
    );
  }
}
