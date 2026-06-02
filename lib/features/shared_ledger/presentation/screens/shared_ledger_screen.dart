import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:intl/intl.dart';
import '../../../../core/constants/app_colors.dart';
import '../../../../core/constants/app_typography.dart';
import '../../../../core/di/injection.dart';
import '../../../../core/services/ledger_socket_service.dart';
import '../../../../core/utils/app_logger.dart';
import '../../../../l10n/app_localizations.dart';
import '../../../../shared/models/ledger_entry.dart';
import '../../../../shared/widgets/app_toast.dart';
import '../../../../shared/widgets/empty_state_widget.dart';
import '../../../../shared/widgets/error_state_widget.dart';
import '../../../auth/presentation/bloc/auth_bloc.dart';
import '../../../auth/presentation/bloc/auth_state.dart';
import '../../services/ledger_statement_service.dart';
import '../bloc/ledger_bloc.dart';
import '../bloc/ledger_event.dart';
import '../bloc/ledger_state.dart';

class SharedLedgerScreen extends StatefulWidget {
  final String linkId;
  final String customerName;
  final bool isVendorView;

  const SharedLedgerScreen({
    super.key,
    required this.linkId,
    required this.customerName,
    this.isVendorView = true,
  });

  @override
  State<SharedLedgerScreen> createState() => _SharedLedgerScreenState();
}

class _SharedLedgerScreenState extends State<SharedLedgerScreen> {
  static const _m = 'LedgerScreen';
  late final LedgerBloc _bloc;
  late final LedgerSocketService _socket;

  @override
  void initState() {
    super.initState();
    _bloc = LedgerBloc(getIt())..add(LoadLedger(widget.linkId));
    _socket = getIt<LedgerSocketService>();
    _socket.joinLedger(widget.linkId);

    _socket.onEntryAdded((data) {
      try {
        final entry = LedgerEntry.fromJson(data['entry'] as Map<String, dynamic>);
        AppLogger.v(_m, 'Socket entry_added received id:${entry.id}');
        _bloc.add(SocketLedgerEntryAdded(entry));
      } catch (e) {
        AppLogger.e(_m, 'Failed to parse socket entry_added', e);
      }
    });

    _socket.onEntryUpdated((data) {
      try {
        final entry = LedgerEntry.fromJson(data['entry'] as Map<String, dynamic>);
        AppLogger.v(_m, 'Socket entry_updated received id:${entry.id}');
        _bloc.add(SocketLedgerEntryUpdated(entry));
      } catch (e) {
        AppLogger.e(_m, 'Failed to parse socket entry_updated', e);
      }
    });
  }

  @override
  void dispose() {
    _socket.leaveLedger(widget.linkId);
    _socket.off('ledger:entry_added');
    _socket.off('ledger:entry_updated');
    _bloc.close();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return BlocProvider.value(
      value: _bloc,
      child: SharedLedgerView(customerName: widget.customerName, linkId: widget.linkId, isVendorView: widget.isVendorView),
    );
  }
}

class SharedLedgerView extends StatelessWidget {
  final String customerName;
  final String linkId;
  final bool isVendorView;

  const SharedLedgerView(
      {super.key, required this.customerName, required this.linkId, this.isVendorView = true});

  @override
  Widget build(BuildContext context) {
    final l10n = AppLocalizations.of(context)!;
    final authState = context.read<AuthBloc>().state;
    final currentUserId = authState is AuthAuthenticated ? authState.user.id : '';
    return Scaffold(
      appBar: AppBar(
        title: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Text(customerName, style: AppTypography.h3),
            Text(
              l10n.sharedLedger,
              style:
                  AppTypography.bodySmall.copyWith(color: AppColors.primary),
            ),
          ],
        ),
        actions: [
          IconButton(
            onPressed: () => _showLedgerInfo(context, l10n),
            icon: const Icon(Icons.info_outline_rounded),
          ),
        ],
      ),
      body: SafeArea(child: Column(
        children: [
          _BalanceHeader(
            linkId: linkId,
            customerName: customerName,
            isVendorView: isVendorView,
          ),
          _FilterBar(),
          Expanded(
              child: _LedgerList(linkId: linkId, customerName: customerName, currentUserId: currentUserId)),
        ],
      ),
      ),
      bottomNavigationBar: _LedgerActions(
        linkId: linkId,
        customerName: customerName,
        isVendorView: isVendorView,
      ),
    );
  }

  void _showLedgerInfo(BuildContext context, AppLocalizations l10n) {
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
            Text(l10n.ledgerInfoTitle, style: AppTypography.h3),
            const SizedBox(height: 16),
            _InfoRow(
              icon: Icons.lock_rounded,
              color: AppColors.success,
              label: l10n.statusConfirmed,
              desc: l10n.statusConfirmedDesc,
            ),
            _InfoRow(
              icon: Icons.access_time_rounded,
              color: AppColors.warning,
              label: l10n.statusPending,
              desc: l10n.statusPendingDesc,
            ),
            _InfoRow(
              icon: Icons.warning_amber_rounded,
              color: AppColors.error,
              label: l10n.statusDisputed,
              desc: l10n.statusDisputedDesc,
            ),
            const SizedBox(height: 16),
          ],
        ),
      ),
    );
  }
}

