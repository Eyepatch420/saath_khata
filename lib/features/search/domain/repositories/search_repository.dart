import '../models/vendor_search_result.dart';
import '../models/vendor_public_profile.dart';

abstract class SearchRepository {
  Future<List<VendorSearchResult>> searchVendors({
    String? q,
    String? category,
    int page = 1,
    int limit = 20,
  });

  Future<VendorPublicProfile> getVendorProfile(String vendorUserId);
}
