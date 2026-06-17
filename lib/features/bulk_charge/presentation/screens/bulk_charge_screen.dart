import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import '../../../../core/constants/app_colors.dart';
import '../../../../core/constants/app_typography.dart';
import '../../../../core/di/injection.dart';
import '../../../../shared/models/link_model.dart';
import '../../../../shared/models/product_template.dart';
import '../../../../shared/widgets/app_toast.dart';
import '../../../vendor/presentation/bloc/vendor_bloc.dart';
import '../../../vendor/presentation/bloc/vendor_state.dart';
import '../../data/repositories/template_repository.dart';
import '../cubit/bulk_charge_cubit.dart';

class BulkChargeScreen extends StatelessWidget {
  const BulkChargeScreen({super.key});

  @override
  Widget build(BuildContext context) {
    return BlocProvider(
      create: (_) =>
          BulkChargeCubit(getIt<TemplateRepository>())..loadTemplates(),
      child: const _BulkChargeView(),
    );
  }
}

class _BulkChargeView extends StatelessWidget {
  const _BulkChargeView();

  @override
  Widget build(BuildContext context) {
    final vendorState = context.watch<VendorBloc>().state;
    final customers =
        vendorState is VendorLoaded ? vendorState.customers : <CustomerLinkItem>[];

    return Scaffold(
      appBar: AppBar(
        title: const Text('Bulk Charge'),
        actions: [
          IconButton(
            onPressed: () => _showCreateTemplateSheet(context),
            icon: const Icon(Icons.add_rounded),
            tooltip: 'New product',
          ),
        ],
      ),
      body: BlocConsumer<BulkChargeCubit, BulkChargeState>(
        listenWhen: (_, curr) =>
            curr.templateError != null || curr.submitError != null,
        listener: (context, state) {
          final err = state.submitError ?? state.templateError;
          if (err != null) {
            AppToast.show(context, err, type: ToastType.error);
          }
        },
        builder: (context, state) {
          if (state.templatesLoading) {
            return const Center(child: CircularProgressIndicator());
          }

          if (state.templates.isEmpty) {
            return _EmptyTemplates(
              onAdd: () => _showCreateTemplateSheet(context),
            );
          }

          return Column(
            children: [
              // ── Template picker ──────────────────────────────────────────
              _TemplatePicker(
                templates: state.templates,
                selected: state.selectedTemplate,
                onSelect: (t) =>
                    context.read<BulkChargeCubit>().selectTemplate(t),
                onDelete: (t) =>
                    context.read<BulkChargeCubit>().deleteTemplate(t.id),
              ),
              if (state.selectedTemplate != null) ...[
                _TemplateInfoBar(template: state.selectedTemplate!),
                const Divider(height: 1),
                // ── Customer quantity grid ───────────────────────────────
                Expanded(
                  child: customers.isEmpty
                      ? const _NoCustomers()
                      : _CustomerGrid(
                          customers: customers,
                          quantities: state.quantities,
                          unit: state.selectedTemplate!.unit,
                          pricePerUnit: state.selectedTemplate!.pricePerUnit,
                        ),
                ),
              ] else
                const Expanded(child: _SelectTemplateHint()),
            ],
          );
        },
      ),
      bottomNavigationBar: _BottomBar(customers: customers),
    );
  }

