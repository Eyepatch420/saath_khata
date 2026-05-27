import 'package:dio/dio.dart';
import '../../../../core/network/api_client.dart';
import '../../../../core/network/api_endpoints.dart';
import '../../domain/repositories/customer_repository.dart';
import '../../../../shared/models/link_model.dart';

class CustomerRepositoryImpl implements CustomerRepository {
  final ApiClient _api;

  CustomerRepositoryImpl(this._api);

  @override
  Future<List<VendorLinkItem>> getLinkedVendors() async {
    try {
      final response = await _api.get(ApiEndpoints.myVendors);
      // data is a JSON array directly, not a map
      final list = (response.data as Map<String, dynamic>)['data'] as List;
      return list
          .map((e) => VendorLinkItem.fromJson(e as Map<String, dynamic>))
          .toList();
    } on DioException catch (e) {
      throw Exception(ApiClient.extractErrorMessage(e));
    }
  }
}
