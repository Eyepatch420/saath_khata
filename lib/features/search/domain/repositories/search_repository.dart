import '../models/vendor_search_result.dart';

abstract class SearchRepository {
  Future<List<VendorSearchResult>> searchVendors({
    String? q,
    String? category,
    int page = 1,
    int limit = 20,
  });
}
