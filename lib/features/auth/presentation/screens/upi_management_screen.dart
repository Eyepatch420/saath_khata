import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import '../../../../core/constants/app_colors.dart';
import '../../../../core/constants/app_typography.dart';
import '../../../../core/di/injection.dart';
import '../../data/models/upi_id_model.dart';
import '../../data/models/user_model.dart';
import '../../domain/repositories/auth_repository.dart';
import '../bloc/auth_bloc.dart';
import '../bloc/auth_event.dart';
import '../../../../shared/widgets/app_toast.dart';

const int _maxUpiIds = 5;

class UpiManagementScreen extends StatefulWidget {
  final UserModel user;
  const UpiManagementScreen({super.key, required this.user});

  @override
  State<UpiManagementScreen> createState() => _UpiManagementScreenState();
}

class _UpiManagementScreenState extends State<UpiManagementScreen> {
  late List<_UpiEntry> _entries;
  bool _isSaving = false;

  @override
  void initState() {
    super.initState();
    _entries = (widget.user.upiIds ?? [])
        .map((u) => _UpiEntry(serverId: u.id, upiId: u.upiId, isPrimary: u.isPrimary))
        .toList();
  }

  void _setPrimary(int index) {
    setState(() {
      for (var i = 0; i < _entries.length; i++) {
        _entries[i] = _entries[i].copyWith(isPrimary: i == index);
      }
    });
  }

  void _delete(int index) {
    setState(() {
      _entries.removeAt(index);
      // If we deleted the primary and there are remaining entries, promote the first
      if (_entries.isNotEmpty && !_entries.any((e) => e.isPrimary)) {
        _entries[0] = _entries[0].copyWith(isPrimary: true);
      }
    });
  }

  void _showAddDialog() {
    final ctrl = TextEditingController();
    showDialog<void>(
      context: context,
      builder: (ctx) => AlertDialog(
        shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(16)),
        title: const Text('Add UPI ID'),
        content: TextField(
          controller: ctrl,
          autofocus: true,
          keyboardType: TextInputType.emailAddress,
          decoration: const InputDecoration(
            hintText: 'yourname@upi',
            prefixIcon: Icon(Icons.account_balance_wallet_outlined),
          ),
        ),
        actions: [
          TextButton(
            onPressed: () => Navigator.pop(ctx),
            child: const Text('Cancel'),
          ),
          TextButton(
            onPressed: () {
              final value = ctrl.text.trim();
              if (!_isValidUpiId(value)) {
                AppToast.show(ctx, 'Invalid UPI ID format (e.g. name@upi)',
                    type: ToastType.error);
                return;
              }
              if (_entries.any((e) => e.upiId == value)) {
                AppToast.show(ctx, 'This UPI ID is already added',
                    type: ToastType.warning);
                return;
              }
              Navigator.pop(ctx);
              setState(() {
                final isFirstEntry = _entries.isEmpty;
                _entries.add(_UpiEntry(
                  upiId: value,
                  isPrimary: isFirstEntry,
                ));
              });
            },
            child: const Text('Add', style: TextStyle(color: AppColors.primary)),
          ),
        ],
      ),
    );
  }

  bool _isValidUpiId(String value) {
    if (value.isEmpty) return false;
    return RegExp(r'^[a-zA-Z0-9._-]+@[a-zA-Z0-9]+$').hasMatch(value);
  }

  Future<void> _save() async {
    setState(() => _isSaving = true);
    try {
      final upiModels = _entries
          .map((e) => UpiIdModel(
                id: e.serverId ?? '',
                upiId: e.upiId,
                isPrimary: e.isPrimary,
              ))
          .toList();

      final updated = await getIt<AuthRepository>().updateProfile(
        upiIds: upiModels,
      );

      if (!mounted) return;
      context.read<AuthBloc>().add(AuthUserUpdated(updated));
      AppToast.show(context, 'UPI IDs saved successfully', type: ToastType.success);
      Navigator.pop(context);
    } on Exception catch (e) {
      if (!mounted) return;
      AppToast.show(
        context,
        e.toString().replaceFirst('Exception: ', ''),
        type: ToastType.error,
      );
    } finally {
      if (mounted) setState(() => _isSaving = false);
    }
  }

  @override
  Widget build(BuildContext context) {
    final canAdd = _entries.length < _maxUpiIds;
    return Scaffold(
      appBar: AppBar(
        title: const Text('My UPI IDs'),
        actions: [
          Padding(
            padding: const EdgeInsets.only(right: 8),
            child: _isSaving
                ? const Center(
                    child: SizedBox(
                      width: 20,
                      height: 20,
                      child: CircularProgressIndicator(strokeWidth: 2),
                    ),
                  )
                : TextButton(
                    onPressed: _save,
                    child: const Text(
                      'Save',
                      style: TextStyle(
                        color: AppColors.primary,
                        fontWeight: FontWeight.w600,
                      ),
                    ),
                  ),
          ),
        ],
      ),
      body: SafeArea(
        child: Column(
          children: [
            Expanded(
              child: _entries.isEmpty
                  ? _EmptyState(onAdd: _showAddDialog)
                  : ListView(
                      padding: const EdgeInsets.symmetric(
                          horizontal: 20, vertical: 16),
                      children: [
                        Text(
                          'PRIMARY UPI ID',
                          style: AppTypography.bodySmall.copyWith(
                            color: AppColors.textHint,
                            fontWeight: FontWeight.w600,
                            letterSpacing: 0.8,
                          ),
                        ),
                        const SizedBox(height: 8),
                        Text(
                          'The primary ID is shared with customers for payment. '
                          'Tap the star to switch which one is primary.',
                          style: AppTypography.bodySmall
                              .copyWith(color: AppColors.textSecondary),
                        ),
                        const SizedBox(height: 16),
                        ...List.generate(_entries.length, (i) {
                          final entry = _entries[i];
                          return _UpiIdTile(
                            entry: entry,
                            onSetPrimary: () => _setPrimary(i),
                            onDelete: _entries.length == 1
                                ? null // prevent deleting the last entry if desired
                                : () => _delete(i),
                          );
                        }),
                        const SizedBox(height: 8),
                        Text(
                          '${_entries.length} / $_maxUpiIds UPI IDs',
                          style: AppTypography.bodySmall.copyWith(
                            color: canAdd
                                ? AppColors.textSecondary
                                : AppColors.error,
                          ),
                          textAlign: TextAlign.center,
                        ),
                      ],
                    ),
            ),
            if (canAdd)
              Padding(
                padding: EdgeInsets.fromLTRB(
                  20,
                  8,
                  20,
                  MediaQuery.of(context).viewPadding.bottom + 20,
                ),
                child: SizedBox(
                  width: double.infinity,
                  child: OutlinedButton.icon(
                    onPressed: _showAddDialog,
                    icon: const Icon(Icons.add_rounded),
                    label: const Text('Add UPI ID'),
                    style: OutlinedButton.styleFrom(
                      foregroundColor: AppColors.primary,
                      side: const BorderSide(color: AppColors.primary),
                      padding: const EdgeInsets.symmetric(vertical: 14),
                      shape: RoundedRectangleBorder(
                          borderRadius: BorderRadius.circular(12)),
                    ),
                  ),
                ),
              ),
          ],
        ),
      ),
    );
  }
}

