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

class VendorDashboard extends StatelessWidget {
  const VendorDashboard({super.key});

  @override
  Widget build(BuildContext context) {
    return BlocProvider(
      create: (context) => VendorBloc(getIt())..add(LoadVendorDashboard()),
      child: const VendorDashboardView(),
    );
  }
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
            Text(l10n.vendorDashboard, style: AppTypography.bodySmall.copyWith(color: AppColors.primary)),
          ],
        ),
        actions: [
          IconButton(
            onPressed: () => context.push(AppRouter.notifications),
            icon: const Icon(Icons.notifications_none_rounded),
          ),
          const SizedBox(width: 8),
        ],
      ),
      body: BlocBuilder<VendorBloc, VendorState>(
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
                padding: const EdgeInsets.all(20),
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    Text(l10n.collectionSummary, style: AppTypography.h3),
                    const SizedBox(height: 16),
                    Row(
                      children: [
                        Expanded(
                          child: StatCard(
                            title: l10n.outstanding,
                            value: '₹${state.totalOutstanding.toStringAsFixed(0)}',
                            color: AppColors.error,
                            icon: Icons.account_balance_wallet_rounded,
                          ),
                        ),
                        const SizedBox(width: 16),
                        Expanded(
                          child: StatCard(
                            title: l10n.collectedToday,
                            value: '₹${state.todayCollection.toStringAsFixed(0)}',
                            color: AppColors.success,
                            icon: Icons.payments_rounded,
                          ),
                        ),
                      ],
                    ),
                    const SizedBox(height: 24),
                    Text(l10n.quickActions, style: AppTypography.h3),
                    const SizedBox(height: 12),
                    Row(
                      mainAxisAlignment: MainAxisAlignment.spaceBetween,
                      children: [
                        _QuickAction(
                          icon: Icons.camera_alt_rounded,
                          label: l10n.scanBill,
                          onTap: () => context.push(AppRouter.scanBill),
                        ),
                        _QuickAction(
                          icon: Icons.notifications_active_rounded,
                          label: l10n.remindAll,
                          onTap: () {},
                        ),
                        _QuickAction(
                          icon: Icons.person_add_rounded,
                          label: l10n.addNew,
                          onTap: () => _showAddCustomerSheet(context),
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
                      separatorBuilder: (context, index) => const SizedBox(height: 12),
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
      bottomNavigationBar: null,
      floatingActionButton: FloatingActionButton.extended(
        onPressed: () => _showAddCustomerSheet(context),
        backgroundColor: AppColors.primary,
        icon: const Icon(Icons.add, color: Colors.white),
        label: Text(l10n.addNew.toUpperCase(), style: const TextStyle(color: Colors.white, fontWeight: FontWeight.bold)),
      ),
    );
  }

  void _showAddCustomerSheet(BuildContext context) {
    final l10n = AppLocalizations.of(context)!;
    final emailCtrl = TextEditingController();
    final bloc = context.read<VendorBloc>();
    bool isLoading = false;

    showModalBottomSheet(
      context: context,
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
                keyboardType: TextInputType.emailAddress,
                decoration: const InputDecoration(
                  labelText: 'Customer Email',
                  prefixIcon: Icon(Icons.email_outlined),
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
                              ScaffoldMessenger.of(context).showSnackBar(
                                const SnackBar(content: Text('Customer added successfully')),
                              );
                            }
                          } catch (e) {
                            setSheetState(() => isLoading = false);
                            if (context.mounted) {
                              ScaffoldMessenger.of(context).showSnackBar(
                                SnackBar(
                                  content: Text(e.toString().replaceFirst('Exception: ', '')),
                                ),
                              );
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
                          child: CircularProgressIndicator(strokeWidth: 2, color: Colors.white),
                        )
                      : Text(l10n.addCustomer, style: const TextStyle(color: Colors.white)),
                ),
              ),
            ],
          ),
        ),
      ),
    );
  }
}


class _QuickAction extends StatelessWidget {
  final IconData icon;
  final String label;
  final VoidCallback onTap;

  const _QuickAction({
    required this.icon,
    required this.label,
    required this.onTap,
  });

  @override
  Widget build(BuildContext context) {
    return InkWell(
      onTap: onTap,
      child: Column(
        children: [
          Container(
            padding: const EdgeInsets.all(12),
            decoration: BoxDecoration(
              color: Theme.of(context).colorScheme.surface,
              shape: BoxShape.circle,
              boxShadow: [
                BoxShadow(color: Colors.black.withValues(alpha: 0.05), blurRadius: 4, offset: const Offset(0, 2)),
              ],
            ),
            child: Icon(icon, color: AppColors.primary),
          ),
          const SizedBox(height: 8),
          Text(label, style: AppTypography.bodySmall.copyWith(fontSize: 10)),
        ],
      ),
    );
  }
}

class _CustomerTile extends StatelessWidget {
  final dynamic customer;

  const _CustomerTile({required this.customer});

  @override
  Widget build(BuildContext context) {
    final info = customer.customer; // CustomerLinkItem.customer → UserSummary
    final surface = Theme.of(context).colorScheme.surface;
    return InkWell(
      onTap: () => context.push(
        AppRouter.sharedLedger,
        extra: {'linkId': customer.linkId, 'name': info.name},
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
                style: const TextStyle(color: AppColors.primary, fontWeight: FontWeight.bold),
              ),
            ),
            const SizedBox(width: 16),
            Expanded(
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  Text(info.name, style: AppTypography.labelLarge),
                  if (info.mobile != null)
                    Text(info.mobile!, style: AppTypography.bodySmall),
                ],
              ),
            ),
            Column(
              crossAxisAlignment: CrossAxisAlignment.end,
              children: [
                Text('₹${customer.balance.toStringAsFixed(0)}',
                    style: AppTypography.labelLarge.copyWith(color: AppColors.error)),
                const Icon(Icons.chevron_right_rounded, color: AppColors.textHint, size: 16),
              ],
            ),
          ],
        ),
      ),
    );
  }
}
