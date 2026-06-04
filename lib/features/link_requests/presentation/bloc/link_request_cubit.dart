import 'package:flutter_bloc/flutter_bloc.dart';
import '../../domain/repositories/link_request_repository.dart';
import 'link_request_state.dart';

/// Manages the vendor approval screen state — load, accept, decline.
class LinkRequestCubit extends Cubit<LinkRequestState> {
  final LinkRequestRepository _repo;

  LinkRequestCubit(this._repo) : super(const LinkRequestInitial());

  Future<void> loadRequest(String requestId) async {
    emit(const LinkRequestLoading());
    try {
      final req = await _repo.getRequestById(requestId);
      emit(LinkRequestLoaded(req));
    } catch (e) {
      emit(LinkRequestError(e.toString().replaceFirst('Exception: ', '')));
    }
  }

  Future<void> accept(String requestId) async {
    emit(const LinkRequestLoading());
    try {
      final req = await _repo.acceptRequest(requestId);
      emit(LinkRequestResponded(req));
    } catch (e) {
      emit(LinkRequestError(e.toString().replaceFirst('Exception: ', '')));
    }
  }

  Future<void> decline(String requestId) async {
    emit(const LinkRequestLoading());
    try {
      final req = await _repo.declineRequest(requestId);
      emit(LinkRequestResponded(req));
    } catch (e) {
      emit(LinkRequestError(e.toString().replaceFirst('Exception: ', '')));
    }
  }
}

/// Manages the customer "send request" CTA on the vendor profile screen.
class SendLinkRequestCubit extends Cubit<SendRequestState> {
  final LinkRequestRepository _repo;

  SendLinkRequestCubit(this._repo) : super(const SendRequestIdle());

  Future<void> send({required String vendorId, String? message}) async {
    emit(const SendRequestSending());
    try {
      final req = await _repo.sendRequest(vendorId: vendorId, message: message);
      emit(SendRequestSuccess(req));
    } catch (e) {
      emit(SendRequestError(e.toString().replaceFirst('Exception: ', '')));
    }
  }

  void reset() => emit(const SendRequestIdle());
}
