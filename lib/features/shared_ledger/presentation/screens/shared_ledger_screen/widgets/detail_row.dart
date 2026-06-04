import 'package:flutter/material.dart';
import '../../../../../../core/constants/app_typography.dart';

class LedgerDetailRow extends StatelessWidget {
  final String label;
  final String value;
  const LedgerDetailRow(this.label, this.value, {super.key});

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.only(bottom: 12),
      child: Row(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          SizedBox(
            width: 120,
            child: Text(label, style: AppTypography.bodySmall),
          ),
          Expanded(
            child: Text(value, style: AppTypography.labelLarge),
          ),
        ],
      ),
    );
  }
}
