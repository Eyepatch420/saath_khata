import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:go_router/go_router.dart';
import '../../../../core/constants/app_colors.dart';
import '../../../../core/constants/app_typography.dart';
import '../../../../core/widgets/primary_button.dart';
import '../../../../core/router/app_router.dart';
import '../../../../l10n/app_localizations.dart';
import '../../../../shared/widgets/app_toast.dart';
import '../bloc/auth_bloc.dart';
import '../bloc/auth_event.dart';
import '../bloc/auth_state.dart';

class OtpVerifyScreen extends StatefulWidget {
  final String phone;
  final String role;
  const OtpVerifyScreen({super.key, required this.phone, required this.role});

  @override
  State<OtpVerifyScreen> createState() => _OtpVerifyScreenState();
}

class _OtpVerifyScreenState extends State<OtpVerifyScreen> {
  final List<TextEditingController> _controllers = List.generate(
    6,
    (_) => TextEditingController(),
  );
  final List<FocusNode> _focusNodes = List.generate(6, (_) => FocusNode());

  @override
  void dispose() {
    for (final c in _controllers) {
      c.dispose();
    }
    for (final f in _focusNodes) {
      f.dispose();
    }
    super.dispose();
  }

  String get _otp => _controllers.map((c) => c.text).join();

  void _onDigitChanged(int index, String value) {
    if (value.isNotEmpty && index < 5) {
      _focusNodes[index + 1].requestFocus();
    }
  }

  void _submit(BuildContext context) {
    final otp = _otp;
    final l10n = AppLocalizations.of(context)!;
    if (otp.length != 6) {
      AppToast.show(context, l10n.enterAll6Digits, type: ToastType.warning);
      return;
    }
    context.read<AuthBloc>().add(
      AuthOtpVerifyRequested(phone: widget.phone, otp: otp, role: widget.role),
    );
  }

  void _resend(BuildContext context) {
    final l10n = AppLocalizations.of(context)!;
    for (final c in _controllers) {
      c.clear();
    }
    _focusNodes[0].requestFocus();
    context.read<AuthBloc>().add(AuthOtpSendRequested(phone: widget.phone));
    AppToast.show(context, l10n.resendOtp, type: ToastType.success);
  }

  Widget _buildDigitBox(BuildContext context, int index) {
    final cs = Theme.of(context).colorScheme;
    final isDark = Theme.of(context).brightness == Brightness.dark;

    return KeyboardListener(
      focusNode: FocusNode(),
      onKeyEvent: (event) {
        if (event is KeyDownEvent &&
            event.logicalKey == LogicalKeyboardKey.backspace &&
            _controllers[index].text.isEmpty &&
            index > 0) {
          _controllers[index - 1].clear();
          _focusNodes[index - 1].requestFocus();
        }
      },
      child: ClipRRect(
        borderRadius: BorderRadius.circular(14),
        child: Container(
          width: 52,
          height: 60,
          decoration: BoxDecoration(
            color: cs.surface,
            borderRadius: BorderRadius.circular(14),
            border: Border.all(color: AppColors.primary, width: 1.5),
            boxShadow: isDark
                ? null
                : [
                    BoxShadow(
                      color: Colors.black.withValues(alpha: 0.04),
                      blurRadius: 4,
                      offset: const Offset(0, 2),
                    ),
                  ],
          ),
          child: TextField(
            controller: _controllers[index],
            focusNode: _focusNodes[index],
            textAlign: TextAlign.center,
            keyboardType: TextInputType.number,
            maxLength: 1,
            style: AppTypography.h2.copyWith(color: cs.onSurface),
            inputFormatters: [FilteringTextInputFormatter.digitsOnly],
            decoration: const InputDecoration(
              counterText: '',
              border: InputBorder.none,
              enabledBorder: InputBorder.none,
              focusedBorder: InputBorder.none,
              contentPadding: EdgeInsets.zero,
            ),
            onChanged: (v) => _onDigitChanged(index, v),
          ),
        ),
      ),
    );
  }

