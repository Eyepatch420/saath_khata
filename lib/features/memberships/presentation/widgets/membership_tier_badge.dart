import 'package:flutter/material.dart';
import 'membership_banner.dart';

/// A compact pill showing a customer's membership tier — used on the vendor
/// dashboard and all-customers cards. Renders nothing when [tierName] is null.
class MembershipTierBadge extends StatelessWidget {
  final String? tierName;
  final int? tierLevel;
  final bool compact;

  const MembershipTierBadge({
    super.key,
    required this.tierName,
    required this.tierLevel,
    this.compact = false,
  });

  @override
  Widget build(BuildContext context) {
    if (tierName == null) return const SizedBox.shrink();
    final color = MembershipBanner.tierColor(tierLevel ?? 1);

    return Container(
      padding: EdgeInsets.symmetric(
        horizontal: compact ? 6 : 8,
        vertical: compact ? 2 : 3,
      ),
      decoration: BoxDecoration(
        color: color.withValues(alpha: 0.12),
        borderRadius: BorderRadius.circular(20),
        border: Border.all(color: color.withValues(alpha: 0.5)),
      ),
      child: Row(
        mainAxisSize: MainAxisSize.min,
        children: [
          Icon(Icons.workspace_premium_rounded,
              size: compact ? 11 : 13, color: color),
          const SizedBox(width: 3),
          Text(
            tierName!,
            style: TextStyle(
              color: color,
              fontSize: compact ? 10 : 11,
              fontWeight: FontWeight.w700,
            ),
          ),
        ],
      ),
    );
  }
}
