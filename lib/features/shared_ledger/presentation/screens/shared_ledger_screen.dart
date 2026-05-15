import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:intl/intl.dart';
import '../../../../core/constants/app_colors.dart';
import '../../../../core/constants/app_typography.dart';
import '../../../../core/di/injection.dart';
import '../../../../shared/models/ledger_entry.dart';
import '../../../../shared/widgets/empty_state_widget.dart';
import '../../../../shared/widgets/error_state_widget.dart';
import '../bloc/ledger_bloc.dart';
import '../bloc/ledger_event.dart';
import '../bloc/ledger_state.dart';

class SharedLedgerScreen extends StatelessWidget {
  final String linkId;
  final String customerName;

  const SharedLedgerScreen({
    super.key,
    required this.linkId,
    required this.customerName,
  });

  @override
  Widget build(BuildContext context) {
    return BlocProvider(
      create: (context) => LedgerBloc(getIt())..add(LoadLedger(linkId)),
      child: SharedLedgerView(customerName: customerName, linkId: linkId),
    );
  }
}

class SharedLedgerView extends StatelessWidget {
  final String customerName;
  final String linkId;

  const SharedLedgerView({super.key, required this.customerName, required this.linkId});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: AppColors.background,
      appBar: AppBar(
        title: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Text(customerName, style: AppTypography.h3),
            Text('Shared Ledger',
                style: AppTypography.bodySmall.copyWith(color: AppColors.primary)),
          ],
        ),
        actions: [
          IconButton(
            onPressed: () => _showLedgerInfo(context),
            icon: const Icon(Icons.info_outline_rounded),
          ),
        ],
      ),
      body: Column(
        children: [
          _BalanceHeader(linkId: linkId),
          _FilterBar(),
          Expanded(child: _LedgerList(linkId: linkId, customerName: customerName)),
        ],
      ),
      bottomNavigationBar: _LedgerActions(
        linkId: linkId,
        customerName: customerName,
      ),
    );
  }

  void _showLedgerInfo(BuildContext context) {
    showModalBottomSheet(
      context: context,
      shape: const RoundedRectangleBorder(
        borderRadius: BorderRadius.vertical(top: Radius.circular(24)),
      ),
      builder: (_) => Padding(
        padding: const EdgeInsets.all(24),
        child: Column(
          mainAxisSize: MainAxisSize.min,
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Text('How this ledger works', style: AppTypography.h3),
            const SizedBox(height: 16),
            _InfoRow(
              icon: Icons.lock_rounded,
              color: AppColors.success,
              label: 'Confirmed',
              desc: 'Both parties agreed. Entry is locked and cannot be changed.',
            ),
            _InfoRow(
              icon: Icons.access_time_rounded,
              color: AppColors.warning,
              label: 'Pending',
              desc: 'Awaiting customer confirmation. Auto-confirmed after 72 hours.',
            ),
            _InfoRow(
              icon: Icons.warning_amber_rounded,
              color: AppColors.error,
              label: 'Disputed',
              desc: 'Customer raised a dispute. Vendor review required.',
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

  const _InfoRow({required this.icon, required this.color, required this.label, required this.desc});

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
                Text(label, style: AppTypography.labelLarge.copyWith(color: color)),
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
  const _BalanceHeader({required this.linkId});

  @override
  Widget build(BuildContext context) {
    return BlocBuilder<LedgerBloc, LedgerState>(
      builder: (context, state) {
        double balance = 0;
        if (state is LedgerLoaded) balance = state.balance;
        if (state is LedgerActionLoading) balance = state.balance;

        return Container(
          padding: const EdgeInsets.symmetric(vertical: 16, horizontal: 20),
          decoration: const BoxDecoration(
            color: AppColors.surface,
            border: Border(bottom: BorderSide(color: AppColors.divider)),
          ),
          child: Row(
            mainAxisAlignment: MainAxisAlignment.spaceBetween,
            children: [
              Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  Text('TOTAL BALANCE', style: AppTypography.bodySmall),
                  const SizedBox(height: 4),
                  Text(
                    '₹${balance.toStringAsFixed(0)}',
                    style: AppTypography.h1.copyWith(
                      color: balance > 0 ? AppColors.error : AppColors.success,
                    ),
                  ),
                  Text(
                    balance > 0 ? 'Customer owes you' : balance < 0 ? 'You owe customer' : 'Settled',
                    style: AppTypography.bodySmall.copyWith(
                      color: balance > 0 ? AppColors.error : AppColors.success,
                    ),
                  ),
                ],
              ),
              ElevatedButton.icon(
                onPressed: () {},
                icon: const Icon(Icons.picture_as_pdf_rounded, size: 16),
                label: const Text('Statement'),
                style: ElevatedButton.styleFrom(
                  backgroundColor: AppColors.secondary,
                  padding: const EdgeInsets.symmetric(horizontal: 14, vertical: 10),
                ),
              ),
            ],
          ),
        );
      },
    );
  }
}

class _FilterBar extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return BlocBuilder<LedgerBloc, LedgerState>(
      builder: (context, state) {
        EntryStatus? activeFilter;
        if (state is LedgerLoaded) activeFilter = state.activeFilter;

        return Container(
          color: AppColors.surface,
          padding: const EdgeInsets.symmetric(horizontal: 16, vertical: 8),
          child: SingleChildScrollView(
            scrollDirection: Axis.horizontal,
            child: Row(
              children: [
                _FilterChip(
                  label: 'All',
                  isActive: activeFilter == null,
                  onTap: () => context.read<LedgerBloc>().add(const FilterLedger(null)),
                ),
                const SizedBox(width: 8),
                _FilterChip(
                  label: 'Pending',
                  isActive: activeFilter == EntryStatus.pending,
                  color: AppColors.warning,
                  onTap: () => context.read<LedgerBloc>().add(const FilterLedger(EntryStatus.pending)),
                ),
                const SizedBox(width: 8),
                _FilterChip(
                  label: 'Confirmed',
                  isActive: activeFilter == EntryStatus.confirmed,
                  color: AppColors.success,
                  onTap: () => context.read<LedgerBloc>().add(const FilterLedger(EntryStatus.confirmed)),
                ),
                const SizedBox(width: 8),
                _FilterChip(
                  label: 'Disputed',
                  isActive: activeFilter == EntryStatus.disputed,
                  color: AppColors.error,
                  onTap: () => context.read<LedgerBloc>().add(const FilterLedger(EntryStatus.disputed)),
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
          color: isActive ? activeColor : activeColor.withValues(alpha: 0.08),
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

  const _LedgerList({required this.linkId, required this.customerName});

  @override
  Widget build(BuildContext context) {
    return BlocBuilder<LedgerBloc, LedgerState>(
      builder: (context, state) {
        if (state is LedgerLoading) {
          return const Center(child: CircularProgressIndicator());
        }

        if (state is LedgerError) {
          return ErrorStateWidget(
            message: state.message,
            onRetry: () => context.read<LedgerBloc>().add(LoadLedger(linkId)),
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
            title: 'No transactions yet',
            subtitle: 'Add a credit or payment entry to get started.',
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
        );
      },
    );
  }
}

class _EntryCard extends StatelessWidget {
  final LedgerEntry entry;
  final String customerName;

  const _EntryCard({required this.entry, required this.customerName});

  @override
  Widget build(BuildContext context) {
    final isCredit = entry.type == EntryType.credit;

    return GestureDetector(
      onTap: () => _showEntryDetail(context),
      child: Container(
        padding: const EdgeInsets.all(16),
        decoration: BoxDecoration(
          color: AppColors.surface,
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
                    color: (isCredit ? AppColors.error : AppColors.success).withValues(alpha: 0.1),
                    shape: BoxShape.circle,
                  ),
                  child: Icon(
                    isCredit ? Icons.arrow_upward_rounded : Icons.arrow_downward_rounded,
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
                        entry.description ?? (isCredit ? 'Credit Entry' : 'Payment Received'),
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
                    _StatusChip(status: entry.status),
                  ],
                ),
              ],
            ),
            if (entry.status == EntryStatus.pending && !entry.isLocked) ...[
              const Divider(height: 20),
              Row(
                children: [
                  Expanded(
                    child: OutlinedButton(
                      onPressed: () => _showDisputeSheet(context),
                      style: OutlinedButton.styleFrom(
                        foregroundColor: AppColors.error,
                        side: const BorderSide(color: AppColors.error),
                        padding: const EdgeInsets.symmetric(vertical: 10),
                        minimumSize: const Size(0, 36),
                      ),
                      child: const Text('Dispute', style: TextStyle(fontSize: 13)),
                    ),
                  ),
                  const SizedBox(width: 12),
                  Expanded(
                    child: ElevatedButton(
                      onPressed: () => _confirmEntry(context),
                      style: ElevatedButton.styleFrom(
                        backgroundColor: AppColors.success,
                        padding: const EdgeInsets.symmetric(vertical: 10),
                        minimumSize: const Size(0, 36),
                      ),
                      child: const Text('Confirm', style: TextStyle(fontSize: 13, color: Colors.white)),
                    ),
                  ),
                ],
              ),
            ],
            if (entry.status == EntryStatus.disputed && entry.disputeReason != null) ...[
              const Divider(height: 20),
              Row(
                children: [
                  const Icon(Icons.warning_amber_rounded, size: 14, color: AppColors.error),
                  const SizedBox(width: 6),
                  Expanded(
                    child: Text(
                      entry.disputeReason!,
                      style: AppTypography.bodySmall.copyWith(color: AppColors.error),
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

  void _confirmEntry(BuildContext context) {
    showDialog(
      context: context,
      builder: (_) => AlertDialog(
        shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(16)),
        title: const Text('Confirm Entry'),
        content: Text(
          'Are you sure you want to confirm ₹${entry.amount.toStringAsFixed(0)} entry? This action cannot be undone.',
        ),
        actions: [
          TextButton(
            onPressed: () => Navigator.pop(context),
            child: const Text('Cancel'),
          ),
          ElevatedButton(
            onPressed: () {
              Navigator.pop(context);
              context.read<LedgerBloc>().add(ConfirmLedgerEntry(entry.id));
            },
            style: ElevatedButton.styleFrom(backgroundColor: AppColors.success),
            child: const Text('Confirm', style: TextStyle(color: Colors.white)),
          ),
        ],
      ),
    );
  }

  void _showDisputeSheet(BuildContext context) {
    final bloc = context.read<LedgerBloc>();
    final controller = TextEditingController();

    showModalBottomSheet(
      context: context,
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
            Text('Raise a Dispute', style: AppTypography.h3),
            const SizedBox(height: 4),
            Text(
              'Describe what is incorrect about this entry.',
              style: AppTypography.bodySmall.copyWith(color: AppColors.textSecondary),
            ),
            const SizedBox(height: 20),
            TextField(
              controller: controller,
              maxLines: 3,
              decoration: InputDecoration(
                hintText: 'e.g. Amount should be ₹50, not ₹60',
                hintStyle: AppTypography.bodyMedium.copyWith(color: AppColors.textHint),
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
                child: const Text('Submit Dispute', style: TextStyle(color: Colors.white)),
              ),
            ),
          ],
        ),
      ),
    );
  }

  void _showEntryDetail(BuildContext context) {
    showModalBottomSheet(
      context: context,
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
                Text('Entry Details', style: AppTypography.h3),
                _StatusChip(status: entry.status),
              ],
            ),
            const SizedBox(height: 20),
            _DetailRow('Amount', '₹${entry.amount.toStringAsFixed(2)}'),
            _DetailRow('Type', entry.type == EntryType.credit ? 'Credit (Given)' : 'Payment (Received)'),
            _DetailRow('Date', DateFormat('dd MMM yyyy, hh:mm a').format(entry.date)),
            if (entry.description != null) _DetailRow('Description', entry.description!),
            if (entry.quantity != null) _DetailRow('Quantity', '${entry.quantity} ${entry.unit ?? ''}'),
            if (entry.confirmedAt != null)
              _DetailRow('Confirmed At', DateFormat('dd MMM yyyy').format(entry.confirmedAt!)),
            if (entry.disputeReason != null)
              _DetailRow('Dispute Reason', entry.disputeReason!),
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
    final Color color;
    final String text;
    final IconData icon;

    switch (status) {
      case EntryStatus.confirmed:
        color = AppColors.success;
        text = 'Confirmed';
        icon = Icons.lock_rounded;
        break;
      case EntryStatus.disputed:
        color = AppColors.error;
        text = 'Disputed';
        icon = Icons.warning_rounded;
        break;
      case EntryStatus.pending:
        color = AppColors.warning;
        text = 'Pending';
        icon = Icons.access_time_rounded;
        break;
      case EntryStatus.autoConfirmed:
        color = AppColors.success;
        text = 'Auto-Confirmed';
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
            style: TextStyle(fontSize: 10, fontWeight: FontWeight.bold, color: color),
          ),
        ],
      ),
    );
  }
}

class _LedgerActions extends StatelessWidget {
  final String linkId;
  final String customerName;

  const _LedgerActions({required this.linkId, required this.customerName});

  @override
  Widget build(BuildContext context) {
    return Container(
      padding: const EdgeInsets.fromLTRB(20, 12, 20, 20),
      decoration: BoxDecoration(
        color: AppColors.surface,
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
              onPressed: () => _showAddEntrySheet(context, EntryType.payment),
              style: OutlinedButton.styleFrom(
                foregroundColor: AppColors.success,
                side: const BorderSide(color: AppColors.success),
                padding: const EdgeInsets.symmetric(vertical: 14),
              ),
              icon: const Icon(Icons.arrow_downward_rounded, size: 18),
              label: const Text('RECORD PAYMENT'),
            ),
          ),
          const SizedBox(width: 12),
          Expanded(
            child: ElevatedButton.icon(
              onPressed: () => _showAddEntrySheet(context, EntryType.credit),
              style: ElevatedButton.styleFrom(
                backgroundColor: AppColors.error,
                padding: const EdgeInsets.symmetric(vertical: 14),
              ),
              icon: const Icon(Icons.arrow_upward_rounded, size: 18, color: Colors.white),
              label: const Text('GIVE CREDIT', style: TextStyle(color: Colors.white)),
            ),
          ),
        ],
      ),
    );
  }

  void _showAddEntrySheet(BuildContext context, EntryType type) {
    final bloc = context.read<LedgerBloc>();
    final amountCtrl = TextEditingController();
    final descCtrl = TextEditingController();
    final qtyCtrl = TextEditingController();

    showModalBottomSheet(
      context: context,
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
                    color: (type == EntryType.credit ? AppColors.error : AppColors.success)
                        .withValues(alpha: 0.1),
                    shape: BoxShape.circle,
                  ),
                  child: Icon(
                    type == EntryType.credit
                        ? Icons.arrow_upward_rounded
                        : Icons.arrow_downward_rounded,
                    color: type == EntryType.credit ? AppColors.error : AppColors.success,
                  ),
                ),
                const SizedBox(width: 12),
                Text(
                  type == EntryType.credit ? 'Give Credit' : 'Record Payment',
                  style: AppTypography.h3,
                ),
              ],
            ),
            Text(
              'for $customerName',
              style: AppTypography.bodySmall.copyWith(color: AppColors.textSecondary),
            ),
            const SizedBox(height: 20),
            TextField(
              controller: amountCtrl,
              keyboardType: const TextInputType.numberWithOptions(decimal: true),
              decoration: const InputDecoration(
                labelText: 'Amount (₹)',
                prefixIcon: Icon(Icons.currency_rupee_rounded),
              ),
            ),
            const SizedBox(height: 16),
            TextField(
              controller: descCtrl,
              decoration: const InputDecoration(
                labelText: 'Description (optional)',
                prefixIcon: Icon(Icons.description_rounded),
                hintText: 'e.g. 2L Milk, Monthly groceries',
              ),
            ),
            const SizedBox(height: 16),
            TextField(
              controller: qtyCtrl,
              keyboardType: const TextInputType.numberWithOptions(decimal: true),
              decoration: const InputDecoration(
                labelText: 'Quantity (optional)',
                prefixIcon: Icon(Icons.numbers_rounded),
                hintText: 'e.g. 2',
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
                    description: descCtrl.text.trim().isEmpty ? null : descCtrl.text.trim(),
                    quantity: double.tryParse(qtyCtrl.text),
                  ));
                },
                style: ElevatedButton.styleFrom(
                  backgroundColor: type == EntryType.credit ? AppColors.error : AppColors.success,
                  padding: const EdgeInsets.symmetric(vertical: 14),
                ),
                child: Text(
                  type == EntryType.credit ? 'ADD CREDIT ENTRY' : 'RECORD PAYMENT',
                  style: const TextStyle(color: Colors.white, fontWeight: FontWeight.bold),
                ),
              ),
            ),
          ],
        ),
      ),
    );
  }
}
