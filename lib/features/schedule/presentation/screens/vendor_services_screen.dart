import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import '../../../../core/constants/app_colors.dart';
import '../../../../shared/models/schedule_model.dart';
import '../cubit/schedule_cubit.dart';
import 'create_service_sheet.dart';
import 'service_detail_screen.dart';

class VendorServicesScreen extends StatefulWidget {
  const VendorServicesScreen({super.key});

  @override
  State<VendorServicesScreen> createState() => _VendorServicesScreenState();
}

class _VendorServicesScreenState extends State<VendorServicesScreen>
    with SingleTickerProviderStateMixin {
  late TabController _tabs;

  @override
  void initState() {
    super.initState();
    _tabs = TabController(length: 2, vsync: this);
    context.read<ServicesCubit>().load();
    context.read<DeliveriesCubit>().load();
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
        title: const Text('Scheduled Services'),
        backgroundColor: AppColors.primary,
        foregroundColor: Colors.white,
        bottom: TabBar(
          controller: _tabs,
          labelColor: Colors.white,
          unselectedLabelColor: Colors.white70,
          indicatorColor: Colors.white,
          tabs: const [
            Tab(text: 'Services'),
            Tab(text: "Today's Deliveries"),
          ],
        ),
      ),
      body: TabBarView(
        controller: _tabs,
        children: const [
          _ServicesTab(),
          _DeliveriesTab(),
        ],
      ),
      // Shell uses extendBody, so padding.bottom carries the pill nav height —
      // lift the FAB above it like the dashboard FAB.
      floatingActionButton: Padding(
        padding: EdgeInsets.only(bottom: MediaQuery.of(context).padding.bottom),
        child: BlocBuilder<ServicesCubit, ServicesState>(
          builder: (context, state) {
            return FloatingActionButton.extended(
              onPressed: () => _showCreateSheet(context),
              backgroundColor: AppColors.primary,
              icon: const Icon(Icons.add, color: Colors.white),
              label: const Text('New Service', style: TextStyle(color: Colors.white)),
            );
          },
        ),
      ),
    );
  }

  void _showCreateSheet(BuildContext context) {
    final cubit = context.read<ServicesCubit>();
    showModalBottomSheet(
      context: context,
      useRootNavigator: true,
      isScrollControlled: true,
      useSafeArea: true,
      builder: (_) => BlocProvider.value(
        value: cubit,
        child: const CreateServiceSheet(),
      ),
    );
  }
}

class _ServicesTab extends StatelessWidget {
  const _ServicesTab();

  @override
  Widget build(BuildContext context) {
    return BlocBuilder<ServicesCubit, ServicesState>(
      builder: (context, state) {
        if (state is ServicesLoading) {
          return const Center(child: CircularProgressIndicator());
        }
        if (state is ServicesError) {
          return Center(
            child: Column(
              mainAxisSize: MainAxisSize.min,
              children: [
                Text(state.message, style: const TextStyle(color: AppColors.error)),
                const SizedBox(height: 12),
                ElevatedButton(
                  onPressed: () => context.read<ServicesCubit>().load(),
                  child: const Text('Retry'),
                ),
              ],
            ),
          );
        }
        final services = (state as ServicesLoaded).services;
        if (services.isEmpty) {
          return const Center(
            child: Column(
              mainAxisSize: MainAxisSize.min,
              children: [
                Icon(Icons.calendar_today_outlined, size: 64, color: AppColors.textHint),
                SizedBox(height: 12),
                Text('No services yet', style: TextStyle(color: AppColors.textSecondary)),
                SizedBox(height: 4),
                Text(
                  'Tap + to create a scheduled service',
                  style: TextStyle(color: AppColors.textHint, fontSize: 13),
                ),
              ],
            ),
          );
        }
        return RefreshIndicator(
          onRefresh: () => context.read<ServicesCubit>().load(),
          child: ListView.separated(
            padding: const EdgeInsets.all(16),
            itemCount: services.length,
            separatorBuilder: (_, __) => const SizedBox(height: 8),
            itemBuilder: (ctx, i) => _ServiceCard(service: services[i]),
          ),
        );
      },
    );
  }
}

