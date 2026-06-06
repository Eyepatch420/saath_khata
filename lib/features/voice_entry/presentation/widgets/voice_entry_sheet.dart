import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import '../../../../core/constants/app_colors.dart';
import '../../../../core/constants/app_typography.dart';
import '../../../../core/di/injection.dart';
import '../../../../core/services/speech_service.dart';
import '../../../../l10n/app_localizations.dart';
import '../../../../shared/models/ledger_entry.dart';
import '../../../shared_ledger/presentation/bloc/ledger_bloc.dart';
import '../../../shared_ledger/presentation/bloc/ledger_event.dart';
import '../../domain/models/voice_draft.dart';
import '../../domain/repositories/voice_repository.dart';
import '../bloc/voice_entry_cubit.dart';
import '../bloc/voice_entry_state.dart';

/// Opens the voice-entry flow as a modal sheet. Launched only from the shared
/// ledger (both vendor and customer). On confirm it dispatches the existing
/// AddLedgerEntry on [ledgerBloc] so the entry flows through the normal path.
Future<void> showVoiceEntrySheet(
  BuildContext context, {
  required String linkId,
  required bool isVendorView,
  required String language,
  required LedgerBloc ledgerBloc,
}) {
  return showModalBottomSheet(
    context: context,
    useRootNavigator: true,
    isScrollControlled: true,
    backgroundColor: Colors.transparent,
    builder: (_) => _VoiceEntrySheet(
      linkId: linkId,
      isVendorView: isVendorView,
      language: language,
      ledgerBloc: ledgerBloc,
    ),
  );
}

class _VoiceEntrySheet extends StatefulWidget {
  final String linkId;
  final bool isVendorView;
  final String language;
  final LedgerBloc ledgerBloc;

  const _VoiceEntrySheet({
    required this.linkId,
    required this.isVendorView,
    required this.language,
    required this.ledgerBloc,
  });

  @override
  State<_VoiceEntrySheet> createState() => _VoiceEntrySheetState();
}

class _VoiceEntrySheetState extends State<_VoiceEntrySheet> {
  late final VoiceEntryCubit _cubit;

  @override
  void initState() {
    super.initState();
    _cubit = VoiceEntryCubit(
      speech: getIt<SpeechService>(),
      repo: getIt<VoiceRepository>(),
      linkId: widget.linkId,
      language: widget.language,
    )..startListening();
  }

  @override
  void dispose() {
    _cubit.close();
    super.dispose();
  }

  void _confirm(VoiceDraft draft) {
    widget.ledgerBloc.add(AddLedgerEntry(
      amount: draft.amount,
      type: draft.type,
      linkId: widget.linkId,
      description: draft.description,
      quantity: draft.quantity,
      unit: draft.unit,
    ));
    Navigator.pop(context);
  }

  @override
  Widget build(BuildContext context) {
    return BlocProvider.value(
      value: _cubit,
      child: Container(
        decoration: const BoxDecoration(
          color: AppColors.secondary,
          borderRadius: BorderRadius.vertical(top: Radius.circular(28)),
        ),
        padding: EdgeInsets.only(
          left: 24,
          right: 24,
          top: 16,
          bottom: MediaQuery.of(context).viewInsets.bottom + 24,
        ),
        child: BlocBuilder<VoiceEntryCubit, VoiceEntryState>(
          builder: (context, state) {
            return Column(
              mainAxisSize: MainAxisSize.min,
              children: [
                Container(
                  width: 40,
                  height: 4,
                  margin: const EdgeInsets.only(bottom: 16),
                  decoration: BoxDecoration(
                    color: Colors.white24,
                    borderRadius: BorderRadius.circular(2),
                  ),
                ),
                switch (state) {
                  VoiceListening() => _ListeningView(
                      partial: state.partial,
                      onStop: _cubit.stopListening,
                    ),
                  VoiceParsing() => _ParsingView(transcript: state.transcript),
                  VoiceReview() => _ReviewCard(
                      draft: state.draft,
                      isVendorView: widget.isVendorView,
                      onConfirm: _confirm,
                      onRetry: _cubit.startListening,
                    ),
                  VoiceErrorState() => _ErrorView(
                      message: state.message,
                      onRetry: _cubit.startListening,
                    ),
                  VoiceIdle() => const SizedBox(
                      height: 120,
                      child: Center(
                          child: CircularProgressIndicator(color: Colors.white)),
                    ),
                },
              ],
            );
          },
        ),
      ),
    );
  }
}

// ── Listening ────────────────────────────────────────────────────────────────
class _ListeningView extends StatelessWidget {
  final String partial;
  final VoidCallback onStop;
  const _ListeningView({required this.partial, required this.onStop});

