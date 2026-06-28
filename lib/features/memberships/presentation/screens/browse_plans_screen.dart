import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import '../../../../core/constants/app_colors.dart';
import '../../../../shared/widgets/app_toast.dart';
import '../../domain/models/membership_plan.dart';
import '../bloc/membership_cubit.dart';
import '../bloc/membership_state.dart';
import '../membership_theme.dart';

/// Customer: browse a vendor's active plans and apply for one.
/// Expects a MembershipCubit (for [linkId]) provided above it.
class BrowsePlansScreen extends StatelessWidget {
  final String vendorName;
  const BrowsePlansScreen({super.key, required this.vendorName});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: AppColors.background,
      appBar: AppBar(
        title: Text('$vendorName · Plans', overflow: TextOverflow.ellipsis),
        backgroundColor: MembershipTheme.purple,
        foregroundColor: Colors.white,
      ),
      body: BlocConsumer<MembershipCubit, MembershipState>(
        listenWhen: (_, c) => c is MembershipError,
        listener: (context, state) {
          if (state is MembershipError) {
            AppToast.show(context, state.message, type: ToastType.error);
          }
        },
        builder: (context, state) {
          if (state is! MembershipLoaded) {
            return const Center(child: CircularProgressIndicator());
          }
          final status = state.status;
          final plans = status.plans;
          final currentPlanId = status.current?.plan.id;
          final pendingPlanId = status.pendingRequest?.requestedPlan?.id;

          if (plans.isEmpty) {
            return const Center(
              child: Text('This vendor has no membership plans yet.',
                  style: TextStyle(color: AppColors.textSecondary)),
            );
          }

          return ListView.separated(
            padding: const EdgeInsets.all(16),
            itemCount: plans.length,
            separatorBuilder: (_, i) => const SizedBox(height: 14),
            itemBuilder: (ctx, i) {
              final p = plans[i];
              return _PlanCard(
                plan: p,
                isCurrent: p.id == currentPlanId,
                isPending: p.id == pendingPlanId,
                busy: state.actionInProgress,
                onApply: () => _confirmApply(context, p),
              );
            },
          );
        },
      ),
    );
  }

  Future<void> _confirmApply(BuildContext context, MembershipPlan plan) async {
    final cubit = context.read<MembershipCubit>();
    final msgCtrl = TextEditingController();
    final ok = await showModalBottomSheet<bool>(
      context: context,
      isScrollControlled: true,
      useRootNavigator: true,
      shape: const RoundedRectangleBorder(
        borderRadius: BorderRadius.vertical(top: Radius.circular(24)),
      ),
      builder: (sheetCtx) => Padding(
        padding: EdgeInsets.only(
          left: 20,
          right: 20,
          top: 20,
          bottom: MediaQuery.of(sheetCtx).viewInsets.bottom + 24,
        ),
        child: Column(
          mainAxisSize: MainAxisSize.min,
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Text('Apply for ${plan.name}',
                style: const TextStyle(
                    fontSize: 18, fontWeight: FontWeight.bold)),
            const SizedBox(height: 4),
            Text(
              '₹${plan.price.toStringAsFixed(0)} / ${plan.durationDays} days'
              '${plan.advanceRequired > 0 ? ' · advance ₹${plan.advanceRequired.toStringAsFixed(0)}' : ''}',
              style: const TextStyle(color: AppColors.textSecondary),
            ),
            const SizedBox(height: 16),
            TextField(
              controller: msgCtrl,
              decoration: const InputDecoration(
                labelText: 'Message to vendor (optional)',
                border: OutlineInputBorder(),
              ),
              maxLines: 2,
            ),
            const SizedBox(height: 16),
            FilledButton(
              onPressed: () => Navigator.pop(sheetCtx, true),
              style: FilledButton.styleFrom(
                backgroundColor: MembershipTheme.purple,
                minimumSize: const Size.fromHeight(50),
              ),
              child: const Text('Send Request'),
            ),
          ],
        ),
      ),
    );

    if (ok != true) return;
    await cubit.requestPlan(plan.id, message: msgCtrl.text.trim());
    if (!context.mounted) return;
    final s = cubit.state;
    if (s is MembershipLoaded && s.status.pendingRequest != null) {
      AppToast.show(context, 'Request sent to vendor');
      Navigator.pop(context);
    }
  }
}

