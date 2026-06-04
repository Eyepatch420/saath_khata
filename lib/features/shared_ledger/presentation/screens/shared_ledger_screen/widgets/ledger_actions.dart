import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import '../../../../../../core/constants/app_colors.dart';
import '../../../../../../core/constants/app_typography.dart';
import '../../../../../../l10n/app_localizations.dart';
import '../../../../../../shared/models/ledger_entry.dart';
import '../../../bloc/ledger_bloc.dart';
import '../../../bloc/ledger_event.dart';

class LedgerActions extends StatelessWidget {
  final String linkId;
  final String customerName;
  final bool isVendorView;

  const LedgerActions({
    super.key,
    required this.linkId,
    required this.customerName,
    this.isVendorView = true,
  });

  @override
  Widget build(BuildContext context) {
    final l10n = AppLocalizations.of(context)!;
    return Container(
      padding: const EdgeInsets.fromLTRB(20, 12, 20, 20),
      decoration: BoxDecoration(
        color: Theme.of(context).colorScheme.surface,
        boxShadow: [
          BoxShadow(
            color: Colors.black.withValues(alpha: 0.06),
            blurRadius: 10,
            offset: const Offset(0, -4),
          ),
        ],
      ),
      child: Row(
        children: [
          Expanded(
            child: OutlinedButton.icon(
              onPressed: () =>
                  _showAddEntrySheet(context, l10n, EntryType.payment),
              style: OutlinedButton.styleFrom(
                foregroundColor: AppColors.success,
                side: const BorderSide(color: AppColors.success),
                padding: const EdgeInsets.symmetric(vertical: 14),
              ),
              icon: const Icon(Icons.arrow_downward_rounded, size: 18),
              label: Text(l10n.recordPayment),
            ),
          ),
          if (isVendorView) ...[
            const SizedBox(width: 12),
            Expanded(
              child: ElevatedButton.icon(
                onPressed: () =>
                    _showAddEntrySheet(context, l10n, EntryType.credit),
                style: ElevatedButton.styleFrom(
                  backgroundColor: AppColors.error,
                  padding: const EdgeInsets.symmetric(vertical: 14),
                ),
                icon: const Icon(Icons.arrow_upward_rounded,
                    size: 18, color: Colors.white),
                label: Text(l10n.giveCredit,
                    style: const TextStyle(color: Colors.white)),
              ),
            ),
          ],
        ],
      ),
    );
  }

  void _showAddEntrySheet(
      BuildContext context, AppLocalizations l10n, EntryType type) {
    final bloc = context.read<LedgerBloc>();
    final amountCtrl = TextEditingController();
    final descCtrl = TextEditingController();
    final qtyCtrl = TextEditingController();

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
            Row(
              children: [
                Container(
                  padding: const EdgeInsets.all(8),
                  decoration: BoxDecoration(
                    color: (type == EntryType.credit
                            ? AppColors.error
                            : AppColors.success)
                        .withValues(alpha: 0.1),
                    shape: BoxShape.circle,
                  ),
                  child: Icon(
                    type == EntryType.credit
                        ? Icons.arrow_upward_rounded
                        : Icons.arrow_downward_rounded,
                    color: type == EntryType.credit
                        ? AppColors.error
                        : AppColors.success,
                  ),
                ),
                const SizedBox(width: 12),
                Text(
                  type == EntryType.credit
                      ? l10n.giveCreditSheet
                      : l10n.recordPaymentSheet,
                  style: AppTypography.h3,
                ),
              ],
            ),
            Text(
              l10n.entryFor(customerName),
              style: AppTypography.bodySmall
                  .copyWith(color: AppColors.textSecondary),
            ),
            const SizedBox(height: 20),
            TextField(
              controller: amountCtrl,
              keyboardType:
                  const TextInputType.numberWithOptions(decimal: true),
              decoration: InputDecoration(
                labelText: l10n.amountRupees,
                prefixIcon: const Icon(Icons.currency_rupee_rounded),
              ),
            ),
            const SizedBox(height: 16),
            TextField(
              controller: descCtrl,
              decoration: InputDecoration(
                labelText: l10n.descriptionOptional,
                prefixIcon: const Icon(Icons.description_rounded),
                hintText: l10n.descriptionHint,
              ),
            ),
            const SizedBox(height: 16),
            TextField(
              controller: qtyCtrl,
              keyboardType:
                  const TextInputType.numberWithOptions(decimal: true),
              decoration: InputDecoration(
                labelText: l10n.quantityOptional,
                prefixIcon: const Icon(Icons.numbers_rounded),
                hintText: l10n.quantityHint,
              ),
            ),
            const SizedBox(height: 24),
            SizedBox(
              width: double.infinity,
              child: ElevatedButton(
                onPressed: () {
                  final amount = double.tryParse(amountCtrl.text);
                  if (amount == null || amount <= 0) return;
                  Navigator.pop(ctx);
                  bloc.add(AddLedgerEntry(
                    amount: amount,
                    type: type,
                    linkId: linkId,
                    vendorId: 'v1',
                    customerId: 'c1',
                    description: descCtrl.text.trim().isEmpty
                        ? null
                        : descCtrl.text.trim(),
                    quantity: double.tryParse(qtyCtrl.text),
                  ));
                },
                style: ElevatedButton.styleFrom(
                  backgroundColor:
                      type == EntryType.credit ? AppColors.error : AppColors.success,
                  padding: const EdgeInsets.symmetric(vertical: 14),
                ),
                child: Text(
                  type == EntryType.credit
                      ? l10n.addCreditEntry
                      : l10n.recordPayment,
                  style: const TextStyle(
                      color: Colors.white, fontWeight: FontWeight.bold),
                ),
              ),
            ),
          ],
        ),
      ),
    );
  }
}
