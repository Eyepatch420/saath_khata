import 'package:flutter/material.dart';
import '../../../../../../core/constants/app_colors.dart';
import '../../../../../../core/constants/app_typography.dart';

class ReportsSummaryCard extends StatelessWidget {
  final String label;
  final String value;
  final Color color;
  final String? subtitle;

  const ReportsSummaryCard({
    super.key,
    required this.label,
    required this.value,
    required this.color,
    this.subtitle,
  });

  @override
  Widget build(BuildContext context) {
    return Container(
      padding: const EdgeInsets.all(16),
      decoration: BoxDecoration(
        color: Theme.of(context).colorScheme.surface,
        borderRadius: BorderRadius.circular(12),
      ),
      child: Row(
        mainAxisAlignment: MainAxisAlignment.spaceBetween,
        children: [
          Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              Text(label, style: AppTypography.bodyMedium),
              if (subtitle != null)
                Text(subtitle!,
                    style: AppTypography.bodySmall
                        .copyWith(color: AppColors.textHint)),
            ],
          ),
          Text(value, style: AppTypography.h3.copyWith(color: color)),
        ],
      ),
    );
  }
}
