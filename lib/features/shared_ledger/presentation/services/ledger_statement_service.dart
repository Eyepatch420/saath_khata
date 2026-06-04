import 'package:intl/intl.dart';
import 'package:pdf/pdf.dart';
import 'package:pdf/widgets.dart' as pw;
import 'package:printing/printing.dart';

import '../../../auth/data/models/user_model.dart';
import '../../../../shared/models/ledger_entry.dart';

/// Generates and shares a professional PDF statement for a shared ledger.
class LedgerStatementService {
  // Brand colours matching AppColors
  static const _teal = PdfColor.fromInt(0xFF00C896);
  static const _navy = PdfColor.fromInt(0xFF0F2027);
  static const _errorRed = PdfColor.fromInt(0xFFE53935);
  static const _successGreen = PdfColor.fromInt(0xFF4CAF50);
  static const _warningAmber = PdfColor.fromInt(0xFFFFB300);
  static const _bgLight = PdfColor.fromInt(0xFFF8F9FA);
  static const _textSecondary = PdfColor.fromInt(0xFF757575);
  static const _divider = PdfColor.fromInt(0xFFEEEEEE);

  static final _currencyFmt = NumberFormat('#,##,##0.00', 'en_IN');
  static final _dateFmt = DateFormat('dd MMM yyyy');

  /// Generates the PDF and opens the system share sheet.
  static Future<void> generateAndShare({
    required UserModel currentUser,
    required String counterpartyName,
    required List<LedgerEntry> entries,
    required double balance,
    required bool isVendorView,
  }) async {
    // Load Noto Sans — supports ₹ and all Indian/Unicode characters.
    final regular = await PdfGoogleFonts.notoSansRegular();
    final bold = await PdfGoogleFonts.notoSansBold();
    final italic = await PdfGoogleFonts.notoSansItalic();

    final doc = pw.Document(
      theme: pw.ThemeData.withFont(base: regular, bold: bold, italic: italic),
    );

    // Derive party labels
    final vendorName = isVendorView
        ? (currentUser.businessName?.isNotEmpty == true
              ? currentUser.businessName!
              : currentUser.name)
        : counterpartyName;
    final customerName = isVendorView ? counterpartyName : currentUser.name;

    // Sort entries newest-first for display
    final sorted = [...entries]..sort((a, b) => b.date.compareTo(a.date));

    // Compute summary stats
    double totalCredit = 0;
    double totalPayment = 0;
    int pendingCount = 0;
    int confirmedCount = 0;
    int disputedCount = 0;

    for (final e in entries) {
      if (e.type == EntryType.credit) totalCredit += e.amount;
      if (e.type == EntryType.payment) totalPayment += e.amount;
      switch (e.status) {
        case EntryStatus.pending:
          pendingCount++;
          break;
        case EntryStatus.confirmed:
        case EntryStatus.autoConfirmed:
          confirmedCount++;
          break;
        case EntryStatus.disputed:
          disputedCount++;
          break;
      }
    }

    final generatedOn = DateFormat(
      'dd MMM yyyy, hh:mm a',
    ).format(DateTime.now());
    final statementTitle =
        'Saath Khata Statement — $vendorName & $customerName';

    doc.addPage(
      pw.MultiPage(
        pageFormat: PdfPageFormat.a4,
        margin: const pw.EdgeInsets.all(32),
        header: (ctx) =>
            _buildHeader(ctx, vendorName, customerName, generatedOn),
        footer: (ctx) => _buildFooter(ctx),
        build: (ctx) => [
          pw.SizedBox(height: 8),
          _summarySection(
            balance,
            totalCredit,
            totalPayment,
            pendingCount,
            confirmedCount,
            disputedCount,
            isVendorView,
          ),
          pw.SizedBox(height: 20),
          _transactionTable(sorted),
          pw.SizedBox(height: 16),
          _disclaimer(),
        ],
      ),
    );

    await Printing.sharePdf(
      bytes: await doc.save(),
      filename:
          '${statementTitle.replaceAll(RegExp(r'[^a-zA-Z0-9 _-]'), '_')}.pdf',
    );
  }

  // ── Header ──────────────────────────────────────────────────────────────────

