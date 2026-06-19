import 'package:flutter/material.dart';
import '../../../../../../core/constants/app_colors.dart';
import '../../../../../../core/constants/app_typography.dart';
import '../../../../../../l10n/app_localizations.dart';
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
    final l10n = AppLocalizations.of(context)!;
    if (value == null || value <= 0) {
      setState(() => _error = l10n.discountValueInvalid);
      return;
    }
    if (_type == DiscountType.percentage && value > 100) {
      setState(() => _error = l10n.percentageExceedsMax);
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
          Text(AppLocalizations.of(context)!.discountFor(widget.tier.name), style: AppTypography.h3),
          const SizedBox(height: 4),
          Text(
            AppLocalizations.of(context)!.memberDiscountDescription,
            style: AppTypography.bodySmall
                .copyWith(color: AppColors.textSecondary),
          ),
          const SizedBox(height: 20),

          // Type selector
          SegmentedButton<DiscountType>(
            segments: [
              ButtonSegment(value: DiscountType.none, label: Text(AppLocalizations.of(context)!.none)),
              ButtonSegment(value: DiscountType.percentage, label: Text(AppLocalizations.of(context)!.percent)),
              ButtonSegment(value: DiscountType.flat, label: Text(AppLocalizations.of(context)!.flatAmount)),
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
                labelText: isPercentage ? AppLocalizations.of(context)!.discountPercent : AppLocalizations.of(context)!.discountAmount,
                prefixIcon: Icon(
                    isPercentage ? Icons.percent_rounded : Icons.currency_rupee_rounded),
                hintText: isPercentage ? AppLocalizations.of(context)!.percentExample : AppLocalizations.of(context)!.amountExample,
              ),
              onChanged: (_) => setState(() => _error = null),
            ),
            if (isPercentage) ...[
              const SizedBox(height: 14),
              TextField(
                controller: _capCtrl,
                keyboardType: TextInputType.number,
                decoration: InputDecoration(
                  labelText: AppLocalizations.of(context)!.maxDiscountPerDue,
                  prefixIcon: const Icon(Icons.vertical_align_top_rounded),
                  hintText: AppLocalizations.of(context)!.maxDiscountExample,
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
              child: Text(AppLocalizations.of(context)!.saveDiscount,
                  style: const TextStyle(color: Colors.white)),
            ),
          ),
        ],
      ),
    );
  }
}
