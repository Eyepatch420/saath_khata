import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:intl/intl.dart';
import '../../../../core/constants/app_colors.dart';
import '../../../../core/di/injection.dart';
import '../../../../features/vendor/presentation/bloc/vendor_bloc.dart';
import '../../../../features/vendor/presentation/bloc/vendor_state.dart';
import '../../../../shared/models/link_model.dart';
import '../cubit/schedule_cubit.dart';

class SubscribeSheet extends StatefulWidget {
  final String serviceId;
  const SubscribeSheet({super.key, required this.serviceId});

  @override
  State<SubscribeSheet> createState() => _SubscribeSheetState();
}

class _SubscribeSheetState extends State<SubscribeSheet> {
  final _formKey = GlobalKey<FormState>();
  final _qtyCtrl = TextEditingController(text: '1');
  final _priceCtrl = TextEditingController();

  CustomerLinkItem? _selectedCustomer;
  DateTime _startDate = DateTime.now();

  @override
  void dispose() {
    _qtyCtrl.dispose();
    _priceCtrl.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: EdgeInsets.only(bottom: MediaQuery.of(context).viewInsets.bottom),
      child: SingleChildScrollView(
        padding: const EdgeInsets.fromLTRB(20, 20, 20, 32),
        child: Form(
          key: _formKey,
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            mainAxisSize: MainAxisSize.min,
            children: [
              Row(
                children: [
                  const Expanded(
                    child: Text('Add Subscriber',
                        style: TextStyle(fontSize: 18, fontWeight: FontWeight.bold)),
                  ),
                  IconButton(
                      onPressed: () => Navigator.pop(context),
                      icon: const Icon(Icons.close)),
                ],
              ),
              const SizedBox(height: 16),
              const Text('Customer', style: TextStyle(fontWeight: FontWeight.w600)),
              const SizedBox(height: 6),
              BlocBuilder<VendorBloc, VendorState>(
                bloc: getIt<VendorBloc>(),
                builder: (context, state) {
                  final customers = state is VendorLoaded ? state.customers : <CustomerLinkItem>[];
                  return DropdownButtonFormField<CustomerLinkItem>(
                    value: _selectedCustomer,
                    hint: const Text('Select customer'),
                    decoration: const InputDecoration(border: OutlineInputBorder()),
                    items: customers.map((c) => DropdownMenuItem(
                          value: c,
                          child: Text(c.nickname ?? c.customer.name),
                        )).toList(),
                    onChanged: (v) => setState(() => _selectedCustomer = v),
                    validator: (_) => _selectedCustomer == null ? 'Select a customer' : null,
                  );
                },
              ),
              const SizedBox(height: 14),
              Row(
                children: [
                  Expanded(
                    child: TextFormField(
                      controller: _qtyCtrl,
                      decoration: const InputDecoration(labelText: 'Qty per Delivery *'),
                      keyboardType: const TextInputType.numberWithOptions(decimal: true),
                      validator: (v) {
                        if (v == null || v.isEmpty) return 'Required';
                        if (double.tryParse(v) == null || double.parse(v) <= 0) {
                          return 'Invalid qty';
                        }
                        return null;
                      },
                    ),
                  ),
                  const SizedBox(width: 12),
                  Expanded(
                    child: TextFormField(
                      controller: _priceCtrl,
                      decoration:
                          const InputDecoration(labelText: 'Custom Price (₹, optional)'),
                      keyboardType: const TextInputType.numberWithOptions(decimal: true),
                    ),
                  ),
                ],
              ),
              const SizedBox(height: 14),
              const Text('Start Date', style: TextStyle(fontWeight: FontWeight.w600)),
              const SizedBox(height: 6),
              InkWell(
                onTap: () => _pickDate(context),
                borderRadius: BorderRadius.circular(8),
                child: Container(
                  padding: const EdgeInsets.symmetric(horizontal: 14, vertical: 12),
                  decoration: BoxDecoration(
                    border: Border.all(color: Colors.grey.shade400),
                    borderRadius: BorderRadius.circular(8),
                  ),
                  child: Row(
                    children: [
                      const Icon(Icons.calendar_today_outlined, size: 18,
                          color: AppColors.textSecondary),
                      const SizedBox(width: 8),
                      Text(DateFormat('d MMM yyyy').format(_startDate)),
                    ],
                  ),
                ),
              ),
              const SizedBox(height: 20),
              BlocBuilder<SubscriptionsCubit, SubscriptionsState>(
                builder: (context, state) {
                  final saving = state is SubscriptionsLoaded && state.saving;
                  return SizedBox(
                    width: double.infinity,
                    height: 50,
                    child: ElevatedButton(
                      onPressed: saving ? null : () => _submit(context),
                      style: ElevatedButton.styleFrom(
                        backgroundColor: AppColors.primary,
                        foregroundColor: Colors.white,
                        shape: RoundedRectangleBorder(
                            borderRadius: BorderRadius.circular(12)),
                      ),
                      child: saving
                          ? const SizedBox(
                              width: 20,
                              height: 20,
                              child: CircularProgressIndicator(
                                  strokeWidth: 2, color: Colors.white))
                          : const Text('Subscribe',
                              style: TextStyle(fontWeight: FontWeight.bold)),
                    ),
                  );
                },
              ),
            ],
          ),
        ),
      ),
    );
  }

  Future<void> _pickDate(BuildContext context) async {
    final picked = await showDatePicker(
      context: context,
      initialDate: _startDate,
      firstDate: DateTime.now(),
      lastDate: DateTime.now().add(const Duration(days: 365)),
    );
    if (picked != null) setState(() => _startDate = picked);
  }

  Future<void> _submit(BuildContext context) async {
    if (!_formKey.currentState!.validate()) return;
    final price = _priceCtrl.text.trim().isEmpty
        ? null
        : double.tryParse(_priceCtrl.text.trim());
    final ok = await context.read<SubscriptionsCubit>().subscribe(
          serviceId: widget.serviceId,
          linkId: _selectedCustomer!.linkId,
          quantityPerDelivery: double.parse(_qtyCtrl.text.trim()),
          customPricePerUnit: price,
          startDate: DateFormat('yyyy-MM-dd').format(_startDate),
        );
    if (ok && context.mounted) Navigator.pop(context);
  }
}
