import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:intl/intl.dart';
import '../../../../core/constants/app_colors.dart';
import '../../../../shared/models/schedule_model.dart';
import '../cubit/schedule_cubit.dart';
import 'subscribe_sheet.dart';

class ServiceDetailScreen extends StatefulWidget {
  final ScheduledService service;
  const ServiceDetailScreen({super.key, required this.service});

  @override
  State<ServiceDetailScreen> createState() => _ServiceDetailScreenState();
}

class _ServiceDetailScreenState extends State<ServiceDetailScreen> {
  @override
  void initState() {
    super.initState();
    context.read<SubscriptionsCubit>().loadForService(widget.service.id);
  }

  @override
  Widget build(BuildContext context) {
    final svc = widget.service;
    return Scaffold(
      appBar: AppBar(
        title: Text(svc.name),
        backgroundColor: AppColors.primary,
        foregroundColor: Colors.white,
        actions: [
          if (svc.isActive)
            PopupMenuButton<String>(
              onSelected: (v) {
                if (v == 'deactivate') _deactivate(context);
              },
              itemBuilder: (_) => [
                const PopupMenuItem(value: 'deactivate', child: Text('Deactivate')),
              ],
            ),
        ],
      ),
      body: ListView(
        padding: const EdgeInsets.all(16),
        children: [
          _InfoCard(service: svc),
          const SizedBox(height: 16),
          Row(
            mainAxisAlignment: MainAxisAlignment.spaceBetween,
            children: [
              const Text('Subscribers',
                  style: TextStyle(fontSize: 16, fontWeight: FontWeight.bold)),
              ElevatedButton.icon(
                onPressed: () => _showSubscribeSheet(context),
                icon: const Icon(Icons.person_add, size: 16),
                label: const Text('Add Customer'),
                style: ElevatedButton.styleFrom(
                  backgroundColor: AppColors.primary,
                  foregroundColor: Colors.white,
                ),
              ),
            ],
          ),
          const SizedBox(height: 12),
          BlocBuilder<SubscriptionsCubit, SubscriptionsState>(
            builder: (context, state) {
              if (state is SubscriptionsLoading) {
                return const Center(
                    child: Padding(
                  padding: EdgeInsets.all(32),
                  child: CircularProgressIndicator(),
                ));
              }
              if (state is SubscriptionsError) {
                return Text(state.message,
                    style: const TextStyle(color: AppColors.error));
              }
              final subs = (state as SubscriptionsLoaded).subscriptions;
              if (subs.isEmpty) {
                return const Center(
                  child: Padding(
                    padding: EdgeInsets.all(32),
                    child: Text('No subscribers yet',
                        style: TextStyle(color: AppColors.textSecondary)),
                  ),
                );
              }
              return Column(
                children: subs
                    .map((s) => _SubscriberTile(sub: s))
                    .toList(),
              );
            },
          ),
        ],
      ),
    );
  }

  void _showSubscribeSheet(BuildContext context) {
    showModalBottomSheet(
      context: context,
      isScrollControlled: true,
      useSafeArea: true,
      builder: (_) => BlocProvider.value(
        value: context.read<SubscriptionsCubit>(),
        child: SubscribeSheet(serviceId: widget.service.id),
      ),
    );
  }

  void _deactivate(BuildContext context) {
    showDialog(
      context: context,
      builder: (_) => AlertDialog(
        title: const Text('Deactivate Service'),
        content: const Text(
            'This will stop all future deliveries. Active subscriptions will be unaffected until manually removed.'),
        actions: [
          TextButton(
              onPressed: () => Navigator.pop(context),
              child: const Text('Cancel')),
          ElevatedButton(
            onPressed: () async {
              Navigator.pop(context);
              final ok = await context
                  .read<ServicesCubit>()
                  .deactivate(widget.service.id);
              if (ok && context.mounted) Navigator.pop(context);
            },
            style:
                ElevatedButton.styleFrom(backgroundColor: AppColors.error),
            child: const Text('Deactivate',
                style: TextStyle(color: Colors.white)),
          ),
        ],
      ),
    );
  }
}

class _InfoCard extends StatelessWidget {
  final ScheduledService service;
  const _InfoCard({required this.service});

  @override
  Widget build(BuildContext context) {
    return Card(
      shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(12)),
      child: Padding(
        padding: const EdgeInsets.all(16),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            if (service.description != null) ...[
              Text(service.description!,
                  style: const TextStyle(color: AppColors.textSecondary)),
              const SizedBox(height: 12),
            ],
            _row('Type', service.serviceType.label),
            _row('Schedule', service.scheduleLabel),
            if (service.unit != null)
              _row('Unit', service.unit!),
            if (service.defaultPricePerUnit != null)
              _row('Default Price',
                  '₹${service.defaultPricePerUnit!.toStringAsFixed(2)} / ${service.unit ?? 'unit'}'),
            _row('Auto Ledger Entry',
                service.autoCreateLedgerEntry ? 'Yes' : 'No'),
            _row('Status', service.isActive ? 'Active' : 'Inactive'),
          ],
        ),
      ),
    );
  }

  Widget _row(String label, String value) => Padding(
        padding: const EdgeInsets.symmetric(vertical: 4),
        child: Row(
          children: [
            SizedBox(
                width: 130,
                child: Text(label,
                    style: const TextStyle(color: AppColors.textSecondary))),
            Expanded(
                child: Text(value,
                    style: const TextStyle(fontWeight: FontWeight.w500))),
          ],
        ),
      );
}

class _SubscriberTile extends StatelessWidget {
  final ServiceSubscription sub;
  const _SubscriberTile({required this.sub});

  @override
  Widget build(BuildContext context) {
    final fmt = DateFormat('d MMM');
    return Card(
      margin: const EdgeInsets.only(bottom: 8),
      shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(10)),
      child: Padding(
        padding: const EdgeInsets.symmetric(horizontal: 14, vertical: 12),
        child: Row(
          children: [
            Expanded(
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  Text(sub.customerId,
                      style: const TextStyle(fontWeight: FontWeight.w600)),
                  Text(
                    '${sub.quantityPerDelivery} ${sub.unit ?? ''} · starts ${fmt.format(sub.startDate)}',
                    style: const TextStyle(
                        fontSize: 12, color: AppColors.textSecondary),
                  ),
                  if (sub.isPaused)
                    const Text('Paused',
                        style: TextStyle(
                            fontSize: 11, color: AppColors.warning)),
                ],
              ),
            ),
            PopupMenuButton<String>(
              onSelected: (v) => _onAction(context, v),
              itemBuilder: (_) => [
                if (sub.isPaused)
                  const PopupMenuItem(
                      value: 'resume', child: Text('Resume'))
                else
                  const PopupMenuItem(value: 'pause', child: Text('Pause')),
                const PopupMenuItem(
                    value: 'remove', child: Text('Remove')),
              ],
            ),
          ],
        ),
      ),
    );
  }

  void _onAction(BuildContext context, String action) {
    final cubit = context.read<SubscriptionsCubit>();
    switch (action) {
      case 'pause':
        cubit.pause(sub.id);
        break;
      case 'resume':
        cubit.resume(sub.id);
        break;
      case 'remove':
        cubit.remove(sub.id);
        break;
    }
  }
}
