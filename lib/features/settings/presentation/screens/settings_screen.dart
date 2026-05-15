import 'package:flutter/material.dart';
import 'package:go_router/go_router.dart';
import 'package:provider/provider.dart';
import '../../../../core/constants/app_colors.dart';
import '../../../../core/constants/app_typography.dart';
import '../../../../core/localization/locale_provider.dart';
import '../../../../core/router/app_router.dart';

class SettingsScreen extends StatelessWidget {
  const SettingsScreen({super.key});

  @override
  Widget build(BuildContext context) {
    final localeProvider = Provider.of<LocaleProvider>(context);
    final currentLang = localeProvider.locale.languageCode == 'hi' ? 'Hindi' : 'English';

    return Scaffold(
      backgroundColor: AppColors.background,
      appBar: AppBar(title: const Text('Settings')),
      body: SingleChildScrollView(
        padding: const EdgeInsets.all(20),
        child: Column(
          children: [
            _ProfileHeader(),
            const SizedBox(height: 24),
            _SettingsTile(
              icon: Icons.language_rounded,
              title: 'App Language',
              subtitle: currentLang,
              onTap: () => _showLanguagePicker(context, localeProvider),
            ),
            _SettingsTile(
              icon: Icons.account_balance_wallet_rounded,
              title: 'My UPI IDs',
              subtitle: 'Manage payment accounts',
              onTap: () {},
            ),
            _SettingsTile(
              icon: Icons.notifications_active_rounded,
              title: 'Notifications',
              subtitle: 'Manage alerts and reminders',
              onTap: () {},
            ),
            _SettingsTile(
              icon: Icons.security_rounded,
              title: 'Security',
              subtitle: 'App PIN and Fingerprint',
              onTap: () {},
            ),
            _SettingsTile(
              icon: Icons.help_outline_rounded,
              title: 'Help & Support',
              subtitle: 'FAQs and Contact Us',
              onTap: () {},
            ),
            const SizedBox(height: 40),
            TextButton(
              onPressed: () => context.go(AppRouter.splash),
              child: const Text('Logout', style: TextStyle(color: AppColors.error, fontWeight: FontWeight.bold)),
            ),
            const SizedBox(height: 8),
            Text('Version 1.0.0', style: AppTypography.bodySmall),
          ],
        ),
      ),
    );
  }

  void _showLanguagePicker(BuildContext context, LocaleProvider provider) {
    showDialog(
      context: context,
      builder: (ctx) => SimpleDialog(
        title: const Text('Select Language'),
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
            child: const Text('हिंदी (Hindi)'),
          ),
        ],
      ),
    );
  }
}

class _ProfileHeader extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return Container(
      padding: const EdgeInsets.all(20),
      decoration: BoxDecoration(
        color: AppColors.surface,
        borderRadius: BorderRadius.circular(16),
      ),
      child: Row(
        children: [
          const CircleAvatar(radius: 30, child: Icon(Icons.person, size: 30)),
          const SizedBox(width: 20),
          Expanded(
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Text('Sujeet Kumar', style: AppTypography.h3),
                Text('+91 9876543210', style: AppTypography.bodySmall),
              ],
            ),
          ),
          IconButton(onPressed: () {}, icon: const Icon(Icons.edit_rounded, size: 20)),
        ],
      ),
    );
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
        tileColor: AppColors.surface,
        shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(12)),
        leading: Icon(icon, color: AppColors.primary),
        title: Text(title, style: AppTypography.labelLarge),
        subtitle: Text(subtitle, style: AppTypography.bodySmall),
        trailing: const Icon(Icons.chevron_right_rounded, color: AppColors.textHint),
      ),
    );
  }
}