  void _showCreateTemplateSheet(BuildContext context) {
    final cubit = context.read<BulkChargeCubit>();
    final nameCtrl = TextEditingController();
    final unitCtrl = TextEditingController();
    final priceCtrl = TextEditingController();

    showModalBottomSheet(
      context: context,
      useRootNavigator: true,
      isScrollControlled: true,
      shape: const RoundedRectangleBorder(
        borderRadius: BorderRadius.vertical(top: Radius.circular(24)),
      ),
      builder: (ctx) => Padding(
        padding: EdgeInsets.only(
          left: 24,
          right: 24,
          top: 24,
          bottom: MediaQuery.of(ctx).viewInsets.bottom + 32,
        ),
        child: Column(
          mainAxisSize: MainAxisSize.min,
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Text('New Product / Service', style: AppTypography.h3),
            const SizedBox(height: 4),
            Text(
              'Define what you sell and its base price',
              style: AppTypography.bodySmall
                  .copyWith(color: AppColors.textSecondary),
            ),
            const SizedBox(height: 20),
            TextField(
              controller: nameCtrl,
              textCapitalization: TextCapitalization.words,
              autofocus: true,
              decoration: const InputDecoration(
                labelText: 'Product name',
                hintText: 'e.g. Daily Morning Milk',
                prefixIcon: Icon(Icons.inventory_2_outlined),
              ),
            ),
            const SizedBox(height: 14),
            Row(
              children: [
                Expanded(
                  child: TextField(
                    controller: unitCtrl,
                    decoration: const InputDecoration(
                      labelText: 'Unit',
                      hintText: 'litre / kg / piece',
                      prefixIcon: Icon(Icons.straighten_rounded),
                    ),
                  ),
                ),
                const SizedBox(width: 12),
                Expanded(
                  child: TextField(
                    controller: priceCtrl,
                    keyboardType:
                        const TextInputType.numberWithOptions(decimal: true),
                    decoration: const InputDecoration(
                      labelText: 'Price / unit (₹)',
                      prefixIcon: Icon(Icons.currency_rupee_rounded),
                    ),
                  ),
                ),
              ],
            ),
            const SizedBox(height: 24),
            SizedBox(
              width: double.infinity,
              child: ElevatedButton(
                onPressed: () {
                  final name = nameCtrl.text.trim();
                  final unit = unitCtrl.text.trim();
                  final price = double.tryParse(priceCtrl.text);
                  if (name.isEmpty || unit.isEmpty || price == null || price <= 0) {
                    return;
                  }
                  Navigator.pop(ctx);
                  cubit.createTemplate(
                    name: name,
                    unit: unit,
                    pricePerUnit: price,
                  );
                },
                style: ElevatedButton.styleFrom(
                  backgroundColor: AppColors.primary,
                  padding: const EdgeInsets.symmetric(vertical: 14),
                ),
                child: const Text('Save Product',
                    style: TextStyle(color: Colors.white, fontWeight: FontWeight.bold)),
              ),
            ),
          ],
        ),
      ),
    );
  }
}

// ─── Template Picker ──────────────────────────────────────────────────────────

class _TemplatePicker extends StatelessWidget {
  final List<ProductTemplate> templates;
  final ProductTemplate? selected;
  final ValueChanged<ProductTemplate> onSelect;
  final ValueChanged<ProductTemplate> onDelete;

  const _TemplatePicker({
    required this.templates,
    required this.selected,
    required this.onSelect,
    required this.onDelete,
  });

  @override
  Widget build(BuildContext context) {
    return Container(
      height: 52,
      padding: const EdgeInsets.symmetric(horizontal: 16),
      child: ListView.separated(
        scrollDirection: Axis.horizontal,
        itemCount: templates.length,
        separatorBuilder: (_, _) => const SizedBox(width: 8),
        itemBuilder: (ctx, i) {
          final t = templates[i];
          final isSelected = t.id == selected?.id;
          return GestureDetector(
            onLongPress: () => _confirmDelete(context, t),
            child: ChoiceChip(
              label: Text(t.name),
              selected: isSelected,
              onSelected: (_) => onSelect(t),
              selectedColor: AppColors.primary,
              labelStyle: TextStyle(
                color: isSelected ? Colors.white : null,
                fontWeight: FontWeight.w600,
              ),
            ),
          );
        },
      ),
    );
  }