  static pw.Widget _buildHeader(
    pw.Context ctx,
    String vendorName,
    String customerName,
    String generatedOn,
  ) {
    return pw.Column(
      crossAxisAlignment: pw.CrossAxisAlignment.start,
      children: [
        pw.Container(
          padding: const pw.EdgeInsets.symmetric(horizontal: 20, vertical: 14),
          decoration: const pw.BoxDecoration(
            gradient: pw.LinearGradient(
              colors: [_navy, PdfColor.fromInt(0xFF2C5364)],
              begin: pw.Alignment.topLeft,
              end: pw.Alignment.bottomRight,
            ),
            borderRadius: pw.BorderRadius.all(pw.Radius.circular(8)),
          ),
          child: pw.Row(
            mainAxisAlignment: pw.MainAxisAlignment.spaceBetween,
            children: [
              pw.Column(
                crossAxisAlignment: pw.CrossAxisAlignment.start,
                children: [
                  pw.Row(
                    children: [
                      pw.Container(
                        width: 10,
                        height: 10,
                        decoration: const pw.BoxDecoration(
                          color: _teal,
                          shape: pw.BoxShape.circle,
                        ),
                      ),
                      pw.SizedBox(width: 6),
                      pw.Text(
                        'SAATH KHATA',
                        style: pw.TextStyle(
                          fontSize: 18,
                          fontWeight: pw.FontWeight.bold,
                          color: PdfColors.white,
                          letterSpacing: 1.5,
                        ),
                      ),
                    ],
                  ),
                  pw.SizedBox(height: 4),
                  pw.Text(
                    'Shared Ledger Statement',
                    style: const pw.TextStyle(
                      fontSize: 10,
                      color: PdfColor.fromInt(0xFFB0BEC5),
                    ),
                  ),
                ],
              ),
              pw.Column(
                crossAxisAlignment: pw.CrossAxisAlignment.end,
                children: [
                  pw.Text(
                    'Generated on',
                    style: const pw.TextStyle(
                      fontSize: 8,
                      color: PdfColor.fromInt(0xFFB0BEC5),
                    ),
                  ),
                  pw.Text(
                    generatedOn,
                    style: const pw.TextStyle(
                      fontSize: 9,
                      color: PdfColors.white,
                    ),
                  ),
                ],
              ),
            ],
          ),
        ),
        pw.SizedBox(height: 12),
        // Party info strip
        pw.Container(
          padding: const pw.EdgeInsets.symmetric(horizontal: 16, vertical: 10),
          decoration: pw.BoxDecoration(
            color: _bgLight,
            borderRadius: const pw.BorderRadius.all(pw.Radius.circular(6)),
            border: pw.Border.all(color: _divider),
          ),
          child: pw.Row(
            children: [
              _partyBox('VENDOR', vendorName),
              pw.SizedBox(width: 8),
              pw.Expanded(
                child: pw.Center(
                  child: pw.Column(
                    mainAxisAlignment: pw.MainAxisAlignment.center,
                    children: [
                      pw.Container(
                        width: 28,
                        height: 28,
                        decoration: pw.BoxDecoration(
                          color: _teal.shade(0.15),
                          shape: pw.BoxShape.circle,
                        ),
                        child: pw.Center(
                          child: pw.Text(
                            '<>',
                            style: pw.TextStyle(
                              fontSize: 10,
                              color: _teal,
                              fontWeight: pw.FontWeight.bold,
                            ),
                          ),
                        ),
                      ),
                    ],
                  ),
                ),
              ),
              pw.SizedBox(width: 8),
              _partyBox('CUSTOMER', customerName),
            ],
          ),
        ),
        pw.SizedBox(height: 4),
        pw.Divider(color: _divider, thickness: 0.5),
      ],
    );
  }

  static pw.Widget _partyBox(String role, String name) {
    return pw.Expanded(
      child: pw.Column(
        crossAxisAlignment: pw.CrossAxisAlignment.start,
        children: [
          pw.Text(
            role,
            style: pw.TextStyle(
              fontSize: 8,
              fontWeight: pw.FontWeight.bold,
              color: _teal,
              letterSpacing: 1,
            ),
          ),
          pw.SizedBox(height: 2),
          pw.Text(
            name,
            style: pw.TextStyle(
              fontSize: 11,
              fontWeight: pw.FontWeight.bold,
              color: _navy,
            ),
          ),
        ],
      ),
    );
  }

  // ── Footer ──────────────────────────────────────────────────────────────────

