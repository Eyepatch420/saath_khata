import 'package:dio/dio.dart';
import '../../../../core/network/api_client.dart';
import '../../../../core/network/api_endpoints.dart';
import '../../domain/repositories/notification_repository.dart';
import '../../../../shared/models/notification_model.dart';

class NotificationRepositoryImpl implements NotificationRepository {
  final ApiClient _api;

  NotificationRepositoryImpl(this._api);

  @override
  Future<List<AppNotification>> getNotifications() async {
    try {
      final response = await _api.get(
        ApiEndpoints.notifications,
        queryParameters: {'page': 1, 'limit': 50},
      );
      final data = ApiClient.extractData(response);
      final list = (data['notifications'] as List?) ?? [];
      return list
          .map((e) => AppNotification.fromJson(e as Map<String, dynamic>))
          .toList();
    } on DioException catch (e) {
      throw Exception(ApiClient.extractErrorMessage(e));
    }
  }

  @override
  Future<int> getUnreadCount() async {
    try {
      final response = await _api.get(ApiEndpoints.notifUnreadCount);
      final data = ApiClient.extractData(response);
      return data['count'] as int;
    } on DioException catch (e) {
      throw Exception(ApiClient.extractErrorMessage(e));
    }
  }

  @override
  Future<void> markAsRead(String notificationId) async {
    try {
      await _api.patch(ApiEndpoints.notifReadOne(notificationId));
    } on DioException catch (e) {
      throw Exception(ApiClient.extractErrorMessage(e));
    }
  }

  @override
  Future<void> markAllAsRead() async {
    try {
      await _api.patch(ApiEndpoints.notifReadAll);
    } on DioException catch (e) {
      throw Exception(ApiClient.extractErrorMessage(e));
    }
  }
}
