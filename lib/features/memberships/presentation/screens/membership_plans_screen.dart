import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import '../../../../core/constants/app_colors.dart';
import '../../../../core/di/injection.dart';
import '../../../../shared/widgets/app_toast.dart';
import '../../../../shared/widgets/error_state_widget.dart';
import '../../domain/models/membership_plan.dart';
import '../bloc/plans_cubit.dart';
import '../membership_theme.dart';
import 'create_plan_screen.dart';

/// Vendor: list + manage membership plans. Entry point to create/edit plans.
class MembershipPlansScreen extends StatelessWidget {
  const MembershipPlansScreen({super.key});

  @override
  Widget build(BuildContext context) {
    return BlocProvider(
      create: (_) => PlansCubit(getIt())..load(),
      child: const _PlansView(),
    );
  }
}

class _PlansView extends StatelessWidget {
  const _PlansView();

  void _openEditor(BuildContext context, {MembershipPlan? plan}) {
    Navigator.of(context).push(
      MaterialPageRoute(
        builder: (_) => BlocProvider.value(
          value: context.read<PlansCubit>(),
          child: CreatePlanScreen(existing: plan),
        ),
      ),
    );
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: AppColors.background,
      appBar: AppBar(
        title: const Text('Membership Plans'),
        backgroundColor: MembershipTheme.purple,
        foregroundColor: Colors.white,
      ),
      floatingActionButton: FloatingActionButton.extended(
        onPressed: () => _openEditor(context),
        backgroundColor: MembershipTheme.purple,
        icon: const Icon(Icons.add),
        label: const Text('New Plan'),
      ),
      body: BlocBuilder<PlansCubit, PlansState>(
        builder: (context, state) {
          if (state is PlansLoading) {
            return const Center(child: CircularProgressIndicator());
          }
          if (state is PlansError) {
            return ErrorStateWidget(
              message: state.message,
              onRetry: () => context.read<PlansCubit>().load(),
            );
          }
          if (state is PlansLoaded) {
            if (state.plans.isEmpty) return const _EmptyPlans();
            return ListView.separated(
              padding: const EdgeInsets.fromLTRB(16, 16, 16, 96),
              itemCount: state.plans.length,
              separatorBuilder: (_, i) => const SizedBox(height: 12),
              itemBuilder: (ctx, i) => _PlanCard(
                plan: state.plans[i],
                onEdit: () => _openEditor(context, plan: state.plans[i]),
                onToggle: () => context.read<PlansCubit>().updatePlan(
                      state.plans[i].id,
                      isActive: !state.plans[i].isActive,
                    ),
                onDelete: () => _confirmDelete(context, state.plans[i]),
              ),
            );
          }
          return const SizedBox();
        },
      ),
    );
  }

  Future<void> _confirmDelete(BuildContext context, MembershipPlan plan) async {
    final cubit = context.read<PlansCubit>();
    final ok = await showDialog<bool>(
      context: context,
      builder: (ctx) => AlertDialog(
        title: const Text('Delete plan?'),
        content: Text('"${plan.name}" will be removed. This cannot be undone.'),
        actions: [
          TextButton(
              onPressed: () => Navigator.pop(ctx, false),
              child: const Text('Cancel')),
          FilledButton(
            onPressed: () => Navigator.pop(ctx, true),
            style: FilledButton.styleFrom(backgroundColor: AppColors.error),
            child: const Text('Delete'),
          ),
        ],
      ),
    );
    if (ok != true) return;
    final success = await cubit.deletePlan(plan.id);
    if (!context.mounted) return;
    if (!success) {
      final s = cubit.state;
      if (s is PlansError) AppToast.show(context, s.message, type: ToastType.error);
    }
  }
}

class _PlanCard extends StatelessWidget {
  final MembershipPlan plan;
  final VoidCallback onEdit;
  final VoidCallback onToggle;
  final VoidCallback onDelete;

  const _PlanCard({
    required this.plan,
    required this.onEdit,
    required this.onToggle,
    required this.onDelete,
  });

  @override
  Widget build(BuildContext context) {
    return Container(
      decoration: BoxDecoration(
        color: AppColors.surface,
        borderRadius: BorderRadius.circular(16),
        border: Border.all(color: AppColors.divider),
      ),
      clipBehavior: Clip.antiAlias,
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Container(
            padding: const EdgeInsets.all(16),
            decoration: const BoxDecoration(gradient: MembershipTheme.headerGradient),
            child: Row(
              children: [
                Expanded(
                  child: Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      Text(plan.name,
                          style: const TextStyle(
                              color: Colors.white,
                              fontWeight: FontWeight.bold,
                              fontSize: 17)),
                      const SizedBox(height: 2),
                      Text(
                        '₹${plan.price.toStringAsFixed(0)} / ${plan.durationDays} days',
                        style: const TextStyle(color: Colors.white70, fontSize: 13),
                      ),
                    ],
                  ),
                ),
                if (!plan.isActive)
                  Container(
                    padding:
                        const EdgeInsets.symmetric(horizontal: 8, vertical: 3),
                    decoration: BoxDecoration(
                      color: Colors.black.withValues(alpha: 0.25),
                      borderRadius: BorderRadius.circular(10),
                    ),
                    child: const Text('Inactive',
                        style: TextStyle(color: Colors.white, fontSize: 11)),
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
                      padding: const EdgeInsets.only(bottom: 6),
                      child: Row(
                        children: [
                          const Icon(Icons.check_circle,
                              size: 16, color: AppColors.success),
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
                if (plan.advanceRequired > 0) ...[
                  const SizedBox(height: 4),
                  Text('Advance: ₹${plan.advanceRequired.toStringAsFixed(0)}',
                      style: const TextStyle(
                          color: AppColors.textSecondary, fontSize: 13)),
                ],
                const Divider(height: 24),
                Row(
                  children: [
                    Icon(Icons.people_alt_rounded,
                        size: 16, color: MembershipTheme.purple),
                    const SizedBox(width: 6),
                    Text('${plan.activeMembers} active',
                        style: const TextStyle(
                            fontWeight: FontWeight.w600,
                            color: MembershipTheme.purple)),
                    const Spacer(),
                    TextButton(
                      onPressed: onToggle,
                      child: Text(plan.isActive ? 'Deactivate' : 'Activate'),
                    ),
                    IconButton(
                      onPressed: onEdit,
                      icon: const Icon(Icons.edit_outlined, size: 20),
                      color: MembershipTheme.purple,
                    ),
                    IconButton(
                      onPressed: onDelete,
                      icon: const Icon(Icons.delete_outline, size: 20),
                      color: AppColors.error,
                    ),
                  ],
                ),
              ],
            ),
          ),
        ],
      ),
    );
  }
}

class _EmptyPlans extends StatelessWidget {
  const _EmptyPlans();
  @override
  Widget build(BuildContext context) {
    return Center(
      child: Column(
        mainAxisSize: MainAxisSize.min,
        children: [
          Icon(Icons.workspace_premium_rounded,
              size: 64, color: MembershipTheme.purple.withValues(alpha: 0.4)),
          const SizedBox(height: 12),
          const Text('No membership plans yet',
              style: TextStyle(fontSize: 16, color: AppColors.textSecondary)),
          const SizedBox(height: 6),
          const Text('Tap "New Plan" to create your first one.',
              style: TextStyle(fontSize: 13, color: AppColors.textHint)),
        ],
      ),
    );
  }
}
