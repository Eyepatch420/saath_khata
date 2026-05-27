import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import '../../../../core/constants/app_colors.dart';
import '../../../../core/constants/app_typography.dart';
import '../../../../l10n/app_localizations.dart';

class UpiPaymentScreen extends StatefulWidget {
  final double amount;
  final String recipientName;
  final String? upiId;

  const UpiPaymentScreen({
    super.key,
    required this.amount,
    required this.recipientName,
    this.upiId,
  });

  @override
  State<UpiPaymentScreen> createState() => _UpiPaymentScreenState();
}

class _UpiPaymentScreenState extends State<UpiPaymentScreen> {
  bool _isProcessing = false;
  bool _isSuccess = false;
  bool _isFailed = false;
  final _upiCtrl = TextEditingController();
  final _noteCtrl = TextEditingController();

  @override
  void initState() {
    super.initState();
    if (widget.upiId != null) _upiCtrl.text = widget.upiId!;
  }

  @override
  void dispose() {
    _upiCtrl.dispose();
    _noteCtrl.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    if (_isSuccess) return _SuccessView(amount: widget.amount, recipient: widget.recipientName);
    if (_isFailed) return _FailureView(onRetry: _reset);

    final l10n = AppLocalizations.of(context)!;
    return Scaffold(
      appBar: AppBar(title: Text(l10n.upiPayment)),
      body: SingleChildScrollView(
        padding: const EdgeInsets.all(24),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.center,
          children: [
            const SizedBox(height: 16),
            _AmountDisplay(amount: widget.amount, recipient: widget.recipientName),
            const SizedBox(height: 32),
            _UpiAppsRow(onAppSelected: _onUpiAppSelected),
            const SizedBox(height: 32),
            const _OrDivider(),
            const SizedBox(height: 24),
            TextField(
              controller: _upiCtrl,
              keyboardType: TextInputType.emailAddress,
              decoration: InputDecoration(
                labelText: l10n.enterUpiId,
                hintText: 'name@upi',
                prefixIcon: const Icon(Icons.account_balance_rounded),
              ),
            ),
            const SizedBox(height: 16),
            TextField(
              controller: _noteCtrl,
              decoration: InputDecoration(
                labelText: l10n.addNoteOptional,
                prefixIcon: const Icon(Icons.note_rounded),
              ),
            ),
            const SizedBox(height: 32),
            SizedBox(
              width: double.infinity,
              child: ElevatedButton(
                onPressed: _isProcessing ? null : _initiatePayment,
                style: ElevatedButton.styleFrom(
                  backgroundColor: AppColors.primary,
                  padding: const EdgeInsets.symmetric(vertical: 16),
                  shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(12)),
                ),
                child: _isProcessing
                    ? const SizedBox(
                        width: 20,
                        height: 20,
                        child: CircularProgressIndicator(color: Colors.white, strokeWidth: 2),
                      )
                    : Text(
                        l10n.payAmountButton(widget.amount.toStringAsFixed(0)),
                        style: const TextStyle(
                          color: Colors.white,
                          fontWeight: FontWeight.bold,
                          fontSize: 16,
                        ),
                      ),
              ),
            ),
            const SizedBox(height: 16),
            Row(
              mainAxisAlignment: MainAxisAlignment.center,
              children: [
                const Icon(Icons.lock_rounded, size: 14, color: AppColors.textHint),
                const SizedBox(width: 6),
                Text(
                  AppLocalizations.of(context)!.securedByUpi,
                  style: AppTypography.bodySmall.copyWith(color: AppColors.textHint),
                ),
              ],
            ),
          ],
        ),
      ),
    );
  }

  void _onUpiAppSelected(String app) {
    HapticFeedback.lightImpact();
    ScaffoldMessenger.of(context).showSnackBar(
      SnackBar(
        content: Text(AppLocalizations.of(context)!.upiAppComingSoon(app)),
        duration: const Duration(seconds: 2),
      ),
    );
  }

  Future<void> _initiatePayment() async {
    if (_upiCtrl.text.trim().isEmpty) {
      ScaffoldMessenger.of(context).showSnackBar(
        SnackBar(content: Text(AppLocalizations.of(context)!.pleaseEnterUpiId)),
      );
      return;
    }
    setState(() => _isProcessing = true);
    await Future.delayed(const Duration(seconds: 2));
    if (!mounted) return;
    setState(() {
      _isProcessing = false;
      _isSuccess = true;
    });
  }

  void _reset() => setState(() {
        _isFailed = false;
        _isSuccess = false;
        _isProcessing = false;
      });
}

class _AmountDisplay extends StatelessWidget {
  final double amount;
  final String recipient;

  const _AmountDisplay({required this.amount, required this.recipient});

  @override
  Widget build(BuildContext context) {
    return Column(
      children: [
        Container(
          width: 64,
          height: 64,
          decoration: BoxDecoration(
            color: AppColors.primary.withValues(alpha: 0.1),
            shape: BoxShape.circle,
          ),
          child: const Icon(Icons.person_rounded, color: AppColors.primary, size: 32),
        ),
        const SizedBox(height: 12),
        Text(recipient, style: AppTypography.labelLarge),
        const SizedBox(height: 16),
        Text(
          '₹${amount.toStringAsFixed(0)}',
          style: AppTypography.h3.copyWith(fontSize: 40, fontWeight: FontWeight.bold),
        ),
        const SizedBox(height: 4),
        Text(AppLocalizations.of(context)!.amountToPay, style: AppTypography.bodySmall.copyWith(color: AppColors.textHint)),
      ],
    );
  }
}