  @override
  Widget build(BuildContext context) {
    final l10n = AppLocalizations.of(context)!;
    return Column(
      mainAxisSize: MainAxisSize.min,
      children: [
        Text(l10n.voiceListening,
            style: AppTypography.h3.copyWith(color: Colors.white70)),
        const SizedBox(height: 24),
        GestureDetector(
          onTap: onStop,
          child: Container(
            width: 96,
            height: 96,
            decoration: BoxDecoration(
              color: AppColors.primary,
              shape: BoxShape.circle,
              boxShadow: [
                BoxShadow(
                    color: AppColors.primary.withValues(alpha: 0.4),
                    blurRadius: 24,
                    spreadRadius: 4),
              ],
            ),
            child: const Icon(Icons.mic_rounded, color: Colors.white, size: 44),
          ),
        ),
        const SizedBox(height: 20),
        Text(
          partial.isEmpty ? '…' : '"$partial"',
          textAlign: TextAlign.center,
          style: AppTypography.bodyLarge.copyWith(color: Colors.white),
        ),
        const SizedBox(height: 16),
        Text('Tap the mic when you\'re done',
            style: AppTypography.bodySmall.copyWith(color: Colors.white38)),
      ],
    );
  }
}

// ── Parsing ──────────────────────────────────────────────────────────────────
class _ParsingView extends StatelessWidget {
  final String transcript;
  const _ParsingView({required this.transcript});

  @override
  Widget build(BuildContext context) {
    final l10n = AppLocalizations.of(context)!;
    return Column(
      mainAxisSize: MainAxisSize.min,
      children: [
        const SizedBox(height: 8),
        const CircularProgressIndicator(color: AppColors.primary),
        const SizedBox(height: 20),
        Text(l10n.voiceThinking,
            style: AppTypography.h3.copyWith(color: Colors.white70)),
        const SizedBox(height: 12),
        Text('"$transcript"',
            textAlign: TextAlign.center,
            style: AppTypography.bodyMedium
                .copyWith(color: Colors.white, fontStyle: FontStyle.italic)),
        const SizedBox(height: 16),
      ],
    );
  }
}

// ── Error ────────────────────────────────────────────────────────────────────
class _ErrorView extends StatelessWidget {
  final String message;
  final VoidCallback onRetry;
  const _ErrorView({required this.message, required this.onRetry});

  @override
  Widget build(BuildContext context) {
    final l10n = AppLocalizations.of(context)!;
    return Column(
      mainAxisSize: MainAxisSize.min,
      children: [
        const Icon(Icons.error_outline_rounded, color: AppColors.error, size: 40),
        const SizedBox(height: 16),
        Text(message,
            textAlign: TextAlign.center,
            style: AppTypography.bodyMedium.copyWith(color: Colors.white)),
        const SizedBox(height: 20),
        Row(
          children: [
            Expanded(
              child: OutlinedButton(
                onPressed: () => Navigator.pop(context),
                style: OutlinedButton.styleFrom(
                  foregroundColor: Colors.white70,
                  side: const BorderSide(color: Colors.white24),
                  padding: const EdgeInsets.symmetric(vertical: 14),
                ),
                child: Text(l10n.cancel),
              ),
            ),
            const SizedBox(width: 12),
            Expanded(
              child: ElevatedButton(
                onPressed: onRetry,
                style: ElevatedButton.styleFrom(
                  backgroundColor: AppColors.primary,
                  padding: const EdgeInsets.symmetric(vertical: 14),
                ),
                child: Text(l10n.tryAgain),
              ),
            ),
          ],
        ),
      ],
    );
  }
}

// ── Review / edit / confirm ──────────────────────────────────────────────────
class _ReviewCard extends StatefulWidget {
  final VoiceDraft draft;
  final bool isVendorView;
  final void Function(VoiceDraft) onConfirm;
  final VoidCallback onRetry;

  const _ReviewCard({
    required this.draft,
    required this.isVendorView,
    required this.onConfirm,
    required this.onRetry,
  });

  @override
  State<_ReviewCard> createState() => _ReviewCardState();
}

class _ReviewCardState extends State<_ReviewCard> {
  late final TextEditingController _amount;
  late final TextEditingController _desc;
  late final TextEditingController _qty;
  late EntryType _type;

  @override
  void initState() {
    super.initState();
    final d = widget.draft;
    _amount = TextEditingController(text: d.amount.toStringAsFixed(0));
    _desc = TextEditingController(text: d.description ?? '');
    _qty = TextEditingController(text: d.quantity?.toString() ?? '');
    // Customers can only record payments.
    _type = widget.isVendorView ? d.type : EntryType.payment;
  }

  @override
  void dispose() {
    _amount.dispose();
    _desc.dispose();
    _qty.dispose();
    super.dispose();
  }

