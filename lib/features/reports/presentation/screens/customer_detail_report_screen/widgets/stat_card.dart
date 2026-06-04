import 'package:flutter/material.dart';
import '../../../../../../core/constants/app_colors.dart';
import '../../../../../../core/constants/app_typography.dart';

class ReportsStatCard extends StatelessWidget {
  final String title;
  final String? subtitle;
  final String value;
  final Color color;
  final IconData icon;

  const ReportsStatCard({
    super.key,
    required this.title,
    required this.value,
    required this.color,
    required this.icon,
    this.subtitle,
  });

  @override
  Widget build(BuildContext context) {
    return Container(
      padding: const EdgeInsets.all(16),
      decoration: BoxDecoration(
        color: Theme.of(context).colorScheme.surface,
        borderRadius: BorderRadius.circular(16),
      ),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Icon(icon, color: color, size: 20),
          const SizedBox(height: 10),
          Text(value, style: AppTypography.h3.copyWith(color: color)),
          const SizedBox(height: 2),
          Text(title,
              style: AppTypography.bodySmall
                  .copyWith(color: AppColors.textHint)),
          if (subtitle != null)
            Text(subtitle!,
                style: AppTypography.bodySmall.copyWith(
                    color: AppColors.textHint, fontSize: 10)),
        ],
      ),
    );
  }
}
