import 'package:equatable/equatable.dart';
import 'membership_request.dart';
import 'membership_tier.dart';

/// Everything the shared-ledger membership banner needs for one link.
class MembershipStatus extends Equatable {
  final String linkId;
  final MembershipTier? currentTier;
  final MembershipRequest? pendingRequest;
  final List<MembershipTier> tiers; // the vendor's three tiers, to pick from

  const MembershipStatus({
    required this.linkId,
    required this.tiers,
    this.currentTier,
    this.pendingRequest,
  });

  factory MembershipStatus.fromJson(Map<String, dynamic> json) =>
      MembershipStatus(
        linkId: json['linkId'] as String,
        currentTier: json['currentTier'] != null
            ? MembershipTier.fromJson(json['currentTier'] as Map<String, dynamic>)
            : null,
        pendingRequest: json['pendingRequest'] != null
            ? MembershipRequest.fromJson(
                json['pendingRequest'] as Map<String, dynamic>)
            : null,
        tiers: ((json['tiers'] as List?) ?? const [])
            .map((e) => MembershipTier.fromJson(e as Map<String, dynamic>))
            .toList(),
      );

  @override
  List<Object?> get props => [linkId, currentTier, pendingRequest, tiers];
}
