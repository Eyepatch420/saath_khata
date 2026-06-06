import 'package:equatable/equatable.dart';
import '../../../../shared/models/ledger_entry.dart';

/// A normalized ledger draft returned by the backend voice-parse endpoint.
/// Mirrors the fields the existing AddLedgerEntry flow needs; the user reviews
/// and (optionally) edits this before it becomes a real entry.
class VoiceDraft extends Equatable {
  final double amount;
  final EntryType type;
  final String? description;
  final double? quantity;
  final String? unit;
  final double? confidence;
  final String rawTranscript;

  const VoiceDraft({
    required this.amount,
    required this.type,
    required this.rawTranscript,
    this.description,
    this.quantity,
    this.unit,
    this.confidence,
  });

  factory VoiceDraft.fromJson(Map<String, dynamic> json) => VoiceDraft(
        amount: (json['amount'] as num).toDouble(),
        type: EntryType.values.firstWhere(
          (e) => e.name == json['type'],
          orElse: () => EntryType.credit,
        ),
        description: json['description'] as String?,
        quantity: (json['quantity'] as num?)?.toDouble(),
        unit: json['unit'] as String?,
        confidence: (json['confidence'] as num?)?.toDouble(),
        rawTranscript: json['rawTranscript'] as String? ?? '',
      );

  VoiceDraft copyWith({
    double? amount,
    EntryType? type,
    String? description,
    double? quantity,
    String? unit,
  }) =>
      VoiceDraft(
        amount: amount ?? this.amount,
        type: type ?? this.type,
        description: description ?? this.description,
        quantity: quantity ?? this.quantity,
        unit: unit ?? this.unit,
        confidence: confidence,
        rawTranscript: rawTranscript,
      );

  bool get isLowConfidence => confidence != null && confidence! < 0.5;

  @override
  List<Object?> get props =>
      [amount, type, description, quantity, unit, confidence, rawTranscript];
}
