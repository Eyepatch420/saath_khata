import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:go_router/go_router.dart';
import '../../../../l10n/app_localizations.dart';
import '../../../../core/constants/app_colors.dart';
import '../../../../core/constants/app_typography.dart';
import '../../../../core/di/injection.dart';
import '../../../../core/router/app_router.dart';
import '../../domain/repositories/vendor_repository.dart';
import '../bloc/vendor_bloc.dart';
import '../bloc/vendor_event.dart';
import '../bloc/vendor_state.dart';
import '../widgets/stat_card.dart';
import '../../../../shared/widgets/app_toast.dart';
import '../../../../shared/widgets/search_bar_pill.dart';
import '../../../notifications/presentation/bloc/notification_bloc.dart';
import '../../../notifications/presentation/bloc/notification_state.dart';
import '../../../search/presentation/screens/vendor_search_screen.dart';
import '../../../memberships/presentation/widgets/membership_tier_badge.dart';

class VendorDashboard extends StatelessWidget {
  const VendorDashboard({super.key});

  @override
  Widget build(BuildContext context) => const VendorDashboardView();
}

class VendorDashboardView extends StatelessWidget {
  const VendorDashboardView({super.key});

  @override
  Widget build(BuildContext context) {
    final l10n = AppLocalizations.of(context)!;

    return Scaffold(
      appBar: AppBar(
        title: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Text(l10n.appTitle, style: AppTypography.h3),
            Text(l10n.vendorDashboard,
                style: AppTypography.bodySmall.copyWith(color: AppColors.primary)),
          ],
        ),
        actions: [
          BlocBuilder<NotificationBloc, NotificationState>(
            bloc: getIt<NotificationBloc>(),
            builder: (context, state) {
              final count =
                  state is NotificationLoaded ? state.unreadCount : 0;
              return Stack(
                alignment: Alignment.center,
                children: [
                  IconButton(
                    onPressed: () => context.push(AppRouter.notifications),
                    icon: const Icon(Icons.notifications_none_rounded),
                  ),
                  if (count > 0)
                    Positioned(
                      top: 8,
                      right: 8,
                      child: _NotifBadge(count: count),
                    ),
                ],
              );
            },
          ),
          const SizedBox(width: 8),
        ],
      ),
      body: SafeArea(child: BlocConsumer<VendorBloc, VendorState>(
        listenWhen: (prev, curr) {
          if (prev is VendorLoaded && curr is VendorLoaded) {
            return prev.remindAllStatus != curr.remindAllStatus &&
                curr.remindAllStatus != RemindAllStatus.loading;
          }
          return false;
        },
        listener: (context, state) {
          if (state is VendorLoaded) {
            if (state.remindAllStatus == RemindAllStatus.success) {
              final count = state.remindAllQueued;
              AppToast.show(
                context,
                count == 0
                    ? 'No customers with outstanding balance'
                    : 'Reminders sent to $count customer${count == 1 ? '' : 's'}',
                type: ToastType.success,
              );
            } else if (state.remindAllStatus == RemindAllStatus.failure) {
              AppToast.show(
                context,
                'Failed to send reminders. Please try again.',
                type: ToastType.error,
              );
            }
          }
        },
        builder: (context, state) {
          if (state is VendorLoading) {
            return const Center(child: CircularProgressIndicator());
          } else if (state is VendorLoaded) {
            return RefreshIndicator(
              onRefresh: () async {
                context.read<VendorBloc>().add(LoadVendorDashboard());
              },
              child: SingleChildScrollView(
                physics: const AlwaysScrollableScrollPhysics(),
                padding: EdgeInsets.fromLTRB(
                    20, 20, 20, MediaQuery.of(context).viewPadding.bottom + 96),
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    const SearchBarPill(viewAs: SearchViewAs.vendor),
                    const SizedBox(height: 24),
                    Text(l10n.collectionSummary, style: AppTypography.h3),
                    const SizedBox(height: 16),
                    Row(
                      children: [
                        Expanded(
                          child: StatCard(
                            title: l10n.outstanding,
                            value:
                                '₹${state.totalOutstanding.toStringAsFixed(0)}',
                            color: AppColors.error,
                            icon: Icons.account_balance_wallet_rounded,
                            onTap: () => context.push(AppRouter.outstandingList),
                          ),
                        ),
                        const SizedBox(width: 16),
                        Expanded(
                          child: StatCard(
                            title: l10n.collectedToday,
                            value:
                                '₹${state.todayCollection.toStringAsFixed(0)}',
                            color: AppColors.success,
                            icon: Icons.payments_rounded,
                            onTap: () => context.push(AppRouter.collectedToday),
                          ),
                        ),
                      ],
                    ),
                    const SizedBox(height: 24),
                    Text(l10n.quickActions, style: AppTypography.h3),
                    const SizedBox(height: 12),
                    Row(
                      children: [
                        Expanded(
                          child: _ActionCard(
                            icon: Icons.notifications_active_rounded,
                            label: l10n.remindAll,
                            subtitle: 'Notify customers with dues',
                            gradient: const LinearGradient(
                              colors: [Color(0xFF00C896), Color(0xFF00A878)],
                              begin: Alignment.topLeft,
                              end: Alignment.bottomRight,
                            ),
                            isLoading:
                                state.remindAllStatus == RemindAllStatus.loading,
                            onTap: () => context
                                .read<VendorBloc>()
                                .add(RemindAllRequested()),
                          ),
                        ),
                        const SizedBox(width: 12),
                        Expanded(
                          child: _ActionCard(
                            icon: Icons.person_add_rounded,
                            label: l10n.addNew,
                            subtitle: 'Link a new customer',
                            gradient: const LinearGradient(
                              colors: [Color(0xFF1A3A4A), Color(0xFF0F2027)],
                              begin: Alignment.topLeft,
                              end: Alignment.bottomRight,
                            ),
                            isLoading: false,
                            onTap: () => showVendorAddCustomerSheet(context),
                          ),
                        ),
                      ],
                    ),
                    const SizedBox(height: 32),
                    Row(
                      mainAxisAlignment: MainAxisAlignment.spaceBetween,
                      children: [
                        Text(l10n.recentCustomers, style: AppTypography.h3),
                        TextButton(
                          onPressed: () => context.push(AppRouter.allCustomers),
                          child: Text(l10n.viewAll),
                        ),
                      ],
                    ),
                    const SizedBox(height: 12),
                    ListView.separated(
                      shrinkWrap: true,
                      physics: const NeverScrollableScrollPhysics(),
                      itemCount: state.customers.length,
                      separatorBuilder: (context, index) =>
                          const SizedBox(height: 12),
                      itemBuilder: (context, index) {
                        final customer = state.customers[index];
                        return _CustomerTile(customer: customer);
                      },
                    ),
                  ],
                ),
              ),
            );
          } else if (state is VendorError) {
            return Center(child: Text(state.message));
          }
          return const SizedBox();
        },
      ),
      ),
      bottomNavigationBar: null,
    );
  }
}

