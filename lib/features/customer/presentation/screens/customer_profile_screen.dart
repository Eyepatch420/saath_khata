import 'package:flutter/material.dart';
import '../../../../core/constants/app_colors.dart';
import '../../../../core/constants/app_typography.dart';

class CustomerProfileScreen extends StatelessWidget {
  const CustomerProfileScreen({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: AppColors.background,
      appBar: AppBar(
        title: const Text('Profile'),
      ),
      body: SingleChildScrollView(
        padding: const EdgeInsets.all(20),
        child: Column(
          children: [
            const CircleAvatar(
              radius: 50,
              backgroundColor: AppColors.primary,
              child: Icon(Icons.person_rounded, size: 60, color: Colors.white),
            ),
            const SizedBox(height: 16),
            Text('John Doe', style: AppTypography.h2),
            Text('+91 9876543210', style: AppTypography.bodyMedium.copyWith(color: AppColors.textSecondary)),
            const SizedBox(height: 32),
            _ProfileItem(icon: Icons.notifications_rounded, title: 'Notification Settings'),
            _ProfileItem(icon: Icons.language_rounded, title: 'Language'),
            _ProfileItem(icon: Icons.security_rounded, title: 'Security & PIN'),
            _ProfileItem(icon: Icons.help_outline_rounded, title: 'Help & Support'),
            const SizedBox(height: 32),
            TextButton(
              onPressed: () {},
              child: const Text('Logout', style: TextStyle(color: AppColors.error, fontWeight: FontWeight.bold)),
            ),
          ],
        ),
      ),
    );
  }
}

class _ProfileItem extends StatelessWidget {
  final IconData icon;
  final String title;

  const _ProfileItem({required this.icon, required this.title});

  @override
  Widget build(BuildContext context) {
    return ListTile(
      leading: Icon(icon, color: AppColors.primary),
      title: Text(title, style: AppTypography.bodyLarge),
      trailing: const Icon(Icons.chevron_right_rounded),
      onTap: () {},
    );
  }
}
