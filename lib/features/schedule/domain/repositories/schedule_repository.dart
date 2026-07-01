import '../../../../shared/models/schedule_model.dart';

abstract class ScheduleRepository {
  // -------------------------------------------------------------------------
  // Services (vendor)
  // -------------------------------------------------------------------------

  Future<List<ScheduledService>> getServices();

  Future<ScheduledService> createService({
    required String name,
    required ServiceType serviceType,
    required ScheduleType scheduleType,
    String? description,
    String? unit,
    double? defaultPricePerUnit,
    List<int>? deliveryDays,
    String? deliveryTime,
    bool autoCreateLedgerEntry = true,
  });

  Future<ScheduledService> updateService(
    String id, {
    String? name,
    String? description,
    String? unit,
    double? defaultPricePerUnit,
    ScheduleType? scheduleType,
    List<int>? deliveryDays,
    String? deliveryTime,
    bool? autoCreateLedgerEntry,
  });

  Future<void> deactivateService(String id);

  // -------------------------------------------------------------------------
  // Subscriptions (vendor view)
  // -------------------------------------------------------------------------

  Future<List<ServiceSubscription>> getSubscriptionsForService(String serviceId);

  Future<List<ServiceSubscription>> getAllSubscriptions();

  Future<ServiceSubscription> subscribe({
    required String serviceId,
    required String linkId,
    required double quantityPerDelivery,
    double? customPricePerUnit,
    required String startDate,
    String? endDate,
  });

  Future<void> removeSubscription(String id);

  Future<ServiceSubscription> pauseSubscription(String id, {String? pausedUntil});

  Future<ServiceSubscription> resumeSubscription(String id);

  // -------------------------------------------------------------------------
  // Subscriptions (customer / my view)
  // -------------------------------------------------------------------------

  Future<List<ServiceSubscription>> getMySubscriptions();

  // -------------------------------------------------------------------------
  // Deliveries (vendor view)
  // -------------------------------------------------------------------------

  Future<({List<ScheduledDelivery> deliveries, int total, int page})> getVendorDeliveries({
    String? date,
    String? startDate,
    String? endDate,
    String? serviceId,
    String? status,
    String? linkId,
    int page = 1,
    int limit = 50,
  });

  Future<ScheduledDelivery> markDelivered(String id);

  Future<ScheduledDelivery> skipDelivery(String id, {String? notes});

  // -------------------------------------------------------------------------
  // Deliveries (customer / my view)
  // -------------------------------------------------------------------------

  Future<({List<ScheduledDelivery> deliveries, int total, int page})> getMyDeliveries({
    String? date,
    String? startDate,
    String? endDate,
    int page = 1,
    int limit = 50,
  });
}
