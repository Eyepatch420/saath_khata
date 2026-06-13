import 'package:flutter_bloc/flutter_bloc.dart';
import '../../../../core/utils/app_logger.dart';
import '../../domain/models/membership_tier.dart';
import '../../domain/repositories/membership_repository.dart';

// ── State ─────────────────────────────────────────────────────────────────────

sealed class MembershipTiersState {
  const MembershipTiersState();
}

class MembershipTiersLoading extends MembershipTiersState {
  const MembershipTiersLoading();
}

class MembershipTiersLoaded extends MembershipTiersState {
  final List<MembershipTier> tiers;
  final bool saving;
  const MembershipTiersLoaded(this.tiers, {this.saving = false});

  MembershipTiersLoaded copyWith({List<MembershipTier>? tiers, bool? saving}) =>
      MembershipTiersLoaded(tiers ?? this.tiers, saving: saving ?? this.saving);
}

class MembershipTiersError extends MembershipTiersState {
  final String message;
  const MembershipTiersError(this.message);
}

// ── Cubit ─────────────────────────────────────────────────────────────────────

/// Vendor-facing management of their three membership tiers: rename + discount.
class MembershipTiersCubit extends Cubit<MembershipTiersState> {
  final MembershipRepository _repo;
  static const _m = 'MembershipTiers';

  MembershipTiersCubit(this._repo) : super(const MembershipTiersLoading());

  Future<void> load() async {
    emit(const MembershipTiersLoading());
    try {
      final tiers = await _repo.getTiers();
      emit(MembershipTiersLoaded(tiers));
    } catch (e) {
      AppLogger.e(_m, 'Load tiers failed', e);
      emit(MembershipTiersError(_clean(e)));
    }
  }

  /// Update a single tier (rename and/or discount). Optimistically flags saving,
  /// then swaps in the server's authoritative tier on success.
  Future<void> updateTier(
    String tierId, {
    String? name,
    DiscountType? discountType,
    double? discountValue,
    double? discountCap,
    bool clearCap = false,
  }) async {
    final current = state;
    if (current is! MembershipTiersLoaded) return;
    emit(current.copyWith(saving: true));
    try {
      final updated = await _repo.updateTier(
        tierId,
        name: name,
        discountType: discountType,
        discountValue: discountValue,
        discountCap: discountCap,
        clearCap: clearCap,
      );
      final next = current.tiers
          .map((t) => t.id == updated.id ? updated : t)
          .toList();
      emit(MembershipTiersLoaded(next));
    } catch (e) {
      AppLogger.e(_m, 'Update tier failed', e);
      emit(MembershipTiersError(_clean(e)));
      emit(current.copyWith(saving: false)); // restore so the screen re-enables
    }
  }

  String _clean(Object e) => e.toString().replaceFirst('Exception: ', '');
}
