import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:go_router/go_router.dart';
import 'package:provider/provider.dart';
import '../../../../core/constants/app_colors.dart';
import '../../../../core/constants/app_typography.dart';
import '../../../../core/localization/locale_provider.dart';
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
      body: SingleChildScrollView(
        padding: EdgeInsets.fromLTRB(20, 20, 20, MediaQuery.of(context).viewPadding.bottom + 96),
        child: Column(
          children: [
            const _ProfileHeader(),
            const SizedBox(height: 24),
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
              onTap: () {},
            ),
            _SettingsTile(
              icon: Icons.notifications_active_rounded,
              title: l10n.notifications,
              subtitle: l10n.settingsManageAlerts,
              onTap: () {},
            ),
            _SettingsTile(
              icon: Icons.security_rounded,
              title: l10n.security,
              subtitle: l10n.settingsAppPinFingerprint,
              onTap: () {},
            ),
            _SettingsTile(
              icon: Icons.help_outline_rounded,
              title: l10n.helpSupport,
              subtitle: l10n.settingsFaqsContact,
              onTap: () {},
            ),
            const SizedBox(height: 40),
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
                          child: CircularProgressIndicator(strokeWidth: 2),
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
                style: AppTypography.bodySmall),
          ],
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
    showDialog(
      context: context,
      builder: (ctx) => SimpleDialog(
        title: Text(l10n.selectLanguage),
        children: [
          SimpleDialogOption(
            onPressed: () {
              Navigator.pop(ctx);
              provider.setLocale(const Locale('en'));
            },
            child: const Text('English'),
          ),
          SimpleDialogOption(
            onPressed: () {
              Navigator.pop(ctx);
              provider.setLocale(const Locale('hi'));
            },
            child: const Text('हिंदी'),
          ),
        ],
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
                    if (user?.email != null && user!.email.isNotEmpty)
                      Text(user.email, style: AppTypography.bodySmall),
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
        trailing: const Icon(Icons.chevron_right_rounded,
            color: AppColors.textHint),
      ),
    );
  }
}