  void _confirmDelete(BuildContext context, ProductTemplate t) {
    showDialog(
      context: context,
      builder: (ctx) => AlertDialog(
        title: const Text('Delete product?'),
        content: Text('Remove "${t.name}" from your product list?'),
        actions: [
          TextButton(
            onPressed: () => Navigator.pop(ctx),
            child: const Text('Cancel'),
          ),
          TextButton(
            onPressed: () {
              Navigator.pop(ctx);
              onDelete(t);
            },
            style: TextButton.styleFrom(foregroundColor: AppColors.error),
            child: const Text('Delete'),
          ),
        ],
      ),
    );
  }
}

// ─── Template Info Bar ────────────────────────────────────────────────────────

class _TemplateInfoBar extends StatelessWidget {
  final ProductTemplate template;
  const _TemplateInfoBar({required this.template});

  @override
  Widget build(BuildContext context) {
    return Container(
      padding: const EdgeInsets.symmetric(horizontal: 16, vertical: 10),
      color: AppColors.primary.withValues(alpha: 0.06),
      child: Row(
        children: [
          const Icon(Icons.inventory_2_outlined,
              size: 16, color: AppColors.primary),
          const SizedBox(width: 8),
          Text(template.name,
              style: AppTypography.labelLarge
                  .copyWith(color: AppColors.primary)),
          const SizedBox(width: 8),
          Text('•', style: AppTypography.bodySmall),
          const SizedBox(width: 8),
          Text(
            '₹${template.pricePerUnit.toStringAsFixed(2)} / ${template.unit}',
            style: AppTypography.bodySmall
                .copyWith(color: AppColors.textSecondary),
          ),
        ],
      ),
    );
  }
}

// ─── Customer Quantity Grid ───────────────────────────────────────────────────

class _CustomerGrid extends StatelessWidget {
  final List<CustomerLinkItem> customers;
  final Map<String, double> quantities;
  final String unit;
  final double pricePerUnit;

  const _CustomerGrid({
    required this.customers,
    required this.quantities,
    required this.unit,
    required this.pricePerUnit,
  });

  @override
  Widget build(BuildContext context) {
    return ListView.separated(
      padding: EdgeInsets.fromLTRB(
          16, 12, 16, MediaQuery.of(context).padding.bottom + kBottomNavigationBarHeight + 12),
      itemCount: customers.length,
      separatorBuilder: (_, _) => const SizedBox(height: 8),
      itemBuilder: (ctx, i) {
        final c = customers[i];
        final qty = quantities[c.linkId] ?? 0;
        return _CustomerQtyRow(
          customer: c,
          quantity: qty,
          unit: unit,
          pricePerUnit: pricePerUnit,
          onChanged: (newQty) =>
              context.read<BulkChargeCubit>().setQuantity(c.linkId, newQty),
        );
      },
    );
  }
}

class _CustomerQtyRow extends StatelessWidget {
  final CustomerLinkItem customer;
  final double quantity;
  final String unit;
  final double pricePerUnit;
  final ValueChanged<double> onChanged;

  const _CustomerQtyRow({
    required this.customer,
    required this.quantity,
    required this.unit,
    required this.pricePerUnit,
    required this.onChanged,
  });

  @override
  Widget build(BuildContext context) {
    final hasQty = quantity > 0;
    final amount = quantity * pricePerUnit;
    final surface = Theme.of(context).colorScheme.surface;

    return Container(
      padding: const EdgeInsets.all(14),
      decoration: BoxDecoration(
        color: surface,
        borderRadius: BorderRadius.circular(14),
        border: hasQty
            ? Border.all(color: AppColors.primary.withValues(alpha: 0.4))
            : null,
      ),
      child: Row(
        children: [
          // Avatar
          CircleAvatar(
            radius: 20,
            backgroundColor: hasQty
                ? AppColors.primary.withValues(alpha: 0.15)
                : Colors.grey.withValues(alpha: 0.15),
            child: Text(
              customer.displayName[0].toUpperCase(),
              style: TextStyle(
                color: hasQty ? AppColors.primary : AppColors.textHint,
                fontWeight: FontWeight.bold,
              ),
            ),
          ),
          const SizedBox(width: 12),
          // Name + qty label
          Expanded(
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Text(customer.displayName,
                    style: AppTypography.labelLarge
                        .copyWith(color: hasQty ? null : AppColors.textHint)),
                Text(
                  '${quantity.toStringAsFixed(quantity % 1 == 0 ? 0 : 1)} $unit',
                  style: AppTypography.bodySmall
                      .copyWith(color: AppColors.textSecondary),
                ),
              ],
            ),
          ),
          // Stepper
          _Stepper(
            value: quantity,
            onDecrement: () => onChanged((quantity - 1).clamp(0, 9999)),
            onIncrement: () => onChanged(quantity + 1),
          ),
          // Amount
          SizedBox(
            width: 60,
            child: Text(
              hasQty ? '= ₹${amount.toStringAsFixed(0)}' : '= ₹0',
              textAlign: TextAlign.end,
              style: AppTypography.labelLarge.copyWith(
                color: hasQty ? AppColors.primary : AppColors.textHint,
              ),
            ),
          ),
        ],
      ),
    );
  }
}

