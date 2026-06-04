import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import '../../../../../../core/constants/app_colors.dart';
import '../../../../../../l10n/app_localizations.dart';
import '../../../../../../shared/models/ledger_entry.dart';
import '../../../bloc/ledger_bloc.dart';
import '../../../bloc/ledger_event.dart';
import '../../../bloc/ledger_state.dart';

class LedgerFilterBar extends StatelessWidget {
  const LedgerFilterBar({super.key});

  @override
  Widget build(BuildContext context) {
    final l10n = AppLocalizations.of(context)!;
    return BlocBuilder<LedgerBloc, LedgerState>(
      builder: (context, state) {
        EntryStatus? activeFilter;
        if (state is LedgerLoaded) activeFilter = state.activeFilter;

        return Container(
          color: Theme.of(context).colorScheme.surface,
          padding: const EdgeInsets.symmetric(horizontal: 16, vertical: 8),
          child: SingleChildScrollView(
            scrollDirection: Axis.horizontal,
            child: Row(
              children: [
                _LedgerFilterChip(
                  label: l10n.filterAll,
                  isActive: activeFilter == null,
                  onTap: () => context
                      .read<LedgerBloc>()
                      .add(const FilterLedger(null)),
                ),
                const SizedBox(width: 8),
                _LedgerFilterChip(
                  label: l10n.statusPending,
                  isActive: activeFilter == EntryStatus.pending,
                  color: AppColors.warning,
                  onTap: () => context
                      .read<LedgerBloc>()
                      .add(const FilterLedger(EntryStatus.pending)),
                ),
                const SizedBox(width: 8),
                _LedgerFilterChip(
                  label: l10n.statusConfirmed,
                  isActive: activeFilter == EntryStatus.confirmed,
                  color: AppColors.success,
                  onTap: () => context
                      .read<LedgerBloc>()
                      .add(const FilterLedger(EntryStatus.confirmed)),
                ),
                const SizedBox(width: 8),
                _LedgerFilterChip(
                  label: l10n.statusDisputed,
                  isActive: activeFilter == EntryStatus.disputed,
                  color: AppColors.error,
                  onTap: () => context
                      .read<LedgerBloc>()
                      .add(const FilterLedger(EntryStatus.disputed)),
                ),
              ],
            ),
          ),
        );
      },
    );
  }
}

class _LedgerFilterChip extends StatelessWidget {
  final String label;
  final bool isActive;
  final Color? color;
  final VoidCallback onTap;

  const _LedgerFilterChip({
    required this.label,
    required this.isActive,
    required this.onTap,
    this.color,
  });

  @override
  Widget build(BuildContext context) {
    final activeColor = color ?? AppColors.primary;
    return GestureDetector(
      onTap: onTap,
      child: AnimatedContainer(
        duration: const Duration(milliseconds: 200),
        padding: const EdgeInsets.symmetric(horizontal: 14, vertical: 6),
        decoration: BoxDecoration(
          color: isActive
              ? activeColor
              : activeColor.withValues(alpha: 0.08),
          borderRadius: BorderRadius.circular(20),
        ),
        child: Text(
          label,
          style: TextStyle(
            fontSize: 12,
            fontWeight: FontWeight.w600,
            color: isActive ? Colors.white : activeColor,
          ),
        ),
      ),
    );
  }
}
