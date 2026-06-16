import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import '../../../../../../l10n/app_localizations.dart';
import '../../../../../../shared/models/ledger_entry.dart';
import '../../../../../../shared/widgets/empty_state_widget.dart';
import '../../../../../../shared/widgets/error_state_widget.dart';
import '../../../bloc/ledger_bloc.dart';
import '../../../bloc/ledger_event.dart';
import '../../../bloc/ledger_state.dart';
import 'entry_card.dart';

/// Renders the ledger entries as **slivers**, so it can live directly inside the
/// shared-ledger [CustomScrollView] alongside the collapsing header and pinned
/// filter bar. Pull-to-refresh is handled by the parent scroll view.
class LedgerSliverList extends StatelessWidget {
  final String linkId;
  final String customerName;
  final String currentUserId;

  const LedgerSliverList({
    super.key,
    required this.linkId,
    required this.customerName,
    required this.currentUserId,
  });

  @override
  Widget build(BuildContext context) {
    final l10n = AppLocalizations.of(context)!;
    return BlocBuilder<LedgerBloc, LedgerState>(
      builder: (context, state) {
        if (state is LedgerLoading) {
          return const SliverFillRemaining(
            hasScrollBody: false,
            child: Center(child: CircularProgressIndicator()),
          );
        }

        if (state is LedgerError) {
          return SliverFillRemaining(
            hasScrollBody: false,
            child: ErrorStateWidget(
              message: state.message,
              onRetry: () =>
                  context.read<LedgerBloc>().add(LoadLedger(linkId)),
            ),
          );
        }

        final entries = state is LedgerLoaded
            ? state.entries
            : state is LedgerActionLoading
                ? state.entries
                : <LedgerEntry>[];

        if (entries.isEmpty) {
          return SliverFillRemaining(
            hasScrollBody: false,
            child: EmptyStateWidget(
              icon: Icons.receipt_long_rounded,
              title: l10n.noLedgerTransactions,
              subtitle: l10n.noLedgerTransactionsSubtitle,
            ),
          );
        }

        return SliverPadding(
          padding: const EdgeInsets.all(16),
          sliver: SliverList.separated(
            itemCount: entries.length,
            separatorBuilder: (context, index) => const SizedBox(height: 12),
            itemBuilder: (_, index) => LedgerEntryCard(
              entry: entries[index],
              customerName: customerName,
              currentUserId: currentUserId,
            ),
          ),
        );
      },
    );
  }
}
