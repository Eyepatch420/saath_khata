import 'dart:ui' show ImageFilter;
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:go_router/go_router.dart';
import 'package:provider/provider.dart';
import '../../../../core/constants/app_colors.dart';
import '../../../../core/constants/app_typography.dart';
import '../../../../core/localization/locale_provider.dart';
import '../../../../core/network/api_endpoints.dart';
import '../../../../core/router/app_router.dart';
import '../../../../l10n/app_localizations.dart';
import '../../../auth/data/models/user_model.dart';
import '../../../auth/presentation/bloc/auth_bloc.dart';
import '../../../auth/presentation/bloc/auth_event.dart';
import '../../../auth/presentation/bloc/auth_state.dart';

class SettingsScreen extends StatelessWidget {
  const SettingsScreen({super.key});

  @override
  Widget build(BuildContext context) {
    final l10n = AppLocalizations.of(context)!;
    final localeProvider = Provider.of<LocaleProvider>(context);
    final currentLang =
        localeProvider.locale.languageCode == 'hi' ? 'हिंदी' : 'English';

    return Scaffold(
      appBar: AppBar(title: Text(l10n.settings)),
      body: SafeArea(
        child: SingleChildScrollView(
          padding: EdgeInsets.fromLTRB(
              20, 20, 20, MediaQuery.of(context).viewPadding.bottom + 96),
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.stretch,
            children: [
              const _ProfileHeader(),
              const SizedBox(height: 24),
              _SectionLabel(label: l10n.accountSettings),
              const SizedBox(height: 8),
              _SettingsTile(
                icon: Icons.person_outline_rounded,
                title: l10n.editProfile,
                subtitle: 'Update your name, photo and details',
                onTap: () {
                  final authState = context.read<AuthBloc>().state;
                  if (authState is AuthAuthenticated) {
                    context.push(AppRouter.editProfile,
                        extra: authState.user);
                  }
                },
              ),
              _SettingsTile(
                icon: Icons.lock_outline_rounded,
                title: l10n.changePassword,
                subtitle: 'Update your account password',
                onTap: () => context.push(AppRouter.changePassword),
              ),
              _SettingsTile(
                icon: Icons.language_rounded,
                title: l10n.appLanguage,
                subtitle: currentLang,
                onTap: () => _showLanguagePicker(context, l10n, localeProvider),
              ),
              _SettingsTile(
                icon: Icons.account_balance_wallet_rounded,
                title: l10n.myUpiIds,
                subtitle: l10n.settingsManagePayments,
                onTap: () {
                  final authState = context.read<AuthBloc>().state;
                  if (authState is AuthAuthenticated) {
                    context.push(AppRouter.upiManagement,
                        extra: authState.user);
                  }
                },
              ),
              _SettingsTile(
                icon: Icons.workspace_premium_rounded,
                title: 'Membership Tiers',
                subtitle: 'Rename tiers and set member discounts',
                onTap: () => context.push(AppRouter.membershipTiers),
              ),
              _SettingsTile(
                icon: Icons.help_outline_rounded,
                title: l10n.helpSupport,
                subtitle: l10n.settingsFaqsContact,
                onTap: () {},
              ),
              const SizedBox(height: 12),
              _SectionLabel(label: l10n.legalInfo),
              const SizedBox(height: 8),
              _SettingsTile(
                icon: Icons.description_outlined,
                title: l10n.termsAndConditions,
                subtitle: 'Read our terms of service',
                onTap: () => context.push(
                  AppRouter.policy,
                  extra: {
                    'title': l10n.termsAndConditions,
                    'endpoint': ApiEndpoints.termsAndConditions,
                  },
                ),
              ),
              _SettingsTile(
                icon: Icons.privacy_tip_outlined,
                title: l10n.privacyPolicy,
                subtitle: 'How we handle your data',
                onTap: () => context.push(
                  AppRouter.policy,
                  extra: {
                    'title': l10n.privacyPolicy,
                    'endpoint': ApiEndpoints.privacyPolicy,
                  },
                ),
              ),
              const SizedBox(height: 32),
              BlocBuilder<AuthBloc, AuthState>(
                builder: (context, state) {
                  final isLoggingOut = state is AuthLoading;
                  return TextButton(
                    onPressed: isLoggingOut
                        ? null
                        : () => _confirmLogout(context, l10n),
                    child: isLoggingOut
                        ? const SizedBox(
                            height: 20,
                            width: 20,
                            child:
                                CircularProgressIndicator(strokeWidth: 2),
                          )
                        : Text(
                            l10n.logout,
                            style: const TextStyle(
                              color: AppColors.error,
                              fontWeight: FontWeight.bold,
                            ),
                          ),
                  );
                },
              ),
              const SizedBox(height: 8),
              Text(l10n.settingsVersion('1.0.0'),
                  style: AppTypography.bodySmall,
                  textAlign: TextAlign.center),
            ],
          ),
        ),
      ),
    );
  }

  void _confirmLogout(BuildContext context, AppLocalizations l10n) {
    showDialog(
      context: context,
      builder: (ctx) => AlertDialog(
        title: Text(l10n.logout),
        content: const Text('Are you sure you want to log out?'),
        actions: [
          TextButton(
            onPressed: () => Navigator.pop(ctx),
            child: const Text('Cancel'),
          ),
          TextButton(
            onPressed: () {
              Navigator.pop(ctx);
              context.read<AuthBloc>().add(const AuthLogoutRequested());
            },
            child: Text(
              l10n.logout,
              style: const TextStyle(color: AppColors.error),
            ),
          ),
        ],
      ),
    );
  }

  void _showLanguagePicker(
      BuildContext context, AppLocalizations l10n, LocaleProvider provider) {
    const languages = [
      {'locale': 'en', 'native': 'English', 'label': 'English'},
      {'locale': 'hi', 'native': 'हिन्दी', 'label': 'Hindi'},
      {'locale': 'bn', 'native': 'বাংলা', 'label': 'Bengali'},
      {'locale': 'mr', 'native': 'मराठी', 'label': 'Marathi'},
      {'locale': 'ta', 'native': 'தமிழ்', 'label': 'Tamil'},
      {'locale': 'te', 'native': 'తెలుగు', 'label': 'Telugu'},
      {'locale': 'kn', 'native': 'ಕನ್ನಡ', 'label': 'Kannada'},
      {'locale': 'gu', 'native': 'ગુજરાતી', 'label': 'Gujarati'},
      {'locale': 'pa', 'native': 'ਪੰਜਾਬੀ', 'label': 'Punjabi'},
      {'locale': 'ml', 'native': 'മലയാളം', 'label': 'Malayalam'},
      {'locale': 'bho', 'native': 'भोजपुरी', 'label': 'Bhojpuri'},
      {'locale': 'mai', 'native': 'मैथिली', 'label': 'Maithili'},
    ];
    final currentCode = provider.locale.languageCode;
    final initialIndex =
        languages.indexWhere((l) => l['locale'] == currentCode).clamp(0, languages.length - 1);
    int selectedIndex = initialIndex;
    final controller = FixedExtentScrollController(initialItem: initialIndex);

    showGeneralDialog(
      context: context,
      useRootNavigator: true,
      barrierDismissible: true,
      barrierLabel: 'language-picker',
      barrierColor: Colors.transparent,
      transitionDuration: const Duration(milliseconds: 280),
      transitionBuilder: (ctx, animation, _, child) {
        final curved = CurvedAnimation(
          parent: animation,
          curve: Curves.easeOutBack,
          reverseCurve: Curves.easeInCubic,
        );
        return BackdropFilter(
          filter: ImageFilter.blur(
            sigmaX: 8 * animation.value,
            sigmaY: 8 * animation.value,
          ),
          child: FadeTransition(
            opacity: animation,
            child: ScaleTransition(scale: curved, child: child),
          ),
        );
      },
      pageBuilder: (ctx, anim, secondAnim) => Dialog(
        shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(20)),
        insetPadding: const EdgeInsets.symmetric(horizontal: 40),
        child: Padding(
          padding: const EdgeInsets.fromLTRB(24, 24, 24, 20),
          child: Column(
            mainAxisSize: MainAxisSize.min,
            children: [
              Text(l10n.selectLanguage, style: AppTypography.h3),
              const SizedBox(height: 16),
              SizedBox(
                height: 200,
                child: ListWheelScrollView.useDelegate(
                  controller: controller,
                  itemExtent: 52,
                  physics: const FixedExtentScrollPhysics(),
                  onSelectedItemChanged: (index) => selectedIndex = index,
                  childDelegate: ListWheelChildBuilderDelegate(
                    childCount: languages.length,
                    builder: (_, index) => Center(
                      child: Column(
                        mainAxisAlignment: MainAxisAlignment.center,
                        children: [
                          Text(languages[index]['native']!,
                              style: AppTypography.labelLarge.copyWith(fontSize: 16)),
                          Text(languages[index]['label']!,
                              style: AppTypography.bodySmall
                                  .copyWith(color: AppColors.textHint)),
                        ],
                      ),
                    ),
                  ),
                ),
              ),
              const SizedBox(height: 16),
              Row(
                children: [
                  Expanded(
                    child: OutlinedButton(
                      onPressed: () => Navigator.pop(ctx),
                      style: OutlinedButton.styleFrom(
                        padding: const EdgeInsets.symmetric(vertical: 12),
                        shape: RoundedRectangleBorder(
                            borderRadius: BorderRadius.circular(12)),
                      ),
                      child: Text(l10n.cancel),
                    ),
                  ),
                  const SizedBox(width: 12),
                  Expanded(
                    child: ElevatedButton(
                      onPressed: () {
                        Navigator.pop(ctx);
                        provider.setLocale(
                          Locale(languages[selectedIndex]['locale']!),
                        );
                      },
                      style: ElevatedButton.styleFrom(
                        backgroundColor: AppColors.primary,
                        foregroundColor: Colors.white,
                        padding: const EdgeInsets.symmetric(vertical: 12),
                        shape: RoundedRectangleBorder(
                            borderRadius: BorderRadius.circular(12)),
                      ),
                      child: const Text('Done',
                          style: TextStyle(fontWeight: FontWeight.bold)),
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

class _SectionLabel extends StatelessWidget {
  final String label;
  const _SectionLabel({required this.label});

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.only(left: 4, bottom: 4),
      child: Text(
        label.toUpperCase(),
        style: AppTypography.bodySmall.copyWith(
          color: AppColors.textHint,
          fontWeight: FontWeight.w600,
          letterSpacing: 0.8,
        ),
      ),
    );
  }
}

class _ProfileHeader extends StatelessWidget {
  const _ProfileHeader();

  @override
  Widget build(BuildContext context) {
    return BlocBuilder<AuthBloc, AuthState>(
      buildWhen: (_, current) =>
          current is AuthAuthenticated || current is AuthUnauthenticated,
      builder: (context, state) {
        final user = state is AuthAuthenticated ? state.user : null;
        return Container(
          padding: const EdgeInsets.all(20),
          decoration: BoxDecoration(
            color: Theme.of(context).colorScheme.surface,
            borderRadius: BorderRadius.circular(16),
          ),
          child: Row(
            children: [
              _buildAvatar(user),
              const SizedBox(width: 20),
              Expanded(
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    Text(user?.name ?? '...', style: AppTypography.h3),
                    if (user?.email != null && user!.email!.isNotEmpty)
                      Text(user.email!, style: AppTypography.bodySmall),
                  ],
                ),
              ),
              if (user != null)
                IconButton(
                  onPressed: () =>
                      context.push(AppRouter.editProfile, extra: user),
                  icon: const Icon(Icons.edit_rounded, size: 20),
                ),
            ],
          ),
        );
      },
    );
  }

  Widget _buildAvatar(UserModel? user) {
    if (user?.profilePhotoUrl != null) {
      return CircleAvatar(
        radius: 30,
        backgroundImage: NetworkImage(user!.profilePhotoUrl!),
      );
    }
    return const CircleAvatar(radius: 30, child: Icon(Icons.person, size: 30));
  }
}

class _SettingsTile extends StatelessWidget {
  final IconData icon;
  final String title;
  final String subtitle;
  final VoidCallback onTap;

  const _SettingsTile({
    required this.icon,
    required this.title,
    required this.subtitle,
    required this.onTap,
  });

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.only(bottom: 12),
      child: ListTile(
        onTap: onTap,
        tileColor: Theme.of(context).colorScheme.surface,
        shape:
            RoundedRectangleBorder(borderRadius: BorderRadius.circular(12)),
        leading: Icon(icon, color: AppColors.primary),
        title: Text(title, style: AppTypography.labelLarge),
        subtitle: Text(subtitle, style: AppTypography.bodySmall),
        trailing:
            const Icon(Icons.chevron_right_rounded, color: AppColors.textHint),
      ),
    );
  }
}
