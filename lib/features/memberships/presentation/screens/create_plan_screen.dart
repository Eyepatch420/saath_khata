import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import '../../../../core/constants/app_colors.dart';
import '../../../../shared/widgets/app_toast.dart';
import '../../domain/models/membership_plan.dart';
import '../bloc/plans_cubit.dart';
import '../membership_theme.dart';

/// Create or edit a membership plan. Pass [existing] to edit.
class CreatePlanScreen extends StatefulWidget {
  final MembershipPlan? existing;
  const CreatePlanScreen({super.key, this.existing});

  @override
  State<CreatePlanScreen> createState() => _CreatePlanScreenState();
}

class _BenefitRow {
  final TextEditingController labelCtrl;
  final TextEditingController quotaCtrl;
  _BenefitRow({String label = '', int? quota})
      : labelCtrl = TextEditingController(text: label),
        quotaCtrl = TextEditingController(text: quota?.toString() ?? '');
  void dispose() {
    labelCtrl.dispose();
    quotaCtrl.dispose();
  }
}

class _CreatePlanScreenState extends State<CreatePlanScreen> {
  final _formKey = GlobalKey<FormState>();
  final _nameCtrl = TextEditingController();
  final _durationCtrl = TextEditingController(text: '30');
  final _priceCtrl = TextEditingController();
  final _customAdvanceCtrl = TextEditingController();
  final List<_BenefitRow> _benefits = [];

  // null = None, otherwise the chosen advance amount; -1 sentinel = custom
  double _advance = 0;
  bool _customAdvance = false;

  bool get _isEdit => widget.existing != null;

  @override
  void initState() {
    super.initState();
    final e = widget.existing;
    if (e != null) {
      _nameCtrl.text = e.name;
      _durationCtrl.text = e.durationDays.toString();
      _priceCtrl.text = e.price.toStringAsFixed(0);
      _advance = e.advanceRequired;
      if (e.advanceRequired != 0 && e.advanceRequired != 200 && e.advanceRequired != 500) {
        _customAdvance = true;
        _customAdvanceCtrl.text = e.advanceRequired.toStringAsFixed(0);
      }
      for (final b in e.benefits) {
        _benefits.add(_BenefitRow(label: b.label, quota: b.quota));
      }
    }
    if (_benefits.isEmpty) _benefits.add(_BenefitRow());
  }

  @override
  void dispose() {
    _nameCtrl.dispose();
    _durationCtrl.dispose();
    _priceCtrl.dispose();
    _customAdvanceCtrl.dispose();
    for (final b in _benefits) {
      b.dispose();
    }
    super.dispose();
  }

  double get _effectiveAdvance {
    if (_customAdvance) return double.tryParse(_customAdvanceCtrl.text.trim()) ?? 0;
    return _advance;
  }