class _Stepper extends StatelessWidget {
  final double value;
  final VoidCallback onDecrement;
  final VoidCallback onIncrement;

  const _Stepper({
    required this.value,
    required this.onDecrement,
    required this.onIncrement,
  });

  @override
  Widget build(BuildContext context) {
    final hasQty = value > 0;
    return Row(
      mainAxisSize: MainAxisSize.min,
      children: [
        _StepBtn(
          icon: Icons.remove,
          onTap: hasQty ? onDecrement : null,
          filled: false,
        ),
        SizedBox(
          width: 32,
          child: Text(
            value.toStringAsFixed(value % 1 == 0 ? 0 : 1),
            textAlign: TextAlign.center,
            style: AppTypography.labelLarge,
          ),
        ),
        _StepBtn(
          icon: Icons.add,
          onTap: onIncrement,
          filled: true,
        ),
      ],
    );
  }
}

class _StepBtn extends StatelessWidget {
  final IconData icon;
  final VoidCallback? onTap;
  final bool filled;

  const _StepBtn({required this.icon, required this.onTap, required this.filled});

  @override
  Widget build(BuildContext context) {
    return GestureDetector(
      onTap: onTap,
      child: Container(
        width: 32,
        height: 32,
        decoration: BoxDecoration(
          shape: BoxShape.circle,
          color: filled && onTap != null
              ? AppColors.primary
              : Colors.transparent,
          border: Border.all(
            color: onTap != null ? AppColors.primary : AppColors.textHint,
          ),
        ),
        child: Icon(
          icon,
          size: 16,
          color: filled && onTap != null
              ? Colors.white
              : onTap != null
                  ? AppColors.primary
                  : AppColors.textHint,
        ),
      ),
    );
  }
}

// ─── Bottom Bar ───────────────────────────────────────────────────────────────

class _BottomBar extends StatelessWidget {
  final List<CustomerLinkItem> customers;
  const _BottomBar({required this.customers});

