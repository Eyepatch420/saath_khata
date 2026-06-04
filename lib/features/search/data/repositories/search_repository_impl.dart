import 'package:dio/dio.dart';
import '../../../../core/network/api_client.dart';
import '../../../../core/network/api_endpoints.dart';
import '../../domain/models/vendor_search_result.dart';
import '../../domain/repositories/search_repository.dart';

class SearchRepositoryImpl implements SearchRepository {
  final ApiClient _api;

  SearchRepositoryImpl(this._api);

  @override
  Future<List<VendorSearchResult>> searchVendors({
    String? q,
    String? category,
    int page = 1,
    int limit = 20,
  }) async {
    try {
      final params = <String, dynamic>{
        'page': page,
        'limit': limit,
      };
      if (q != null && q.isNotEmpty) params['q'] = q;
      if (category != null) params['category'] = category;

      final response = await _api.get(
        ApiEndpoints.searchVendors,
        queryParameters: params,
      );

      final data = ApiClient.extractData(response);
      final results = ((data['results']) as List<dynamic>)
          .map((e) => VendorSearchResult.fromJson(e as Map<String, dynamic>))
          .toList();

      return results;
    } on DioException catch (e) {
      throw Exception(ApiClient.extractErrorMessage(e));
    }
  }
}
