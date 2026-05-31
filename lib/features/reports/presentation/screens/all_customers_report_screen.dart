import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:go_router/go_router.dart';
import '../../../../core/constants/app_colors.dart';
import '../../../../core/constants/app_typography.dart';
import '../../../../core/di/injection.dart';
import '../../../../core/router/app_router.dart';
import '../../../../features/vendor/domain/repositories/vendor_repository.dart';
import '../../../../l10n/app_localizations.dart';
import '../../../../shared/models/report_models.dart';
import '../../../../shared/widgets/empty_state_widget.dart';
import '../../../../shared/widgets/error_state_widget.dart';
import '../bloc/all_customers_report_cubit.dart';

class AllCustomersReportScreen extends StatelessWidget {
  const AllCustomersReportScreen({super.key});

  @override
  Widget build(BuildContext context) {
    return BlocProvider(
      create: (_) =>
          AllCustomersReportCubit(getIt<VendorRepository>())..load(),
      child: const _AllCustomersView(),
    );
  }
}

class _AllCustomersView extends StatelessWidget {
  const _AllCustomersView();

  @override
  Widget build(BuildContext context) {
    final l10n = AppLocalizations.of(context)!;
    return Scaffold(
      appBar: AppBar(title: Text(l10n.allCustomersReport)),
      body: SafeArea(
        child: BlocBuilder<AllCustomersReportCubit, AllCustomersReportState>(
          builder: (context, state) {
            if (state is AllCustomersReportLoading) {
              return const Center(child: CircularProgressIndicator());
            }
            if (state is AllCustomersReportError) {
              return ErrorStateWidget(
                message: state.message,
                onRetry: () =>
                    context.read<AllCustomersReportCubit>().load(),
              );
            }
            if (state is AllCustomersReportLoaded) {
              if (state.customers.isEmpty) {
                return EmptyStateWidget(
                  icon: Icons.people_outline_rounded,
                  title: l10n.noCustomersYet,
                  subtitle: l10n.noCustomersYetSubtitle,
                );
              }
              return Column(
                children: [
                  _SummaryHeader(customers: state.customers),
                  Expanded(
                    child: RefreshIndicator(
                      onRefresh: () =>
                          context.read<AllCustomersReportCubit>().load(),
                      child: ListView.separated(
                        padding: EdgeInsets.fromLTRB(
                            16,
                            16,
                            16,
                            MediaQuery.of(context).viewPadding.bottom + 96),
                        itemCount: state.customers.length,
                        separatorBuilder: (_, __) =>
                            const SizedBox(height: 12),
                        itemBuilder: (context, index) => _CustomerReportTile(
                          customer: state.customers[index],
                        ),
                      ),
                    ),
                  ),
                ],
              );
            }
            return const SizedBox();
          },
        ),
      ),
    );
  }
}

// ─── Summary Header ───────────────────────────────────────────────────────────

class _SummaryHeader extends StatelessWidget {
  final List<CustomerReportItem> customers;
  const _SummaryHeader({required this.customers});

  @override
  Widget build(BuildContext context) {
    final totalOutstanding =
        customers.fold(0.0, (s, c) => s + (c.balance > 0 ? c.balance : 0));
    final totalCollected =
        customers.fold(0.0, (s, c) => s + c.collectedThisMonth);

    return Container(
      padding: const EdgeInsets.symmetric(horizontal: 20, vertical: 14),
      color: Theme.of(context).colorScheme.surface,
      child: Row(
        children: [
          Expanded(
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Text('${customers.length} customers',
                    style: AppTypography.labelLarge),
                Text('Ranked by outstanding balance',
                    style: AppTypography.bodySmall
                        .copyWith(color: AppColors.textHint)),
              ],
            ),
          ),
          Column(
            crossAxisAlignment: CrossAxisAlignment.end,
            children: [
              Text('₹${totalOutstanding.toStringAsFixed(0)}',
                  style: AppTypography.labelLarge
                      .copyWith(color: AppColors.error)),
              Text('₹${totalCollected.toStringAsFixed(0)} this month',
                  style: AppTypography.bodySmall
                      .copyWith(color: AppColors.success)),
            ],
          ),
        ],
      ),
    );
  }
}

// ─── Customer Report Tile ─────────────────────────────────────────────────────

class _CustomerReportTile extends StatelessWidget {
  final CustomerReportItem customer;
  const _CustomerReportTile({required this.customer});

  @override
  Widget build(BuildContext context) {
    return InkWell(
      onTap: () => context.push(
        AppRouter.customerDetailReport,
        extra: {'linkId': customer.linkId, 'name': customer.customerName},
      ),
      borderRadius: BorderRadius.circular(16),
      child: Container(
        padding: const EdgeInsets.all(16),
        decoration: BoxDecoration(
          color: Theme.of(context).colorScheme.surface,
          borderRadius: BorderRadius.circular(16),
        ),
        child: Row(
          children: [
            CircleAvatar(
              backgroundColor: AppColors.primary.withValues(alpha: 0.1),
              child: Text(
                customer.customerName[0].toUpperCase(),
                style: const TextStyle(
                    color: AppColors.primary, fontWeight: FontWeight.bold),
              ),
            ),
            const SizedBox(width: 16),
            Expanded(
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  Text(customer.customerName, style: AppTypography.labelLarge),
                  if (customer.customerPhone != null)
                    Text(customer.customerPhone!,
                        style: AppTypography.bodySmall),
                ],
              ),
            ),
            Column(
              crossAxisAlignment: CrossAxisAlignment.end,
              children: [
                Text(
                  '₹${customer.balance.toStringAsFixed(0)}',
                  style: AppTypography.labelLarge.copyWith(
                      color: customer.balance > 0
                          ? AppColors.error
                          : AppColors.success),
                ),
                if (customer.collectedThisMonth > 0)
                  Text(
                    '₹${customer.collectedThisMonth.toStringAsFixed(0)} this mo.',
                    style: AppTypography.bodySmall
                        .copyWith(color: AppColors.success),
                  ),
              ],
            ),
            const SizedBox(width: 4),
            const Icon(Icons.chevron_right_rounded,
                color: AppColors.textHint, size: 20),
          ],
        ),
      ),
    );
  }
}