  @override
  Widget build(BuildContext context) {
    return BlocBuilder<BulkChargeCubit, BulkChargeState>(
      builder: (context, state) {
        final template = state.selectedTemplate;
        if (template == null) return const SizedBox.shrink();

        final total = state.totalAmount(template.pricePerUnit);
        final count = state.activeCustomerCount;
        final hasItems = count > 0;

        return Container(
          padding: EdgeInsets.fromLTRB(
              20, 12, 20, MediaQuery.of(context).viewPadding.bottom + 12),
          decoration: BoxDecoration(
            color: Theme.of(context).colorScheme.surface,
            boxShadow: [
              BoxShadow(
                color: Colors.black.withValues(alpha: 0.06),
                blurRadius: 10,
                offset: const Offset(0, -4),
              ),
            ],
          ),
          child: Row(
            children: [
              Expanded(
                child: Column(
                  mainAxisSize: MainAxisSize.min,
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    Text(
                      '$count customer${count == 1 ? '' : 's'}  •  '
                      '${state.quantities.values.fold(0.0, (s, q) => s + q).toStringAsFixed(1)} ${template.unit}',
                      style: AppTypography.bodySmall
                          .copyWith(color: AppColors.textSecondary),
                    ),
                    Text(
                      '₹${total.toStringAsFixed(0)} total',
                      style: AppTypography.labelLarge,
                    ),
                  ],
                ),
              ),
              const SizedBox(width: 16),
              ElevatedButton.icon(
                onPressed: hasItems && !state.isSubmitting
                    ? () => _submit(context, customers)
                    : null,
                style: ElevatedButton.styleFrom(
                  backgroundColor: AppColors.primary,
                  padding: const EdgeInsets.symmetric(
                      horizontal: 24, vertical: 14),
                ),
                icon: state.isSubmitting
                    ? const SizedBox(
                        width: 18,
                        height: 18,
                        child: CircularProgressIndicator(
                            strokeWidth: 2, color: Colors.white),
                      )
                    : const Icon(Icons.bolt_rounded,
                        color: Colors.white, size: 20),
                label: Text(
                  'Charge All',
                  style: TextStyle(
                    color: Colors.white,
                    fontWeight: FontWeight.bold,
                    fontSize: state.isSubmitting ? 13 : 15,
                  ),
                ),
              ),
            ],
          ),
        );
      },
    );
  }

  Future<void> _submit(
      BuildContext context, List<CustomerLinkItem> customers) async {
    final cubit = context.read<BulkChargeCubit>();
    final result = await cubit.submitCharge(customers);
    if (!context.mounted || result == null) return;

    final ok = result.succeeded.length;
    final fail = result.failed.length;

    if (fail == 0) {
      AppToast.show(
        context,
        'Charged $ok customer${ok == 1 ? '' : 's'} successfully',
        type: ToastType.success,
      );
    } else {
      AppToast.show(
        context,
        '$ok charged, $fail failed',
        type: fail == ok + fail ? ToastType.error : ToastType.success,
      );
    }
  }
}

// ─── Empty / hint states ──────────────────────────────────────────────────────

class _EmptyTemplates extends StatelessWidget {
  final VoidCallback onAdd;
  const _EmptyTemplates({required this.onAdd});

  @override
  Widget build(BuildContext context) {
    return Center(
      child: Padding(
        padding: const EdgeInsets.all(40),
        child: Column(
          mainAxisSize: MainAxisSize.min,
          children: [
            const Icon(Icons.inventory_2_outlined,
                size: 56, color: AppColors.textHint),
            const SizedBox(height: 16),
            Text('No products yet', style: AppTypography.h3),
            const SizedBox(height: 8),
            Text(
              'Define the items you sell — milk, paneer, etc. — once, then use them every day.',
              textAlign: TextAlign.center,
              style: AppTypography.bodySmall
                  .copyWith(color: AppColors.textSecondary),
            ),
            const SizedBox(height: 24),
            ElevatedButton.icon(
              onPressed: onAdd,
              style: ElevatedButton.styleFrom(
                backgroundColor: AppColors.primary,
                padding: const EdgeInsets.symmetric(
                    horizontal: 24, vertical: 12),
              ),
              icon: const Icon(Icons.add_rounded, color: Colors.white),
              label: const Text('Add First Product',
                  style: TextStyle(color: Colors.white)),
            ),
          ],
        ),
      ),
    );
  }
}

class _SelectTemplateHint extends StatelessWidget {
  const _SelectTemplateHint();

  @override
  Widget build(BuildContext context) {
    return const Center(
      child: Text(
        'Select a product above to assign quantities',
        style: TextStyle(color: AppColors.textHint),
      ),
    );
  }
}

class _NoCustomers extends StatelessWidget {
  const _NoCustomers();

  @override
  Widget build(BuildContext context) {
    return const Center(
      child: Text(
        'No customers linked yet',
        style: TextStyle(color: AppColors.textHint),
      ),
    );
  }
}
