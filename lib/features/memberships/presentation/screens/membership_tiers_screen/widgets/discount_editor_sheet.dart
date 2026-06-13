import 'package:flutter/material.dart';
import '../../../../../../core/constants/app_colors.dart';
import '../../../../../../core/constants/app_typography.dart';
import '../../../../domain/models/membership_tier.dart';

/// Result returned by the discount editor sheet.
class DiscountEditResult {
  final DiscountType type;
  final double value;
  final double? cap;
  const DiscountEditResult({required this.type, required this.value, this.cap});
}

/// Bottom sheet that lets a vendor configure a tier's discount function:
/// none / percentage (+ optional cap) / flat. Returns null if dismissed.
class DiscountEditorSheet extends StatefulWidget {
  final MembershipTier tier;
  const DiscountEditorSheet({super.key, required this.tier});

  static Future<DiscountEditResult?> show(
    BuildContext context,
    MembershipTier tier,
  ) {
    return showModalBottomSheet<DiscountEditResult>(
      context: context,
      useRootNavigator: true,
      isScrollControlled: true,
      shape: const RoundedRectangleBorder(
        borderRadius: BorderRadius.vertical(top: Radius.circular(24)),
      ),
      builder: (_) => DiscountEditorSheet(tier: tier),
    );
  }

  @override
  State<DiscountEditorSheet> createState() => _DiscountEditorSheetState();
}

class _DiscountEditorSheetState extends State<DiscountEditorSheet> {
  late DiscountType _type;
  late final TextEditingController _valueCtrl;
  late final TextEditingController _capCtrl;
  String? _error;

  @override
  void initState() {
    super.initState();
    _type = widget.tier.discountType;
    _valueCtrl = TextEditingController(
      text: widget.tier.discountValue > 0
          ? widget.tier.discountValue.toStringAsFixed(
              widget.tier.discountValue % 1 == 0 ? 0 : 2)
          : '',
    );
    _capCtrl = TextEditingController(
      text: widget.tier.discountCap != null
          ? widget.tier.discountCap!.toStringAsFixed(0)
          : '',
    );
  }

  @override
  void dispose() {
    _valueCtrl.dispose();
    _capCtrl.dispose();
    super.dispose();
  }

  void _save() {
    if (_type == DiscountType.none) {
      Navigator.pop(
        context,
        const DiscountEditResult(type: DiscountType.none, value: 0),
      );
      return;
    }
    final value = double.tryParse(_valueCtrl.text.trim());
    if (value == null || value <= 0) {
      setState(() => _error = 'Enter a valid amount greater than 0');
      return;
    }
    if (_type == DiscountType.percentage && value > 100) {
      setState(() => _error = 'Percentage cannot exceed 100');
      return;
    }
    final cap = _type == DiscountType.percentage
        ? double.tryParse(_capCtrl.text.trim())
        : null;
    Navigator.pop(
      context,
      DiscountEditResult(type: _type, value: value, cap: cap),
    );
  }

  @override
  Widget build(BuildContext context) {
    final isPercentage = _type == DiscountType.percentage;
    final isFlat = _type == DiscountType.flat;

    return Padding(
      padding: EdgeInsets.only(
        left: 24,
        right: 24,
        top: 24,
        bottom: MediaQuery.of(context).viewInsets.bottom + 24,
      ),
      child: Column(
        mainAxisSize: MainAxisSize.min,
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Text('Discount for ${widget.tier.name}', style: AppTypography.h3),
          const SizedBox(height: 4),
          Text(
            'Members on this tier get this discount on their dues.',
            style: AppTypography.bodySmall
                .copyWith(color: AppColors.textSecondary),
          ),
          const SizedBox(height: 20),

          // Type selector
          SegmentedButton<DiscountType>(
            segments: const [
              ButtonSegment(value: DiscountType.none, label: Text('None')),
              ButtonSegment(
                  value: DiscountType.percentage, label: Text('Percent')),
              ButtonSegment(value: DiscountType.flat, label: Text('Flat ₹')),
            ],
            selected: {_type},
            onSelectionChanged: (s) => setState(() {
              _type = s.first;
              _error = null;
            }),
          ),
          const SizedBox(height: 20),

          if (isPercentage || isFlat) ...[
            TextField(
              controller: _valueCtrl,
              keyboardType:
                  const TextInputType.numberWithOptions(decimal: true),
              decoration: InputDecoration(
                labelText: isPercentage ? 'Discount %' : 'Discount amount (₹)',
                prefixIcon: Icon(
                    isPercentage ? Icons.percent_rounded : Icons.currency_rupee_rounded),
                hintText: isPercentage ? 'e.g. 5' : 'e.g. 50',
              ),
              onChanged: (_) => setState(() => _error = null),
            ),
            if (isPercentage) ...[
              const SizedBox(height: 14),
              TextField(
                controller: _capCtrl,
                keyboardType: TextInputType.number,
                decoration: const InputDecoration(
                  labelText: 'Max discount per due (₹) — optional',
                  prefixIcon: Icon(Icons.vertical_align_top_rounded),
                  hintText: 'e.g. 100 (leave blank for no cap)',
                ),
              ),
            ],
          ],

          if (_error != null) ...[
            const SizedBox(height: 12),
            Text(_error!,
                style: AppTypography.bodySmall.copyWith(color: AppColors.error)),
          ],

          const SizedBox(height: 24),
          SizedBox(
            width: double.infinity,
            child: ElevatedButton(
              onPressed: _save,
              style: ElevatedButton.styleFrom(
                backgroundColor: AppColors.primary,
                padding: const EdgeInsets.symmetric(vertical: 14),
              ),
              child: const Text('Save discount',
                  style: TextStyle(color: Colors.white)),
            ),
          ),
        ],
      ),
    );
  }
}
