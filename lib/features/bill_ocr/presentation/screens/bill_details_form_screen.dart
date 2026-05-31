import 'package:flutter/material.dart';
import 'package:go_router/go_router.dart';
import '../../../../core/widgets/primary_button.dart';
import '../../../../core/widgets/custom_text_field.dart';
import '../../../../l10n/app_localizations.dart';

class BillDetailsFormScreen extends StatefulWidget {
  const BillDetailsFormScreen({super.key});

  @override
  State<BillDetailsFormScreen> createState() => _BillDetailsFormScreenState();
}

class _BillDetailsFormScreenState extends State<BillDetailsFormScreen> {
  final _amountController = TextEditingController(text: '1250');
  final _descriptionController = TextEditingController(text: 'Monthly Grocery Bill');
  final _dateController = TextEditingController(text: '26 May 2024');

  @override
  Widget build(BuildContext context) {
    final l10n = AppLocalizations.of(context)!;
    return Scaffold(

      appBar: AppBar(
        title: Text(l10n.verifyBillDetails),
      ),
      body: SafeArea(child: SingleChildScrollView(
        padding: const EdgeInsets.all(24),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Container(
              height: 200,
              width: double.infinity,
              decoration: BoxDecoration(
                color: Colors.grey[300],
                borderRadius: BorderRadius.circular(16),
                image: const DecorationImage(
                  image: NetworkImage('https://placeholder.com/bill'),
                  fit: BoxFit.cover,
                  opacity: 0.5,
                ),
              ),
              child: Center(
                child: Text(l10n.scannedBillPreview,
                    style: const TextStyle(color: Colors.black54)),
              ),
            ),
            const SizedBox(height: 32),
            CustomTextField(
              label: l10n.entryAmount,
              controller: _amountController,
              keyboardType: TextInputType.number,
              prefixIcon: Icons.currency_rupee,
            ),
            const SizedBox(height: 20),
            CustomTextField(
              label: l10n.entryDate,
              controller: _dateController,
              prefixIcon: Icons.calendar_today,
            ),
            const SizedBox(height: 20),
            CustomTextField(
              label: l10n.descriptionItemDetails,
              controller: _descriptionController,
              prefixIcon: Icons.description,
            ),
            const SizedBox(height: 20),
            CustomTextField(
              label: l10n.selectCustomer,
              hintText: l10n.searchCustomerHint,
              prefixIcon: Icons.person,
            ),
            const SizedBox(height: 40),
            PrimaryButton(
              label: l10n.saveToKhata,
              onPressed: () {
                context.pop();
                context.pop();
              },
            ),
          ],
        ),
      ),
      ),
    );
  }
}
