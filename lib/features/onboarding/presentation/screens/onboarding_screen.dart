import 'package:flutter/material.dart';
import 'package:go_router/go_router.dart';
import '../../../../l10n/app_localizations.dart';
import '../../../../core/constants/app_colors.dart';
import '../../../../core/constants/app_typography.dart';
import '../../../../core/router/app_router.dart';
import '../../../../core/widgets/primary_button.dart';

class OnboardingScreen extends StatefulWidget {
  const OnboardingScreen({super.key});

  @override
  State<OnboardingScreen> createState() => _OnboardingScreenState();
}

class _OnboardingScreenState extends State<OnboardingScreen> {
  final PageController _pageController = PageController();
  int _currentPage = 0;

  @override
  Widget build(BuildContext context) {
    final l10n = AppLocalizations.of(context)!;
    
    final List<Map<String, String>> onboardingData = [
      {
        'title': l10n.onboarding1Title,
        'subtitle': l10n.onboarding1Subtitle,
        'icon': '📒',
      },
      {
        'title': l10n.onboarding2Title,
        'subtitle': l10n.onboarding2Subtitle,
        'icon': '🎙️',
      },
      {
        'title': l10n.onboarding3Title,
        'subtitle': l10n.onboarding3Subtitle,
        'icon': '💸',
      },
    ];

    return Scaffold(
      backgroundColor: AppColors.background,
      body: SafeArea(
        child: Padding(
          padding: const EdgeInsets.all(24.0),
          child: Column(
            children: [
              Align(
                alignment: Alignment.topRight,
                child: TextButton(
                  onPressed: () => context.go(AppRouter.roleSelection),
                  child: Text(l10n.skip, style: AppTypography.bodyMedium.copyWith(color: AppColors.primary)),
                ),
              ),
              Expanded(
                child: PageView.builder(
                  controller: _pageController,
                  onPageChanged: (value) => setState(() => _currentPage = value),
                  itemCount: onboardingData.length,
                  itemBuilder: (context, index) => Column(
                    mainAxisAlignment: MainAxisAlignment.center,
                    children: [
                      Text(
                        onboardingData[index]['icon']!,
                        style: const TextStyle(fontSize: 100),
                      ),
                      const SizedBox(height: 40),
                      Text(
                        onboardingData[index]['title']!,
                        textAlign: TextAlign.center,
                        style: AppTypography.h1,
                      ),
                      const SizedBox(height: 16),
                      Text(
                        onboardingData[index]['subtitle']!,
                        textAlign: TextAlign.center,
                        style: AppTypography.bodyLarge.copyWith(color: AppColors.textSecondary),
                      ),
                    ],
                  ),
                ),
              ),
              Row(
                mainAxisAlignment: MainAxisAlignment.center,
                children: List.generate(
                  onboardingData.length,
                  (index) => Container(
                    margin: const EdgeInsets.only(right: 8),
                    height: 8,
                    width: _currentPage == index ? 24 : 8,
                    decoration: BoxDecoration(
                      color: _currentPage == index ? AppColors.primary : AppColors.divider,
                      borderRadius: BorderRadius.circular(4),
                    ),
                  ),
                ),
              ),
              const SizedBox(height: 40),
              PrimaryButton(
                label: _currentPage == onboardingData.length - 1 ? l10n.getStarted.toUpperCase() : l10n.next.toUpperCase(),
                onPressed: () {
                  if (_currentPage == onboardingData.length - 1) {
                    context.go(AppRouter.roleSelection);
                  } else {
                    _pageController.nextPage(
                      duration: const Duration(milliseconds: 300),
                      curve: Curves.easeIn,
                    );
                  }
                },
              ),
            ],
          ),
        ),
      ),
    );
  }
}
