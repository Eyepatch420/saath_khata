import 'package:equatable/equatable.dart';

// ---------------------------------------------------------------------------
// Enums
// ---------------------------------------------------------------------------

enum ServiceType { product, session }

extension ServiceTypeX on ServiceType {
  String toJson() => name; // 'product' | 'session'

  String get label => switch (this) {
    ServiceType.product => 'Product',
    ServiceType.session => 'Session',
  };
}

ServiceType _serviceTypeFromJson(String v) => ServiceType.values.firstWhere(
  (e) => e.name == v,
  orElse: () => ServiceType.product,
);

enum ScheduleType { daily, weekly, customDays }

extension ScheduleTypeX on ScheduleType {
  String toJson() => switch (this) {
    ScheduleType.daily => 'daily',
    ScheduleType.weekly => 'weekly',
    ScheduleType.customDays => 'custom_days',
  };

  String get label => switch (this) {
    ScheduleType.daily => 'Daily',
    ScheduleType.weekly => 'Weekly',
    ScheduleType.customDays => 'Custom Days',
  };
}

ScheduleType _scheduleTypeFromJson(String v) => switch (v) {
  'weekly' => ScheduleType.weekly,
  'custom_days' => ScheduleType.customDays,
  _ => ScheduleType.daily,
};

enum DeliveryStatus { scheduled, delivered, skipped, failed }

extension DeliveryStatusX on DeliveryStatus {
  String toJson() => name; // 'scheduled' | 'delivered' | 'skipped' | 'failed'

  String get label => switch (this) {
    DeliveryStatus.scheduled => 'Scheduled',
    DeliveryStatus.delivered => 'Delivered',
    DeliveryStatus.skipped => 'Skipped',
    DeliveryStatus.failed => 'Failed',
  };
}

DeliveryStatus _deliveryStatusFromJson(String v) => DeliveryStatus.values
    .firstWhere((e) => e.name == v, orElse: () => DeliveryStatus.scheduled);

// ---------------------------------------------------------------------------
// Day-of-week names (0 = Sun … 6 = Sat)
// ---------------------------------------------------------------------------
const _dayNames = ['Sun', 'Mon', 'Tue', 'Wed', 'Thu', 'Fri', 'Sat'];

// ---------------------------------------------------------------------------
// ScheduledService
// ---------------------------------------------------------------------------

class ScheduledService extends Equatable {
  final String id;
  final String name;
  final String? description;
  final ServiceType serviceType;
  final String? unit;
  final double? defaultPricePerUnit;
  final ScheduleType scheduleType;
  final List<int>? deliveryDays;
  final String? deliveryTime;
  final bool autoCreateLedgerEntry;
  final bool isActive;
  final int subscriberCount;
  final DateTime createdAt;

  const ScheduledService({
    required this.id,
    required this.name,
    this.description,
    required this.serviceType,
    this.unit,
    this.defaultPricePerUnit,
    required this.scheduleType,
    this.deliveryDays,
    this.deliveryTime,
    required this.autoCreateLedgerEntry,
    required this.isActive,
    required this.subscriberCount,
    required this.createdAt,
  });

  /// Human-readable delivery schedule label.
  /// - Daily → "Daily"
  /// - Weekly → "Mon, Wed, Fri" (from deliveryDays)
  /// - Custom days → "Custom"
  String get scheduleLabel {
    switch (scheduleType) {
      case ScheduleType.daily:
        return 'Daily';
      case ScheduleType.weekly:
        if (deliveryDays != null && deliveryDays!.isNotEmpty) {
          return deliveryDays!
              .map((d) => d >= 0 && d < _dayNames.length ? _dayNames[d] : '$d')
              .join(', ');
        }
        return 'Weekly';
      case ScheduleType.customDays:
        if (deliveryDays != null && deliveryDays!.isNotEmpty) {
          return deliveryDays!
              .map((d) => d >= 0 && d < _dayNames.length ? _dayNames[d] : '$d')
              .join(', ');
        }
        return 'Custom';
    }
  }

  factory ScheduledService.fromJson(Map<String, dynamic> json) =>
      ScheduledService(
        id: json['id'] as String,
        name: json['name'] as String,
        description: json['description'] as String?,
        serviceType: _serviceTypeFromJson(json['serviceType'] as String),
        unit: json['unit'] as String?,
        defaultPricePerUnit: (json['defaultPricePerUnit'] as num?)?.toDouble(),
        scheduleType: _scheduleTypeFromJson(json['scheduleType'] as String),
        deliveryDays: (json['deliveryDays'] as List<dynamic>?)
            ?.map((e) => e as int)
            .toList(),
        deliveryTime: json['deliveryTime'] as String?,
        autoCreateLedgerEntry: json['autoCreateLedgerEntry'] as bool? ?? true,
        isActive: json['isActive'] as bool? ?? true,
        subscriberCount: json['subscriberCount'] as int? ?? 0,
        createdAt: DateTime.parse(json['createdAt'] as String),
      );

  @override
  List<Object?> get props => [
    id,
    name,
    description,
    serviceType,
    unit,
    defaultPricePerUnit,
    scheduleType,
    deliveryDays,
    deliveryTime,
    autoCreateLedgerEntry,
    isActive,
    subscriberCount,
    createdAt,
  ];
}

// ---------------------------------------------------------------------------
// ServiceSubscription
// ---------------------------------------------------------------------------

class ServiceSubscription extends Equatable {
  final String id;
  final String serviceId;
  final String serviceName;
  final ServiceType serviceType;
  final String vendorName;
  final double quantityPerDelivery;
  final String? unit;
  final double? effectivePrice;
  final DateTime? nextDeliveryDate;
  final DateTime startDate;
  final DateTime? endDate;
  final bool isActive;
  final bool isPaused;
  final DateTime? pausedUntil;
  final String linkId;
  final String customerId;
  final String customerName;
  final String vendorId;