  Future<void> _submit() async {
    if (!_formKey.currentState!.validate()) return;
    final benefits = _benefits
        .where((b) => b.labelCtrl.text.trim().isNotEmpty)
        .map((b) => PlanBenefit(
              id: '',
              label: b.labelCtrl.text.trim(),
              quota: int.tryParse(b.quotaCtrl.text.trim()),
            ))
        .toList();

    final cubit = context.read<PlansCubit>();
    final ok = _isEdit
        ? await cubit.updatePlan(
            widget.existing!.id,
            name: _nameCtrl.text.trim(),
            durationDays: int.parse(_durationCtrl.text.trim()),
            price: double.parse(_priceCtrl.text.trim()),
            advanceRequired: _effectiveAdvance,
            benefits: benefits,
          )
        : await cubit.createPlan(
            name: _nameCtrl.text.trim(),
            durationDays: int.parse(_durationCtrl.text.trim()),
            price: double.parse(_priceCtrl.text.trim()),
            advanceRequired: _effectiveAdvance,
            benefits: benefits,
          );

    if (!mounted) return;
    if (ok) {
      AppToast.show(context, _isEdit ? 'Plan updated' : 'Plan published');
      Navigator.pop(context);
    } else {
      final s = cubit.state;
      if (s is PlansError) AppToast.show(context, s.message, type: ToastType.error);
    }
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: AppColors.background,
      appBar: AppBar(
        title: Text(_isEdit ? 'Edit Plan' : 'Create Membership Plan'),
        backgroundColor: MembershipTheme.purple,
        foregroundColor: Colors.white,
      ),
      body: Form(
        key: _formKey,
        child: ListView(
          padding: const EdgeInsets.all(16),
          children: [
            _Card(
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  TextFormField(
                    controller: _nameCtrl,
                    textCapitalization: TextCapitalization.words,
                    decoration: _dec('Plan name', hint: 'e.g. Gold Membership'),
                    validator: (v) =>
                        (v == null || v.trim().isEmpty) ? 'Required' : null,
                  ),
                  const SizedBox(height: 12),
                  Row(
                    children: [
                      Expanded(
                        child: TextFormField(
                          controller: _durationCtrl,
                          keyboardType: TextInputType.number,
                          inputFormatters: [
                            FilteringTextInputFormatter.digitsOnly
                          ],
                          decoration: _dec('Duration (days)'),
                          validator: (v) {
                            final n = int.tryParse(v?.trim() ?? '');
                            if (n == null || n < 1) return 'Min 1';
                            return null;
                          },
                        ),
                      ),
                      const SizedBox(width: 12),
                      Expanded(
                        child: TextFormField(
                          controller: _priceCtrl,
                          keyboardType: const TextInputType.numberWithOptions(
                              decimal: true),
                          inputFormatters: [
                            FilteringTextInputFormatter.allow(RegExp(r'[0-9.]'))
                          ],
                          decoration: _dec('Price ₹'),
                          validator: (v) {
                            final n = double.tryParse(v?.trim() ?? '');
                            if (n == null || n < 0) return 'Invalid';
                            return null;
                          },
                        ),
                      ),
                    ],
                  ),
                ],
              ),
            ),
            const SizedBox(height: 16),
            _SectionLabel('Benefits'),
            const SizedBox(height: 8),
            _Card(
              child: Column(
                children: [
                  ...List.generate(_benefits.length, (i) => _benefitRow(i)),
                  const SizedBox(height: 4),
                  Align(
                    alignment: Alignment.centerLeft,
                    child: TextButton.icon(
                      onPressed: () =>
                          setState(() => _benefits.add(_BenefitRow())),
                      icon: const Icon(Icons.add_circle_outline, size: 18),
                      label: const Text('Add benefit'),
                      style: TextButton.styleFrom(
                          foregroundColor: MembershipTheme.purple),
                    ),
                  ),
                ],
              ),
            ),
            const SizedBox(height: 16),
            _SectionLabel('Advance required'),
            const SizedBox(height: 8),
            _Card(
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  Wrap(
                    spacing: 8,
                    children: [
                      _advanceChip('None', 0),
                      _advanceChip('₹200', 200),
                      _advanceChip('₹500', 500),
                      ChoiceChip(
                        label: const Text('Custom'),
                        selected: _customAdvance,
                        selectedColor: MembershipTheme.purpleSoft,
                        onSelected: (_) => setState(() => _customAdvance = true),
                      ),
                    ],
                  ),
                  if (_customAdvance) ...[
                    const SizedBox(height: 12),
                    TextFormField(
                      controller: _customAdvanceCtrl,
                      keyboardType: const TextInputType.numberWithOptions(
                          decimal: true),
                      inputFormatters: [
                        FilteringTextInputFormatter.allow(RegExp(r'[0-9.]'))
                      ],
                      decoration: _dec('Custom advance ₹'),
                    ),
                  ],
                ],
              ),
            ),
            const SizedBox(height: 28),
          ],
        ),
      ),
      bottomNavigationBar: BlocBuilder<PlansCubit, PlansState>(
        builder: (context, state) {
          final saving = state is PlansLoaded && state.saving;
          return SafeArea(
            child: Padding(
              padding: const EdgeInsets.all(16),
              child: FilledButton.icon(
                onPressed: saving ? null : _submit,
                icon: saving
                    ? const SizedBox(
                        width: 18,
                        height: 18,
                        child: CircularProgressIndicator(
                            color: Colors.white, strokeWidth: 2))
                    : const Icon(Icons.publish_rounded),
                label: Text(_isEdit ? 'Save Changes' : 'Publish Plan'),
                style: FilledButton.styleFrom(
                  backgroundColor: MembershipTheme.purple,
                  minimumSize: const Size.fromHeight(52),
                ),
              ),
            ),
          );
        },
      ),
    );
  }

  Widget _benefitRow(int i) {
    final row = _benefits[i];
    return Padding(
      padding: const EdgeInsets.only(bottom: 10),
      child: Row(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          const Padding(
            padding: EdgeInsets.only(top: 12),
            child: Icon(Icons.check_circle, size: 18, color: AppColors.success),
          ),
          const SizedBox(width: 8),
          Expanded(
            flex: 3,
            child: TextFormField(
              controller: row.labelCtrl,
              decoration: _dec('Benefit', hint: 'e.g. 4 haircuts'),
            ),
          ),
          const SizedBox(width: 8),
          Expanded(
            flex: 1,
            child: TextFormField(
              controller: row.quotaCtrl,
              keyboardType: TextInputType.number,
              inputFormatters: [FilteringTextInputFormatter.digitsOnly],
              decoration: _dec('Qty'),
            ),
          ),
          if (_benefits.length > 1)
            IconButton(
              icon: const Icon(Icons.close, size: 18, color: AppColors.error),
              onPressed: () => setState(() {
                _benefits[i].dispose();
                _benefits.removeAt(i);
              }),
            ),
        ],
      ),
    );
  }

  Widget _advanceChip(String label, double value) {
    final selected = !_customAdvance && _advance == value;
    return ChoiceChip(
      label: Text(label),
      selected: selected,
      selectedColor: MembershipTheme.purpleSoft,
      onSelected: (_) => setState(() {
        _customAdvance = false;
        _advance = value;
      }),
    );
  }

  InputDecoration _dec(String label, {String? hint}) => InputDecoration(
        labelText: label,
        hintText: hint,
        isDense: true,
        border: const OutlineInputBorder(),
        focusedBorder: const OutlineInputBorder(
          borderSide: BorderSide(color: MembershipTheme.purple, width: 1.5),
        ),
      );
}

class _Card extends StatelessWidget {
  final Widget child;
  const _Card({required this.child});
  @override
  Widget build(BuildContext context) => Container(
        padding: const EdgeInsets.all(16),
        decoration: BoxDecoration(
          color: AppColors.surface,
          borderRadius: BorderRadius.circular(14),
          border: Border.all(color: AppColors.divider),
        ),
        child: child,
      );
}

class _SectionLabel extends StatelessWidget {
  final String text;
  const _SectionLabel(this.text);
  @override
  Widget build(BuildContext context) => Text(
        text.toUpperCase(),
        style: const TextStyle(
          color: AppColors.textSecondary,
          fontSize: 12,
          fontWeight: FontWeight.w700,
          letterSpacing: 0.6,
        ),
      );
}
