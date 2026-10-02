import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import '../../../../core/constants/app_colors.dart';
import '../../../../shared/models/schedule_model.dart';
import '../../domain/repositories/schedule_repository.dart';
import '../cubit/schedule_cubit.dart';

class CreateServiceSheet extends StatefulWidget {
  const CreateServiceSheet({super.key});

  @override
  State<CreateServiceSheet> createState() => _CreateServiceSheetState();
}

class _ItemDraft {
  final nameCtrl = TextEditingController();
  final unitCtrl = TextEditingController();
  final priceCtrl = TextEditingController();

  void dispose() {
    nameCtrl.dispose();
    unitCtrl.dispose();
    priceCtrl.dispose();
  }
}

class _CreateServiceSheetState extends State<CreateServiceSheet> {
  final _formKey = GlobalKey<FormState>();
  final _nameCtrl = TextEditingController();
  final _descCtrl = TextEditingController();

  final List<_ItemDraft> _items = [_ItemDraft()];

  ServiceType _serviceType = ServiceType.product;
  ScheduleType _scheduleType = ScheduleType.daily;
  final Set<int> _deliveryDays = {};
  bool _autoLedger = true;

  static const _dayNames = ['Sun', 'Mon', 'Tue', 'Wed', 'Thu', 'Fri', 'Sat'];

  @override
  void dispose() {
    _nameCtrl.dispose();
    _descCtrl.dispose();
    for (final item in _items) {
      item.dispose();
    }
    super.dispose();
  }

  void _addItem() => setState(() => _items.add(_ItemDraft()));

