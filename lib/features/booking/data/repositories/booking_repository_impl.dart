import 'package:dio/dio.dart';
import '../../../../core/network/api_client.dart';
import '../../../../core/network/api_endpoints.dart';
import '../../domain/repositories/booking_repository.dart';
import '../../../../shared/models/booking_model.dart';

class BookingRepositoryImpl implements BookingRepository {
  final ApiClient _api;

  BookingRepositoryImpl(this._api);

  List<T> _extractList<T>(
    Response response,
    T Function(Map<String, dynamic>) fromJson,
  ) {
    final list = (response.data as Map<String, dynamic>)['data'] as List;
    return list.map((e) => fromJson(e as Map<String, dynamic>)).toList();
  }

  @override
  Future<List<BookingModel>> getVendorBookings(String date) async {
    try {
      final response = await _api.get(
        ApiEndpoints.vendorBookings,
        queryParameters: {'date': date},
      );
      return _extractList(response, BookingModel.fromJson);
    } on DioException catch (e) {
      throw Exception(ApiClient.extractErrorMessage(e));
    }
  }

  @override
  Future<List<BookingModel>> getCustomerBookings() async {
    try {
      final response = await _api.get(ApiEndpoints.customerBookings);
      return _extractList(response, BookingModel.fromJson);
    } on DioException catch (e) {
      throw Exception(ApiClient.extractErrorMessage(e));
    }
  }

  @override
  Future<List<AppointmentSlot>> getAvailableSlots(
    String vendorId,
    String date,
  ) async {
    try {
      final response = await _api.get(
        ApiEndpoints.publicSlots(vendorId),
        queryParameters: {'date': date},
      );
      return _extractList(response, AppointmentSlot.fromJson);
    } on DioException catch (e) {
      throw Exception(ApiClient.extractErrorMessage(e));
    }
  }

  @override
  Future<BookingModel> createBooking(BookingModel booking) async {
    try {
      final body = <String, dynamic>{
        'vendorId': booking.vendorId,
        'date': booking.date,
        'startTime': booking.startTime,
      };
      if (booking.serviceType != null && booking.serviceType!.isNotEmpty) {
        body['serviceType'] = booking.serviceType;
      }
      if (booking.notes != null && booking.notes!.isNotEmpty) {
        body['notes'] = booking.notes;
      }
      final response = await _api.post(ApiEndpoints.bookings, data: body);
      return BookingModel.fromJson(ApiClient.extractData(response));
    } on DioException catch (e) {
      throw Exception(ApiClient.extractErrorMessage(e));
    }
  }

  @override
  Future<BookingModel> updateBookingStatus(
    String bookingId,
    BookingStatus status,
  ) async {
    try {
      final response = await _api.patch(
        ApiEndpoints.bookingById(bookingId),
        data: {'status': status.toJson()},
      );
      return BookingModel.fromJson(ApiClient.extractData(response));
    } on DioException catch (e) {
      throw Exception(ApiClient.extractErrorMessage(e));
    }
  }

  @override
  Future<BookingConfig> saveBookingConfig(BookingConfig config) async {
    try {
      final response = await _api.put(
        ApiEndpoints.bookingConfig,
        data: config.toJson(),
      );
      final data = ApiClient.extractData(response);
      return BookingConfig.fromJson(data);
    } on DioException catch (e) {
      throw Exception(ApiClient.extractErrorMessage(e));
    }
  }

  @override
  Future<BookingConfig?> getBookingConfig() async {
    try {
      final response = await _api.get(ApiEndpoints.bookingConfig);
      final data = (response.data as Map<String, dynamic>)['data'];
      if (data == null) return null;
      return BookingConfig.fromJson(data as Map<String, dynamic>);
    } on DioException catch (e) {
      throw Exception(ApiClient.extractErrorMessage(e));
    }
  }

  @override
  Future<BookingConfig> toggleSlotFull({
    required int dayOfWeek,
    required String startTime,
    required bool isFull,
  }) async {
    try {
      final response = await _api.patch(
        ApiEndpoints.bookingSlotFull,
        data: {
          'dayOfWeek': dayOfWeek,
          'startTime': startTime,
          'isFull': isFull,
        },
      );
      final data = ApiClient.extractData(response);
      return BookingConfig.fromJson(data);
    } on DioException catch (e) {
      throw Exception(ApiClient.extractErrorMessage(e));
    }
  }
}
