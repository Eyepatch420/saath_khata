import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import '../../../../core/di/injection.dart';
import '../../../../l10n/app_localizations.dart';
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
        appBar: AppBar(
          title: Text(AppLocalizations.of(context)!.myKhatas),
        ),
        body: SafeArea(child: BlocBuilder<CustomerBloc, CustomerState>(
          builder: (context, state) {
            if (state is CustomerLoading) {
              return const Center(child: CircularProgressIndicator());
            } else if (state is CustomerLoaded) {
              if (state.vendors.isEmpty) {
                return Center(child: Text(AppLocalizations.of(context)!.noVendorsFound));
              }
              return ListView.separated(
                padding: EdgeInsets.fromLTRB(20, 20, 20, MediaQuery.of(context).viewPadding.bottom + 96),
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
      ),
    );
  }
}