// ── Local state entry (independent of the server model) ──────────────────────

class _UpiEntry {
  final String? serverId;
  final String upiId;
  final bool isPrimary;

  const _UpiEntry({
    this.serverId,
    required this.upiId,
    required this.isPrimary,
  });

  _UpiEntry copyWith({bool? isPrimary}) => _UpiEntry(
        serverId: serverId,
        upiId: upiId,
        isPrimary: isPrimary ?? this.isPrimary,
      );
}

// ── Tile ─────────────────────────────────────────────────────────────────────

class _UpiIdTile extends StatelessWidget {
  final _UpiEntry entry;
  final VoidCallback onSetPrimary;
  final VoidCallback? onDelete;

  const _UpiIdTile({
    required this.entry,
    required this.onSetPrimary,
    required this.onDelete,
  });

  @override
  Widget build(BuildContext context) {
    return Container(
      margin: const EdgeInsets.only(bottom: 10),
      decoration: BoxDecoration(
        color: Theme.of(context).colorScheme.surface,
        borderRadius: BorderRadius.circular(12),
        border: entry.isPrimary
            ? Border.all(color: AppColors.primary, width: 1.5)
            : null,
      ),
      child: ListTile(
        contentPadding:
            const EdgeInsets.symmetric(horizontal: 16, vertical: 4),
        leading: GestureDetector(
          onTap: entry.isPrimary ? null : onSetPrimary,
          child: Tooltip(
            message: entry.isPrimary ? 'Primary UPI ID' : 'Set as primary',
            child: Icon(
              entry.isPrimary ? Icons.star_rounded : Icons.star_outline_rounded,
              color: entry.isPrimary ? Colors.amber : AppColors.textHint,
              size: 26,
            ),
          ),
        ),
        title: Text(
          entry.upiId,
          style: AppTypography.bodyLarge.copyWith(
            fontWeight:
                entry.isPrimary ? FontWeight.w600 : FontWeight.normal,
          ),
        ),
        subtitle: entry.isPrimary
            ? Text(
                'Primary',
                style: AppTypography.bodySmall
                    .copyWith(color: AppColors.primary),
              )
            : null,
        trailing: onDelete != null
            ? IconButton(
                icon: const Icon(Icons.delete_outline_rounded,
                    color: AppColors.error),
                onPressed: onDelete,
                tooltip: 'Remove',
              )
            : null,
      ),
    );
  }
}

// ── Empty state ───────────────────────────────────────────────────────────────

class _EmptyState extends StatelessWidget {
  final VoidCallback onAdd;
  const _EmptyState({required this.onAdd});

  @override
  Widget build(BuildContext context) {
    return Center(
      child: Padding(
        padding: const EdgeInsets.all(32),
        child: Column(
          mainAxisSize: MainAxisSize.min,
          children: [
            Icon(Icons.account_balance_wallet_outlined,
                size: 64, color: AppColors.textHint),
            const SizedBox(height: 16),
            Text(
              'No UPI IDs yet',
              style: AppTypography.h3.copyWith(color: AppColors.textSecondary),
            ),
            const SizedBox(height: 8),
            Text(
              'Add up to 5 UPI IDs. Your primary ID will be shared with customers for payment.',
              style: AppTypography.bodyMedium
                  .copyWith(color: AppColors.textHint),
              textAlign: TextAlign.center,
            ),
            const SizedBox(height: 24),
            ElevatedButton.icon(
              onPressed: onAdd,
              icon: const Icon(Icons.add_rounded, color: Colors.white),
              label: const Text('Add UPI ID',
                  style: TextStyle(color: Colors.white)),
              style: ElevatedButton.styleFrom(
                backgroundColor: AppColors.primary,
                padding: const EdgeInsets.symmetric(
                    horizontal: 24, vertical: 12),
                shape: RoundedRectangleBorder(
                    borderRadius: BorderRadius.circular(12)),
              ),
            ),
          ],
        ),
      ),
    );
  }
}
