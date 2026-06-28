import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import '../../../../core/constants/app_colors.dart';
import '../../../../shared/models/order_model.dart';
import '../bloc/order_bloc.dart';
import '../bloc/order_event.dart';
import '../bloc/order_state.dart';
import 'order_detail_screen.dart';

class CustomerOrdersScreen extends StatefulWidget {
  const CustomerOrdersScreen({super.key});

  @override
  State<CustomerOrdersScreen> createState() => _CustomerOrdersScreenState();
}

class _CustomerOrdersScreenState extends State<CustomerOrdersScreen> {
  @override
  void initState() {
    super.initState();
    context.read<OrderBloc>().add(const LoadCustomerOrders());
  }

  Color _statusColor(OrderStatus s) => switch (s) {
        OrderStatus.pending => AppColors.warning,
        OrderStatus.confirmed => Colors.blue,
        OrderStatus.delivered => AppColors.success,
        OrderStatus.rejected => AppColors.error,
        OrderStatus.cancelled => AppColors.textSecondary,
      };

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text('My Orders'),
        backgroundColor: AppColors.primary,
        foregroundColor: Colors.white,
      ),
      body: BlocBuilder<OrderBloc, OrderState>(
        builder: (context, state) {
          if (state is OrderLoading) {
            return const Center(child: CircularProgressIndicator());
          }
          if (state is OrderError) {
            return Center(child: Text(state.message));
          }
          final orders = switch (state) {
            OrderLoaded(orders: final o) => o,
            OrderActionLoading(orders: final o) => o,
            _ => <Order>[],
          };
          if (orders.isEmpty) {
            return const Center(child: Text('No orders yet'));
          }
          return RefreshIndicator(
            onRefresh: () async =>
                context.read<OrderBloc>().add(const LoadCustomerOrders()),
            child: ListView.separated(
              padding: const EdgeInsets.all(16),
              itemCount: orders.length,
              separatorBuilder: (_, i) => const SizedBox(height: 8),
              itemBuilder: (ctx, i) {
                final order = orders[i];
                return Card(
                  clipBehavior: Clip.antiAlias,
                  child: InkWell(
                    onTap: () => Navigator.of(context).push(
                      MaterialPageRoute(
                        builder: (_) => BlocProvider.value(
                          value: context.read<OrderBloc>(),
                          child: OrderDetailScreen(order: order, role: 'customer'),
                        ),
                      ),
                    ),
                    child: Padding(
                    padding: const EdgeInsets.all(12),
                    child: Column(
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children: [
                        Row(
                          children: [
                            Text(
                              '${order.items.length} item${order.items.length > 1 ? 's' : ''}',
                              style: const TextStyle(
                                  fontWeight: FontWeight.w600, fontSize: 15),
                            ),
                            const Spacer(),
                            Container(
                              padding: const EdgeInsets.symmetric(
                                  horizontal: 8, vertical: 3),
                              decoration: BoxDecoration(
                                color: _statusColor(order.status)
                                    .withValues(alpha: 0.15),
                                borderRadius: BorderRadius.circular(12),
                              ),
                              child: Text(
                                order.status.label,
                                style: TextStyle(
                                    color: _statusColor(order.status),
                                    fontSize: 12,
                                    fontWeight: FontWeight.w600),
                              ),
                            ),
                          ],
                        ),
                        const SizedBox(height: 8),
                        ...order.items.map((item) => Padding(
                              padding: const EdgeInsets.only(bottom: 3),
                              child: Row(
                                children: [
                                  const Text('• ',
                                      style: TextStyle(
                                          color: AppColors.textSecondary)),
                                  Expanded(child: Text(item.name)),
                                  if (item.qty != null)
                                    Text(item.qty!,
                                        style: const TextStyle(
                                            color: AppColors.textSecondary)),
                                ],
                              ),
                            )),
                        if (order.note != null) ...[
                          const SizedBox(height: 6),
                          Text(
                            'Note: ${order.note}',
                            style: const TextStyle(
                                color: AppColors.textSecondary,
                                fontStyle: FontStyle.italic,
                                fontSize: 13),
                          ),
                        ],
                        const SizedBox(height: 6),
                        Text(
                          _formatDate(order.createdAt),
                          style: const TextStyle(
                              color: AppColors.textSecondary, fontSize: 12),
                        ),
                      ],
                    ),
                  ),
                  ),
                );
              },
            ),
          );
        },
      ),
    );
  }

  String _formatDate(DateTime dt) {
    final now = DateTime.now();
    final diff = now.difference(dt);
    if (diff.inDays == 0) return 'Today';
    if (diff.inDays == 1) return 'Yesterday';
    return '${dt.day}/${dt.month}/${dt.year}';
  }
}
