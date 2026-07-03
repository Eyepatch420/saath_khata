import 'package:flutter_bloc/flutter_bloc.dart';
import '../../../../core/utils/app_logger.dart';
import '../../../../shared/models/schedule_model.dart';
import '../../domain/repositories/schedule_repository.dart';

// ─── Services Cubit ──────────────────────────────────────────────────────────

sealed class ServicesState {
  const ServicesState();
}

class ServicesLoading extends ServicesState {
  const ServicesLoading();
}

class ServicesLoaded extends ServicesState {
  final List<ScheduledService> services;
  final bool saving;
  const ServicesLoaded(this.services, {this.saving = false});
  ServicesLoaded copyWith({List<ScheduledService>? services, bool? saving}) =>
      ServicesLoaded(services ?? this.services, saving: saving ?? this.saving);
}

class ServicesError extends ServicesState {
  final String message;
  const ServicesError(this.message);
}

class ServicesCubit extends Cubit<ServicesState> {
  final ScheduleRepository _repo;
  static const _m = 'Services';

  ServicesCubit(this._repo) : super(const ServicesLoading());

  Future<void> load() async {
    emit(const ServicesLoading());
    try {
      emit(ServicesLoaded(await _repo.getServices()));
    } catch (e) {
      AppLogger.e(_m, 'Load failed', e);
      emit(ServicesError(_clean(e)));
    }
  }

  Future<bool> create({
    required String name,
    required ServiceType serviceType,
    required ScheduleType scheduleType,
    String? description,
    String? unit,
    double? defaultPricePerUnit,
    List<int>? deliveryDays,
    String? deliveryTime,
    bool autoCreateLedgerEntry = true,
  }) async {
    _setSaving(true);
    try {
      await _repo.createService(
        name: name,
        serviceType: serviceType,
        scheduleType: scheduleType,
        description: description,
        unit: unit,
        defaultPricePerUnit: defaultPricePerUnit,
        deliveryDays: deliveryDays,
        deliveryTime: deliveryTime,
        autoCreateLedgerEntry: autoCreateLedgerEntry,
      );
      emit(ServicesLoaded(await _repo.getServices()));
      return true;
    } catch (e) {
      AppLogger.e(_m, 'Create failed', e);
      emit(ServicesError(_clean(e)));
      emit(ServicesLoaded(await _safeList()));
      return false;
    }
  }

  Future<bool> deactivate(String id) async {
    _setSaving(true);
    try {
      await _repo.deactivateService(id);
      emit(ServicesLoaded(await _repo.getServices()));
      return true;
    } catch (e) {
      AppLogger.e(_m, 'Deactivate failed', e);
      emit(ServicesError(_clean(e)));
      emit(ServicesLoaded(await _safeList()));
      return false;
    }
  }

  void _setSaving(bool v) {
    final s = state;
    if (s is ServicesLoaded) emit(s.copyWith(saving: v));
  }

  Future<List<ScheduledService>> _safeList() async {
    try {
      return await _repo.getServices();
    } catch (_) {
      return const [];
    }
  }

  String _clean(Object e) => e.toString().replaceFirst('Exception: ', '');
}

// ─── Subscriptions Cubit (vendor side) ───────────────────────────────────────

sealed class SubscriptionsState {
  const SubscriptionsState();
}

class SubscriptionsLoading extends SubscriptionsState {
  const SubscriptionsLoading();
}

class SubscriptionsLoaded extends SubscriptionsState {
  final List<ServiceSubscription> subscriptions;
  final bool saving;
  const SubscriptionsLoaded(this.subscriptions, {this.saving = false});
  SubscriptionsLoaded copyWith({
    List<ServiceSubscription>? subscriptions,
    bool? saving,
  }) => SubscriptionsLoaded(
    subscriptions ?? this.subscriptions,
    saving: saving ?? this.saving,
  );
}

class SubscriptionsError extends SubscriptionsState {
  final String message;
  const SubscriptionsError(this.message);
}

