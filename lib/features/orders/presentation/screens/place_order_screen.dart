import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import '../../../../core/constants/app_colors.dart';
import '../../../../shared/models/link_model.dart' show VendorLinkItem;
import '../bloc/order_bloc.dart';
import '../bloc/order_event.dart';
import '../bloc/order_state.dart';

class PlaceOrderScreen extends StatefulWidget {
  final VendorLinkItem vendor;

  const PlaceOrderScreen({super.key, required this.vendor});

  @override
  State<PlaceOrderScreen> createState() => _PlaceOrderScreenState();
}

class _ItemRow {
  final TextEditingController nameCtrl = TextEditingController();
  final TextEditingController qtyCtrl = TextEditingController();
  final TextEditingController unitCtrl = TextEditingController();
  final TextEditingController priceCtrl = TextEditingController();

  /// qty (default 1) × price. 0 when price is empty/invalid.
  double get subtotal {
    final price = double.tryParse(priceCtrl.text.trim()) ?? 0;
    final qty = double.tryParse(qtyCtrl.text.trim()) ?? 1;
    return price * (qty == 0 ? 1 : qty);
  }

  void dispose() {
    nameCtrl.dispose();
    qtyCtrl.dispose();
    unitCtrl.dispose();
    priceCtrl.dispose();
  }
}

class _PlaceOrderScreenState extends State<PlaceOrderScreen> {
  final List<_ItemRow> _rows = [_ItemRow()];
  final _noteCtrl = TextEditingController();
  final _formKey = GlobalKey<FormState>();

  @override
  void dispose() {
    for (final r in _rows) {
      r.dispose();
    }
    _noteCtrl.dispose();
    super.dispose();
  }

  double get _grandTotal => _rows.fold(0.0, (s, r) => s + r.subtotal);

  void _addRow() => setState(() => _rows.add(_ItemRow()));

  void _removeRow(int index) {
    if (_rows.length == 1) return;
    setState(() {
      _rows[index].dispose();
      _rows.removeAt(index);
    });
  }

  void _submit() {
    if (!_formKey.currentState!.validate()) return;
    final items = _rows.map((r) {
      final price = double.tryParse(r.priceCtrl.text.trim());
      return <String, dynamic>{
        'name': r.nameCtrl.text.trim(),
        if (r.qtyCtrl.text.trim().isNotEmpty) 'qty': r.qtyCtrl.text.trim(),
        if (r.unitCtrl.text.trim().isNotEmpty) 'unit': r.unitCtrl.text.trim(),
        // ignore: use_null_aware_elements
        if (price != null) 'pricePerUnit': price,
      };
    }).toList();

    context.read<OrderBloc>().add(PlaceOrder(
          linkId: widget.vendor.linkId,
          items: items,
          note: _noteCtrl.text.trim().isEmpty ? null : _noteCtrl.text.trim(),
        ));
  }

  @override
  Widget build(BuildContext context) {
    return BlocListener<OrderBloc, OrderState>(
      listener: (context, state) {
        if (state is OrderPlaced) {
          ScaffoldMessenger.of(context).showSnackBar(
            const SnackBar(content: Text('Order placed successfully!')),
          );
          Navigator.of(context).pop();
        } else if (state is OrderError) {
          ScaffoldMessenger.of(context).showSnackBar(
            SnackBar(content: Text(state.message), backgroundColor: AppColors.error),
          );
        }
      },
      child: Scaffold(
        appBar: AppBar(
          title: Text('Order from ${widget.vendor.displayName}',
              overflow: TextOverflow.ellipsis),
          backgroundColor: AppColors.primary,
          foregroundColor: Colors.white,
        ),
        body: Form(
          key: _formKey,
          onChanged: () => setState(() {}), // keep subtotals/total live
          child: ListView(
            padding: const EdgeInsets.all(16),
            children: [
              ...List.generate(
                _rows.length,
                (i) => _ItemCard(
                  row: _rows[i],
                  index: i,
                  onRemove: _rows.length > 1 ? () => _removeRow(i) : null,
                ),
              ),
              const SizedBox(height: 4),
              Align(
                alignment: Alignment.centerLeft,
                child: TextButton.icon(
                  onPressed: _addRow,
                  icon: const Icon(Icons.add_circle_outline),
                  label: const Text('Add item'),
                ),
              ),
              const SizedBox(height: 8),
              TextFormField(
                controller: _noteCtrl,
                decoration: const InputDecoration(
                  labelText: 'Order note (optional)',
                  border: OutlineInputBorder(),
                ),
                maxLines: 2,
              ),
              const SizedBox(height: 24),
            ],
          ),
        ),
        bottomNavigationBar: BlocBuilder<OrderBloc, OrderState>(
          builder: (context, state) {
            final loading = state is OrderActionLoading;
            return SafeArea(
              child: Container(
                padding: const EdgeInsets.fromLTRB(16, 12, 16, 16),
                decoration: BoxDecoration(
                  color: Theme.of(context).colorScheme.surface,
                  boxShadow: [
                    BoxShadow(
                      color: Colors.black.withValues(alpha: 0.06),
                      blurRadius: 8,
                      offset: const Offset(0, -2),
                    ),
                  ],
                ),
                child: Column(
                  mainAxisSize: MainAxisSize.min,
                  children: [
                    Row(
                      mainAxisAlignment: MainAxisAlignment.spaceBetween,
                      children: [
                        const Text('Total',
                            style: TextStyle(
                                fontSize: 15, fontWeight: FontWeight.w600)),
                        Text(
                          '₹${_grandTotal.toStringAsFixed(2)}',
                          style: const TextStyle(
                            fontSize: 18,
                            fontWeight: FontWeight.bold,
                            color: AppColors.primary,
                          ),
                        ),
                      ],
                    ),
                    const SizedBox(height: 10),
                    FilledButton(
                      onPressed: loading ? null : _submit,
                      style: FilledButton.styleFrom(
                        backgroundColor: AppColors.primary,
                        minimumSize: const Size.fromHeight(50),
                      ),
                      child: loading
                          ? const SizedBox(
                              width: 22,
                              height: 22,
                              child: CircularProgressIndicator(
                                  color: Colors.white, strokeWidth: 2),
                            )
                          : const Text('Place Order',
                              style: TextStyle(fontSize: 16)),
                    ),
                  ],
                ),
              ),
            );
          },
        ),
      ),
    );
  }
}

