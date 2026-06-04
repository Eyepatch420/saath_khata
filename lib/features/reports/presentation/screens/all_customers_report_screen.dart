import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import '../../../../core/di/injection.dart';
import '../../../../features/vendor/domain/repositories/vendor_repository.dart';
import '../../../../l10n/app_localizations.dart';
import '../../../../shared/widgets/empty_state_widget.dart';
import '../../../../shared/widgets/error_state_widget.dart';
import '../bloc/all_customers_report_cubit.dart';
import 'all_customers_report_screen/widgets/customer_report_tile.dart';
import 'all_customers_report_screen/widgets/summary_header.dart';

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
                  CustomersSummaryHeader(customers: state.customers),
                  Expanded(
                    child: RefreshIndicator(
                      onRefresh: () =>
                          context.read<AllCustomersReportCubit>().load(),
                      child: ListView.separated(
                        padding: EdgeInsets.fromLTRB(
                          16,
                          16,
                          16,
                          MediaQuery.of(context).viewPadding.bottom + 96,
                        ),
                        itemCount: state.customers.length,
                        separatorBuilder: (_, _) =>
                            const SizedBox(height: 12),
                        itemBuilder: (context, index) =>
                            CustomerReportTile(
                                customer: state.customers[index]),
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
