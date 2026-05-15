import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import '../../../../core/constants/app_colors.dart';
import '../../../../core/di/injection.dart';
import '../bloc/customer_bloc.dart';
import '../bloc/customer_event.dart';
import '../bloc/customer_state.dart';
import '../widgets/vendor_tile.dart';

class MyKhatasScreen extends StatelessWidget {
  const MyKhatasScreen({super.key});

  @override
  Widget build(BuildContext context) {
    return BlocProvider(
      create: (context) => CustomerBloc(getIt())..add(LoadCustomerDashboard()),
      child: Scaffold(
        backgroundColor: AppColors.background,
        appBar: AppBar(
          title: const Text('My Khatas'),
        ),
        body: BlocBuilder<CustomerBloc, CustomerState>(
          builder: (context, state) {
            if (state is CustomerLoading) {
              return const Center(child: CircularProgressIndicator());
            } else if (state is CustomerLoaded) {
              if (state.vendors.isEmpty) {
                return const Center(child: Text('No vendors found'));
              }
              return ListView.separated(
                padding: const EdgeInsets.all(20),
                itemCount: state.vendors.length,
                separatorBuilder: (context, index) => const SizedBox(height: 12),
                itemBuilder: (context, index) {
                  return VendorTile(vendor: state.vendors[index]);
                },
              );
            }
            return const SizedBox();
          },
        ),
      ),
    );
  }
}
