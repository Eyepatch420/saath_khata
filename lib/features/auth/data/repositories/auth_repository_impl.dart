import 'package:dio/dio.dart';
import '../../../../core/network/api_client.dart';
import '../../../../core/network/api_endpoints.dart';
import '../../domain/repositories/auth_repository.dart';
import '../models/auth_response_model.dart';
import '../models/upi_id_model.dart';
import '../models/user_model.dart';

class AuthRepositoryImpl implements AuthRepository {
  final ApiClient _api;

  AuthRepositoryImpl(this._api);

  @override
  Future<AuthResponseModel> login({
    required String email,
    required String password,
  }) async {
    try {
      final response = await _api.post(
        ApiEndpoints.login,
        data: {'email': email, 'password': password},
      );
      return AuthResponseModel.fromJson(ApiClient.extractData(response));
    } on DioException catch (e) {
      throw Exception(ApiClient.extractErrorMessage(e));
    }
  }

  @override
  Future<AuthResponseModel> signup({
    required String name,
    required String email,
    required String password,
    required String role,
    String? mobile,
    String? upiId,
    String? businessName,
    String? businessCategory,
    String? businessAddress,
  }) async {
    final body = <String, dynamic>{
      'name': name,
      'email': email,
      'password': password,
      'role': role,
    };
    if (mobile != null && mobile.isNotEmpty) body['mobile'] = mobile;
    if (upiId != null && upiId.isNotEmpty) body['upiId'] = upiId;
    if (businessName != null && businessName.isNotEmpty) {
      body['businessName'] = businessName;
    }
    if (businessCategory != null) body['businessCategory'] = businessCategory;
    if (businessAddress != null && businessAddress.isNotEmpty) {
      body['businessAddress'] = businessAddress;
    }

    try {
      final response = await _api.post(ApiEndpoints.signup, data: body);
      return AuthResponseModel.fromJson(ApiClient.extractData(response));
    } on DioException catch (e) {
      final raw = ApiClient.extractErrorMessage(e);
      if (raw.toLowerCase().contains('already exists')) {
        throw Exception(
          'This email is already registered. Each email can only have one '
          'account (vendor or customer). Please use a different email address.',
        );
      }
      throw Exception(raw);
    }
  }

  @override
  Future<void> logout({required String refreshToken}) async {
    try {
      await _api.post(
          ApiEndpoints.logout, data: {'refreshToken': refreshToken});
    } on DioException catch (e) {
      throw Exception(ApiClient.extractErrorMessage(e));
    }
  }

  @override
  Future<UserModel> updateProfile({
    String? name,
    String? mobile,
    String? upiId,
    String? businessName,
    String? businessCategory,
    String? businessAddress,
    double? businessLatitude,
    double? businessLongitude,
    List<UpiIdModel>? upiIds,
  }) async {
    final body = <String, dynamic>{};
    if (name != null) body['name'] = name;
    if (mobile != null) body['mobile'] = mobile;
    if (upiId != null) body['upiId'] = upiId;
    if (businessName != null) body['businessName'] = businessName;
    if (businessCategory != null) body['businessCategory'] = businessCategory;
    if (businessAddress != null) body['businessAddress'] = businessAddress;
    if (businessLatitude != null) body['businessLatitude'] = businessLatitude;
    if (businessLongitude != null) body['businessLongitude'] = businessLongitude;
    if (upiIds != null) {
      body['upiIds'] = upiIds.map((u) => u.toJson()).toList();
    }

    try {
      final response = await _api.patch(ApiEndpoints.updateProfile, data: body);
      return UserModel.fromJson(ApiClient.extractData(response));
    } on DioException catch (e) {
      throw Exception(ApiClient.extractErrorMessage(e));
    }
  }
}