class _PlanCard extends StatelessWidget {
  final MembershipPlan plan;
  final bool isCurrent;
  final bool isPending;
  final bool busy;
  final VoidCallback onApply;

  const _PlanCard({
    required this.plan,
    required this.isCurrent,
    required this.isPending,
    required this.busy,
    required this.onApply,
  });

  @override
  Widget build(BuildContext context) {
    return Container(
      decoration: BoxDecoration(
        color: AppColors.surface,
        borderRadius: BorderRadius.circular(18),
        border: Border.all(
          color: isCurrent ? MembershipTheme.purple : AppColors.divider,
          width: isCurrent ? 1.5 : 1,
        ),
      ),
      clipBehavior: Clip.antiAlias,
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Container(
            width: double.infinity,
            padding: const EdgeInsets.all(18),
            decoration: const BoxDecoration(gradient: MembershipTheme.headerGradient),
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Text(plan.name,
                    style: const TextStyle(
                        color: Colors.white,
                        fontSize: 18,
                        fontWeight: FontWeight.bold)),
                const SizedBox(height: 4),
                Row(
                  crossAxisAlignment: CrossAxisAlignment.baseline,
                  textBaseline: TextBaseline.alphabetic,
                  children: [
                    Text('₹${plan.price.toStringAsFixed(0)}',
                        style: const TextStyle(
                            color: Colors.white,
                            fontSize: 24,
                            fontWeight: FontWeight.bold)),
                    Text(' / ${plan.durationDays} days',
                        style: const TextStyle(color: Colors.white70)),
                  ],
                ),
              ],
            ),
          ),
          Padding(
            padding: const EdgeInsets.all(16),
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                ...plan.benefits.map((b) => Padding(
                      padding: const EdgeInsets.only(bottom: 8),
                      child: Row(
                        children: [
                          const Icon(Icons.check_circle,
                              size: 18, color: AppColors.success),
                          const SizedBox(width: 8),
                          Expanded(child: Text(b.label)),
                          if (b.hasQuota)
                            Text('×${b.quota}',
                                style: const TextStyle(
                                    color: AppColors.textSecondary,
                                    fontWeight: FontWeight.w600)),
                        ],
                      ),
                    )),
                if (plan.advanceRequired > 0)
                  Padding(
                    padding: const EdgeInsets.only(top: 4),
                    child: Text(
                        'Advance required: ₹${plan.advanceRequired.toStringAsFixed(0)}',
                        style: const TextStyle(
                            color: AppColors.textSecondary, fontSize: 13)),
                  ),
                const SizedBox(height: 14),
                SizedBox(
                  width: double.infinity,
                  child: _actionButton(),
                ),
              ],
            ),
          ),
        ],
      ),
    );
  }

  Widget _actionButton() {
    if (isCurrent) {
      return OutlinedButton.icon(
        onPressed: null,
        icon: const Icon(Icons.check_circle, size: 18),
        label: const Text('Current Plan'),
        style: OutlinedButton.styleFrom(foregroundColor: MembershipTheme.purple),
      );
    }
    if (isPending) {
      return OutlinedButton.icon(
        onPressed: null,
        icon: const Icon(Icons.hourglass_top_rounded, size: 18),
        label: const Text('Request Pending'),
        style: OutlinedButton.styleFrom(foregroundColor: AppColors.warning),
      );
    }
    return FilledButton(
      onPressed: busy ? null : onApply,
      style: FilledButton.styleFrom(backgroundColor: MembershipTheme.purple),
      child: const Text('Apply'),
    );
  }
}
