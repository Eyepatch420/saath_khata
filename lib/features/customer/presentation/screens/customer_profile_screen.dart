import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:go_router/go_router.dart';
import '../../../../core/constants/app_colors.dart';
import '../../../../core/constants/app_typography.dart';
import '../../../../core/router/app_router.dart';
import '../../../../l10n/app_localizations.dart';
import '../../../auth/data/models/user_model.dart';
import '../../../auth/presentation/bloc/auth_bloc.dart';
import '../../../auth/presentation/bloc/auth_event.dart';
import '../../../auth/presentation/bloc/auth_state.dart';

class CustomerProfileScreen extends StatelessWidget {
  const CustomerProfileScreen({super.key});

  @override
  Widget build(BuildContext context) {
    final l10n = AppLocalizations.of(context)!;
    return BlocBuilder<AuthBloc, AuthState>(
      buildWhen: (_, current) =>
          current is AuthAuthenticated || current is AuthUnauthenticated,
      builder: (context, state) {
        final user = state is AuthAuthenticated ? state.user : null;
        return Scaffold(
          appBar: AppBar(
            title: const Text('Profile'),
            actions: [
              if (user != null)
                IconButton(
                  icon: const Icon(Icons.edit_rounded),
                  tooltip: 'Edit Profile',
                  onPressed: () =>
                      context.push(AppRouter.editProfile, extra: user),
                ),
            ],
          ),
          body: SafeArea(child: SingleChildScrollView(
            padding: EdgeInsets.fromLTRB(20, 20, 20, MediaQuery.of(context).viewPadding.bottom + 96),
            child: Column(
              children: [
                _buildAvatar(user),
                const SizedBox(height: 16),
                Text(user?.name ?? '...', style: AppTypography.h2),
                if (user?.mobile != null)
                  Text(
                    user!.mobile!,
                    style: AppTypography.bodyMedium
                        .copyWith(color: AppColors.textSecondary),
                  ),
                Text(
                  user?.email ?? '',
                  style: AppTypography.bodySmall
                      .copyWith(color: AppColors.textHint),
                ),
                const SizedBox(height: 32),
                _ProfileItem(
                  icon: Icons.notifications_rounded,
                  title: l10n.notificationSettings,
                ),
                _ProfileItem(
                  icon: Icons.language_rounded,
                  title: l10n.appLanguage,
                ),
                _ProfileItem(
                  icon: Icons.security_rounded,
                  title: l10n.securityPin,
                ),
                _ProfileItem(
                  icon: Icons.help_outline_rounded,
                  title: l10n.helpSupport,
                ),
                const SizedBox(height: 32),
                TextButton(
                  onPressed: () => _confirmLogout(context, l10n),
                  child: Text(
                    l10n.logout,
                    style: const TextStyle(
                      color: AppColors.error,
                      fontWeight: FontWeight.bold,
                    ),
                  ),
                ),
              ],
            ),
          ),
          ),
        );
      },
    );
  }

  Widget _buildAvatar(UserModel? user) {
    if (user?.profilePhotoUrl != null) {
      return CircleAvatar(
        radius: 50,
        backgroundImage: NetworkImage(user!.profilePhotoUrl!),
      );
    }
    return const CircleAvatar(
      radius: 50,
      backgroundColor: AppColors.customerAccent,
      child: Icon(Icons.person_rounded, size: 60, color: Colors.white),
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
