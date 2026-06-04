import 'package:flutter/material.dart';
import '../../../../../../core/constants/app_typography.dart';

class LedgerInfoRow extends StatelessWidget {
  final IconData icon;
  final Color color;
  final String label;
  final String desc;

  const LedgerInfoRow({
    super.key,
    required this.icon,
    required this.color,
    required this.label,
    required this.desc,
  });

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.only(bottom: 12),
      child: Row(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Icon(icon, color: color, size: 20),
          const SizedBox(width: 12),
          Expanded(
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Text(label,
                    style:
                        AppTypography.labelLarge.copyWith(color: color)),
                Text(desc, style: AppTypography.bodySmall),
              ],
            ),
          ),
        ],
      ),
    );
  }
}
