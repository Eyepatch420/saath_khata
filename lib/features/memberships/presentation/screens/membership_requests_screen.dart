import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import '../../../../core/constants/app_colors.dart';
import '../../../../core/constants/app_typography.dart';
import '../../../../core/di/injection.dart';
import '../../../../shared/widgets/app_toast.dart';
import '../../../../shared/widgets/error_state_widget.dart';
import '../../domain/models/membership_request.dart';
import '../../domain/models/membership_tier.dart';
import '../bloc/membership_requests_cubit.dart';
import '../widgets/membership_banner.dart';

class MembershipRequestsScreen extends StatelessWidget {
  const MembershipRequestsScreen({super.key});

  @override
  Widget build(BuildContext context) {
    return BlocProvider(
      create: (_) => MembershipRequestsCubit(getIt())..load(),
      child: const _MembershipRequestsView(),
    );
  }
}

class _MembershipRequestsView extends StatelessWidget {
  const _MembershipRequestsView();

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(title: const Text('Membership Requests')),
      body: SafeArea(
        child: BlocConsumer<MembershipRequestsCubit, MembershipRequestsState>(
          listenWhen: (_, curr) => curr is MembershipRequestsError,
          listener: (context, state) {
            if (state is MembershipRequestsError) {
              AppToast.show(context, state.message, type: ToastType.error);
            }
          },
          builder: (context, state) {
            if (state is MembershipRequestsLoading) {
              return const Center(child: CircularProgressIndicator());
            }
            if (state is MembershipRequestsError) {
              return ErrorStateWidget(
                message: state.message,
                onRetry: () =>
                    context.read<MembershipRequestsCubit>().load(),
              );
            }
            if (state is MembershipRequestsLoaded) {
              return _RequestList(state: state);
            }
            return const SizedBox();
          },
        ),
      ),
    );
  }
}

class _RequestList extends StatelessWidget {
  final MembershipRequestsLoaded state;
  const _RequestList({required this.state});

  @override
  Widget build(BuildContext context) {
    final cubit = context.read<MembershipRequestsCubit>();

    if (state.requests.isEmpty) {
      return Center(
        child: Column(
          mainAxisSize: MainAxisSize.min,
          children: [
            Icon(Icons.inbox_outlined,
                size: 64, color: AppColors.textHint.withValues(alpha: 0.5)),
            const SizedBox(height: 12),
            const Text('No pending requests',
                style: TextStyle(
                    color: AppColors.textSecondary, fontSize: 16)),
            const SizedBox(height: 6),
            const Text(
              'Customers can apply for membership\nfrom their ledger screen.',
              textAlign: TextAlign.center,
              style: TextStyle(color: AppColors.textHint, fontSize: 13),
            ),
          ],
        ),
      );
    }

    return RefreshIndicator(
      onRefresh: () => cubit.load(),
      child: ListView.separated(
        padding: const EdgeInsets.all(16),
        itemCount: state.requests.length,
        separatorBuilder: (_, i) => const SizedBox(height: 10),
        itemBuilder: (ctx, i) {
          final req = state.requests[i];
          final busy = state.busyIds.contains(req.id);
          return _RequestCard(
            request: req,
            busy: busy,
            onApprove: () => cubit.approve(req.id),
            onDecline: () => cubit.decline(req.id),
          );
        },
      ),
    );
  }
}

class _RequestCard extends StatelessWidget {
  final MembershipRequest request;
  final bool busy;
  final VoidCallback onApprove;
  final VoidCallback onDecline;

  const _RequestCard({
    required this.request,
    required this.busy,
    required this.onApprove,
    required this.onDecline,
  });

  @override
  Widget build(BuildContext context) {
    final tier = request.requestedTier;
    final tierColor = MembershipBanner.tierColor(tier.level);

    return Container(
      padding: const EdgeInsets.all(16),
      decoration: BoxDecoration(
        color: Theme.of(context).colorScheme.surface,
        borderRadius: BorderRadius.circular(14),
        border: Border.all(
          color: tierColor.withValues(alpha: 0.3),
        ),
      ),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Row(
            children: [
              CircleAvatar(
                radius: 20,
                backgroundColor: tierColor.withValues(alpha: 0.12),
                child: Text(
                  request.customer.name[0].toUpperCase(),
                  style: TextStyle(
                      color: tierColor, fontWeight: FontWeight.bold),
                ),
              ),
              const SizedBox(width: 12),
              Expanded(
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    Text(request.customer.name,
                        style: AppTypography.labelLarge),
                    const SizedBox(height: 2),
                    Text(_formatDate(request.createdAt),
                        style: const TextStyle(
                            color: AppColors.textHint, fontSize: 12)),
                  ],
                ),
              ),
              _TierBadge(tier: tier, color: tierColor),
            ],
          ),
          if (request.message != null && request.message!.isNotEmpty) ...[
            const SizedBox(height: 10),
            Container(
              padding: const EdgeInsets.all(10),
              decoration: BoxDecoration(
                color: AppColors.background,
                borderRadius: BorderRadius.circular(8),
              ),
              child: Row(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  const Icon(Icons.format_quote_rounded,
                      size: 16, color: AppColors.textHint),
                  const SizedBox(width: 6),
                  Expanded(
                    child: Text(
                      request.message!,
                      style: const TextStyle(
                          color: AppColors.textSecondary, fontSize: 13),
                    ),
                  ),
                ],
              ),
            ),
          ],
          const SizedBox(height: 14),
          if (busy)
            const Center(child: CircularProgressIndicator())
          else
            Row(
              children: [
                Expanded(
                  child: OutlinedButton(
                    onPressed: onDecline,
                    style: OutlinedButton.styleFrom(
                      foregroundColor: AppColors.error,
                      side: const BorderSide(color: AppColors.error),
                    ),
                    child: const Text('Decline'),
                  ),
                ),
                const SizedBox(width: 12),
                Expanded(
                  child: FilledButton(
                    onPressed: onApprove,
                    style: FilledButton.styleFrom(
                      backgroundColor: AppColors.success,
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

  String _formatDate(DateTime dt) {
    final now = DateTime.now();
    final diff = now.difference(dt);
    if (diff.inDays == 0) {
      if (diff.inHours == 0) return '${diff.inMinutes}m ago';
      return '${diff.inHours}h ago';
    }
    if (diff.inDays == 1) return 'Yesterday';
    return '${dt.day}/${dt.month}/${dt.year}';
  }
}

class _TierBadge extends StatelessWidget {
  final MembershipTier tier;
  final Color color;

  const _TierBadge({required this.tier, required this.color});

  @override
  Widget build(BuildContext context) {
    return Container(
      padding: const EdgeInsets.symmetric(horizontal: 10, vertical: 5),
      decoration: BoxDecoration(
        color: color.withValues(alpha: 0.12),
        borderRadius: BorderRadius.circular(20),
        border: Border.all(color: color.withValues(alpha: 0.35)),
      ),
      child: Row(
        mainAxisSize: MainAxisSize.min,
        children: [
          Icon(Icons.workspace_premium_rounded, size: 14, color: color),
          const SizedBox(width: 4),
          Text(
            tier.name,
            style: TextStyle(
                color: color,
                fontWeight: FontWeight.w600,
                fontSize: 12),
          ),
        ],
      ),
    );
  }
}
