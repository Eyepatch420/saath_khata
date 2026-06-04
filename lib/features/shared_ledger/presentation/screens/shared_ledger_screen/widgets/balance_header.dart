import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import '../../../../../../shared/models/ledger_entry.dart';
import '../../../../../../shared/widgets/app_toast.dart';
import '../../../../../../core/constants/app_colors.dart';
import '../../../../../../core/constants/app_typography.dart';
import '../../../../../../l10n/app_localizations.dart';
import '../../../../../auth/presentation/bloc/auth_bloc.dart';
import '../../../../../auth/presentation/bloc/auth_state.dart';
import '../../../services/ledger_statement_service.dart';
import '../../../bloc/ledger_bloc.dart';
import '../../../bloc/ledger_state.dart';

class LedgerBalanceHeader extends StatelessWidget {
  final String linkId;
  final String customerName;
  final bool isVendorView;

  const LedgerBalanceHeader({
    super.key,
    required this.linkId,
    required this.customerName,
    required this.isVendorView,
  });

  @override
  Widget build(BuildContext context) {
    final l10n = AppLocalizations.of(context)!;
    return BlocBuilder<LedgerBloc, LedgerState>(
      builder: (context, state) {
        double balance = 0;
        List<LedgerEntry> allEntries = const [];
        if (state is LedgerLoaded) {
          balance = state.balance;
          allEntries = state.allEntries;
        }
        if (state is LedgerActionLoading) {
          balance = state.balance;
          allEntries = state.entries;
        }

        final balanceLabel = balance > 0
            ? l10n.balanceCustomerOwes
            : balance < 0
            ? l10n.balanceYouOwe
            : l10n.balanceSettled;

        return Container(
          padding: const EdgeInsets.symmetric(vertical: 16, horizontal: 20),
          decoration: BoxDecoration(
            color: Theme.of(context).colorScheme.surface,
            border: Border(
              bottom: BorderSide(color: Theme.of(context).dividerColor),
            ),
          ),
          child: Row(
            mainAxisAlignment: MainAxisAlignment.spaceBetween,
            children: [
              Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  Text(l10n.totalBalance, style: AppTypography.bodySmall),
                  const SizedBox(height: 4),
                  Text(
                    '₹${balance.toStringAsFixed(0)}',
                    style: AppTypography.h1.copyWith(
                      color: balance > 0 ? AppColors.error : AppColors.success,
                    ),
                  ),
                  Text(
                    balanceLabel,
                    style: AppTypography.bodySmall.copyWith(
                      color: balance > 0 ? AppColors.error : AppColors.success,
                    ),
                  ),
                ],
              ),
              ElevatedButton.icon(
                onPressed: allEntries.isEmpty
                    ? null
                    : () => _exportStatement(context, allEntries, balance),
                icon: const Icon(Icons.picture_as_pdf_rounded, size: 16),
                label: Text(l10n.statement),
                style: ElevatedButton.styleFrom(
                  backgroundColor: AppColors.secondary,
                  padding: const EdgeInsets.symmetric(
                    horizontal: 14,
                    vertical: 10,
                  ),
                ),
              ),
            ],
          ),
        );
      },
    );
  }

  Future<void> _exportStatement(
    BuildContext context,
    List<LedgerEntry> entries,
    double balance,
  ) async {
    final authState = context.read<AuthBloc>().state;
    if (authState is! AuthAuthenticated) return;

    AppToast.show(context, 'Generating statement…', type: ToastType.info);

    try {
      await LedgerStatementService.generateAndShare(
        currentUser: authState.user,
        counterpartyName: customerName,
        entries: entries,
        balance: balance,
        isVendorView: isVendorView,
      );
    } catch (e) {
      if (context.mounted) {
        AppToast.show(context, 'Failed to generate PDF', type: ToastType.error);
      }
    }
  }
}