  void _submit() {
    final amount = double.tryParse(_amount.text.trim());
    if (amount == null || amount <= 0) return;
    widget.onConfirm(widget.draft.copyWith(
      amount: amount,
      type: _type,
      description: _desc.text.trim().isEmpty ? null : _desc.text.trim(),
      quantity: double.tryParse(_qty.text.trim()),
    ));
  }

  @override
  Widget build(BuildContext context) {
    final l10n = AppLocalizations.of(context)!;
    return Container(
      padding: const EdgeInsets.all(20),
      decoration: BoxDecoration(
        color: Colors.white,
        borderRadius: BorderRadius.circular(20),
      ),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.stretch,
        mainAxisSize: MainAxisSize.min,
        children: [
          Row(
            children: [
              Text(l10n.voiceDetectedEntry, style: AppTypography.bodySmall),
              const Spacer(),
              if (widget.draft.isLowConfidence)
                Container(
                  padding:
                      const EdgeInsets.symmetric(horizontal: 8, vertical: 2),
                  decoration: BoxDecoration(
                    color: AppColors.warning.withValues(alpha: 0.15),
                    borderRadius: BorderRadius.circular(10),
                  ),
                  child: Text('Please check',
                      style: AppTypography.bodySmall
                          .copyWith(color: AppColors.warning)),
                ),
            ],
          ),
          const SizedBox(height: 6),
          Text('"${widget.draft.rawTranscript}"',
              style: AppTypography.bodySmall.copyWith(
                  color: AppColors.textSecondary,
                  fontStyle: FontStyle.italic)),
          const SizedBox(height: 16),
          if (widget.isVendorView) ...[
            Row(
              children: [
                Expanded(
                  child: _TypeChip(
                    label: l10n.giveCredit,
                    selected: _type == EntryType.credit,
                    color: AppColors.error,
                    onTap: () => setState(() => _type = EntryType.credit),
                  ),
                ),
                const SizedBox(width: 12),
                Expanded(
                  child: _TypeChip(
                    label: l10n.recordPayment,
                    selected: _type == EntryType.payment,
                    color: AppColors.success,
                    onTap: () => setState(() => _type = EntryType.payment),
                  ),
                ),
              ],
            ),
            const SizedBox(height: 16),
          ],
          TextField(
            controller: _amount,
            keyboardType: const TextInputType.numberWithOptions(decimal: true),
            decoration: InputDecoration(
              labelText: l10n.amountRupees,
              prefixIcon: const Icon(Icons.currency_rupee_rounded),
            ),
          ),
          const SizedBox(height: 12),
          TextField(
            controller: _desc,
            decoration: InputDecoration(
              labelText: l10n.descriptionOptional,
              prefixIcon: const Icon(Icons.description_rounded),
            ),
          ),
          const SizedBox(height: 12),
          TextField(
            controller: _qty,
            keyboardType: const TextInputType.numberWithOptions(decimal: true),
            decoration: InputDecoration(
              labelText: l10n.quantityOptional,
              prefixIcon: const Icon(Icons.numbers_rounded),
            ),
          ),
          const SizedBox(height: 20),
          Row(
            children: [
              IconButton(
                onPressed: widget.onRetry,
                icon: const Icon(Icons.mic_rounded),
                color: AppColors.primary,
                tooltip: l10n.tryAgain,
              ),
              const SizedBox(width: 8),
              Expanded(
                child: ElevatedButton(
                  onPressed: _submit,
                  style: ElevatedButton.styleFrom(
                    backgroundColor: AppColors.primary,
                    padding: const EdgeInsets.symmetric(vertical: 16),
                  ),
                  child: Text(l10n.voiceConfirmEntry,
                      style: const TextStyle(
                          color: Colors.white, fontWeight: FontWeight.bold)),
                ),
              ),
            ],
          ),
        ],
      ),
    );
  }
}

class _TypeChip extends StatelessWidget {
  final String label;
  final bool selected;
  final Color color;
  final VoidCallback onTap;

  const _TypeChip({
    required this.label,
    required this.selected,
    required this.color,
    required this.onTap,
  });

  @override
  Widget build(BuildContext context) {
    return InkWell(
      onTap: onTap,
      borderRadius: BorderRadius.circular(10),
      child: Container(
        padding: const EdgeInsets.symmetric(vertical: 12),
        alignment: Alignment.center,
        decoration: BoxDecoration(
          color: selected ? color.withValues(alpha: 0.12) : Colors.transparent,
          borderRadius: BorderRadius.circular(10),
          border: Border.all(
            color: selected ? color : AppColors.divider,
            width: selected ? 2 : 1,
          ),
        ),
        child: Text(
          label,
          style: AppTypography.labelLarge.copyWith(
            color: selected ? color : AppColors.textSecondary,
            fontWeight: FontWeight.w600,
          ),
        ),
      ),
    );
  }
}
