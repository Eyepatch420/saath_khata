import '../../../../shared/models/link_model.dart';

abstract class CustomerRepository {
  /// GET /api/v1/links/vendors — all linked vendors with balances
  Future<List<VendorLinkItem>> getLinkedVendors();

  /// DELETE /api/v1/links/:linkId — customer deactivates their link with a vendor
  Future<void> deactivateLink(String linkId);

  /// PATCH /api/v1/links/:linkId/nickname — customer sets their own nickname for this vendor
  Future<void> updateLinkNickname(String linkId, String? nickname);
}
