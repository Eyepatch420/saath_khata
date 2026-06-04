import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:go_router/go_router.dart';
import '../../../../l10n/app_localizations.dart';
import '../../../../core/constants/app_colors.dart';
import '../../../../core/constants/app_typography.dart';
import '../../../../core/router/app_router.dart';
import '../../../../core/widgets/primary_button.dart';
import '../../../../core/widgets/custom_text_field.dart';
import '../bloc/auth_bloc.dart';
import '../bloc/auth_event.dart';
import '../bloc/auth_state.dart';
import '../../../../shared/widgets/app_toast.dart';

class LoginScreen extends StatefulWidget {
  const LoginScreen({super.key});

  @override
  State<LoginScreen> createState() => _LoginScreenState();
}

class _LoginScreenState extends State<LoginScreen> {
  final _emailController = TextEditingController();
  final _passwordController = TextEditingController();
  bool _obscurePassword = true;

  @override
  void dispose() {
    _emailController.dispose();
    _passwordController.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    final l10n = AppLocalizations.of(context)!;
    final role = GoRouterState.of(context).extra as String? ?? 'vendor';

    // Uses the top-level AuthBloc provided in main.dart
    return BlocConsumer<AuthBloc, AuthState>(
      listener: (context, state) {
        if (state is AuthAuthenticated) {
          context.go(
            state.user.isVendor ? AppRouter.vendorHome : AppRouter.customerHome,
          );
        } else if (state is AuthError) {
          AppToast.show(context, state.message, type: ToastType.error);
        }
      },
      builder: (context, state) {
        final isLoading = state is AuthLoading;

        return Scaffold(
          appBar: AppBar(
            elevation: 0,
            backgroundColor: Colors.transparent,
          ),
          body: SafeArea(child: SingleChildScrollView(
            padding: const EdgeInsets.all(24.0),
            keyboardDismissBehavior: ScrollViewKeyboardDismissBehavior.onDrag,
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Row(
                  children: [
                    Container(
                      padding: const EdgeInsets.symmetric(
                          horizontal: 10, vertical: 4),
                      decoration: BoxDecoration(
                        color: (role == 'vendor'
                                ? AppColors.primary
                                : AppColors.customerAccent)
                            .withValues(alpha: 0.12),
                        borderRadius: BorderRadius.circular(8),
                      ),
                      child: Text(
                        role == 'vendor' ? 'Vendor' : 'Customer',
                        style: AppTypography.bodySmall.copyWith(
                          color: role == 'vendor'
                              ? AppColors.primary
                              : AppColors.customerAccent,
                          fontWeight: FontWeight.w600,
                        ),
                      ),
                    ),
                  ],
                ),
                const SizedBox(height: 12),
                Text(l10n.loginTitle, style: AppTypography.h1),
                const SizedBox(height: 8),
                Text(
                  'Enter your email and password to continue.',
                  style: AppTypography.bodyMedium
                      .copyWith(color: AppColors.textSecondary),
                ),
                const SizedBox(height: 40),
                CustomTextField(
                  label: l10n.email,
                  hintText: 'you@example.com',
                  prefixIcon: Icons.email_rounded,
                  controller: _emailController,
                  keyboardType: TextInputType.emailAddress,
                ),
                const SizedBox(height: 20),
                CustomTextField(
                  label: l10n.password,
                  hintText: l10n.passwordHint,
                  prefixIcon: Icons.lock_rounded,
                  controller: _passwordController,
                  obscureText: _obscurePassword,
                  suffixIcon: IconButton(
                    icon: Icon(
                      _obscurePassword
                          ? Icons.visibility_off_rounded
                          : Icons.visibility_rounded,
                      color: AppColors.textHint,
                    ),
                    onPressed: () =>
                        setState(() => _obscurePassword = !_obscurePassword),
                  ),
                ),
                const SizedBox(height: 32),
                PrimaryButton(
                  label: l10n.loginButton,
                  isLoading: isLoading,
                  onPressed: isLoading
                      ? null
                      : () {
                          final email = _emailController.text.trim();
                          final password = _passwordController.text;
                          if (email.isEmpty || password.isEmpty) {
                            AppToast.show(context, l10n.pleaseEnterCredentials, type: ToastType.warning);
                            return;
                          }
                          context.read<AuthBloc>().add(
                                AuthLoginRequested(
                                  email: email,
                                  password: password,
                                  role: role,
                                ),
                              );
                        },
                ),
                const SizedBox(height: 16),
                Center(
                  child: TextButton(
                    onPressed: isLoading
                        ? null
                        : () =>
                            context.push(AppRouter.profileSetup, extra: role),
                    child: RichText(
                      text: TextSpan(
                        text: '${l10n.noAccount} ',
                        style: AppTypography.bodyMedium
                            .copyWith(color: AppColors.textSecondary),
                        children: [
                          TextSpan(
                            text: l10n.signUp,
                            style: AppTypography.bodyMedium.copyWith(
                              color: AppColors.primary,
                              fontWeight: FontWeight.bold,
                            ),
                          ),
                        ],
                      ),
                    ),
                  ),
                ),
                const SizedBox(height: 8),
              ],
            ),
          ),
          ),
        );
      },
    );
  }
}
