import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import '../../../../../../core/constants/app_colors.dart';
import '../../../../../../l10n/app_localizations.dart';
import '../../../../../../shared/models/ledger_entry.dart';
import '../../../../../../shared/widgets/empty_state_widget.dart';
import '../../../../../../shared/widgets/error_state_widget.dart';
import '../../../bloc/ledger_bloc.dart';
import '../../../bloc/ledger_event.dart';
import '../../../bloc/ledger_state.dart';
import 'entry_card.dart';

class LedgerList extends StatefulWidget {
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
  State<LedgerList> createState() => _LedgerListState();
}

class _LedgerListState extends State<LedgerList> {
  /// Pull-to-refresh: dispatch and release the indicator quickly.
  ///
  /// We do NOT use bloc.stream.firstWhere() here because LedgerLoaded extends
  /// Equatable — if the server returns the same data Bloc deduplicates the
  /// emission and firstWhere never fires, hanging for the full timeout.
  /// Instead we dispatch and wait a short minimum delay so the spinner feels
  /// intentional; the list rebuilds whenever the BLoC emits.
  Future<void> _handleRefresh() async {
    context.read<LedgerBloc>().add(RefreshLedger(widget.linkId));
    await Future.delayed(const Duration(milliseconds: 500));
  }

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
                context.read<LedgerBloc>().add(LoadLedger(widget.linkId)),
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
              _buildRefreshableList(entries),
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
          // Wrap the empty state with a RefreshIndicator too — user can
          // pull down to check if something has been added since loading.
          return RefreshIndicator(
            onRefresh: _handleRefresh,
            color: AppColors.primary,
            child: SingleChildScrollView(
              physics: const AlwaysScrollableScrollPhysics(),
              child: SizedBox(
                height: 400,
                child: EmptyStateWidget(
                  icon: Icons.receipt_long_rounded,
                  title: l10n.noLedgerTransactions,
                  subtitle: l10n.noLedgerTransactionsSubtitle,
                ),
              ),
            ),
          );
        }

        return _buildRefreshableList(entries);
      },
    );
  }

  Widget _buildRefreshableList(List<LedgerEntry> entries) {
    return RefreshIndicator(
      onRefresh: _handleRefresh,
      color: AppColors.primary,
      displacement: 48,
      child: ListView.separated(
        physics: const AlwaysScrollableScrollPhysics(),
        padding: const EdgeInsets.all(16),
        itemCount: entries.length,
        separatorBuilder: (_, idx) => const SizedBox(height: 12),
        itemBuilder: (_, index) => LedgerEntryCard(
          entry: entries[index],
          customerName: widget.customerName,
          currentUserId: widget.currentUserId,
        ),
      ),
    );
  }
}