  static pw.Widget _buildFooter(pw.Context ctx) {
    return pw.Column(
      children: [
        pw.Divider(color: _divider, thickness: 0.5),
        pw.SizedBox(height: 4),
        pw.Row(
          mainAxisAlignment: pw.MainAxisAlignment.spaceBetween,
          children: [
            pw.Text(
              'Saath Khata — Shared Ledger',
              style: const pw.TextStyle(fontSize: 8, color: _textSecondary),
            ),
            pw.Text(
              'Page ${ctx.pageNumber} of ${ctx.pagesCount}',
              style: const pw.TextStyle(fontSize: 8, color: _textSecondary),
            ),
          ],
        ),
      ],
    );
  }

  // ── Summary Section ──────────────────────────────────────────────────────────

  static pw.Widget _summarySection(
    double balance,
    double totalCredit,
    double totalPayment,
    int pendingCount,
    int confirmedCount,
    int disputedCount,
    bool isVendorView,
  ) {
    final balanceLabel = balance > 0
        ? 'Customer Owes'
        : balance < 0
        ? 'You Owe'
        : 'Settled';
    final balanceColor = balance > 0
        ? _errorRed
        : balance < 0
        ? _successGreen
        : _teal;

    return pw.Column(
      crossAxisAlignment: pw.CrossAxisAlignment.start,
      children: [
        _sectionTitle('Account Summary'),
        pw.SizedBox(height: 10),
        pw.Row(
          crossAxisAlignment: pw.CrossAxisAlignment.start,
          children: [
            // Balance box
            pw.Expanded(
              flex: 2,
              child: pw.Container(
                padding: const pw.EdgeInsets.all(16),
                decoration: pw.BoxDecoration(
                  color: balanceColor.shade(0.08),
                  borderRadius: const pw.BorderRadius.all(
                    pw.Radius.circular(8),
                  ),
                  border: pw.Border.all(color: balanceColor.shade(0.3)),
                ),
                child: pw.Column(
                  crossAxisAlignment: pw.CrossAxisAlignment.start,
                  children: [
                    pw.Text(
                      'Current Balance',
                      style: const pw.TextStyle(
                        fontSize: 9,
                        color: _textSecondary,
                      ),
                    ),
                    pw.SizedBox(height: 4),
                    pw.Text(
                      '₹${_currencyFmt.format(balance.abs())}',
                      style: pw.TextStyle(
                        fontSize: 22,
                        fontWeight: pw.FontWeight.bold,
                        color: balanceColor,
                      ),
                    ),
                    pw.SizedBox(height: 4),
                    pw.Container(
                      padding: const pw.EdgeInsets.symmetric(
                        horizontal: 8,
                        vertical: 3,
                      ),
                      decoration: pw.BoxDecoration(
                        color: balanceColor.shade(0.15),
                        borderRadius: const pw.BorderRadius.all(
                          pw.Radius.circular(4),
                        ),
                      ),
                      child: pw.Text(
                        balanceLabel,
                        style: pw.TextStyle(
                          fontSize: 9,
                          fontWeight: pw.FontWeight.bold,
                          color: balanceColor,
                        ),
                      ),
                    ),
                  ],
                ),
              ),
            ),
            pw.SizedBox(width: 10),
            // Credit / Payment split
            pw.Expanded(
              flex: 3,
              child: pw.Column(
                children: [
                  _statRow('Total Credit Given', totalCredit, _errorRed),
                  pw.SizedBox(height: 8),
                  _statRow('Total Payments Made', totalPayment, _successGreen),
                ],
              ),
            ),
          ],
        ),
        pw.SizedBox(height: 10),
        // Status breakdown row
        pw.Row(
          children: [
            _statusBadge('Confirmed', confirmedCount, _successGreen),
            pw.SizedBox(width: 8),
            _statusBadge('Pending', pendingCount, _warningAmber),
            pw.SizedBox(width: 8),
            _statusBadge('Disputed', disputedCount, _errorRed),
          ],
        ),
      ],
    );
  }

