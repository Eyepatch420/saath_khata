import 'package:flutter/material.dart';
import 'package:go_router/go_router.dart';
import '../../../../core/constants/app_colors.dart';
import '../../../../core/widgets/primary_button.dart';
import '../../../../core/widgets/custom_text_field.dart';

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
    return Scaffold(
      backgroundColor: AppColors.background,
      appBar: AppBar(
        title: const Text('Verify Bill Details'),
      ),
      body: SingleChildScrollView(
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
                  image: NetworkImage('https://placeholder.com/bill'), // Mock image
                  fit: BoxFit.cover,
                  opacity: 0.5,
                ),
              ),
              child: const Center(
                child: Text('Scanned Bill Preview', style: TextStyle(color: Colors.black54)),
              ),
            ),
            const SizedBox(height: 32),
            CustomTextField(
              label: 'Amount',
              controller: _amountController,
              keyboardType: TextInputType.number,
              prefixIcon: Icons.currency_rupee,
            ),
            const SizedBox(height: 20),
            CustomTextField(
              label: 'Date',
              controller: _dateController,
              prefixIcon: Icons.calendar_today,
            ),
            const SizedBox(height: 20),
            CustomTextField(
              label: 'Description / Item Details',
              controller: _descriptionController,
              prefixIcon: Icons.description,
            ),
            const SizedBox(height: 20),
            const CustomTextField(
              label: 'Select Customer',
              hintText: 'Search or select customer',
              prefixIcon: Icons.person,
            ),
            const SizedBox(height: 40),
            PrimaryButton(
              label: 'SAVE TO KHATA',
              onPressed: () {
                // Return to dashboard
                context.pop();
                context.pop();
              },
            ),
          ],
        ),
      ),
    );
  }
}
