import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import '../../../../core/constants/app_colors.dart';
import '../../../../core/constants/app_typography.dart';
import '../../domain/models/membership_plan.dart';
import '../bloc/membership_cubit.dart';
import '../bloc/membership_state.dart';
import '../membership_theme.dart';

/// Membership banner on the shared ledger (vendor view only). Shows the active
/// plan + benefit usage, lets the vendor enroll a customer into a plan, and
/// surfaces an actionable card for any pending request.
class MembershipBanner extends StatelessWidget {
  final String customerName;
  final bool isVendorView;
  final bool isStaffView;

  const MembershipBanner({
    super.key,
    required this.customerName,
    required this.isVendorView,
    this.isStaffView = false,
  });

  @override
  Widget build(BuildContext context) {
    return BlocConsumer<MembershipCubit, MembershipState>(
      listenWhen: (prev, curr) => curr is MembershipError,
      listener: (context, state) {
        if (state is MembershipError) {
          ScaffoldMessenger.of(context)
            ..hideCurrentSnackBar()
            ..showSnackBar(SnackBar(
                content: Text(state.message), backgroundColor: AppColors.error));
        }
      },
      builder: (context, state) {
        if (state is! MembershipLoaded) return const SizedBox.shrink();
        final status = state.status;
        final busy = state.actionInProgress;
        final cubit = context.read<MembershipCubit>();
        final current = status.current;

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
              Row(
                children: [
                  Icon(Icons.workspace_premium_rounded,
                      color: current != null
                          ? MembershipTheme.purple
                          : AppColors.textHint,
                      size: 22),
                  const SizedBox(width: 10),
                  Expanded(
                    child: Column(
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children: [
                        Text('Membership',
                            style: AppTypography.bodySmall
                                .copyWith(color: AppColors.textSecondary)),
                        Text(
                          current?.plan.name ?? 'No membership',
                          style: AppTypography.bodyLarge.copyWith(
                            fontWeight: FontWeight.bold,
                            color: current != null
                                ? MembershipTheme.purpleDark
                                : AppColors.textSecondary,
                          ),
                        ),
                        if (current != null)
                          Text('${current.daysLeft} days left',
                              style: AppTypography.bodySmall
                                  .copyWith(color: AppColors.textSecondary)),
                      ],
                    ),
                  ),
                  if (busy)
                    const SizedBox(
                        width: 18,
                        height: 18,
                        child: CircularProgressIndicator(strokeWidth: 2))
                  else
                    TextButton.icon(
                      onPressed: () => _openEnrollPicker(context, cubit, status.plans,
                          current?.plan.id),
                      icon: Icon(current == null
                          ? Icons.add_rounded
                          : Icons.swap_horiz_rounded,
                          size: 16),
                      label: Text(current == null ? 'Enroll' : 'Change'),
                      style: TextButton.styleFrom(
                          foregroundColor: MembershipTheme.purple),
                    ),
                ],
              ),

              // Quota benefit usage with "mark used" controls (vendor only).
              if (current != null && current.benefitUsage.any((b) => b.hasQuota)) ...[
                const Divider(height: 18),
                ...current.benefitUsage.where((b) => b.hasQuota).map((b) {
                  final done = b.used >= (b.quota ?? 0);
                  return Padding(
                    padding: const EdgeInsets.only(bottom: 6),
                    child: Row(
                      children: [
                        Expanded(child: Text(b.label)),
                        Text('${b.used}/${b.quota}',
                            style: TextStyle(
                                color: done ? AppColors.error : AppColors.success,
                                fontWeight: FontWeight.w700)),
                        const SizedBox(width: 8),
                        OutlinedButton(
                          onPressed: (busy || done)
                              ? null
                              : () => cubit.useBenefit(current.id, b.benefitId),
                          style: OutlinedButton.styleFrom(
                            minimumSize: const Size(0, 32),
                            padding: const EdgeInsets.symmetric(horizontal: 10),
                            foregroundColor: MembershipTheme.purple,
                          ),
                          child: Text(done ? 'Used' : 'Use',
                              style: const TextStyle(fontSize: 12)),
                        ),
                      ],
                    ),
                  );
                }),
              ],

              // Pending request — approve / decline.
              if (status.pendingRequest != null) ...[
                const SizedBox(height: 12),
                _PendingRequestCard(
                  planName: status.pendingRequest!.requestedPlan?.name ?? 'a plan',
                  message: status.pendingRequest!.message,
                  customerName: customerName,
                  busy: busy,
                  onApprove: () => cubit.approve(status.pendingRequest!.id),
                  onDecline: () => cubit.decline(status.pendingRequest!.id),
                ),
              ],
            ],
          ),
        );
      },
    );
  }

  void _openEnrollPicker(
    BuildContext context,
    MembershipCubit cubit,
    List<MembershipPlan> plans,
    String? currentPlanId,
  ) {
    showModalBottomSheet<void>(
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
            Text('Enroll ${customerName.isEmpty ? 'customer' : customerName}',
                style: AppTypography.h3),
            const SizedBox(height: 4),
            const Text('Choose a plan to start their membership.',
                style: TextStyle(color: AppColors.textSecondary)),
            const SizedBox(height: 16),
            if (plans.isEmpty)
              const Padding(
                padding: EdgeInsets.symmetric(vertical: 12),
                child: Text(
                    'No active plans. Create one in Memberships → Plans first.',
                    style: TextStyle(color: AppColors.textSecondary)),
              )
            else
              ...plans.map((p) {
                final isCurrent = p.id == currentPlanId;
                return ListTile(
                  contentPadding: EdgeInsets.zero,
                  leading: const CircleAvatar(
                    backgroundColor: MembershipTheme.purpleSoft,
                    child: Icon(Icons.workspace_premium_rounded,
                        color: MembershipTheme.purple),
                  ),
                  title: Text(p.name),
                  subtitle: Text(
                      '₹${p.price.toStringAsFixed(0)} · ${p.durationDays} days'),
                  trailing: isCurrent
                      ? const Icon(Icons.check_circle, color: AppColors.success)
                      : null,
                  onTap: isCurrent
                      ? null
                      : () {
                          Navigator.pop(sheetCtx);
                          cubit.enroll(p.id);
                        },
                );
              }),
          ],
        ),
      ),
    );
  }
}

class _PendingRequestCard extends StatelessWidget {
  final String planName;
  final String? message;
  final String customerName;
  final bool busy;
  final VoidCallback onApprove;
  final VoidCallback onDecline;

  const _PendingRequestCard({
    required this.planName,
    required this.message,
    required this.customerName,
    required this.busy,
    required this.onApprove,
    required this.onDecline,
  });

  @override
  Widget build(BuildContext context) {
    return Container(
      padding: const EdgeInsets.all(12),
      decoration: BoxDecoration(
        color: MembershipTheme.purpleSoft,
        borderRadius: BorderRadius.circular(12),
        border: Border.all(color: MembershipTheme.purple.withValues(alpha: 0.3)),
      ),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Row(
            children: [
              const Icon(Icons.upgrade_rounded,
                  color: MembershipTheme.purple, size: 18),
              const SizedBox(width: 8),
              Expanded(
                child: Text('$customerName requested $planName',
                    style: AppTypography.bodyMedium
                        .copyWith(fontWeight: FontWeight.w600)),
              ),
            ],
          ),
          if (message != null && message!.isNotEmpty) ...[
            const SizedBox(height: 6),
            Text('"$message"',
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
