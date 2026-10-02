import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:intl/intl.dart';
import '../../../../core/constants/app_colors.dart';
import '../../../../core/di/injection.dart';
import '../../../../features/vendor/presentation/bloc/vendor_bloc.dart';
import '../../../../features/vendor/presentation/bloc/vendor_state.dart';
import '../../../../shared/models/link_model.dart';
import '../../../../shared/models/schedule_model.dart';
import '../../domain/repositories/schedule_repository.dart';
import '../cubit/schedule_cubit.dart';

class SubscribeSheet extends StatefulWidget {
  final ScheduledService service;
  const SubscribeSheet({super.key, required this.service});

  @override
  State<SubscribeSheet> createState() => _SubscribeSheetState();
}

class _ItemQtyDraft {
  final ScheduledServiceItem item;
  final qtyCtrl = TextEditingController();
  final priceCtrl = TextEditingController();
  bool customPriceExpanded = false;

  _ItemQtyDraft(this.item, {required bool isFirst}) {
    qtyCtrl.text = isFirst ? '1' : '0';
  }

  void dispose() {
    qtyCtrl.dispose();
    priceCtrl.dispose();
  }
}

class _SubscribeSheetState extends State<SubscribeSheet> {
  final _formKey = GlobalKey<FormState>();
  late final List<_ItemQtyDraft> _itemDrafts;

  CustomerLinkItem? _selectedCustomer;
  DateTime _startDate = DateTime.now();

  @override
  void initState() {
    super.initState();
    final activeItems = widget.service.items.where((i) => i.isActive).toList();
    _itemDrafts = [
      for (var i = 0; i < activeItems.length; i++)
        _ItemQtyDraft(activeItems[i], isFirst: i == 0),
    ];
  }

