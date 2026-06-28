import '../../../../shared/models/order_model.dart';

abstract class OrderRepository {
  Future<OrderListResult> getVendorOrders({String? status});
  Future<OrderListResult> getCustomerOrders();
  Future<OrderListResult> getStaffOrders();
  Future<Order> placeOrder({
    required String linkId,
    required List<Map<String, String?>> items,
    String? note,
  });
  Future<Order> updateOrderStatus(String orderId, OrderStatus status);
}