  static pw.Widget _statRow(String label, double amount, PdfColor color) {
    return pw.Container(
      padding: const pw.EdgeInsets.all(12),
      decoration: pw.BoxDecoration(
        color: color.shade(0.06),
        borderRadius: const pw.BorderRadius.all(pw.Radius.circular(6)),
        border: pw.Border.all(color: color.shade(0.2)),
      ),
      child: pw.Row(
        mainAxisAlignment: pw.MainAxisAlignment.spaceBetween,
        children: [
          pw.Text(
            label,
            style: const pw.TextStyle(fontSize: 9, color: _textSecondary),
          ),
          pw.Text(
            '₹${_currencyFmt.format(amount)}',
            style: pw.TextStyle(
              fontSize: 11,
              fontWeight: pw.FontWeight.bold,
              color: color,
            ),
          ),
        ],
      ),
    );
  }

  static pw.Widget _statusBadge(String label, int count, PdfColor color) {
    return pw.Expanded(
      child: pw.Container(
        padding: const pw.EdgeInsets.symmetric(vertical: 8),
        decoration: pw.BoxDecoration(
          color: color.shade(0.08),
          borderRadius: const pw.BorderRadius.all(pw.Radius.circular(6)),
        ),
        child: pw.Column(
          children: [
            pw.Text(
              '$count',
              style: pw.TextStyle(
                fontSize: 16,
                fontWeight: pw.FontWeight.bold,
                color: color,
              ),
            ),
            pw.Text(label, style: pw.TextStyle(fontSize: 8, color: color)),
          ],
        ),
      ),
    );
  }

  // ── Transaction Table ────────────────────────────────────────────────────────

  static pw.Widget _transactionTable(List<LedgerEntry> entries) {
    final headerDecor = pw.BoxDecoration(
      gradient: const pw.LinearGradient(
        colors: [_navy, PdfColor.fromInt(0xFF1C3A48)],
      ),
    );

    pw.Widget cell(
      String text, {
      pw.TextStyle? style,
      pw.Alignment alignment = pw.Alignment.centerLeft,
    }) {
      return pw.Padding(
        padding: const pw.EdgeInsets.symmetric(horizontal: 8, vertical: 6),
        child: pw.Align(
          alignment: alignment,
          child: pw.Text(text, style: style),
        ),
      );
    }

    final rows = <pw.TableRow>[
      // Header row
      pw.TableRow(
        decoration: headerDecor,
        children: [
          cell(
            'Date',
            style: pw.TextStyle(
              fontSize: 9,
              fontWeight: pw.FontWeight.bold,
              color: PdfColors.white,
            ),
          ),
          cell(
            'Description',
            style: pw.TextStyle(
              fontSize: 9,
              fontWeight: pw.FontWeight.bold,
              color: PdfColors.white,
            ),
          ),
          cell(
            'Type',
            style: pw.TextStyle(
              fontSize: 9,
              fontWeight: pw.FontWeight.bold,
              color: PdfColors.white,
            ),
          ),
          cell(
            'Amount',
            style: pw.TextStyle(
              fontSize: 9,
              fontWeight: pw.FontWeight.bold,
              color: PdfColors.white,
            ),
            alignment: pw.Alignment.centerRight,
          ),
          cell(
            'Status',
            style: pw.TextStyle(
              fontSize: 9,
              fontWeight: pw.FontWeight.bold,
              color: PdfColors.white,
            ),
            alignment: pw.Alignment.center,
          ),
        ],
      ),
    ];

    for (var i = 0; i < entries.length; i++) {
      final e = entries[i];
      final isCredit = e.type == EntryType.credit;
      final amountColor = isCredit ? _errorRed : _successGreen;
      final rowBg = i.isEven ? PdfColors.white : _bgLight;

      final statusLabel = _statusLabel(e.status);
      final statusColor = _statusColor(e.status);

      rows.add(
        pw.TableRow(
          decoration: pw.BoxDecoration(color: rowBg),
          children: [
            cell(
              _dateFmt.format(e.date),
              style: const pw.TextStyle(fontSize: 8, color: _textSecondary),
            ),
            cell(
              e.description?.isNotEmpty == true
                  ? e.description!
                  : (isCredit ? 'Credit Given' : 'Payment Received'),
              style: pw.TextStyle(
                fontSize: 8.5,
                color: _navy,
                fontWeight: pw.FontWeight.bold,
              ),
            ),
            cell(
              isCredit ? 'Credit' : 'Payment',
              style: pw.TextStyle(fontSize: 8, color: amountColor),
            ),
            cell(
              '${isCredit ? '+' : '-'}₹${_currencyFmt.format(e.amount)}',
              style: pw.TextStyle(
                fontSize: 9,
                fontWeight: pw.FontWeight.bold,
                color: amountColor,
              ),
              alignment: pw.Alignment.centerRight,
            ),
            pw.Padding(
              padding: const pw.EdgeInsets.symmetric(
                horizontal: 6,
                vertical: 5,
              ),
              child: pw.Align(
                alignment: pw.Alignment.center,
                child: pw.Container(
                  padding: const pw.EdgeInsets.symmetric(
                    horizontal: 6,
                    vertical: 2,
                  ),
                  decoration: pw.BoxDecoration(
                    color: statusColor.shade(0.12),
                    borderRadius: const pw.BorderRadius.all(
                      pw.Radius.circular(4),
                    ),
                  ),
                  child: pw.Text(
                    statusLabel,
                    style: pw.TextStyle(
                      fontSize: 7,
                      fontWeight: pw.FontWeight.bold,
                      color: statusColor,
                    ),
                  ),
                ),
              ),
            ),
          ],
        ),
      );
    }

    return pw.Column(
      crossAxisAlignment: pw.CrossAxisAlignment.start,
      children: [
        _sectionTitle('Transaction History (${entries.length} entries)'),
        pw.SizedBox(height: 10),
        pw.Table(
          border: pw.TableBorder.all(color: _divider, width: 0.5),
          columnWidths: {
            0: const pw.FixedColumnWidth(68), // Date
            1: const pw.FlexColumnWidth(2.5), // Description
            2: const pw.FixedColumnWidth(52), // Type
            3: const pw.FixedColumnWidth(72), // Amount
            4: const pw.FixedColumnWidth(60), // Status
          },
          children: rows,
        ),
      ],
    );
  }

