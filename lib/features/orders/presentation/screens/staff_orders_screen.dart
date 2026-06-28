import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import '../../../../core/constants/app_colors.dart';
import '../../../../shared/models/order_model.dart';
import '../bloc/order_bloc.dart';
import '../bloc/order_event.dart';
import '../bloc/order_state.dart';
import 'order_detail_screen.dart';

class StaffOrdersScreen extends StatefulWidget {
  const StaffOrdersScreen({super.key});

  @override
  State<StaffOrdersScreen> createState() => _StaffOrdersScreenState();
}

class _StaffOrdersScreenState extends State<StaffOrdersScreen> {
  @override
  void initState() {
    super.initState();
    context.read<OrderBloc>().add(const LoadStaffOrders());
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text('Deliveries'),
        backgroundColor: AppColors.primary,
        foregroundColor: Colors.white,
      ),
      body: BlocListener<OrderBloc, OrderState>(
        listener: (context, state) {
          if (state is OrderError) {
            ScaffoldMessenger.of(context).showSnackBar(
              SnackBar(
                  content: Text(state.message),
                  backgroundColor: AppColors.error),
            );
          }
        },
        child: BlocBuilder<OrderBloc, OrderState>(
          builder: (context, state) {
            if (state is OrderLoading) {
              return const Center(child: CircularProgressIndicator());
            }
            final orders = switch (state) {
              OrderLoaded(orders: final o) => o,
              OrderActionLoading(orders: final o) => o,
              _ => <Order>[],
            };
            if (orders.isEmpty) {
              return const Center(
                child: Column(
                  mainAxisSize: MainAxisSize.min,
                  children: [
                    Icon(Icons.check_circle_outline,
                        size: 56, color: AppColors.success),
                    SizedBox(height: 12),
                    Text('No pending deliveries',
                        style: TextStyle(color: AppColors.textSecondary)),
                  ],
                ),
              );
            }
            return RefreshIndicator(
              onRefresh: () async =>
                  context.read<OrderBloc>().add(const LoadStaffOrders()),
              child: ListView.separated(
                padding: const EdgeInsets.all(16),
                itemCount: orders.length,
                separatorBuilder: (_, i) => const SizedBox(height: 8),
                itemBuilder: (ctx, i) => _DeliveryCard(order: orders[i]),
              ),
            );
          },
        ),
      ),
    );
  }
}

class _DeliveryCard extends StatelessWidget {
  final Order order;

  const _DeliveryCard({required this.order});

  void _openDetail(BuildContext context) {
    Navigator.of(context).push(
      MaterialPageRoute(
        builder: (_) => BlocProvider.value(
          value: context.read<OrderBloc>(),
          child: OrderDetailScreen(order: order, role: 'staff'),
        ),
      ),
    );
  }

  @override
  Widget build(BuildContext context) {
    return Card(
      clipBehavior: Clip.antiAlias,
      child: InkWell(
        onTap: () => _openDetail(context),
        child: Padding(
          padding: const EdgeInsets.all(12),
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              Row(
                children: [
                  Expanded(
                    child: Text(
                      order.customerName ?? 'Customer',
                      style: const TextStyle(
                          fontWeight: FontWeight.w600, fontSize: 15),
                    ),
                  ),
                  Text('₹${order.total.toStringAsFixed(0)}',
                      style: const TextStyle(
                          fontWeight: FontWeight.bold,
                          color: AppColors.primary)),
                ],
              ),
              const SizedBox(height: 8),
              ...order.items.take(3).map((item) => Padding(
                    padding: const EdgeInsets.only(bottom: 3),
                    child: Row(
                      children: [
                        const Text('• ',
                            style: TextStyle(color: AppColors.textSecondary)),
                        Expanded(
                            child: Text(item.name,
                                overflow: TextOverflow.ellipsis)),
                        if (item.qty != null)
                          Text(
                              '${item.qty}${item.unit != null ? ' ${item.unit}' : ''}',
                              style: const TextStyle(
                                  color: AppColors.textSecondary)),
                      ],
                    ),
                  )),
              if (order.items.length > 3)
                Text('+ ${order.items.length - 3} more',
                    style: const TextStyle(
                        color: AppColors.textHint, fontSize: 12)),
              const SizedBox(height: 10),
              SizedBox(
                width: double.infinity,
                child: FilledButton.icon(
                  onPressed: () => _openDetail(context),
                  icon: const Icon(Icons.local_shipping_outlined),
                  label: const Text('Deliver'),
                  style:
                      FilledButton.styleFrom(backgroundColor: AppColors.primary),
                ),
              ),
            ],
          ),
        ),
      ),
    );
  }
}
