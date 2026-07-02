import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import '../../../../core/constants/app_colors.dart';
import '../../../schedule/presentation/cubit/schedule_cubit.dart';
import '../../../schedule/presentation/widgets/delivery_card.dart';

/// Today's deliveries for the vendor, as seen by a staff (delivery) member.
/// Reuses [DeliveriesCubit] scoped to the owner vendor via effectiveVendorId
/// on the backend, and the same [DeliveryCard] the vendor's Schedule tab uses.
class StaffDeliveriesScreen extends StatelessWidget {
  const StaffDeliveriesScreen({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(title: const Text("Today's Deliveries")),
      body: SafeArea(
        child: BlocBuilder<DeliveriesCubit, DeliveriesState>(
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
                    Text('No deliveries today', style: TextStyle(color: AppColors.textSecondary)),
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
                itemBuilder: (ctx, i) => DeliveryCard(delivery: deliveries[i]),
              ),
            );
          },
        ),
      ),
    );
  }
}
