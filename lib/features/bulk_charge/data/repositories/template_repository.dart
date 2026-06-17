import 'package:dio/dio.dart';
import '../../../../core/network/api_client.dart';
import '../../../../core/network/api_endpoints.dart';
import '../../../../shared/models/product_template.dart';

class TemplateRepository {
  final ApiClient _api;
  TemplateRepository(this._api);

  Future<List<ProductTemplate>> getTemplates() async {
    try {
      final response = await _api.get(ApiEndpoints.productTemplates);
      final data = ApiClient.extractData(response);
      final list = data as List;
      return list
          .map((e) => ProductTemplate.fromJson(e as Map<String, dynamic>))
          .toList();
    } on DioException catch (e) {
      throw Exception(ApiClient.extractErrorMessage(e));
    }
  }

  Future<ProductTemplate> createTemplate({
    required String name,
    required String unit,
    required double pricePerUnit,
  }) async {
    try {
      final response = await _api.post(ApiEndpoints.productTemplates, data: {
        'name': name,
        'unit': unit,
        'pricePerUnit': pricePerUnit,
      });
      return ProductTemplate.fromJson(
          ApiClient.extractData(response) as Map<String, dynamic>);
    } on DioException catch (e) {
      throw Exception(ApiClient.extractErrorMessage(e));
    }
  }

  Future<void> deleteTemplate(String id) async {
    try {
      await _api.delete(ApiEndpoints.productTemplateById(id));
    } on DioException catch (e) {
      throw Exception(ApiClient.extractErrorMessage(e));
    }
  }

  Future<BulkChargeResult> bulkCharge({
    required String templateId,
    required List<BulkChargeItem> items,
    DateTime? date,
  }) async {
    try {
      final body = <String, dynamic>{
        'templateId': templateId,
        'items': items.map((i) => i.toJson()).toList(),
      };
      if (date != null) body['date'] = date.toUtc().toIso8601String();

      final response = await _api.post(ApiEndpoints.bulkCharge, data: body);
      final raw = ApiClient.extractData(response);
      return BulkChargeResult.fromJson(
          Map<String, dynamic>.from(raw as Map));
    } on DioException catch (e) {
      throw Exception(ApiClient.extractErrorMessage(e));
    }
  }
}
