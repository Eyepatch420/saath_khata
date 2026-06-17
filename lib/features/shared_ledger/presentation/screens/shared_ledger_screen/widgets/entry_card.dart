import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:intl/intl.dart';
import '../../../../../../core/constants/app_colors.dart';
import '../../../../../../core/constants/app_typography.dart';
import '../../../../../../l10n/app_localizations.dart';
import '../../../../../../shared/models/ledger_entry.dart';
import '../../../bloc/ledger_bloc.dart';
import '../../../bloc/ledger_event.dart';
import 'detail_row.dart';
import 'status_chip.dart';

class LedgerEntryCard extends StatelessWidget {
  final LedgerEntry entry;
  final String customerName;
  final String currentUserId;
  final bool isVendorView;

  const LedgerEntryCard({
    super.key,
    required this.entry,
    required this.customerName,
    required this.currentUserId,
    required this.isVendorView,
  });

  @override
  Widget build(BuildContext context) {
    final l10n = AppLocalizations.of(context)!;
    final isCredit = entry.type == EntryType.credit;

    return GestureDetector(
      onTap: () => _showEntryDetail(context, l10n),
      child: Container(
        padding: const EdgeInsets.all(16),
        decoration: BoxDecoration(
          color: Theme.of(context).colorScheme.surface,
          borderRadius: BorderRadius.circular(16),
          border: entry.status == EntryStatus.disputed
              ? Border.all(color: AppColors.error.withValues(alpha: 0.3))
              : null,
        ),
        child: Column(
          children: [
            Row(
              children: [
                Container(
                  padding: const EdgeInsets.all(10),
                  decoration: BoxDecoration(
                    color: (isCredit ? AppColors.error : AppColors.success)
                        .withValues(alpha: 0.1),
                    shape: BoxShape.circle,
                  ),
                  child: Icon(
                    isCredit
                        ? Icons.arrow_upward_rounded
                        : Icons.arrow_downward_rounded,
                    color: isCredit ? AppColors.error : AppColors.success,
                    size: 18,
                  ),
                ),
                const SizedBox(width: 12),
                Expanded(
                  child: Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      Text(
                        entry.description ??
                            (isCredit
                                ? l10n.entryTypeCreditLabel
                                : l10n.entryTypePaymentLabel),
                        style: AppTypography.labelLarge,
                      ),
                      const SizedBox(height: 2),
                      Text(
                        DateFormat('dd MMM yyyy, hh:mm a').format(entry.date),
                        style: AppTypography.bodySmall,
                      ),
                    ],
                  ),
                ),
                Column(
                  crossAxisAlignment: CrossAxisAlignment.end,
                  children: [
                    Text(
                      '₹${entry.amount.toStringAsFixed(0)}',
                      style: AppTypography.h3.copyWith(
                        color: isCredit ? AppColors.error : AppColors.success,
                      ),
                    ),
                    const SizedBox(height: 4),
                    LedgerStatusChip(status: entry.status),
                  ],
                ),
              ],
            ),
            if (entry.status == EntryStatus.pending &&
                !entry.isLocked &&
                (isVendorView
                    ? entry.type == EntryType.payment
                    : entry.type == EntryType.credit)) ...[
              const Divider(height: 20),
              Row(
                children: [
                  Expanded(
                    child: OutlinedButton(
                      onPressed: () => _showDisputeSheet(context, l10n),
                      style: OutlinedButton.styleFrom(
                        foregroundColor: AppColors.error,
                        side: const BorderSide(color: AppColors.error),
                        padding: const EdgeInsets.symmetric(vertical: 10),
                        minimumSize: const Size(0, 36),
                      ),
                      child:
                          Text(l10n.dispute, style: const TextStyle(fontSize: 13)),
                    ),
                  ),
                  const SizedBox(width: 12),
                  Expanded(
                    child: ElevatedButton(
                      onPressed: () => _confirmEntry(context, l10n),
                      style: ElevatedButton.styleFrom(
                        backgroundColor: AppColors.success,
                        padding: const EdgeInsets.symmetric(vertical: 10),
                        minimumSize: const Size(0, 36),
                      ),
                      child: Text(l10n.confirm,
                          style: const TextStyle(
                              fontSize: 13, color: Colors.white)),
                    ),
                  ),
                ],
              ),
            ],
            if (entry.status == EntryStatus.disputed &&
                entry.disputeReason != null) ...[
              const Divider(height: 20),
              Row(
                children: [
                  const Icon(Icons.warning_amber_rounded,
                      size: 14, color: AppColors.error),
                  const SizedBox(width: 6),
                  Expanded(
                    child: Text(
                      entry.disputeReason!,
                      style: AppTypography.bodySmall
                          .copyWith(color: AppColors.error),
                    ),
                  ),
                ],
              ),
            ],
          ],
        ),
      ),
    );
  }

  void _confirmEntry(BuildContext context, AppLocalizations l10n) {
    showDialog(
      context: context,
      builder: (_) => AlertDialog(
        shape:
            RoundedRectangleBorder(borderRadius: BorderRadius.circular(16)),
        title: Text(l10n.confirmEntryTitle),
        content:
            Text(l10n.confirmEntryMessage(entry.amount.toStringAsFixed(0))),
        actions: [
          TextButton(
            onPressed: () => Navigator.pop(context),
            child: Text(l10n.cancel),
          ),
          ElevatedButton(
            onPressed: () {
              Navigator.pop(context);
              context
                  .read<LedgerBloc>()
                  .add(ConfirmLedgerEntry(entry.id));
            },
            style: ElevatedButton.styleFrom(
                backgroundColor: AppColors.success),
            child: Text(l10n.confirm,
                style: const TextStyle(color: Colors.white)),
          ),
        ],
      ),
    );
  }

  void _showDisputeSheet(BuildContext context, AppLocalizations l10n) {
    final bloc = context.read<LedgerBloc>();
    final controller = TextEditingController();

    showModalBottomSheet(
      context: context,
      useRootNavigator: true,
      isScrollControlled: true,
      shape: const RoundedRectangleBorder(
        borderRadius: BorderRadius.vertical(top: Radius.circular(24)),
      ),
      builder: (ctx) => Padding(
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
            Text(l10n.raiseDisputeTitle, style: AppTypography.h3),
            const SizedBox(height: 4),
            Text(
              l10n.raiseDisputeSubtitle,
              style: AppTypography.bodySmall
                  .copyWith(color: AppColors.textSecondary),
            ),
            const SizedBox(height: 20),
            TextField(
              controller: controller,
              maxLines: 3,
              decoration: InputDecoration(
                hintText: l10n.raiseDisputeHint,
                hintStyle: AppTypography.bodyMedium
                    .copyWith(color: AppColors.textHint),
              ),
            ),
            const SizedBox(height: 20),
            SizedBox(
              width: double.infinity,
              child: ElevatedButton(
                onPressed: () {
                  if (controller.text.trim().isNotEmpty) {
                    Navigator.pop(ctx);
                    bloc.add(DisputeLedgerEntry(
                      entryId: entry.id,
                      reason: controller.text.trim(),
                    ));
                  }
                },
                style: ElevatedButton.styleFrom(
                  backgroundColor: AppColors.error,
                  padding: const EdgeInsets.symmetric(vertical: 14),
                ),
                child: Text(l10n.submitDispute,
                    style: const TextStyle(color: Colors.white)),
              ),
            ),
          ],
        ),
      ),
    );
  }

  void _showEntryDetail(BuildContext context, AppLocalizations l10n) {
    showModalBottomSheet(
      context: context,
      useRootNavigator: true,
      shape: const RoundedRectangleBorder(
        borderRadius: BorderRadius.vertical(top: Radius.circular(24)),
      ),
      builder: (_) => Padding(
        padding: const EdgeInsets.all(24),
        child: Column(
          mainAxisSize: MainAxisSize.min,
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Row(
              mainAxisAlignment: MainAxisAlignment.spaceBetween,
              children: [
                Text(l10n.entryDetails, style: AppTypography.h3),
                LedgerStatusChip(status: entry.status),
              ],
            ),
            const SizedBox(height: 20),
            LedgerDetailRow(
                l10n.entryAmount, '₹${entry.amount.toStringAsFixed(2)}'),
            LedgerDetailRow(
              l10n.entryType,
              entry.type == EntryType.credit
                  ? l10n.entryTypeCreditGiven
                  : l10n.entryTypePaymentReceived,
            ),
            LedgerDetailRow(l10n.entryDate,
                DateFormat('dd MMM yyyy, hh:mm a').format(entry.date)),
            if (entry.description != null)
              LedgerDetailRow(l10n.entryDescription, entry.description!),
            if (entry.quantity != null)
              LedgerDetailRow(l10n.entryQuantity,
                  '${entry.quantity} ${entry.unit ?? ''}'),
            if (entry.confirmedAt != null)
              LedgerDetailRow(l10n.entryConfirmedAt,
                  DateFormat('dd MMM yyyy').format(entry.confirmedAt!)),
            if (entry.disputeReason != null)
              LedgerDetailRow(l10n.entryDisputeReason, entry.disputeReason!),
            const SizedBox(height: 8),
          ],
        ),
      ),
    );
  }
}