class SubscriptionsCubit extends Cubit<SubscriptionsState> {
  final ScheduleRepository _repo;
  static const _m = 'Subscriptions';

  SubscriptionsCubit(this._repo) : super(const SubscriptionsLoading());

  Future<void> loadForVendor() async {
    emit(const SubscriptionsLoading());
    try {
      emit(SubscriptionsLoaded(await _repo.getAllSubscriptions()));
    } catch (e) {
      AppLogger.e(_m, 'Load vendor subs failed', e);
      emit(SubscriptionsError(_clean(e)));
    }
  }

  Future<void> loadForService(String serviceId) async {
    emit(const SubscriptionsLoading());
    try {
      emit(
        SubscriptionsLoaded(await _repo.getSubscriptionsForService(serviceId)),
      );
    } catch (e) {
      AppLogger.e(_m, 'Load service subs failed', e);
      emit(SubscriptionsError(_clean(e)));
    }
  }

  Future<bool> subscribe({
    required String serviceId,
    required String linkId,
    required double quantityPerDelivery,
    double? customPricePerUnit,
    required String startDate,
    String? endDate,
  }) async {
    _setSaving(true);
    try {
      await _repo.subscribe(
        serviceId: serviceId,
        linkId: linkId,
        quantityPerDelivery: quantityPerDelivery,
        customPricePerUnit: customPricePerUnit,
        startDate: startDate,
        endDate: endDate,
      );
      emit(SubscriptionsLoaded(await _repo.getAllSubscriptions()));
      return true;
    } catch (e) {
      AppLogger.e(_m, 'Subscribe failed', e);
      emit(SubscriptionsError(_clean(e)));
      emit(SubscriptionsLoaded(await _safeList()));
      return false;
    }
  }

  Future<bool> pause(String id, {String? pausedUntil}) async {
    _setSaving(true);
    try {
      await _repo.pauseSubscription(id, pausedUntil: pausedUntil);
      emit(SubscriptionsLoaded(await _repo.getAllSubscriptions()));
      return true;
    } catch (e) {
      AppLogger.e(_m, 'Pause failed', e);
      emit(SubscriptionsError(_clean(e)));
      emit(SubscriptionsLoaded(await _safeList()));
      return false;
    }
  }

  Future<bool> resume(String id) async {
    _setSaving(true);
    try {
      await _repo.resumeSubscription(id);
      emit(SubscriptionsLoaded(await _repo.getAllSubscriptions()));
      return true;
    } catch (e) {
      AppLogger.e(_m, 'Resume failed', e);
      emit(SubscriptionsError(_clean(e)));
      emit(SubscriptionsLoaded(await _safeList()));
      return false;
    }
  }

  Future<bool> remove(String id) async {
    _setSaving(true);
    try {
      await _repo.removeSubscription(id);
      emit(SubscriptionsLoaded(await _repo.getAllSubscriptions()));
      return true;
    } catch (e) {
      AppLogger.e(_m, 'Remove failed', e);
      emit(SubscriptionsError(_clean(e)));
      emit(SubscriptionsLoaded(await _safeList()));
      return false;
    }
  }

  void _setSaving(bool v) {
    final s = state;
    if (s is SubscriptionsLoaded) emit(s.copyWith(saving: v));
  }

  Future<List<ServiceSubscription>> _safeList() async {
    try {
      return await _repo.getAllSubscriptions();
    } catch (_) {
      return const [];
    }
  }

  String _clean(Object e) => e.toString().replaceFirst('Exception: ', '');
}

// ─── My Subscriptions Cubit (customer side) ───────────────────────────────────

class MySubscriptionsCubit extends Cubit<SubscriptionsState> {
  final ScheduleRepository _repo;
  static const _m = 'MySubscriptions';

  MySubscriptionsCubit(this._repo) : super(const SubscriptionsLoading());

