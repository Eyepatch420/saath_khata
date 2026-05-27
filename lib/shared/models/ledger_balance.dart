import 'package:equatable/equatable.dart';

/// Response shape from GET /links/:linkId/entries/balance
class LedgerBalance extends Equatable {
  final String linkId;
  final double balance;
  final int pendingCount;
  final int confirmedCount;
  final int disputedCount;
  final double totalCreditAmount;
  final double totalPaymentAmount;

  const LedgerBalance({
    required this.linkId,
    required this.balance,
    required this.pendingCount,
    required this.confirmedCount,
    required this.disputedCount,
    required this.totalCreditAmount,
    required this.totalPaymentAmount,
  });

  factory LedgerBalance.fromJson(Map<String, dynamic> json) => LedgerBalance(
        linkId: json['linkId'] as String,
        balance: (json['balance'] as num).toDouble(),
        pendingCount: json['pendingCount'] as int,
        confirmedCount: json['confirmedCount'] as int,
        disputedCount: json['disputedCount'] as int,
        totalCreditAmount: (json['totalCreditAmount'] as num).toDouble(),
        totalPaymentAmount: (json['totalPaymentAmount'] as num).toDouble(),
      );

  @override
  List<Object?> get props => [
        linkId,
        balance,
        pendingCount,
        confirmedCount,
        disputedCount,
        totalCreditAmount,
        totalPaymentAmount,
      ];
}