  void _removeItem(int index) {
    setState(() {
      _items[index].dispose();
      _items.removeAt(index);
    });
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
                      'New Service',
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
              TextFormField(
                controller: _nameCtrl,
                decoration: const InputDecoration(labelText: 'Service Name *'),
                validator: (v) =>
                    v == null || v.trim().isEmpty ? 'Required' : null,
              ),
              const SizedBox(height: 12),
              TextFormField(
                controller: _descCtrl,
                decoration: const InputDecoration(labelText: 'Description'),
                maxLines: 2,
              ),
              const SizedBox(height: 16),
              const Text(
                'Service Type',
                style: TextStyle(fontWeight: FontWeight.w600),
              ),
              const SizedBox(height: 6),
              SegmentedButton<ServiceType>(
                segments: ServiceType.values
                    .map((t) => ButtonSegment(value: t, label: Text(t.label)))
                    .toList(),
                selected: {_serviceType},
                onSelectionChanged: (s) =>
                    setState(() => _serviceType = s.first),
              ),
              const SizedBox(height: 16),
              const Text(
                'Schedule',
                style: TextStyle(fontWeight: FontWeight.w600),
              ),
              const SizedBox(height: 6),
              SegmentedButton<ScheduleType>(
                segments: ScheduleType.values
                    .map((t) => ButtonSegment(value: t, label: Text(t.label)))
                    .toList(),
                selected: {_scheduleType},
                onSelectionChanged: (s) =>
                    setState(() => _scheduleType = s.first),
              ),
              if (_scheduleType != ScheduleType.daily) ...[
                const SizedBox(height: 12),
                const Text(
                  'Delivery Days',
                  style: TextStyle(fontWeight: FontWeight.w600),
                ),
                const SizedBox(height: 6),
                Wrap(
                  spacing: 6,
                  children: List.generate(7, (i) {
                    final selected = _deliveryDays.contains(i);
                    return FilterChip(
                      label: Text(_dayNames[i]),
                      selected: selected,
                      onSelected: (v) {
                        setState(() {
                          if (v) {
                            _deliveryDays.add(i);
                          } else {
                            _deliveryDays.remove(i);
                          }
                        });
                      },
                      selectedColor: AppColors.primary.withValues(alpha: 0.2),
                      checkmarkColor: AppColors.primary,
                    );
                  }),
                ),
              ],
              const SizedBox(height: 16),
              Row(
                mainAxisAlignment: MainAxisAlignment.spaceBetween,
                children: [
                  const Text(
                    'Items',
                    style: TextStyle(fontWeight: FontWeight.w600),
                  ),
                  TextButton.icon(
                    onPressed: _addItem,
                    icon: const Icon(Icons.add, size: 16),
                    label: const Text('Add Item'),
                  ),
                ],
              ),
              const SizedBox(height: 6),
              ...List.generate(
                _items.length,
                (i) => Padding(
                  padding: const EdgeInsets.only(bottom: 10),
                  child: _ItemRow(
                    item: _items[i],
                    onRemove: _items.length > 1 ? () => _removeItem(i) : null,
                  ),
                ),
              ),
              const SizedBox(height: 12),
              SwitchListTile(
                contentPadding: EdgeInsets.zero,
                title: const Text('Auto-create ledger entry'),
                subtitle: const Text(
                  'Add to khata automatically on delivery',
                  style: TextStyle(fontSize: 12),
                ),
                value: _autoLedger,
                onChanged: (v) => setState(() => _autoLedger = v),
                activeThumbColor: AppColors.primary,
              ),
              const SizedBox(height: 20),
              BlocBuilder<ServicesCubit, ServicesState>(
                builder: (context, state) {
                  final saving = state is ServicesLoaded && state.saving;
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
                              'Create Service',
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

  Future<void> _submit(BuildContext context) async {
    if (!_formKey.currentState!.validate()) return;
    if (_scheduleType != ScheduleType.daily && _deliveryDays.isEmpty) {
      ScaffoldMessenger.of(context).showSnackBar(
        const SnackBar(content: Text('Select at least one delivery day')),
      );
      return;
    }

    final items = <ServiceItemInput>[];
    for (final draft in _items) {
      final name = draft.nameCtrl.text.trim();
      final unit = draft.unitCtrl.text.trim();
      final price = double.tryParse(draft.priceCtrl.text.trim());
      if (name.isEmpty || unit.isEmpty || price == null || price < 0) {
        ScaffoldMessenger.of(context).showSnackBar(
          const SnackBar(
            content: Text('Fill in name, unit and price for every item'),
          ),
        );
        return;
      }
      items.add(ServiceItemInput(name: name, unit: unit, defaultPricePerUnit: price));
    }

    final ok = await context.read<ServicesCubit>().create(
      name: _nameCtrl.text.trim(),
      description: _descCtrl.text.trim().isEmpty ? null : _descCtrl.text.trim(),
      serviceType: _serviceType,
      scheduleType: _scheduleType,
      items: items,
      deliveryDays: _scheduleType != ScheduleType.daily
          ? (_deliveryDays.toList()..sort())
          : null,
      autoCreateLedgerEntry: _autoLedger,
    );
    if (ok && context.mounted) Navigator.pop(context);
  }
}

class _ItemRow extends StatelessWidget {
  final _ItemDraft item;
  final VoidCallback? onRemove;
  const _ItemRow({required this.item, required this.onRemove});

  @override
  Widget build(BuildContext context) {
    return Row(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        Expanded(
          flex: 3,
          child: TextFormField(
            controller: item.nameCtrl,
            decoration: const InputDecoration(labelText: 'Item name'),
          ),
        ),
        const SizedBox(width: 8),
        Expanded(
          flex: 2,
          child: TextFormField(
            controller: item.unitCtrl,
            decoration: const InputDecoration(labelText: 'Unit'),
          ),
        ),
        const SizedBox(width: 8),
        Expanded(
          flex: 2,
          child: TextFormField(
            controller: item.priceCtrl,
            decoration: const InputDecoration(labelText: 'Price (₹)'),
            keyboardType: const TextInputType.numberWithOptions(decimal: true),
          ),
        ),
        SizedBox(
          width: 40,
          child: onRemove != null
              ? IconButton(
                  onPressed: onRemove,
                  icon: const Icon(Icons.remove_circle_outline, size: 20),
                  color: AppColors.error,
                  padding: EdgeInsets.zero,
                )
              : null,
        ),
      ],
    );
  }
}