  // ── Disclaimer ───────────────────────────────────────────────────────────────

  static pw.Widget _disclaimer() {
    return pw.Container(
      padding: const pw.EdgeInsets.all(12),
      decoration: pw.BoxDecoration(
        color: _bgLight,
        borderRadius: const pw.BorderRadius.all(pw.Radius.circular(6)),
        border: pw.Border.all(color: _divider),
      ),
      child: pw.Row(
        crossAxisAlignment: pw.CrossAxisAlignment.start,
        children: [
          pw.Container(
            width: 14,
            height: 14,
            decoration: pw.BoxDecoration(
              shape: pw.BoxShape.circle,
              border: pw.Border.all(color: _textSecondary, width: 0.8),
            ),
            child: pw.Center(
              child: pw.Text(
                'i',
                style: pw.TextStyle(
                  fontSize: 8,
                  color: _textSecondary,
                  fontWeight: pw.FontWeight.bold,
                ),
              ),
            ),
          ),
          pw.SizedBox(width: 8),
          pw.Expanded(
            child: pw.Text(
              'This statement is generated from Saath Khata and reflects entries '
              'recorded by both parties. Confirmed entries are locked and cannot be modified. '
              'Only confirmed and auto-confirmed entries are considered final. '
              'This document is for reference only.',
              style: const pw.TextStyle(fontSize: 7.5, color: _textSecondary),
            ),
          ),
        ],
      ),
    );
  }

  // ── Helpers ──────────────────────────────────────────────────────────────────

  static pw.Widget _sectionTitle(String title) {
    return pw.Row(
      children: [
        pw.Container(
          width: 3,
          height: 14,
          decoration: const pw.BoxDecoration(
            color: _teal,
            borderRadius: pw.BorderRadius.all(pw.Radius.circular(2)),
          ),
        ),
        pw.SizedBox(width: 8),
        pw.Text(
          title,
          style: pw.TextStyle(
            fontSize: 12,
            fontWeight: pw.FontWeight.bold,
            color: _navy,
          ),
        ),
      ],
    );
  }

  static String _statusLabel(EntryStatus status) {
    switch (status) {
      case EntryStatus.confirmed:
        return 'Confirmed';
      case EntryStatus.autoConfirmed:
        return 'Auto-Confirmed';
      case EntryStatus.pending:
        return 'Pending';
      case EntryStatus.disputed:
        return 'Disputed';
    }
  }

  static PdfColor _statusColor(EntryStatus status) {
    switch (status) {
      case EntryStatus.confirmed:
      case EntryStatus.autoConfirmed:
        return _successGreen;
      case EntryStatus.pending:
        return _warningAmber;
      case EntryStatus.disputed:
        return _errorRed;
    }
  }
}