class _ItemCard extends StatelessWidget {
  final _ItemRow row;
  final int index;
  final VoidCallback? onRemove;

  const _ItemCard({required this.row, required this.index, this.onRemove});

  static const _decimal =
      TextInputType.numberWithOptions(decimal: true);

  @override
  Widget build(BuildContext context) {
    return Card(
      margin: const EdgeInsets.only(bottom: 12),
      child: Padding(
        padding: const EdgeInsets.all(12),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Row(
              children: [
                Text('Item ${index + 1}',
                    style: const TextStyle(fontWeight: FontWeight.w600)),
                const Spacer(),
                if (onRemove != null)
                  IconButton(
                    icon: const Icon(Icons.close, size: 20),
                    onPressed: onRemove,
                    color: AppColors.error,
                    padding: EdgeInsets.zero,
                    constraints: const BoxConstraints(),
                  ),
              ],
            ),
            const SizedBox(height: 8),
            TextFormField(
              controller: row.nameCtrl,
              textCapitalization: TextCapitalization.sentences,
              decoration: const InputDecoration(
                labelText: 'Item name *',
                border: OutlineInputBorder(),
                isDense: true,
              ),
              validator: (v) =>
                  (v == null || v.trim().isEmpty) ? 'Required' : null,
            ),
            const SizedBox(height: 8),
            Row(
              children: [
                Expanded(
                  child: TextFormField(
                    controller: row.qtyCtrl,
                    keyboardType: _decimal,
                    inputFormatters: [
                      FilteringTextInputFormatter.allow(RegExp(r'[0-9.]')),
                    ],
                    decoration: const InputDecoration(
                      labelText: 'Qty',
                      border: OutlineInputBorder(),
                      isDense: true,
                    ),
                  ),
                ),
                const SizedBox(width: 8),
                Expanded(
                  child: TextFormField(
                    controller: row.unitCtrl,
                    decoration: const InputDecoration(
                      labelText: 'Unit',
                      hintText: 'kg, L…',
                      border: OutlineInputBorder(),
                      isDense: true,
                    ),
                  ),
                ),
                const SizedBox(width: 8),
                Expanded(
                  child: TextFormField(
                    controller: row.priceCtrl,
                    keyboardType: _decimal,
                    inputFormatters: [
                      FilteringTextInputFormatter.allow(RegExp(r'[0-9.]')),
                    ],
                    decoration: const InputDecoration(
                      labelText: 'Unit ₹',
                      border: OutlineInputBorder(),
                      isDense: true,
                    ),
                  ),
                ),
              ],
            ),
            const SizedBox(height: 8),
            Align(
              alignment: Alignment.centerRight,
              child: Text(
                'Subtotal: ₹${row.subtotal.toStringAsFixed(2)}',
                style: const TextStyle(
                  color: AppColors.textSecondary,
                  fontWeight: FontWeight.w600,
                  fontSize: 13,
                ),
              ),
            ),
          ],
        ),
      ),
    );
  }
}
