import '../models/link_request_model.dart';

abstract class LinkRequestRepository {
  Future<LinkRequestModel> sendRequest({
    required String vendorId,
    String? message,
  });

  Future<LinkRequestModel> acceptRequest(String requestId);

  Future<LinkRequestModel> declineRequest(String requestId);

  Future<LinkRequestModel> getRequestById(String requestId);

  Future<List<LinkRequestModel>> getPendingRequests();   // vendor
  Future<List<LinkRequestModel>> getSentRequests();      // customer
}