// ─── Add Customer Bottom Sheet ────────────────────────────────────────────────

void showVendorAddCustomerSheet(BuildContext context) {
  final l10n = AppLocalizations.of(context)!;
  final emailCtrl = TextEditingController();
  final bloc = context.read<VendorBloc>();
  bool isLoading = false;

  showModalBottomSheet(
    context: context,
    useRootNavigator: true,
    isScrollControlled: true,
    shape: const RoundedRectangleBorder(
      borderRadius: BorderRadius.vertical(top: Radius.circular(24)),
    ),
    builder: (ctx) => StatefulBuilder(
      builder: (ctx, setSheetState) => Padding(
        padding: EdgeInsets.only(
          left: 24,
          right: 24,
          top: 24,
          bottom: MediaQuery.of(ctx).viewInsets.bottom + 24,
        ),
        child: Column(
          mainAxisSize: MainAxisSize.min,
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Text(l10n.addNewCustomer, style: AppTypography.h3),
            const SizedBox(height: 20),
            TextField(
              controller: emailCtrl,
              keyboardType: TextInputType.text,
              decoration: const InputDecoration(
                labelText: 'Customer email or phone',
                hintText: 'email address or 10-digit mobile',
                prefixIcon: Icon(Icons.person_search_outlined),
              ),
            ),
            const SizedBox(height: 24),
            SizedBox(
              width: double.infinity,
              child: ElevatedButton(
                onPressed: isLoading
                    ? null
                    : () async {
                        final email = emailCtrl.text.trim();
                        if (email.isEmpty) return;
                        setSheetState(() => isLoading = true);
                        try {
                          await getIt<VendorRepository>().linkCustomer(email);
                          if (context.mounted) {
                            Navigator.pop(ctx);
                            bloc.add(LoadVendorDashboard());
                            AppToast.show(context, 'Customer added successfully', type: ToastType.success);
                          }
                        } catch (e) {
                          setSheetState(() => isLoading = false);
                          if (context.mounted) {
                            AppToast.show(context, e.toString().replaceFirst('Exception: ', ''), type: ToastType.error);
                          }
                        }
                      },
                style: ElevatedButton.styleFrom(
                  backgroundColor: AppColors.primary,
                  padding: const EdgeInsets.symmetric(vertical: 14),
                ),
                child: isLoading
                    ? const SizedBox(
                        width: 20,
                        height: 20,
                        child: CircularProgressIndicator(
                            strokeWidth: 2, color: Colors.white),
                      )
                    : Text(l10n.addCustomer,
                        style: const TextStyle(color: Colors.white)),
              ),
            ),
          ],
        ),
      ),
    ),
  );
}

