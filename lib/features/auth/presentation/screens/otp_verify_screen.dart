import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:go_router/go_router.dart';
import '../../../../core/constants/app_colors.dart';
import '../../../../core/constants/app_typography.dart';
import '../../../../core/widgets/primary_button.dart';
import '../../../../core/router/app_router.dart';
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
  final List<TextEditingController> _controllers =
      List.generate(6, (_) => TextEditingController());
  final List<FocusNode> _focusNodes = List.generate(6, (_) => FocusNode());

  @override
  void dispose() {
    for (final c in _controllers) { c.dispose(); }
    for (final f in _focusNodes) { f.dispose(); }
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
    if (otp.length != 6) {
      AppToast.show(context, 'Enter all 6 digits', type: ToastType.warning);
      return;
    }
    context.read<AuthBloc>().add(
          AuthOtpVerifyRequested(phone: widget.phone, otp: otp),
        );
  }

  void _resend(BuildContext context) {
    for (final c in _controllers) { c.clear(); }
    _focusNodes[0].requestFocus();
    context.read<AuthBloc>().add(AuthOtpSendRequested(phone: widget.phone));
    AppToast.show(context, 'OTP resent', type: ToastType.success);
  }

  Widget _buildDigitBox(int index) {
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
      child: Container(
        width: 52,
        height: 60,
        decoration: BoxDecoration(
          color: AppColors.surface,
          borderRadius: BorderRadius.circular(14),
          border: Border.all(color: AppColors.primary, width: 1.5),
          boxShadow: [
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
          style: AppTypography.h2,
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
    );
  }

  @override
  Widget build(BuildContext context) {
    final isVendor = widget.role == 'vendor';
    final roleColor = isVendor ? AppColors.primary : AppColors.customerAccent;
    final roleLabel = isVendor ? 'Vendor' : 'Customer';

    return BlocConsumer<AuthBloc, AuthState>(
      listener: (context, state) {
        if (state is AuthOtpVerifiedNewUser) {
          context.push(AppRouter.profileSetup, extra: {
            'signupToken': state.signupToken,
            'phone': state.phone,
          });
        } else if (state is AuthError) {
          AppToast.show(context, state.message, type: ToastType.error);
          for (final c in _controllers) { c.clear(); }
          _focusNodes[0].requestFocus();
        }
      },
      builder: (context, state) {
        final isLoading = state is AuthLoading;
        return Scaffold(
          backgroundColor: AppColors.background,
          body: SafeArea(
            child: Padding(
              padding: const EdgeInsets.symmetric(horizontal: 24),
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  const SizedBox(height: 16),
                  // Back button
                  GestureDetector(
                    onTap: () => context.pop(),
                    child: const Icon(Icons.arrow_back, size: 24),
                  ),
                  const SizedBox(height: 28),
                  // Role badge
                  Container(
                    padding: const EdgeInsets.symmetric(horizontal: 12, vertical: 5),
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
                  Text('Enter OTP', style: AppTypography.h1),
                  const SizedBox(height: 6),
                  RichText(
                    text: TextSpan(
                      text: 'Sent to  ',
                      style: AppTypography.bodyMedium
                          .copyWith(color: AppColors.textSecondary),
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
                    children: List.generate(6, _buildDigitBox),
                  ),
                  const SizedBox(height: 28),
                  PrimaryButton(
                    label: 'Verify',
                    isLoading: isLoading,
                    onPressed: isLoading ? null : () => _submit(context),
                  ),
                  const SizedBox(height: 16),
                  Center(
                    child: GestureDetector(
                      onTap: isLoading ? null : () => _resend(context),
                      child: RichText(
                        text: TextSpan(
                          text: "Didn't receive it?  ",
                          style: AppTypography.bodySmall
                              .copyWith(color: AppColors.textSecondary),
                          children: [
                            TextSpan(
                              text: 'Resend OTP',
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
                  const SizedBox(height: 8),
                  Center(
                    child: Text(
                      'For demo: enter 123456',
                      style: AppTypography.bodySmall.copyWith(
                        color: AppColors.textHint,
                        fontStyle: FontStyle.italic,
                      ),
                    ),
                  ),
                  const Spacer(),
                ],
              ),
            ),
          ),
        );
      },
    );
  }
}