  @override
  Widget build(BuildContext context) {
    final l10n = AppLocalizations.of(context)!;
    final isVendor = widget.role == 'vendor';
    final roleColor = isVendor ? AppColors.primary : AppColors.customerAccent;
    final roleLabel = isVendor ? l10n.vendor : l10n.customer;
    final cs = Theme.of(context).colorScheme;

    return BlocConsumer<AuthBloc, AuthState>(
      listener: (context, state) {
        if (state is AuthOtpVerifiedNewUser) {
          context.push(
            AppRouter.profileSetup,
            extra: {'signupToken': state.signupToken, 'phone': state.phone},
          );
        } else if (state is AuthError) {
          AppToast.show(context, state.message, type: ToastType.error);
          for (final c in _controllers) {
            c.clear();
          }
          _focusNodes[0].requestFocus();
        }
      },
      builder: (context, state) {
        final isLoading = state is AuthLoading;
        return Scaffold(
          body: SafeArea(
            child: SingleChildScrollView(
              padding: const EdgeInsets.symmetric(horizontal: 24),
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  const SizedBox(height: 16),
                  GestureDetector(
                    onTap: () => context.pop(),
                    child: Icon(
                      Icons.arrow_back,
                      size: 24,
                      color: cs.onSurface,
                    ),
                  ),
                  const SizedBox(height: 28),
                  // Role badge
                  Container(
                    padding: const EdgeInsets.symmetric(
                      horizontal: 12,
                      vertical: 5,
                    ),
                    decoration: BoxDecoration(
                      color: roleColor.withValues(alpha: 0.12),
                      borderRadius: BorderRadius.circular(8),
                    ),
                    child: Text(
                      roleLabel,
                      style: AppTypography.bodySmall.copyWith(
                        color: roleColor,
                        fontWeight: FontWeight.w600,
                      ),
                    ),
                  ),
                  const SizedBox(height: 16),
                  Text(
                    l10n.enterOtpTitle,
                    style: AppTypography.h1.copyWith(color: cs.onSurface),
                  ),
                  const SizedBox(height: 6),
                  RichText(
                    text: TextSpan(
                      text: '${l10n.sentToLabel}  ',
                      style: AppTypography.bodyMedium.copyWith(
                        color: AppColors.textSecondary,
                      ),
                      children: [
                        TextSpan(
                          text: '+91 ${widget.phone}',
                          style: AppTypography.bodyMedium.copyWith(
                            color: AppColors.primary,
                            fontWeight: FontWeight.w600,
                          ),
                        ),
                      ],
                    ),
                  ),
                  const SizedBox(height: 36),
                  // 6 large square OTP boxes
                  Row(
                    mainAxisAlignment: MainAxisAlignment.spaceBetween,
                    children: List.generate(
                      6,
                      (i) => _buildDigitBox(context, i),
                    ),
                  ),
                  const SizedBox(height: 28),
                  PrimaryButton(
                    label: l10n.verifyButton,
                    isLoading: isLoading,
                    onPressed: isLoading ? null : () => _submit(context),
                  ),
                  const SizedBox(height: 16),
                  Center(
                    child: GestureDetector(
                      onTap: isLoading ? null : () => _resend(context),
                      child: RichText(
                        text: TextSpan(
                          text: "${l10n.noOtpReceived}  ",
                          style: AppTypography.bodySmall.copyWith(
                            color: AppColors.textSecondary,
                          ),
                          children: [
                            TextSpan(
                              text: l10n.resendOtp,
                              style: AppTypography.bodySmall.copyWith(
                                color: AppColors.primary,
                                fontWeight: FontWeight.w600,
                              ),
                            ),
                          ],
                        ),
                      ),
                    ),
                  ),
                  const SizedBox(height: 24),
                ],
              ),
            ),
          ),
        );
      },
    );
  }
}
