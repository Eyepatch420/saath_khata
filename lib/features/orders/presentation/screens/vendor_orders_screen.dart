import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import '../../../../core/constants/app_colors.dart';
import '../../../../shared/models/order_model.dart';
import '../bloc/order_bloc.dart';
import '../bloc/order_event.dart';
import '../bloc/order_state.dart';

class VendorOrdersScreen extends StatefulWidget {
  const VendorOrdersScreen({super.key});

  @override
  State<VendorOrdersScreen> createState() => _VendorOrdersScreenState();
}

class _VendorOrdersScreenState extends State<VendorOrdersScreen>
    with SingleTickerProviderStateMixin {
  late TabController _tabs;

  static const _statuses = ['all', 'pending', 'confirmed', 'delivered'];
  static const _labels = ['All', 'Pending', 'Confirmed', 'Delivered'];

  @override
  void initState() {
    super.initState();
    _tabs = TabController(length: _statuses.length, vsync: this);
    _tabs.addListener(() {
      if (!_tabs.indexIsChanging) {
        final s = _statuses[_tabs.index];
        context.read<OrderBloc>().add(LoadVendorOrders(statusFilter: s == 'all' ? null : s));
      }
    });
    context.read<OrderBloc>().add(const LoadVendorOrders());
  }

  @override
  void dispose() {
    _tabs.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text('Orders'),
        backgroundColor: AppColors.primary,
        foregroundColor: Colors.white,
        bottom: TabBar(
          controller: _tabs,
          labelColor: Colors.white,
          unselectedLabelColor: Colors.white70,
          indicatorColor: Colors.white,
          tabs: _labels.map((l) => Tab(text: l)).toList(),
        ),
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
            onRefresh: () async {
              final s = _statuses[_tabs.index];
              context.read<OrderBloc>().add(LoadVendorOrders(statusFilter: s == 'all' ? null : s));
            },
            child: ListView.separated(
              padding: const EdgeInsets.all(16),
              itemCount: orders.length,
              separatorBuilder: (_, i) => const SizedBox(height: 8),
              itemBuilder: (ctx, i) => _OrderCard(order: orders[i], isVendor: true),
            ),
          );
        },
      ),
    );
  }
}

class _OrderCard extends StatelessWidget {
  final Order order;
  final bool isVendor;

  const _OrderCard({required this.order, required this.isVendor});

  Color _statusColor(OrderStatus s) => switch (s) {
        OrderStatus.pending => AppColors.warning,
        OrderStatus.confirmed => Colors.blue,
        OrderStatus.delivered => AppColors.success,
        OrderStatus.rejected => AppColors.error,
        OrderStatus.cancelled => AppColors.textSecondary,
      };

  @override
  Widget build(BuildContext context) {
    return Card(
      child: Padding(
        padding: const EdgeInsets.all(12),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Row(
              children: [
                if (order.customerName != null)
                  Expanded(
                    child: Text(order.customerName!,
                        style: const TextStyle(fontWeight: FontWeight.w600, fontSize: 15)),
                  ),
                Container(
                  padding: const EdgeInsets.symmetric(horizontal: 8, vertical: 3),
                  decoration: BoxDecoration(
                    color: _statusColor(order.status).withValues(alpha: 0.15),
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
                      const Text('• ', style: TextStyle(color: AppColors.textSecondary)),
                      Expanded(child: Text(item.name)),
                      if (item.qty != null)
                        Text(item.qty!,
                            style: const TextStyle(color: AppColors.textSecondary)),
                    ],
                  ),
                )),
            if (order.note != null) ...[
              const SizedBox(height: 6),
              Text('Note: ${order.note}',
                  style: const TextStyle(
                      color: AppColors.textSecondary, fontStyle: FontStyle.italic, fontSize: 13)),
            ],
            if (isVendor && order.status == OrderStatus.pending) ...[
              const SizedBox(height: 10),
              Row(
                children: [
                  Expanded(
                    child: OutlinedButton(
                      onPressed: () => context.read<OrderBloc>().add(
                            UpdateOrderStatus(
                                orderId: order.id, status: OrderStatus.rejected),
                          ),
                      style: OutlinedButton.styleFrom(foregroundColor: AppColors.error),
                      child: const Text('Reject'),
                    ),
                  ),
                  const SizedBox(width: 8),
                  Expanded(
                    child: FilledButton(
                      onPressed: () => context.read<OrderBloc>().add(
                            UpdateOrderStatus(
                                orderId: order.id, status: OrderStatus.confirmed),
                          ),
                      style: FilledButton.styleFrom(backgroundColor: AppColors.primary),
                      child: const Text('Confirm'),
                    ),
                  ),
                ],
              ),
            ],
            if (isVendor && order.status == OrderStatus.confirmed) ...[
              const SizedBox(height: 10),
              SizedBox(
                width: double.infinity,
                child: FilledButton(
                  onPressed: () => context.read<OrderBloc>().add(
                        UpdateOrderStatus(
                            orderId: order.id, status: OrderStatus.delivered),
                      ),
                  style: FilledButton.styleFrom(backgroundColor: Colors.blue),
                  child: const Text('Mark Delivered'),
                ),
              ),
            ],
          ],
        ),
      ),
    );
  }
}
