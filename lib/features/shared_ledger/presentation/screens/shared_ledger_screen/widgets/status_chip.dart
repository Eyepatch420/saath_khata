import 'package:flutter/material.dart';
import '../../../../../../core/constants/app_colors.dart';
import '../../../../../../l10n/app_localizations.dart';
import '../../../../../../shared/models/ledger_entry.dart';

class LedgerStatusChip extends StatelessWidget {
  final EntryStatus status;
  const LedgerStatusChip({super.key, required this.status});

  @override
  Widget build(BuildContext context) {
    final l10n = AppLocalizations.of(context)!;
    final Color color;
    final String text;
    final IconData icon;

    switch (status) {
      case EntryStatus.confirmed:
        color = AppColors.success;
        text = l10n.statusConfirmed;
        icon = Icons.lock_rounded;
        break;
      case EntryStatus.disputed:
        color = AppColors.error;
        text = l10n.statusDisputed;
        icon = Icons.warning_rounded;
        break;
      case EntryStatus.pending:
        color = AppColors.warning;
        text = l10n.statusPending;
        icon = Icons.access_time_rounded;
        break;
      case EntryStatus.autoConfirmed:
        color = AppColors.success;
        text = l10n.statusAutoConfirmed;
        icon = Icons.lock_rounded;
        break;
    }

    return Container(
      padding: const EdgeInsets.symmetric(horizontal: 8, vertical: 3),
      decoration: BoxDecoration(
        color: color.withValues(alpha: 0.12),
        borderRadius: BorderRadius.circular(20),
      ),
      child: Row(
        mainAxisSize: MainAxisSize.min,
        children: [
          Icon(icon, size: 10, color: color),
          const SizedBox(width: 3),
          Text(
            text,
            style: TextStyle(
                fontSize: 10, fontWeight: FontWeight.bold, color: color),
          ),
        ],
      ),
    );
  }
}