  const ServiceSubscription({
    required this.id,
    required this.serviceId,
    required this.serviceName,
    required this.serviceType,
    required this.vendorName,
    required this.quantityPerDelivery,
    this.unit,
    this.effectivePrice,
    this.nextDeliveryDate,
    required this.startDate,
    this.endDate,
    required this.isActive,
    required this.isPaused,
    this.pausedUntil,
    required this.linkId,
    required this.customerId,
    required this.customerName,
    required this.vendorId,
  });

  factory ServiceSubscription.fromJson(Map<String, dynamic> json) =>
      ServiceSubscription(
        id: json['id'] as String,
        serviceId: json['serviceId'] as String,
        serviceName: json['serviceName'] as String,
        serviceType: _serviceTypeFromJson(json['serviceType'] as String),
        vendorName: json['vendorName'] as String,
        quantityPerDelivery: (json['quantityPerDelivery'] as num).toDouble(),
        unit: json['unit'] as String?,
        effectivePrice: (json['effectivePrice'] as num?)?.toDouble(),
        nextDeliveryDate: json['nextDeliveryDate'] != null
            ? DateTime.tryParse(json['nextDeliveryDate'] as String)
            : null,
        startDate: DateTime.parse(json['startDate'] as String),
        endDate: json['endDate'] != null
            ? DateTime.tryParse(json['endDate'] as String)
            : null,
        isActive: json['isActive'] as bool? ?? true,
        isPaused: json['isPaused'] as bool? ?? false,
        pausedUntil: json['pausedUntil'] != null
            ? DateTime.tryParse(json['pausedUntil'] as String)
            : null,
        linkId: json['linkId'] as String,
        customerId: json['customerId'] as String,
        customerName: json['customerName'] as String? ?? '',
        vendorId: json['vendorId'] as String,
      );

  @override
  List<Object?> get props => [
    id,
    serviceId,
    serviceName,
    serviceType,
    vendorName,
    quantityPerDelivery,
    unit,
    effectivePrice,
    nextDeliveryDate,
    startDate,
    endDate,
    isActive,
    isPaused,
    pausedUntil,
    linkId,
    customerId,
    customerName,
    vendorId,
  ];
}

// ---------------------------------------------------------------------------
// ScheduledDelivery
// ---------------------------------------------------------------------------

class ScheduledDelivery extends Equatable {
  final String id;
  final String subscriptionId;
  final String serviceId;
  final String serviceName;
  final String linkId;
  final String vendorId;
  final String customerId;
  final String customerName;
  final String? customerAddress;
  final String? customerPhone;
  final DateTime scheduledDate;
  final DeliveryStatus status;
  final String? ledgerEntryId;
  final DateTime? deliveredAt;
  final String? notes;
  final double quantityPerDelivery;
  final String? unit;
  final String? deliveryTime;

  const ScheduledDelivery({
    required this.id,
    required this.subscriptionId,
    required this.serviceId,
    required this.serviceName,
    required this.linkId,
    required this.vendorId,
    required this.customerId,
    required this.customerName,
    this.customerAddress,
    this.customerPhone,
    required this.scheduledDate,
    required this.status,
    this.ledgerEntryId,
    this.deliveredAt,
    this.notes,
    required this.quantityPerDelivery,
    this.unit,
    this.deliveryTime,
  });

  /// Whether it's time to act on this delivery yet. A `scheduled` delivery
  /// with no [deliveryTime] set is due immediately (today's default); one
  /// with a delivery_time (e.g. "09:00") is only due once the current time
  /// passes that, so staff/vendor see it as "Upcoming" beforehand instead of
  /// an actionable item indistinguishable from ones that are actually due.
  bool get isDue {
    if (status != DeliveryStatus.scheduled) return true;
    final time = deliveryTime;
    if (time == null || time.isEmpty) return true;
    final parts = time.split(':');
    if (parts.length < 2) return true;
    final hour = int.tryParse(parts[0]);
    final minute = int.tryParse(parts[1]);
    if (hour == null || minute == null) return true;
    final now = DateTime.now();
    final due = DateTime(now.year, now.month, now.day, hour, minute);
    return !now.isBefore(due);
  }

  factory ScheduledDelivery.fromJson(Map<String, dynamic> json) =>
      ScheduledDelivery(
        id: json['id'] as String,
        subscriptionId: json['subscriptionId'] as String,
        serviceId: json['serviceId'] as String,
        serviceName: json['serviceName'] as String,
        linkId: json['linkId'] as String,
        vendorId: json['vendorId'] as String,
        customerId: json['customerId'] as String,
        customerName: json['customerName'] as String,
        customerAddress: json['customerAddress'] as String?,
        customerPhone: json['customerPhone'] as String?,
        scheduledDate: DateTime.parse(json['scheduledDate'] as String),
        status: _deliveryStatusFromJson(json['status'] as String),
        ledgerEntryId: json['ledgerEntryId'] as String?,
        deliveredAt: json['deliveredAt'] != null
            ? DateTime.tryParse(json['deliveredAt'] as String)
            : null,
        notes: json['notes'] as String?,
        quantityPerDelivery: (json['quantityPerDelivery'] as num).toDouble(),
        unit: json['unit'] as String?,
        deliveryTime: json['deliveryTime'] as String?,
      );

  @override
  List<Object?> get props => [
    id,
    subscriptionId,
    serviceId,
    serviceName,
    linkId,
    vendorId,
    customerId,
    customerName,
    customerAddress,
    customerPhone,
    scheduledDate,
    status,
    ledgerEntryId,
    deliveredAt,
    notes,
    quantityPerDelivery,
    unit,
    deliveryTime,
  ];
}
