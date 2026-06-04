import 'package:flutter/material.dart';
import 'package:go_router/go_router.dart';
import '../../../../l10n/app_localizations.dart';
import '../../../../core/constants/app_colors.dart';
import '../../../../core/constants/app_typography.dart';
import '../../../../core/router/app_router.dart';
import 'role_selection_screen/widgets/role_card.dart';

class RoleSelectionScreen extends StatelessWidget {
  const RoleSelectionScreen({super.key});

  @override
  Widget build(BuildContext context) {
    final l10n = AppLocalizations.of(context)!;
    return Scaffold(
      body: SafeArea(
        child: Padding(
          padding: const EdgeInsets.all(24.0),
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              const SizedBox(height: 40),
              Text(l10n.welcomeToSaathKhata, style: AppTypography.h1),
              const SizedBox(height: 8),
              Text(
                l10n.tellUsHowYouUse,
                style: AppTypography.bodyLarge
                    .copyWith(color: AppColors.textSecondary),
              ),
              const SizedBox(height: 40),
              RoleCard(
                title: l10n.vendorRoleTitle,
                subtitle: l10n.vendorRoleSubtitle,
                icon: Icons.storefront_rounded,
                color: AppColors.primary,
                onTap: () => context.push(AppRouter.login, extra: 'vendor'),
              ),
              const SizedBox(height: 24),
              RoleCard(
                title: l10n.customerRoleTitle,
                subtitle: l10n.customerRoleSubtitle,
                icon: Icons.person_search_rounded,
                color: AppColors.customerAccent,
                onTap: () =>
                    context.push(AppRouter.login, extra: 'customer'),
              ),
              const Spacer(),
              Center(
                child: Text(
                  l10n.tagline,
                  style: AppTypography.bodySmall
                      .copyWith(fontStyle: FontStyle.italic),
                ),
              ),
            ],
          ),
        ),
      ),
    );
  }
}
