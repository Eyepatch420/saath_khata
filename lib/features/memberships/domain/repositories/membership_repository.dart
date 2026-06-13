import '../models/membership_request.dart';
import '../models/membership_status.dart';
import '../models/membership_tier.dart';

abstract class MembershipRepository {
  /// Vendor: fetch their three tiers (auto-seeded), with names and discounts.
  Future<List<MembershipTier>> getTiers();

  /// Vendor: rename a tier and/or set its discount function. Any subset of
  /// fields may be supplied.
  Future<MembershipTier> updateTier(
    String tierId, {
    String? name,
    DiscountType? discountType,
    double? discountValue,
    double? discountCap,
    bool clearCap = false,
  });

  /// Membership status for a link (both roles): current tier, pending request, tiers.
  Future<MembershipStatus> getStatus(String linkId);

  /// Vendor: set/elevate/remove a customer's tier. [tierId] null removes membership.
  Future<MembershipStatus> assignTier(String linkId, String? tierId);

  /// Customer: apply for a tier on a link.
  Future<MembershipRequest> requestTier(
    String linkId,
    String tierId, {
    String? message,
  });

  /// Vendor: all pending membership requests across their links.
  Future<List<MembershipRequest>> getPendingRequests();

  /// Vendor: approve a pending request (assigns the requested tier).
  Future<MembershipRequest> approveRequest(String requestId);

  /// Vendor: decline a pending request.
  Future<MembershipRequest> declineRequest(String requestId);
}
