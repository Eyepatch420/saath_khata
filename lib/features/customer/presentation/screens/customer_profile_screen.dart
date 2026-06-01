import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:go_router/go_router.dart';
import '../../../../core/constants/app_colors.dart';
import '../../../../core/constants/app_typography.dart';
import '../../../../core/network/api_endpoints.dart';
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
          appBar: AppBar(title: const Text('Profile')),
          body: SafeArea(
            child: SingleChildScrollView(
              padding: EdgeInsets.fromLTRB(
                  20, 20, 20, MediaQuery.of(context).viewPadding.bottom + 96),
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.stretch,
                children: [
                  _buildAvatarSection(context, user),
                  const SizedBox(height: 32),
                  _SectionHeader(label: l10n.accountSettings),
                  const SizedBox(height: 8),
                  _ProfileItem(
                    icon: Icons.person_outline_rounded,
                    title: l10n.editProfile,
                    onTap: user != null
                        ? () => context.push(AppRouter.editProfile, extra: user)
                        : null,
                  ),
                  _ProfileItem(
                    icon: Icons.lock_outline_rounded,
                    title: l10n.changePassword,
                    onTap: () => context.push(AppRouter.changePassword),
                  ),
                  _ProfileItem(
                    icon: Icons.language_rounded,
                    title: l10n.appLanguage,
                    onTap: () => context.push(AppRouter.settings),
                  ),
                  _ProfileItem(
                    icon: Icons.help_outline_rounded,
                    title: l10n.helpSupport,
                    onTap: () {},
                  ),
                  const SizedBox(height: 20),
                  _SectionHeader(label: l10n.legalInfo),
                  const SizedBox(height: 8),
                  _ProfileItem(
                    icon: Icons.description_outlined,
                    title: l10n.termsAndConditions,
                    onTap: () => context.push(
                      AppRouter.policy,
                      extra: {
                        'title': l10n.termsAndConditions,
                        'endpoint': ApiEndpoints.termsAndConditions,
                      },
                    ),
                  ),
                  _ProfileItem(
                    icon: Icons.privacy_tip_outlined,
                    title: l10n.privacyPolicy,
                    onTap: () => context.push(
                      AppRouter.policy,
                      extra: {
                        'title': l10n.privacyPolicy,
                        'endpoint': ApiEndpoints.privacyPolicy,
                      },
                    ),
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

  Widget _buildAvatarSection(BuildContext context, UserModel? user) {
    return Column(
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
          style: AppTypography.bodySmall.copyWith(color: AppColors.textHint),
        ),
      ],
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

class _SectionHeader extends StatelessWidget {
  final String label;
  const _SectionHeader({required this.label});

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

class _ProfileItem extends StatelessWidget {
  final IconData icon;
  final String title;
  final VoidCallback? onTap;

  const _ProfileItem({
    required this.icon,
    required this.title,
    this.onTap,
  });

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.only(bottom: 4),
      child: ListTile(
        leading: Icon(icon, color: AppColors.primary),
        title: Text(title, style: AppTypography.bodyLarge),
        trailing: const Icon(Icons.chevron_right_rounded),
        onTap: onTap,
        tileColor: Theme.of(context).colorScheme.surface,
        shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(12)),
      ),
    );
  }
}