class _UpiAppsRow extends StatelessWidget {
  final void Function(String app) onAppSelected;
  const _UpiAppsRow({required this.onAppSelected});

  @override
  Widget build(BuildContext context) {
    final apps = [
      (name: 'GPay', icon: Icons.g_mobiledata_rounded, color: const Color(0xFF4285F4)),
      (name: 'PhonePe', icon: Icons.phone_android_rounded, color: const Color(0xFF5F259F)),
      (name: 'Paytm', icon: Icons.account_balance_wallet_rounded, color: const Color(0xFF00BAF2)),
      (name: 'BHIM', icon: Icons.currency_rupee_rounded, color: const Color(0xFF0C3860)),
    ];

    return Row(
      mainAxisAlignment: MainAxisAlignment.spaceEvenly,
      children: apps.map((app) {
        return GestureDetector(
          onTap: () => onAppSelected(app.name),
          child: Column(
            children: [
              Container(
                width: 56,
                height: 56,
                decoration: BoxDecoration(
                  color: app.color.withValues(alpha: 0.1),
                  borderRadius: BorderRadius.circular(14),
                  border: Border.all(color: app.color.withValues(alpha: 0.2)),
                ),
                child: Icon(app.icon, color: app.color, size: 28),
              ),
              const SizedBox(height: 6),
              Text(app.name, style: AppTypography.bodySmall.copyWith(fontSize: 11)),
            ],
          ),
        );
      }).toList(),
    );
  }
}

class _OrDivider extends StatelessWidget {
  const _OrDivider();

  @override
  Widget build(BuildContext context) {
    return Row(
      children: [
        const Expanded(child: Divider()),
        Padding(
          padding: const EdgeInsets.symmetric(horizontal: 16),
          child: Text(AppLocalizations.of(context)!.orDivider,
              style: AppTypography.bodySmall.copyWith(color: AppColors.textHint)),
        ),
        const Expanded(child: Divider()),
      ],
    );
  }
}

class _SuccessView extends StatelessWidget {
  final double amount;
  final String recipient;
  const _SuccessView({required this.amount, required this.recipient});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Center(
        child: Padding(
          padding: const EdgeInsets.all(32),
          child: Column(
            mainAxisAlignment: MainAxisAlignment.center,
            children: [
              Container(
                width: 96,
                height: 96,
                decoration: const BoxDecoration(
                  color: AppColors.success,
                  shape: BoxShape.circle,
                ),
                child: const Icon(Icons.check_rounded, color: Colors.white, size: 52),
              ),
              const SizedBox(height: 24),
              Text(AppLocalizations.of(context)!.paymentSuccessful, style: AppTypography.h3),
              const SizedBox(height: 8),
              Text(
                AppLocalizations.of(context)!.paidToRecipient(amount.toStringAsFixed(0), recipient),
                style: AppTypography.bodySmall.copyWith(color: AppColors.textSecondary),
                textAlign: TextAlign.center,
              ),
              const SizedBox(height: 40),
              SizedBox(
                width: double.infinity,
                child: ElevatedButton(
                  onPressed: () => Navigator.pop(context, true),
                  style: ElevatedButton.styleFrom(
                    backgroundColor: AppColors.primary,
                    padding: const EdgeInsets.symmetric(vertical: 14),
                    shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(12)),
                  ),
                  child: Text(AppLocalizations.of(context)!.done,
                      style: const TextStyle(color: Colors.white, fontWeight: FontWeight.bold)),
                ),
              ),
            ],
          ),
        ),
      ),
    );
  }
}

class _FailureView extends StatelessWidget {
  final VoidCallback onRetry;
  const _FailureView({required this.onRetry});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Center(
        child: Padding(
          padding: const EdgeInsets.all(32),
          child: Column(
            mainAxisAlignment: MainAxisAlignment.center,
            children: [
              Container(
                width: 96,
                height: 96,
                decoration: BoxDecoration(
                  color: AppColors.error.withValues(alpha: 0.1),
                  shape: BoxShape.circle,
                ),
                child: const Icon(Icons.error_outline_rounded, color: AppColors.error, size: 52),
              ),
              const SizedBox(height: 24),
              Text(AppLocalizations.of(context)!.paymentFailed, style: AppTypography.h3),
              const SizedBox(height: 8),
              Text(
                AppLocalizations.of(context)!.paymentSomethingWentWrong,
                style: AppTypography.bodySmall.copyWith(color: AppColors.textSecondary),
                textAlign: TextAlign.center,
              ),
              const SizedBox(height: 40),
              Row(
                children: [
                  Expanded(
                    child: OutlinedButton(
                      onPressed: () => Navigator.pop(context, false),
                      style: OutlinedButton.styleFrom(
                        padding: const EdgeInsets.symmetric(vertical: 14),
                      ),
                      child: Text(AppLocalizations.of(context)!.cancel),
                    ),
                  ),
                  const SizedBox(width: 12),
                  Expanded(
                    child: ElevatedButton(
                      onPressed: onRetry,
                      style: ElevatedButton.styleFrom(
                        backgroundColor: AppColors.primary,
                        padding: const EdgeInsets.symmetric(vertical: 14),
                        shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(12)),
                      ),
                      child: Text(AppLocalizations.of(context)!.retryPayment,
                          style: const TextStyle(color: Colors.white)),
                    ),
                  ),
                ],
              ),
            ],
          ),
        ),
      ),
    );
  }
}
