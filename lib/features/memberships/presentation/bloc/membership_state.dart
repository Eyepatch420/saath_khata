import '../../domain/models/membership_status.dart';

sealed class MembershipState {
  const MembershipState();
}

class MembershipInitial extends MembershipState {
  const MembershipInitial();
}

class MembershipLoading extends MembershipState {
  const MembershipLoading();
}

class MembershipLoaded extends MembershipState {
  final MembershipStatus status;

  /// True while an assign/request/approve/decline call is in flight — the UI
  /// keeps showing the current banner but disables the buttons.
  final bool actionInProgress;

  const MembershipLoaded(this.status, {this.actionInProgress = false});

  MembershipLoaded copyWith({MembershipStatus? status, bool? actionInProgress}) =>
      MembershipLoaded(
        status ?? this.status,
        actionInProgress: actionInProgress ?? this.actionInProgress,
      );
}

class MembershipError extends MembershipState {
  final String message;
  const MembershipError(this.message);
}
