import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import '../../../../core/constants/app_colors.dart';
import '../../../../core/constants/app_typography.dart';
import '../../../../core/di/injection.dart';
import '../../../../shared/widgets/app_toast.dart';
import '../../../../shared/widgets/error_state_widget.dart';
import '../../domain/models/membership_tier.dart';
import '../bloc/membership_tiers_cubit.dart';
import 'membership_tiers_screen/widgets/discount_editor_sheet.dart';
import 'membership_tiers_screen/widgets/tier_edit_card.dart';

/// Vendor screen: manage the three membership tiers — rename them and set the
/// discount each member receives. Opened from vendor settings.
class MembershipTiersScreen extends StatelessWidget {
  const MembershipTiersScreen({super.key});

  @override
  Widget build(BuildContext context) {
    return BlocProvider(
      create: (_) => MembershipTiersCubit(getIt())..load(),
      child: const _MembershipTiersView(),
    );
  }
}

class _MembershipTiersView extends StatelessWidget {
  const _MembershipTiersView();

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(title: const Text('Membership Tiers')),
      body: SafeArea(
        child: BlocConsumer<MembershipTiersCubit, MembershipTiersState>(
          listenWhen: (prev, curr) => curr is MembershipTiersError,
          listener: (context, state) {
            if (state is MembershipTiersError) {
              AppToast.show(context, state.message, type: ToastType.error);
            }
          },
          builder: (context, state) {
            if (state is MembershipTiersLoading) {
              return const Center(child: CircularProgressIndicator());
            }
            if (state is MembershipTiersError) {
              return ErrorStateWidget(
                message: state.message,
                onRetry: () => context.read<MembershipTiersCubit>().load(),
              );
            }
            if (state is MembershipTiersLoaded) {
              return _TierList(state: state);
            }
            return const SizedBox();
          },
        ),
      ),
    );
  }
}

class _TierList extends StatelessWidget {
  final MembershipTiersLoaded state;
  const _TierList({required this.state});

  @override
  Widget build(BuildContext context) {
    final cubit = context.read<MembershipTiersCubit>();
    return Stack(
      children: [
        ListView(
          padding: const EdgeInsets.all(16),
          children: [
            Container(
              padding: const EdgeInsets.all(14),
              decoration: BoxDecoration(
                color: AppColors.primary.withValues(alpha: 0.06),
                borderRadius: BorderRadius.circular(12),
                border:
                    Border.all(color: AppColors.primary.withValues(alpha: 0.2)),
              ),
              child: Row(
                children: [
                  Icon(Icons.info_outline_rounded,
                      size: 18, color: AppColors.primary.withValues(alpha: 0.8)),
                  const SizedBox(width: 10),
                  Expanded(
                    child: Text(
                      'Rename your tiers and set the discount each member gets '
                      'on their dues. Assign tiers to customers from their ledger.',
                      style: AppTypography.bodySmall.copyWith(
                        color: AppColors.textSecondary,
                        height: 1.4,
                      ),
                    ),
                  ),
                ],
              ),
            ),
            const SizedBox(height: 16),
            ...state.tiers.map((tier) => Padding(
                  padding: const EdgeInsets.only(bottom: 12),
                  child: TierEditCard(
                    tier: tier,
                    onRename: () => _renameTier(context, cubit, tier),
                    onEditDiscount: () => _editDiscount(context, cubit, tier),
                  ),
                )),
          ],
        ),
        if (state.saving)
          const Positioned.fill(
            child: ColoredBox(
              color: Color(0x22000000),
              child: Center(child: CircularProgressIndicator()),
            ),
          ),
      ],
    );
  }

  Future<void> _renameTier(
    BuildContext context,
    MembershipTiersCubit cubit,
    MembershipTier tier,
  ) async {
    final ctrl = TextEditingController(text: tier.name);
    final newName = await showDialog<String>(
      context: context,
      builder: (ctx) => AlertDialog(
        title: const Text('Rename tier'),
        content: TextField(
          controller: ctrl,
          autofocus: true,
          maxLength: 50,
          decoration: const InputDecoration(labelText: 'Tier name'),
        ),
        actions: [
          TextButton(
            onPressed: () => Navigator.pop(ctx),
            child: const Text('Cancel'),
          ),
          ElevatedButton(
            onPressed: () => Navigator.pop(ctx, ctrl.text.trim()),
            child: const Text('Save'),
          ),
        ],
      ),
    );
    if (newName != null && newName.isNotEmpty && newName != tier.name) {
      cubit.updateTier(tier.id, name: newName);
    }
  }

  Future<void> _editDiscount(
    BuildContext context,
    MembershipTiersCubit cubit,
    MembershipTier tier,
  ) async {
    final result = await DiscountEditorSheet.show(context, tier);
    if (result == null) return;
    cubit.updateTier(
      tier.id,
      discountType: result.type,
      discountValue: result.type == DiscountType.none ? 0 : result.value,
      discountCap: result.cap,
      // When percentage has no cap (or type isn't percentage), clear any old cap.
      clearCap: result.cap == null,
    );
  }
}