  @override
  void dispose() {
    for (final draft in _itemDrafts) {
      draft.dispose();
    }
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    final mq = MediaQuery.of(context);
    return Padding(
      // viewInsets clears the keyboard; viewPadding clears the gesture bar /
      // 3-button nav when the keyboard is closed.
      padding: EdgeInsets.only(bottom: mq.viewInsets.bottom),
      child: SingleChildScrollView(
        padding: EdgeInsets.fromLTRB(20, 20, 20, mq.viewPadding.bottom + 32),
        child: Form(
          key: _formKey,
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            mainAxisSize: MainAxisSize.min,
            children: [
              Row(
                children: [
                  const Expanded(
                    child: Text(
                      'Add Subscriber',
                      style: TextStyle(
                        fontSize: 18,
                        fontWeight: FontWeight.bold,
                      ),
                    ),
                  ),
                  IconButton(
                    onPressed: () => Navigator.pop(context),
                    icon: const Icon(Icons.close),
                  ),
                ],
              ),
              const SizedBox(height: 16),
              const Text(
                'Customer',
                style: TextStyle(fontWeight: FontWeight.w600),
              ),
              const SizedBox(height: 6),
              BlocBuilder<VendorBloc, VendorState>(
                bloc: getIt<VendorBloc>(),
                builder: (context, state) {
                  final customers = state is VendorLoaded
                      ? state.customers
                      : <CustomerLinkItem>[];
                  return DropdownButtonFormField<CustomerLinkItem>(
                    initialValue: _selectedCustomer,
                    hint: const Text('Select customer'),
                    decoration: const InputDecoration(
                      border: OutlineInputBorder(),
                    ),
                    items: customers
                        .map(
                          (c) => DropdownMenuItem(
                            value: c,
                            child: Text(c.nickname ?? c.customer.name),
                          ),
                        )
                        .toList(),
                    onChanged: (v) => setState(() => _selectedCustomer = v),
                    validator: (_) =>
                        _selectedCustomer == null ? 'Select a customer' : null,
                  );
                },
              ),
              const SizedBox(height: 16),
              const Text(
                'Items',
                style: TextStyle(fontWeight: FontWeight.w600),
              ),
              const SizedBox(height: 6),
              ...List.generate(
                _itemDrafts.length,
                (i) => Padding(
                  padding: const EdgeInsets.only(bottom: 10),
                  child: _ItemQtyRow(
                    draft: _itemDrafts[i],
                    onCustomPriceToggle: () => setState(
                      () => _itemDrafts[i].customPriceExpanded =
                          !_itemDrafts[i].customPriceExpanded,
                    ),
                  ),
                ),
              ),
              const SizedBox(height: 8),
              const Text(
                'Start Date',
                style: TextStyle(fontWeight: FontWeight.w600),
              ),
              const SizedBox(height: 6),
              InkWell(
                onTap: () => _pickDate(context),
                borderRadius: BorderRadius.circular(8),
                child: Container(
                  padding: const EdgeInsets.symmetric(
                    horizontal: 14,
                    vertical: 12,
                  ),
                  decoration: BoxDecoration(
                    border: Border.all(color: Colors.grey.shade400),
                    borderRadius: BorderRadius.circular(8),
                  ),
                  child: Row(
                    children: [
                      const Icon(
                        Icons.calendar_today_outlined,
                        size: 18,
                        color: AppColors.textSecondary,
                      ),
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
                          borderRadius: BorderRadius.circular(12),
                        ),
                      ),
                      child: saving
                          ? const SizedBox(
                              width: 20,
                              height: 20,
                              child: CircularProgressIndicator(
                                strokeWidth: 2,
                                color: Colors.white,
                              ),
                            )
                          : const Text(
                              'Subscribe',
                              style: TextStyle(fontWeight: FontWeight.bold),
                            ),
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

    final items = <SubscriptionItemInput>[];
    for (final draft in _itemDrafts) {
      final qty = double.tryParse(draft.qtyCtrl.text.trim()) ?? 0;
      final price = draft.priceCtrl.text.trim().isEmpty
          ? null
          : double.tryParse(draft.priceCtrl.text.trim());
      items.add(SubscriptionItemInput(
        serviceItemId: draft.item.id,
        quantity: qty,
        customPricePerUnit: price,
      ));
    }

    if (!items.any((i) => i.quantity > 0)) {
      ScaffoldMessenger.of(context).showSnackBar(
        const SnackBar(content: Text('Set a quantity for at least one item')),
      );
      return;
    }

    final ok = await context.read<SubscriptionsCubit>().subscribe(
      serviceId: widget.service.id,
      linkId: _selectedCustomer!.linkId,
      items: items,
      startDate: DateFormat('yyyy-MM-dd').format(_startDate),
    );
    if (ok && context.mounted) Navigator.pop(context);
  }
}

class _ItemQtyRow extends StatelessWidget {
  final _ItemQtyDraft draft;
  final VoidCallback onCustomPriceToggle;
  const _ItemQtyRow({required this.draft, required this.onCustomPriceToggle});

  @override
  Widget build(BuildContext context) {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        Row(
          children: [
            Expanded(
              child: Text(
                '${draft.item.name} (${draft.item.unit}) · ₹${draft.item.defaultPricePerUnit.toStringAsFixed(2)}',
                style: const TextStyle(fontSize: 13),
                overflow: TextOverflow.ellipsis,
              ),
            ),
            const SizedBox(width: 8),
            SizedBox(
              width: 90,
              child: TextFormField(
                controller: draft.qtyCtrl,
                decoration: const InputDecoration(labelText: 'Qty'),
                keyboardType: const TextInputType.numberWithOptions(decimal: true),
                validator: (v) {
                  if (v == null || v.trim().isEmpty) return null;
                  if (double.tryParse(v) == null || double.parse(v) < 0) {
                    return 'Invalid';
                  }
                  return null;
                },
              ),
            ),
          ],
        ),
        if (!draft.customPriceExpanded)
          Align(
            alignment: Alignment.centerRight,
            child: TextButton(
              onPressed: onCustomPriceToggle,
              child: const Text('Custom price?', style: TextStyle(fontSize: 12)),
            ),
          )
        else
          Padding(
            padding: const EdgeInsets.only(top: 6),
            child: TextFormField(
              controller: draft.priceCtrl,
              decoration: const InputDecoration(
                labelText: 'Custom Price (₹, optional)',
              ),
              keyboardType: const TextInputType.numberWithOptions(decimal: true),
            ),
          ),
      ],
    );
  }
}
