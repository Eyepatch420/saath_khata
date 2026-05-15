import 'package:flutter/material.dart';
import '../../../../core/constants/app_colors.dart';
import '../../../../core/constants/app_typography.dart';

class VoiceEntryScreen extends StatefulWidget {
  const VoiceEntryScreen({super.key});

  @override
  State<VoiceEntryScreen> createState() => _VoiceEntryScreenState();
}

class _VoiceEntryScreenState extends State<VoiceEntryScreen> {
  bool isListening = true;

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: AppColors.secondary,
      appBar: AppBar(
        backgroundColor: Colors.transparent,
        elevation: 0,
        leading: IconButton(
          icon: const Icon(Icons.close, color: Colors.white),
          onPressed: () => Navigator.pop(context),
        ),
      ),
      body: Column(
        children: [
          const Spacer(),
          Text(
            isListening ? 'Listening...' : 'Thinking...',
            style: AppTypography.h2.copyWith(color: Colors.white70),
          ),
          const SizedBox(height: 20),
          Padding(
            padding: const EdgeInsets.symmetric(horizontal: 40),
            child: Text(
              '"Sujeet ka aaj 2 litre doodh diya, ₹60 udhar"',
              textAlign: TextAlign.center,
              style: AppTypography.h3.copyWith(color: Colors.white, fontStyle: FontStyle.italic),
            ),
          ),
          const SizedBox(height: 60),
          _WaveformPlaceholder(),
          const Spacer(),
          Container(
            padding: const EdgeInsets.all(32),
            decoration: const BoxDecoration(
              color: Colors.white,
              borderRadius: BorderRadius.vertical(top: Radius.circular(32)),
            ),
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.stretch,
              children: [
                Text('Detected Entry', style: AppTypography.bodySmall),
                const SizedBox(height: 16),
                _DetectionField(label: 'Customer', value: 'Sujeet Kumar'),
                _DetectionField(label: 'Item', value: '2L Milk'),
                _DetectionField(label: 'Amount', value: '₹60'),
                const SizedBox(height: 24),
                ElevatedButton(
                  onPressed: () => Navigator.pop(context),
                  style: ElevatedButton.styleFrom(
                    backgroundColor: AppColors.primary,
                    padding: const EdgeInsets.symmetric(vertical: 16),
                  ),
                  child: const Text('CONFIRM ENTRY'),
                ),
              ],
            ),
          ),
        ],
      ),
    );
  }
}

class _WaveformPlaceholder extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return SizedBox(
      height: 100,
      child: Row(
        mainAxisAlignment: MainAxisAlignment.center,
        children: List.generate(
          15,
          (index) => Container(
            margin: const EdgeInsets.symmetric(horizontal: 2),
            width: 4,
            height: (index % 5 + 2) * 10.0,
            decoration: BoxDecoration(
              color: AppColors.primary,
              borderRadius: BorderRadius.circular(2),
            ),
          ),
        ),
      ),
    );
  }
}

class _DetectionField extends StatelessWidget {
  final String label;
  final String value;

  const _DetectionField({required this.label, required this.value});

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.only(bottom: 12),
      child: Row(
        mainAxisAlignment: MainAxisAlignment.spaceBetween,
        children: [
          Text(label, style: AppTypography.bodyMedium.copyWith(color: AppColors.textSecondary)),
          Text(value, style: AppTypography.labelLarge),
        ],
      ),
    );
  }
}
