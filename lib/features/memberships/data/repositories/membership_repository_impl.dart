import 'package:dio/dio.dart';
import '../../../../core/network/api_client.dart';
import '../../../../core/network/api_endpoints.dart';
import '../../domain/models/membership_request.dart';
import '../../domain/models/membership_status.dart';
import '../../domain/models/membership_tier.dart';
import '../../domain/repositories/membership_repository.dart';

class MembershipRepositoryImpl implements MembershipRepository {
  final ApiClient _api;

  MembershipRepositoryImpl(this._api);

  @override
  Future<List<MembershipTier>> getTiers() async {
    try {
      final response = await _api.get(ApiEndpoints.membershipTiers);
      final data = ApiClient.extractData(response);
      final list = (data['tiers'] as List?) ?? [];
      return list
          .map((e) => MembershipTier.fromJson(e as Map<String, dynamic>))
          .toList();
    } on DioException catch (e) {
      throw Exception(ApiClient.extractErrorMessage(e));
    }
  }

  @override
  Future<MembershipTier> updateTier(
    String tierId, {
    String? name,
    DiscountType? discountType,
    double? discountValue,
    double? discountCap,
    bool clearCap = false,
  }) async {
    try {
      final body = <String, dynamic>{};
      if (name != null) body['name'] = name;
      if (discountType != null) body['discountType'] = discountType.toJson();
      if (discountValue != null) body['discountValue'] = discountValue;
      // clearCap sends explicit null; otherwise only send when a value is given.
      if (clearCap) {
        body['discountCap'] = null;
      } else if (discountCap != null) {
        body['discountCap'] = discountCap;
      }
      final response = await _api.patch(
        ApiEndpoints.updateMembershipTier(tierId),
        data: body,
      );
      return MembershipTier.fromJson(ApiClient.extractData(response));
    } on DioException catch (e) {
      throw Exception(ApiClient.extractErrorMessage(e));
    }
  }

  @override
  Future<MembershipStatus> getStatus(String linkId) async {
    try {
      final response = await _api.get(ApiEndpoints.membershipStatus(linkId));
      return MembershipStatus.fromJson(ApiClient.extractData(response));
    } on DioException catch (e) {
      throw Exception(ApiClient.extractErrorMessage(e));
    }
  }

  @override
  Future<MembershipStatus> assignTier(String linkId, String? tierId) async {
    try {
      final response = await _api.patch(
        ApiEndpoints.assignMembership(linkId),
        data: {'tierId': tierId},
      );
      return MembershipStatus.fromJson(ApiClient.extractData(response));
    } on DioException catch (e) {
      throw Exception(ApiClient.extractErrorMessage(e));
    }
  }

  @override
  Future<MembershipRequest> requestTier(
    String linkId,
    String tierId, {
    String? message,
  }) async {
    try {
      final body = <String, dynamic>{'tierId': tierId};
      if (message != null && message.isNotEmpty) body['message'] = message;
      final response = await _api.post(
        ApiEndpoints.requestMembership(linkId),
        data: body,
      );
      return MembershipRequest.fromJson(ApiClient.extractData(response));
    } on DioException catch (e) {
      throw Exception(ApiClient.extractErrorMessage(e));
    }
  }

  @override
  Future<List<MembershipRequest>> getPendingRequests() async {
    try {
      final response = await _api.get(ApiEndpoints.pendingMembershipRequests);
      final data = ApiClient.extractData(response);
      final list = (data['requests'] as List?) ?? [];
      return list
          .map((e) => MembershipRequest.fromJson(e as Map<String, dynamic>))
          .toList();
    } on DioException catch (e) {
      throw Exception(ApiClient.extractErrorMessage(e));
    }
  }

  @override
  Future<MembershipRequest> approveRequest(String requestId) async {
    try {
      final response =
          await _api.patch(ApiEndpoints.approveMembershipRequest(requestId));
      return MembershipRequest.fromJson(ApiClient.extractData(response));
    } on DioException catch (e) {
      throw Exception(ApiClient.extractErrorMessage(e));
    }
  }

  @override
  Future<MembershipRequest> declineRequest(String requestId) async {
    try {
      final response =
          await _api.patch(ApiEndpoints.declineMembershipRequest(requestId));
      return MembershipRequest.fromJson(ApiClient.extractData(response));
    } on DioException catch (e) {
      throw Exception(ApiClient.extractErrorMessage(e));
    }
  }
}