// ─── Action Card ──────────────────────────────────────────────────────────────

class _ActionCard extends StatelessWidget {
  final IconData icon;
  final String label;
  final String subtitle;
  final Gradient gradient;
  final bool isLoading;
  final VoidCallback onTap;

  const _ActionCard({
    required this.icon,
    required this.label,
    required this.subtitle,
    required this.gradient,
    required this.isLoading,
    required this.onTap,
  });

  @override
  Widget build(BuildContext context) {
    return Material(
      color: Colors.transparent,
      borderRadius: BorderRadius.circular(20),
      child: InkWell(
        onTap: isLoading ? null : onTap,
        borderRadius: BorderRadius.circular(20),
        child: Ink(
          decoration: BoxDecoration(
            gradient: gradient,
            borderRadius: BorderRadius.circular(20),
            boxShadow: [
              BoxShadow(
                color: Colors.black.withValues(alpha: 0.15),
                blurRadius: 12,
                offset: const Offset(0, 4),
              ),
            ],
          ),
          padding: const EdgeInsets.symmetric(horizontal: 16, vertical: 20),
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              Row(
                mainAxisAlignment: MainAxisAlignment.spaceBetween,
                children: [
                  Container(
                    padding: const EdgeInsets.all(10),
                    decoration: BoxDecoration(
                      color: Colors.white.withValues(alpha: 0.15),
                      borderRadius: BorderRadius.circular(12),
                    ),
                    child: isLoading
                        ? const SizedBox(
                            width: 22,
                            height: 22,
                            child: CircularProgressIndicator(
                              strokeWidth: 2,
                              color: Colors.white,
                            ),
                          )
                        : Icon(icon, color: Colors.white, size: 22),
                  ),
                  Icon(
                    Icons.arrow_forward_rounded,
                    color: Colors.white.withValues(alpha: 0.6),
                    size: 18,
                  ),
                ],
              ),
              const SizedBox(height: 16),
              Text(
                label,
                style: AppTypography.labelLarge.copyWith(
                  color: Colors.white,
                  fontWeight: FontWeight.w700,
                ),
              ),
              const SizedBox(height: 4),
              Text(
                subtitle,
                style: AppTypography.bodySmall.copyWith(
                  color: Colors.white.withValues(alpha: 0.75),
                  fontSize: 11,
                ),
              ),
            ],
          ),
        ),
      ),
    );
  }
}

// ─── Customer Tile ────────────────────────────────────────────────────────────

class _CustomerTile extends StatelessWidget {
  final dynamic customer;

  const _CustomerTile({required this.customer});

  @override
  Widget build(BuildContext context) {
    final info = customer.customer;
    final surface = Theme.of(context).colorScheme.surface;
    return InkWell(
      onTap: () => context.push(
        AppRouter.sharedLedger,
        extra: {
          'linkId': customer.linkId,
          'name': info.name,
          'isVendorView': true
        },
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
              child: Text(
                info.name[0],
                style: const TextStyle(
                    color: AppColors.primary, fontWeight: FontWeight.bold),
              ),
            ),
            const SizedBox(width: 16),
            Expanded(
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  Row(
                    children: [
                      Flexible(
                        child: Text(info.name,
                            style: AppTypography.labelLarge,
                            overflow: TextOverflow.ellipsis),
                      ),
                      if (customer.tierName != null) ...[
                        const SizedBox(width: 8),
                        MembershipTierBadge(
                          tierName: customer.tierName,
                          tierLevel: customer.tierLevel,
                        ),
                      ],
                    ],
                  ),
                  if (info.mobile != null)
                    Text(info.mobile!, style: AppTypography.bodySmall),
                ],
              ),
            ),
            Column(
              crossAxisAlignment: CrossAxisAlignment.end,
              children: [
                Text('₹${customer.balance.toStringAsFixed(0)}',
                    style: AppTypography.labelLarge
                        .copyWith(color: AppColors.error)),
                const Icon(Icons.chevron_right_rounded,
                    color: AppColors.textHint, size: 16),
              ],
            ),
          ],
        ),
      ),
    );
  }
}

// ─── Notification Badge ───────────────────────────────────────────────────────

class _NotifBadge extends StatelessWidget {
  final int count;
  const _NotifBadge({required this.count});

  @override
  Widget build(BuildContext context) {
    return Container(
      constraints: const BoxConstraints(minWidth: 16, minHeight: 16),
      padding: const EdgeInsets.symmetric(horizontal: 4),
      decoration: const BoxDecoration(
        color: AppColors.error,
        shape: BoxShape.circle,
      ),
      child: Text(
        count > 99 ? '99+' : '$count',
        style: const TextStyle(
          color: Colors.white,
          fontSize: 9,
          fontWeight: FontWeight.bold,
          height: 1.6,
        ),
        textAlign: TextAlign.center,
      ),
    );
  }
}