class _ServiceCard extends StatelessWidget {
  final ScheduledService service;
  const _ServiceCard({required this.service});

  @override
  Widget build(BuildContext context) {
    return Card(
      elevation: 1,
      shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(12)),
      child: InkWell(
        borderRadius: BorderRadius.circular(12),
        onTap: () => Navigator.of(context).push(MaterialPageRoute(
          builder: (_) => MultiBlocProvider(
            providers: [
              BlocProvider.value(value: context.read<ServicesCubit>()),
              BlocProvider.value(value: context.read<SubscriptionsCubit>()),
            ],
            child: ServiceDetailScreen(service: service),
          ),
        )),
        child: Padding(
          padding: const EdgeInsets.all(16),
          child: Row(
            children: [
              _TypeIcon(type: service.serviceType),
              const SizedBox(width: 12),
              Expanded(
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    Text(
                      service.name,
                      style: const TextStyle(fontWeight: FontWeight.w600, fontSize: 16),
                    ),
                    const SizedBox(height: 2),
                    Text(
                      service.scheduleLabel,
                      style: const TextStyle(color: AppColors.textSecondary, fontSize: 13),
                    ),
                    if (service.defaultPricePerUnit != null) ...[
                      const SizedBox(height: 2),
                      Text(
                        '₹${service.defaultPricePerUnit!.toStringAsFixed(0)} / ${service.unit ?? 'unit'}',
                        style: const TextStyle(color: AppColors.primary, fontSize: 13),
                      ),
                    ],
                  ],
                ),
              ),
              Column(
                crossAxisAlignment: CrossAxisAlignment.end,
                children: [
                  Container(
                    padding: const EdgeInsets.symmetric(horizontal: 8, vertical: 3),
                    decoration: BoxDecoration(
                      color: AppColors.primary.withOpacity(0.1),
                      borderRadius: BorderRadius.circular(8),
                    ),
                    child: Text(
                      '${service.subscriberCount} subs',
                      style: const TextStyle(
                        color: AppColors.primary,
                        fontSize: 12,
                        fontWeight: FontWeight.w600,
                      ),
                    ),
                  ),
                  if (!service.isActive)
                    const Padding(
                      padding: EdgeInsets.only(top: 4),
                      child: Text(
                        'Inactive',
                        style: TextStyle(color: AppColors.textHint, fontSize: 11),
                      ),
                    ),
                ],
              ),
            ],
          ),
        ),
      ),
    );
  }
}

class _TypeIcon extends StatelessWidget {
  final ServiceType type;
  const _TypeIcon({required this.type});

  @override
  Widget build(BuildContext context) {
    final icon =
        type == ServiceType.product ? Icons.inventory_2_outlined : Icons.event_available_outlined;
    return Container(
      width: 44,
      height: 44,
      decoration: BoxDecoration(
        color: AppColors.primary.withOpacity(0.1),
        borderRadius: BorderRadius.circular(10),
      ),
      child: Icon(icon, color: AppColors.primary, size: 22),
    );
  }
}

class _DeliveriesTab extends StatelessWidget {
  const _DeliveriesTab();

  @override
  Widget build(BuildContext context) {
    return BlocBuilder<DeliveriesCubit, DeliveriesState>(
      builder: (context, state) {
        if (state is DeliveriesLoading) {
          return const Center(child: CircularProgressIndicator());
        }
        if (state is DeliveriesError) {
          return Center(
            child: Column(
              mainAxisSize: MainAxisSize.min,
              children: [
                Text(state.message, style: const TextStyle(color: AppColors.error)),
                const SizedBox(height: 12),
                ElevatedButton(
                  onPressed: () => context.read<DeliveriesCubit>().load(),
                  child: const Text('Retry'),
                ),
              ],
            ),
          );
        }
        final deliveries = (state as DeliveriesLoaded).deliveries;
        if (deliveries.isEmpty) {
          return const Center(
            child: Column(
              mainAxisSize: MainAxisSize.min,
              children: [
                Icon(Icons.check_circle_outline, size: 64, color: AppColors.textHint),
                SizedBox(height: 12),
                Text("No deliveries today", style: TextStyle(color: AppColors.textSecondary)),
              ],
            ),
          );
        }
        return RefreshIndicator(
          onRefresh: () => context.read<DeliveriesCubit>().load(),
          child: ListView.separated(
            padding: const EdgeInsets.all(16),
            itemCount: deliveries.length,
            separatorBuilder: (_, __) => const SizedBox(height: 8),
            itemBuilder: (ctx, i) => _DeliveryCard(delivery: deliveries[i]),
          ),
        );
      },
    );
  }
}

