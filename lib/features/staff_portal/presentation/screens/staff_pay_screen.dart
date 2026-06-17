import 'dart:io';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:image_picker/image_picker.dart';
import 'package:intl/intl.dart';
import '../../../../core/constants/app_colors.dart';
import '../../../../core/constants/app_typography.dart';
import '../../../../core/di/injection.dart';
import '../../../../shared/widgets/app_toast.dart';
import '../../../../shared/widgets/error_state_widget.dart';
import '../../../auth/presentation/bloc/auth_bloc.dart';
import '../../../auth/presentation/bloc/auth_event.dart';
import '../../data/staff_portal_repository.dart';
import '../../domain/models/staff_self.dart';
import '../cubit/staff_portal_cubit.dart';

class StaffPayScreen extends StatelessWidget {
  const StaffPayScreen({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text('My Pay'),
        actions: [
          IconButton(
            onPressed: () => _confirmLogout(context),
            icon: const Icon(Icons.logout_rounded),
            tooltip: 'Log out',
          ),
        ],
      ),
      body: SafeArea(
        child: BlocBuilder<StaffPortalCubit, StaffPortalState>(
          builder: (context, state) {
            if (state.loading) {
              return const Center(child: CircularProgressIndicator());
            }
            if (state.error != null) {
              return ErrorStateWidget(
                message: state.error!,
                onRetry: () => context.read<StaffPortalCubit>().load(),
              );
            }
            final me = state.me;
            if (me == null) return const SizedBox();
            return RefreshIndicator(
              onRefresh: () => context.read<StaffPortalCubit>().load(),
              child: ListView(
                padding: EdgeInsets.fromLTRB(
                    16, 16, 16, MediaQuery.of(context).padding.bottom + 16),
                children: [
                  _PaySummary(me: me),
                  const SizedBox(height: 16),
                  _QrCard(me: me),
                  const SizedBox(height: 24),
                  Text('Payment History', style: AppTypography.h3),
                  const SizedBox(height: 8),
                  const _SalaryHistory(),
                ],
              ),
            );
          },
        ),
      ),
    );
  }

  void _confirmLogout(BuildContext context) {
    showDialog(
      context: context,
      useRootNavigator: true,
      builder: (ctx) => AlertDialog(
        title: const Text('Log out'),
        content: const Text('Are you sure you want to log out?'),
        actions: [
          TextButton(
            onPressed: () => Navigator.of(ctx, rootNavigator: true).pop(),
            child: const Text('Cancel'),
          ),
          TextButton(
            onPressed: () {
              Navigator.of(ctx, rootNavigator: true).pop();
              context.read<AuthBloc>().add(const AuthLogoutRequested());
            },
            child: const Text('Log out',
                style: TextStyle(color: AppColors.error)),
          ),
        ],
      ),
    );
  }
}

class _PaySummary extends StatelessWidget {
  final StaffSelfInfo me;
  const _PaySummary({required this.me});

  @override
  Widget build(BuildContext context) {
    final surface = Theme.of(context).colorScheme.surface;
    return Container(
      padding: const EdgeInsets.all(20),
      decoration: BoxDecoration(
        color: surface,
        borderRadius: BorderRadius.circular(16),
      ),
      child: Column(
        children: [
          Text(me.name, style: AppTypography.h3),
          Text('${me.role} · ${me.salaryType} ₹${me.salaryAmount.toStringAsFixed(0)}',
              style: AppTypography.bodySmall
                  .copyWith(color: AppColors.textSecondary)),
          const SizedBox(height: 16),
          Row(
            children: [
              Expanded(
                child: _Stat(
                  label: 'Unpaid salary',
                  value: '₹${me.unpaidSalary.toStringAsFixed(0)}',
                  color: AppColors.success,
                ),
              ),
              Expanded(
                child: _Stat(
                  label: 'Advance taken',
                  value: '₹${me.advanceTaken.toStringAsFixed(0)}',
                  color: AppColors.error,
                ),
              ),
            ],
          ),
        ],
      ),
    );
  }
}

class _Stat extends StatelessWidget {
  final String label;
  final String value;
  final Color color;
  const _Stat({required this.label, required this.value, required this.color});

  @override
  Widget build(BuildContext context) {
    return Column(
      children: [
        Text(value, style: AppTypography.h3.copyWith(color: color)),
        const SizedBox(height: 2),
        Text(label,
            style:
                AppTypography.bodySmall.copyWith(color: AppColors.textHint)),
      ],
    );
  }
}

class _QrCard extends StatefulWidget {
  final StaffSelfInfo me;
  const _QrCard({required this.me});

  @override
  State<_QrCard> createState() => _QrCardState();
}

class _QrCardState extends State<_QrCard> {
  bool _uploading = false;

  Future<void> _pickAndUpload() async {
    final cubit = context.read<StaffPortalCubit>();
    final picker = ImagePicker();
    final picked = await picker.pickImage(
      source: ImageSource.gallery,
      maxWidth: 1200,
      imageQuality: 90,
    );
    if (picked == null) return;
    setState(() => _uploading = true);
    final err = await cubit.uploadQr(File(picked.path));
    if (!mounted) return;
    setState(() => _uploading = false);
    AppToast.show(
      context,
      err ?? 'QR uploaded',
      type: err == null ? ToastType.success : ToastType.error,
    );
  }