class _InfoRow extends StatelessWidget {
  final IconData icon;
  final Color color;
  final String label;
  final String desc;

  const _InfoRow(
      {required this.icon,
      required this.color,
      required this.label,
      required this.desc});

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.only(bottom: 12),
      child: Row(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Icon(icon, color: color, size: 20),
          const SizedBox(width: 12),
          Expanded(
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Text(label,
                    style: AppTypography.labelLarge.copyWith(color: color)),
                Text(desc, style: AppTypography.bodySmall),
              ],
            ),
          ),
        ],
      ),
    );
  }
}

class _BalanceHeader extends StatelessWidget {
  final String linkId;
  final String customerName;
  final bool isVendorView;

  const _BalanceHeader({
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
          padding:
              const EdgeInsets.symmetric(vertical: 16, horizontal: 20),
          decoration: BoxDecoration(
            color: Theme.of(context).colorScheme.surface,
            border: Border(bottom: BorderSide(color: Theme.of(context).dividerColor)),
          ),
          child: Row(
            mainAxisAlignment: MainAxisAlignment.spaceBetween,
            children: [
              Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  Text(l10n.totalBalance,
                      style: AppTypography.bodySmall),
                  const SizedBox(height: 4),
                  Text(
                    '₹${balance.toStringAsFixed(0)}',
                    style: AppTypography.h1.copyWith(
                      color: balance > 0
                          ? AppColors.error
                          : AppColors.success,
                    ),
                  ),
                  Text(
                    balanceLabel,
                    style: AppTypography.bodySmall.copyWith(
                      color: balance > 0
                          ? AppColors.error
                          : AppColors.success,
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
                      horizontal: 14, vertical: 10),
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

class _FilterBar extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    final l10n = AppLocalizations.of(context)!;
    return BlocBuilder<LedgerBloc, LedgerState>(
      builder: (context, state) {
        EntryStatus? activeFilter;
        if (state is LedgerLoaded) activeFilter = state.activeFilter;

        return Container(
          color: Theme.of(context).colorScheme.surface,
          padding:
              const EdgeInsets.symmetric(horizontal: 16, vertical: 8),
          child: SingleChildScrollView(
            scrollDirection: Axis.horizontal,
            child: Row(
              children: [
                _FilterChip(
                  label: l10n.filterAll,
                  isActive: activeFilter == null,
                  onTap: () => context
                      .read<LedgerBloc>()
                      .add(const FilterLedger(null)),
                ),
                const SizedBox(width: 8),
                _FilterChip(
                  label: l10n.statusPending,
                  isActive: activeFilter == EntryStatus.pending,
                  color: AppColors.warning,
                  onTap: () => context.read<LedgerBloc>().add(
                      const FilterLedger(EntryStatus.pending)),
                ),
                const SizedBox(width: 8),
                _FilterChip(
                  label: l10n.statusConfirmed,
                  isActive: activeFilter == EntryStatus.confirmed,
                  color: AppColors.success,
                  onTap: () => context.read<LedgerBloc>().add(
                      const FilterLedger(EntryStatus.confirmed)),
                ),
                const SizedBox(width: 8),
                _FilterChip(
                  label: l10n.statusDisputed,
                  isActive: activeFilter == EntryStatus.disputed,
                  color: AppColors.error,
                  onTap: () => context.read<LedgerBloc>().add(
                      const FilterLedger(EntryStatus.disputed)),
                ),
              ],
            ),
          ),
        );
      },
    );
  }
}

class _FilterChip extends StatelessWidget {
  final String label;
  final bool isActive;
  final Color? color;
  final VoidCallback onTap;

  const _FilterChip({
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

class _LedgerList extends StatelessWidget {
  final String linkId;
  final String customerName;
  final String currentUserId;

  const _LedgerList(
      {required this.linkId, required this.customerName, required this.currentUserId});

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
              _buildList(context, entries),
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

        return _buildList(context, entries);
      },
    );
  }

  Widget _buildList(BuildContext context, List<LedgerEntry> entries) {
    return ListView.separated(
      padding: const EdgeInsets.all(16),
      itemCount: entries.length,
      separatorBuilder: (context, index) => const SizedBox(height: 12),
      itemBuilder: (context, index) {
        return _EntryCard(
          entry: entries[index],
          customerName: customerName,
          currentUserId: currentUserId,
        );
      },
    );
  }
}

class _EntryCard extends StatelessWidget {
  final LedgerEntry entry;
  final String customerName;
  final String currentUserId;

  const _EntryCard(
      {required this.entry, required this.customerName, required this.currentUserId});

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
              ? Border.all(
                  color: AppColors.error.withValues(alpha: 0.3))
              : null,
        ),
        child: Column(
          children: [
            Row(
              children: [
                Container(
                  padding: const EdgeInsets.all(10),
                  decoration: BoxDecoration(
                    color: (isCredit
                            ? AppColors.error
                            : AppColors.success)
                        .withValues(alpha: 0.1),
                    shape: BoxShape.circle,
                  ),
                  child: Icon(
                    isCredit
                        ? Icons.arrow_upward_rounded
                        : Icons.arrow_downward_rounded,
                    color: isCredit
                        ? AppColors.error
                        : AppColors.success,
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
                        DateFormat('dd MMM yyyy, hh:mm a')
                            .format(entry.date),
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
                        color: isCredit
                            ? AppColors.error
                            : AppColors.success,
                      ),
                    ),
                    const SizedBox(height: 4),
                    _StatusChip(status: entry.status),
                  ],
                ),
              ],
            ),
            if (entry.status == EntryStatus.pending &&
                !entry.isLocked &&
                entry.createdBy != currentUserId) ...[
              const Divider(height: 20),
              Row(
                children: [
                  Expanded(
                    child: OutlinedButton(
                      onPressed: () =>
                          _showDisputeSheet(context, l10n),
                      style: OutlinedButton.styleFrom(
                        foregroundColor: AppColors.error,
                        side: const BorderSide(color: AppColors.error),
                        padding: const EdgeInsets.symmetric(vertical: 10),
                        minimumSize: const Size(0, 36),
                      ),
                      child: Text(l10n.dispute,
                          style: const TextStyle(fontSize: 13)),
                    ),
                  ),
                  const SizedBox(width: 12),
                  Expanded(
                    child: ElevatedButton(
                      onPressed: () => _confirmEntry(context, l10n),
                      style: ElevatedButton.styleFrom(
                        backgroundColor: AppColors.success,
                        padding:
                            const EdgeInsets.symmetric(vertical: 10),
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
        content: Text(l10n.confirmEntryMessage(
            entry.amount.toStringAsFixed(0))),
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
                _StatusChip(status: entry.status),
              ],
            ),
            const SizedBox(height: 20),
            _DetailRow(l10n.entryAmount,
                '₹${entry.amount.toStringAsFixed(2)}'),
            _DetailRow(
                l10n.entryType,
                entry.type == EntryType.credit
                    ? l10n.entryTypeCreditGiven
                    : l10n.entryTypePaymentReceived),
            _DetailRow(l10n.entryDate,
                DateFormat('dd MMM yyyy, hh:mm a').format(entry.date)),
            if (entry.description != null)
              _DetailRow(l10n.entryDescription, entry.description!),
            if (entry.quantity != null)
              _DetailRow(l10n.entryQuantity,
                  '${entry.quantity} ${entry.unit ?? ''}'),
            if (entry.confirmedAt != null)
              _DetailRow(l10n.entryConfirmedAt,
                  DateFormat('dd MMM yyyy').format(entry.confirmedAt!)),
            if (entry.disputeReason != null)
              _DetailRow(l10n.entryDisputeReason, entry.disputeReason!),
            const SizedBox(height: 8),
          ],
        ),
      ),
    );
  }
}

class _DetailRow extends StatelessWidget {
  final String label;
  final String value;
  const _DetailRow(this.label, this.value);

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.only(bottom: 12),
      child: Row(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          SizedBox(
            width: 120,
            child: Text(label, style: AppTypography.bodySmall),
          ),
          Expanded(
            child: Text(value, style: AppTypography.labelLarge),
          ),
        ],
      ),
    );
  }
}

class _StatusChip extends StatelessWidget {
  final EntryStatus status;
  const _StatusChip({required this.status});

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
                fontSize: 10,
                fontWeight: FontWeight.bold,
                color: color),
          ),
        ],
      ),
    );
  }
}

class _LedgerActions extends StatelessWidget {
  final String linkId;
  final String customerName;
  final bool isVendorView;

  const _LedgerActions(
      {required this.linkId, required this.customerName, this.isVendorView = true});

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
                prefixIcon:
                    const Icon(Icons.currency_rupee_rounded),
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
                  backgroundColor: type == EntryType.credit
                      ? AppColors.error
                      : AppColors.success,
                  padding:
                      const EdgeInsets.symmetric(vertical: 14),
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