class _DeliveryCard extends StatelessWidget {
  final ScheduledDelivery delivery;
  const _DeliveryCard({required this.delivery});

  @override
  Widget build(BuildContext context) {
    final isScheduled = delivery.status == DeliveryStatus.scheduled;
    final statusColor = switch (delivery.status) {
      DeliveryStatus.scheduled => AppColors.warning,
      DeliveryStatus.delivered => AppColors.success,
      DeliveryStatus.skipped => AppColors.textSecondary,
      DeliveryStatus.failed => AppColors.error,
    };

    return Card(
      elevation: 1,
      shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(12)),
      child: Padding(
        padding: const EdgeInsets.all(14),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Row(
              children: [
                Expanded(
                  child: Text(
                    delivery.serviceName,
                    style: const TextStyle(fontWeight: FontWeight.w600, fontSize: 15),
                  ),
                ),
                Container(
                  padding: const EdgeInsets.symmetric(horizontal: 8, vertical: 3),
                  decoration: BoxDecoration(
                    color: statusColor.withOpacity(0.1),
                    borderRadius: BorderRadius.circular(8),
                  ),
                  child: Text(
                    delivery.status.label,
                    style: TextStyle(color: statusColor, fontSize: 12, fontWeight: FontWeight.w600),
                  ),
                ),
              ],
            ),
            const SizedBox(height: 4),
            Text(
              delivery.customerName,
              style: const TextStyle(color: AppColors.textSecondary, fontSize: 13),
            ),
            Text(
              '${delivery.quantityPerDelivery} ${delivery.unit ?? ''}',
              style: const TextStyle(color: AppColors.textHint, fontSize: 12),
            ),
            if (isScheduled) ...[
              const SizedBox(height: 10),
              Row(
                children: [
                  Expanded(
                    child: OutlinedButton.icon(
                      onPressed: () => _skip(context),
                      icon: const Icon(Icons.skip_next, size: 16),
                      label: const Text('Skip'),
                      style: OutlinedButton.styleFrom(
                        foregroundColor: AppColors.textSecondary,
                      ),
                    ),
                  ),
                  const SizedBox(width: 8),
                  Expanded(
                    child: ElevatedButton.icon(
                      onPressed: () => _deliver(context),
                      icon: const Icon(Icons.check, size: 16),
                      label: const Text('Delivered'),
                      style: ElevatedButton.styleFrom(
                        backgroundColor: AppColors.success,
                        foregroundColor: Colors.white,
                      ),
                    ),
                  ),
                ],
              ),
            ],
          ],
        ),
      ),
    );
  }

  void _deliver(BuildContext context) {
    context.read<DeliveriesCubit>().markDelivered(delivery.id);
  }

  void _skip(BuildContext context) {
    showDialog(
      context: context,
      builder: (_) => AlertDialog(
        title: const Text('Skip Delivery'),
        content: const Text('Mark this delivery as skipped today?'),
        actions: [
          TextButton(
            onPressed: () => Navigator.pop(context),
            child: const Text('Cancel'),
          ),
          ElevatedButton(
            onPressed: () {
              Navigator.pop(context);
              context.read<DeliveriesCubit>().skip(delivery.id);
            },
            style: ElevatedButton.styleFrom(backgroundColor: AppColors.error),
            child: const Text('Skip', style: TextStyle(color: Colors.white)),
          ),
        ],
      ),
    );
  }
}