  void _showQr(String url) {
    showDialog(
      context: context,
      useRootNavigator: true,
      builder: (dialogCtx) => Dialog(
        child: Padding(
          padding: const EdgeInsets.all(20),
          child: Column(
            mainAxisSize: MainAxisSize.min,
            children: [
              Text('Scan to pay ${widget.me.name}',
                  style: AppTypography.labelLarge),
              const SizedBox(height: 16),
              ClipRRect(
                borderRadius: BorderRadius.circular(12),
                child: Image.network(url, fit: BoxFit.contain,
                    errorBuilder: (_, e, s) => const Padding(
                          padding: EdgeInsets.all(40),
                          child: Icon(Icons.broken_image_rounded, size: 48),
                        )),
              ),
              const SizedBox(height: 12),
              TextButton(
                onPressed: () =>
                    Navigator.of(dialogCtx, rootNavigator: true).pop(),
                child: const Text('Close'),
              ),
            ],
          ),
        ),
      ),
    );
  }

  @override
  Widget build(BuildContext context) {
    final qr = widget.me.qrCodeUrl;
    final surface = Theme.of(context).colorScheme.surface;
    return Container(
      padding: const EdgeInsets.all(16),
      decoration: BoxDecoration(
        color: surface,
        borderRadius: BorderRadius.circular(16),
      ),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Row(
            children: [
              const Icon(Icons.qr_code_2_rounded, color: AppColors.primary),
              const SizedBox(width: 10),
              Text('My Payment QR', style: AppTypography.labelLarge),
            ],
          ),
          const SizedBox(height: 4),
          Text(
            'Show this QR to a customer to collect payment directly to you.',
            style:
                AppTypography.bodySmall.copyWith(color: AppColors.textSecondary),
          ),
          const SizedBox(height: 14),
          Row(
            children: [
              Expanded(
                child: OutlinedButton.icon(
                  onPressed: qr == null ? null : () => _showQr(qr),
                  icon: const Icon(Icons.visibility_rounded, size: 18),
                  label: const Text('Show my QR'),
                ),
              ),
              const SizedBox(width: 12),
              Expanded(
                child: ElevatedButton.icon(
                  onPressed: _uploading ? null : _pickAndUpload,
                  style: ElevatedButton.styleFrom(
                    backgroundColor: AppColors.primary,
                    foregroundColor: Colors.white,
                  ),
                  icon: _uploading
                      ? const SizedBox(
                          width: 16,
                          height: 16,
                          child: CircularProgressIndicator(
                              strokeWidth: 2, color: Colors.white),
                        )
                      : const Icon(Icons.upload_rounded, size: 18),
                  label: Text(qr == null ? 'Upload QR' : 'Replace'),
                ),
              ),
            ],
          ),
        ],
      ),
    );
  }
}

class _SalaryHistory extends StatefulWidget {
  const _SalaryHistory();

  @override
  State<_SalaryHistory> createState() => _SalaryHistoryState();
}

class _SalaryHistoryState extends State<_SalaryHistory> {
  late Future<List<StaffPayTransaction>> _future;

  @override
  void initState() {
    super.initState();
    _future = getIt<StaffPortalRepository>().getMySalaryHistory();
  }

  @override
  Widget build(BuildContext context) {
    return FutureBuilder<List<StaffPayTransaction>>(
      future: _future,
      builder: (context, snapshot) {
        if (snapshot.connectionState == ConnectionState.waiting) {
          return const Padding(
            padding: EdgeInsets.all(24),
            child: Center(child: CircularProgressIndicator()),
          );
        }
        final txs = snapshot.data ?? [];
        if (txs.isEmpty) {
          return Padding(
            padding: const EdgeInsets.symmetric(vertical: 24),
            child: Center(
              child: Text('No payments yet',
                  style: AppTypography.bodyMedium
                      .copyWith(color: AppColors.textHint)),
            ),
          );
        }
        return Column(
          children: txs.map((t) {
            final isSalary = t.type == 'salary';
            return Container(
              margin: const EdgeInsets.only(bottom: 10),
              padding: const EdgeInsets.all(14),
              decoration: BoxDecoration(
                color: Theme.of(context).colorScheme.surface,
                borderRadius: BorderRadius.circular(12),
              ),
              child: Row(
                children: [
                  Icon(
                    isSalary
                        ? Icons.account_balance_wallet_rounded
                        : Icons.south_west_rounded,
                    color: isSalary ? AppColors.success : AppColors.error,
                    size: 20,
                  ),
                  const SizedBox(width: 12),
                  Expanded(
                    child: Column(
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children: [
                        Text(isSalary ? 'Salary' : 'Advance',
                            style: AppTypography.labelLarge),
                        Text(
                          DateFormat('d MMM yyyy').format(t.createdAt),
                          style: AppTypography.bodySmall
                              .copyWith(color: AppColors.textHint),
                        ),
                      ],
                    ),
                  ),
                  Text(
                    '${isSalary ? '+' : '−'} ₹${t.amount.toStringAsFixed(0)}',
                    style: AppTypography.labelLarge.copyWith(
                        color: isSalary ? AppColors.success : AppColors.error),
                  ),
                ],
              ),
            );
          }).toList(),
        );
      },
    );
  }
}
