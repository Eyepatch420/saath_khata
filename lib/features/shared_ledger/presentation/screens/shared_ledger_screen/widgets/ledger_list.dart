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

class LedgerList extends StatelessWidget {
  final String linkId;
  final String customerName;
  final String currentUserId;

  const LedgerList({
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
          return const Center(child: CircularProgressIndicator());
        }

        if (state is LedgerError) {
          return ErrorStateWidget(
            message: state.message,
            onRetry: () =>
                context.read<LedgerBloc>().add(LoadLedger(linkId)),
          );
        }

        final entries = state is LedgerLoaded
            ? state.entries
            : state is LedgerActionLoading
                ? state.entries
                : <LedgerEntry>[];

        if (state is LedgerActionLoading) {
          return Stack(
            children: [
              _buildList(entries),
              const Positioned.fill(
                child: ColoredBox(
                  color: Color(0x33FFFFFF),
                  child: Center(child: CircularProgressIndicator()),
                ),
              ),
            ],
          );
        }

        if (entries.isEmpty) {
          return EmptyStateWidget(
            icon: Icons.receipt_long_rounded,
            title: l10n.noLedgerTransactions,
            subtitle: l10n.noLedgerTransactionsSubtitle,
          );
        }

        return _buildList(entries);
      },
    );
  }

  Widget _buildList(List<LedgerEntry> entries) {
    return ListView.separated(
      padding: const EdgeInsets.all(16),
      itemCount: entries.length,
      separatorBuilder: (_, _) => const SizedBox(height: 12),
      itemBuilder: (_, index) => LedgerEntryCard(
        entry: entries[index],
        customerName: customerName,
        currentUserId: currentUserId,
      ),
    );
  }
}
