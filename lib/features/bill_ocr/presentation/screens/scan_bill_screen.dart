import 'package:flutter/material.dart';
import 'package:go_router/go_router.dart';
import '../../../../core/constants/app_colors.dart';
import '../../../../core/constants/app_typography.dart';
import '../../../../core/router/app_router.dart';
import '../../../../l10n/app_localizations.dart';

class ScanBillScreen extends StatefulWidget {
  const ScanBillScreen({super.key});

  @override
  State<ScanBillScreen> createState() => _ScanBillScreenState();
}

class _ScanBillScreenState extends State<ScanBillScreen> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Colors.black,
      body: Stack(
        children: [
          // Simulated Camera Preview
          Container(
            width: double.infinity,
            height: double.infinity,
            color: Colors.black,
            child: const Center(
              child: Icon(Icons.camera_rounded, size: 100, color: Colors.white24),
            ),
          ),
          
          // Scanning Overlay
          SafeArea(
            child: Column(
              children: [
                Padding(
                  padding: const EdgeInsets.symmetric(horizontal: 16, vertical: 8),
                  child: Row(
                    mainAxisAlignment: MainAxisAlignment.spaceBetween,
                    children: [
                      IconButton(
                        onPressed: () => context.pop(),
                        icon: const Icon(Icons.close, color: Colors.white),
                      ),
                      Text(AppLocalizations.of(context)!.scanBill, style: AppTypography.h3.copyWith(color: Colors.white)),
                      const IconButton(
                        onPressed: null,
                        icon: Icon(Icons.flash_on, color: Colors.white),
                      ),
                    ],
                  ),
                ),
                const Spacer(),
                
                // Scanning Frame
                Container(
                  width: MediaQuery.of(context).size.width * 0.8,
                  height: MediaQuery.of(context).size.width * 1.2,
                  decoration: BoxDecoration(
                    border: Border.all(color: AppColors.primary, width: 2),
                    borderRadius: BorderRadius.circular(12),
                  ),
                  child: Stack(
                    children: [
                      // Animated scanning line (simulated)
                      TweenAnimationBuilder<double>(
                        tween: Tween(begin: 0.0, end: 1.0),
                        duration: const Duration(seconds: 2),
                        builder: (context, value, child) {
                          return Positioned(
                            top: value * (MediaQuery.of(context).size.width * 1.2),
                            left: 0,
                            right: 0,
                            child: Container(
                              height: 2,
                              decoration: BoxDecoration(
                                boxShadow: [
                                  BoxShadow(
                                    color: AppColors.primary.withValues(alpha: 0.5),
                                    blurRadius: 10,
                                    spreadRadius: 2,
                                  ),
                                ],
                                color: AppColors.primary,
                              ),
                            ),
                          );
                        },
                        onEnd: () {
                          // Keep it looping if needed, but here we just simulate
                        },
                      ),
                    ],
                  ),
                ),
                
                const Spacer(),
                
                Padding(
                  padding: const EdgeInsets.all(32.0),
                  child: Column(
                    children: [
                      Text(
                        AppLocalizations.of(context)!.alignBillInFrame,
                        style: AppTypography.bodyMedium.copyWith(color: Colors.white70),
                      ),
                      const SizedBox(height: 24),
                      GestureDetector(
                        onTap: () {
                          // Simulate capture and OCR processing
                          context.push(AppRouter.billDetailsForm);
                        },
                        child: Container(
                          padding: const EdgeInsets.all(20),
                          decoration: const BoxDecoration(
                            color: Colors.white,
                            shape: BoxShape.circle,
                          ),
                          child: const Icon(Icons.camera_alt, size: 32, color: Colors.black),
                        ),
                      ),
                    ],
                  ),
                ),
              ],
            ),
          ),
        ],
      ),
    );
  }
}
