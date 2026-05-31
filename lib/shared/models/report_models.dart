import 'package:equatable/equatable.dart';

class PaginatedList<T> {
  final List<T> items;
  final bool hasMore;

  const PaginatedList({required this.items, required this.hasMore});
}

/// One row in GET /reports/collected-today
class CollectedTodayItem extends Equatable {
  final String linkId;
  final String customerName;
  final String? customerPhone;
  final double amount;
  final String paidAt;

  const CollectedTodayItem({
    required this.linkId,
    required this.customerName,
    this.customerPhone,
    required this.amount,
    required this.paidAt,
  });

  factory CollectedTodayItem.fromJson(Map<String, dynamic> json) =>
      CollectedTodayItem(
        linkId: json['linkId'] as String,
        customerName: json['customerName'] as String,
        customerPhone: json['customerPhone'] as String?,
        amount: (json['amount'] as num).toDouble(),
        paidAt: json['paidAt'] as String,
      );

  @override
  List<Object?> get props => [linkId, customerName, customerPhone, amount, paidAt];
}

/// GET /reports/summary
class VendorSummaryReport extends Equatable {
  final double totalOutstanding;
  final double totalCollectedThisMonth;
  final double totalCollectedToday;
  final double totalCreditThisMonth;
  final int activeCustomerCount;
  final List<CustomerReportItem> topCustomers;

  const VendorSummaryReport({
    required this.totalOutstanding,
    required this.totalCollectedThisMonth,
    required this.totalCollectedToday,
    required this.totalCreditThisMonth,
    required this.activeCustomerCount,
    required this.topCustomers,
  });

  factory VendorSummaryReport.fromJson(Map<String, dynamic> json) =>
      VendorSummaryReport(
        totalOutstanding: (json['totalOutstanding'] as num).toDouble(),
        totalCollectedThisMonth:
            (json['totalCollectedThisMonth'] as num).toDouble(),
        totalCollectedToday:
            (json['totalCollectedToday'] as num).toDouble(),
        totalCreditThisMonth:
            (json['totalCreditThisMonth'] as num).toDouble(),
        activeCustomerCount: json['activeCustomerCount'] as int,
        topCustomers: (json['topCustomers'] as List)
            .map((e) => CustomerReportItem.fromJson(e as Map<String, dynamic>))
            .toList(),
      );

  @override
  List<Object?> get props => [
        totalOutstanding,
        totalCollectedThisMonth,
        totalCollectedToday,
        totalCreditThisMonth,
        activeCustomerCount,
        topCustomers,
      ];
}

/// One row in GET /reports/customers  (also used inside VendorSummaryReport.topCustomers)
class CustomerReportItem extends Equatable {
  final String linkId;
  final String customerId;
  final String customerName;
  final String? customerPhone;
  final String? profilePhotoUrl;
  final double balance;
  final double collectedThisMonth;

  const CustomerReportItem({
    required this.linkId,
    required this.customerId,
    required this.customerName,
    this.customerPhone,
    this.profilePhotoUrl,
    required this.balance,
    required this.collectedThisMonth,
  });

  factory CustomerReportItem.fromJson(Map<String, dynamic> json) =>
      CustomerReportItem(
        linkId: json['linkId'] as String,
        customerId: json['customerId'] as String,
        customerName: json['customerName'] as String,
        customerPhone: json['customerPhone'] as String?,
        profilePhotoUrl: json['profilePhotoUrl'] as String?,
        balance: (json['balance'] as num).toDouble(),
        collectedThisMonth: (json['collectedThisMonth'] as num).toDouble(),
      );

  @override
  List<Object?> get props => [
        linkId,
        customerId,
        customerName,
        customerPhone,
        profilePhotoUrl,
        balance,
        collectedThisMonth,
      ];
}

/// GET /reports/customers/:linkId
class CustomerDetailReport extends Equatable {
  final String linkId;
  final String customerId;
  final String customerName;
  final double balance;
  final double totalCredit;
  final double totalPaid;
  final int pendingCount;
  final int confirmedCount;
  final int disputedCount;
  final List<MonthlyPaymentData> monthlyBreakdown;

  const CustomerDetailReport({
    required this.linkId,
    required this.customerId,
    required this.customerName,
    required this.balance,
    required this.totalCredit,
    required this.totalPaid,
    required this.pendingCount,
    required this.confirmedCount,
    required this.disputedCount,
    required this.monthlyBreakdown,
  });

  factory CustomerDetailReport.fromJson(Map<String, dynamic> json) =>
      CustomerDetailReport(
        linkId: json['linkId'] as String,
        customerId: json['customerId'] as String,
        customerName: json['customerName'] as String,
        balance: (json['balance'] as num).toDouble(),
        totalCredit: (json['totalCredit'] as num).toDouble(),
        totalPaid: (json['totalPaid'] as num).toDouble(),
        pendingCount: json['pendingCount'] as int,
        confirmedCount: json['confirmedCount'] as int,
        disputedCount: json['disputedCount'] as int,
        monthlyBreakdown: (json['monthlyBreakdown'] as List)
            .map((e) => MonthlyPaymentData.fromJson(e as Map<String, dynamic>))
            .toList(),
      );

  @override
  List<Object?> get props => [
        linkId,
        customerId,
        customerName,
        balance,
        totalCredit,
        totalPaid,
        pendingCount,
        confirmedCount,
        disputedCount,
        monthlyBreakdown,
      ];
}

class MonthlyPaymentData extends Equatable {
  final String month; // 'YYYY-MM'
  final double totalPaid;
  final int transactionCount;

  const MonthlyPaymentData({
    required this.month,
    required this.totalPaid,
    required this.transactionCount,
  });

  factory MonthlyPaymentData.fromJson(Map<String, dynamic> json) =>
      MonthlyPaymentData(
        month: json['month'] as String,
        totalPaid: (json['totalPaid'] as num).toDouble(),
        transactionCount: json['transactionCount'] as int,
      );

  @override
  List<Object?> get props => [month, totalPaid, transactionCount];
}

/// GET /reports/monthly
class MonthlyRevenueReport extends Equatable {
  final int year;
  final List<MonthlyRevenueData> months;

  const MonthlyRevenueReport({required this.year, required this.months});

  factory MonthlyRevenueReport.fromJson(Map<String, dynamic> json) =>
      MonthlyRevenueReport(
        year: json['year'] as int,
        months: (json['months'] as List)
            .map((e) => MonthlyRevenueData.fromJson(e as Map<String, dynamic>))
            .toList(),
      );

  @override
  List<Object?> get props => [year, months];
}

class MonthlyRevenueData extends Equatable {
  final String month; // 'YYYY-MM'
  final double totalCollected;
  final int activeCustomers;

  const MonthlyRevenueData({
    required this.month,
    required this.totalCollected,
    required this.activeCustomers,
  });

  factory MonthlyRevenueData.fromJson(Map<String, dynamic> json) =>
      MonthlyRevenueData(
        month: json['month'] as String,
        totalCollected: (json['totalCollected'] as num).toDouble(),
        activeCustomers: json['activeCustomers'] as int,
      );

  @override
  List<Object?> get props => [month, totalCollected, activeCustomers];
}
