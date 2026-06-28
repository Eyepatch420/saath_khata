import 'package:equatable/equatable.dart';

enum OrderStatus { pending, confirmed, rejected, delivered, cancelled }

extension OrderStatusX on OrderStatus {
  String toJson() => name;

  String get label => switch (this) {
        OrderStatus.pending => 'Pending',
        OrderStatus.confirmed => 'Confirmed',
        OrderStatus.rejected => 'Rejected',
        OrderStatus.delivered => 'Delivered',
        OrderStatus.cancelled => 'Cancelled',
      };
}

OrderStatus _orderStatusFromJson(String v) =>
    OrderStatus.values.firstWhere((e) => e.name == v, orElse: () => OrderStatus.pending);

class OrderItem extends Equatable {
  final String id;
  final String name;
  final String? qty;
  final String? note;
  final int sortOrder;

  const OrderItem({
    required this.id,
    required this.name,
    this.qty,
    this.note,
    required this.sortOrder,
  });

  factory OrderItem.fromJson(Map<String, dynamic> json) => OrderItem(
        id: json['id'] as String,
        name: json['name'] as String,
        qty: json['qty'] as String?,
        note: json['note'] as String?,
        sortOrder: json['sortOrder'] as int? ?? 0,
      );

  Map<String, dynamic> toJson() => {
        'id': id,
        'name': name,
        if (qty != null) 'qty': qty,
        if (note != null) 'note': note,
        'sortOrder': sortOrder,
      };

  @override
  List<Object?> get props => [id, name, qty, note, sortOrder];
}

class Order extends Equatable {
  final String id;
  final String linkId;
  final String vendorId;
  final String customerId;
  final String? customerName;
  final OrderStatus status;
  final String? note;
  final List<OrderItem> items;
  final String? deliveredBy;
  final DateTime? deliveredAt;
  final String? ledgerEntryId;
  final DateTime createdAt;
  final DateTime updatedAt;

  const Order({
    required this.id,
    required this.linkId,
    required this.vendorId,
    required this.customerId,
    this.customerName,
    required this.status,
    this.note,
    required this.items,
    this.deliveredBy,
    this.deliveredAt,
    this.ledgerEntryId,
    required this.createdAt,
    required this.updatedAt,
  });

  factory Order.fromJson(Map<String, dynamic> json) => Order(
        id: json['id'] as String,
        linkId: json['linkId'] as String,
        vendorId: json['vendorId'] as String,
        customerId: json['customerId'] as String,
        customerName: json['customerName'] as String?,
        status: _orderStatusFromJson(json['status'] as String),
        note: json['note'] as String?,
        items: (json['items'] as List<dynamic>)
            .map((e) => OrderItem.fromJson(e as Map<String, dynamic>))
            .toList(),
        deliveredBy: json['deliveredBy'] as String?,
        deliveredAt: json['deliveredAt'] != null
            ? DateTime.tryParse(json['deliveredAt'] as String)
            : null,
        ledgerEntryId: json['ledgerEntryId'] as String?,
        createdAt: DateTime.parse(json['createdAt'] as String),
        updatedAt: DateTime.parse(json['updatedAt'] as String),
      );

  Order copyWith({
    String? id,
    String? linkId,
    String? vendorId,
    String? customerId,
    String? customerName,
    OrderStatus? status,
    String? note,
    List<OrderItem>? items,
    String? deliveredBy,
    DateTime? deliveredAt,
    String? ledgerEntryId,
    DateTime? createdAt,
    DateTime? updatedAt,
  }) =>
      Order(
        id: id ?? this.id,
        linkId: linkId ?? this.linkId,
        vendorId: vendorId ?? this.vendorId,
        customerId: customerId ?? this.customerId,
        customerName: customerName ?? this.customerName,
        status: status ?? this.status,
        note: note ?? this.note,
        items: items ?? this.items,
        deliveredBy: deliveredBy ?? this.deliveredBy,
        deliveredAt: deliveredAt ?? this.deliveredAt,
        ledgerEntryId: ledgerEntryId ?? this.ledgerEntryId,
        createdAt: createdAt ?? this.createdAt,
        updatedAt: updatedAt ?? this.updatedAt,
      );

  @override
  List<Object?> get props => [
        id,
        linkId,
        vendorId,
        customerId,
        customerName,
        status,
        note,
        items,
        deliveredBy,
        deliveredAt,
        ledgerEntryId,
        createdAt,
        updatedAt,
      ];
}

class OrderListResult extends Equatable {
  final List<Order> orders;
  final int total;
  final int pending;

  const OrderListResult({
    required this.orders,
    required this.total,
    required this.pending,
  });

  factory OrderListResult.fromJson(Map<String, dynamic> json) => OrderListResult(
        orders: (json['orders'] as List<dynamic>)
            .map((e) => Order.fromJson(e as Map<String, dynamic>))
            .toList(),
        total: json['total'] as int,
        pending: json['pending'] as int,
      );

  @override
  List<Object?> get props => [orders, total, pending];
}
