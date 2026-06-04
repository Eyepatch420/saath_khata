import '../../domain/models/link_request_model.dart';

sealed class LinkRequestState {
  const LinkRequestState();
}

class LinkRequestInitial extends LinkRequestState {
  const LinkRequestInitial();
}

class LinkRequestLoading extends LinkRequestState {
  const LinkRequestLoading();
}

class LinkRequestLoaded extends LinkRequestState {
  final LinkRequestModel request;
  const LinkRequestLoaded(this.request);
}

/// After accept/decline — carries the updated request.
class LinkRequestResponded extends LinkRequestState {
  final LinkRequestModel request;
  const LinkRequestResponded(this.request);
}

class LinkRequestError extends LinkRequestState {
  final String message;
  const LinkRequestError(this.message);
}

// ── For the customer "send request" flow ─────────────────────────────────────

sealed class SendRequestState {
  const SendRequestState();
}

class SendRequestIdle extends SendRequestState {
  const SendRequestIdle();
}

class SendRequestSending extends SendRequestState {
  const SendRequestSending();
}

class SendRequestSuccess extends SendRequestState {
  final LinkRequestModel request;
  const SendRequestSuccess(this.request);
}

class SendRequestError extends SendRequestState {
  final String message;
  const SendRequestError(this.message);
}