  Future<void> load() async {
    emit(const SubscriptionsLoading());
    try {
      emit(SubscriptionsLoaded(await _repo.getMySubscriptions()));
    } catch (e) {
      AppLogger.e(_m, 'Load failed', e);
      emit(SubscriptionsError(_clean(e)));
    }
  }

  String _clean(Object e) => e.toString().replaceFirst('Exception: ', '');
}

// ─── Deliveries Cubit ─────────────────────────────────────────────────────────

sealed class DeliveriesState {
  const DeliveriesState();
}

class DeliveriesLoading extends DeliveriesState {
  const DeliveriesLoading();
}

class DeliveriesLoaded extends DeliveriesState {
  final List<ScheduledDelivery> deliveries;
  final int total;
  final int page;
  final bool saving;
  // Transient — set when an action (mark delivered/skip) fails, so the UI
  // can show a toast without losing the list. Cleared on the next action.
  final String? actionError;
  const DeliveriesLoaded({
    required this.deliveries,
    required this.total,
    required this.page,
    this.saving = false,
    this.actionError,
  });
  DeliveriesLoaded copyWith({
    List<ScheduledDelivery>? deliveries,
    int? total,
    int? page,
    bool? saving,
    String? actionError,
  }) => DeliveriesLoaded(
    deliveries: deliveries ?? this.deliveries,
    total: total ?? this.total,
    page: page ?? this.page,
    saving: saving ?? this.saving,
    actionError: actionError,
  );
}

class DeliveriesError extends DeliveriesState {
  final String message;
  const DeliveriesError(this.message);
}

class DeliveriesCubit extends Cubit<DeliveriesState> {
  final ScheduleRepository _repo;
  final bool _isCustomer;
  static const _m = 'Deliveries';

  DeliveriesCubit(this._repo, {bool isCustomer = false})
    : _isCustomer = isCustomer,
      super(const DeliveriesLoading());

  Future<void> load({
    String? date,
    String? serviceId,
    String? status,
    String? linkId,
  }) async {
    emit(const DeliveriesLoading());
    try {
      final result = _isCustomer
          ? await _repo.getMyDeliveries(date: date)
          : await _repo.getVendorDeliveries(
              date: date,
              serviceId: serviceId,
              status: status,
              linkId: linkId,
            );
      emit(
        DeliveriesLoaded(
          deliveries: result.deliveries,
          total: result.total,
          page: result.page,
        ),
      );
    } catch (e) {
      AppLogger.e(_m, 'Load failed', e);
      emit(DeliveriesError(_clean(e)));
    }
  }

  Future<bool> markDelivered(String id) async {
    _setSaving(true);
    try {
      final updated = await _repo.markDelivered(id);
      final s = state;
      if (s is DeliveriesLoaded) {
        final list = s.deliveries.map((d) => d.id == id ? updated : d).toList();
        emit(s.copyWith(deliveries: list, saving: false));
      }
      return true;
    } catch (e) {
      AppLogger.e(_m, 'Mark delivered failed', e);
      final s = state;
      if (s is DeliveriesLoaded) {
        emit(s.copyWith(saving: false, actionError: _clean(e)));
      }
      return false;
    }
  }

  Future<bool> skip(String id, {String? notes}) async {
    _setSaving(true);
    try {
      final updated = await _repo.skipDelivery(id, notes: notes);
      final s = state;
      if (s is DeliveriesLoaded) {
        final list = s.deliveries.map((d) => d.id == id ? updated : d).toList();
        emit(s.copyWith(deliveries: list, saving: false));
      }
      return true;
    } catch (e) {
      AppLogger.e(_m, 'Skip failed', e);
      final s = state;
      if (s is DeliveriesLoaded) {
        emit(s.copyWith(saving: false, actionError: _clean(e)));
      }
      return false;
    }
  }

  void _setSaving(bool v) {
    final s = state;
    if (s is DeliveriesLoaded) emit(s.copyWith(saving: v));
  }

  String _clean(Object e) => e.toString().replaceFirst('Exception: ', '');
}
