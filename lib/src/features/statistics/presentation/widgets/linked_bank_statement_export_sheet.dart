import 'dart:io';
import 'dart:ui' show Rect;

import 'package:csv/csv.dart';
import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:intl/intl.dart';
import 'package:path_provider/path_provider.dart';
import 'package:pdf/pdf.dart';
import 'package:pdf/widgets.dart' as pw;
import 'package:share_plus/share_plus.dart';

import 'package:lazervault/core/services/injection_container.dart';
import 'package:lazervault/core/shared_widgets/lazer_vault_loader.dart';
import 'package:lazervault/src/features/open_banking/cubit/open_banking_cubit.dart';
import 'package:lazervault/src/features/open_banking/domain/entities/linked_bank_account.dart';

/// Export a linked bank's synced transaction history (the local statement
/// store banking-service accumulates on every balance refresh) as CSV or PDF.
///
/// Opened from the AI-analytics / financial-insights linked-banks card. Pages
/// through GetAccountWithTransactions (offset cursor) until the chosen date
/// range is covered, then generates the file locally and opens the system
/// share sheet. All failure modes surface as calm snackbars — no raw errors.
class LinkedBankStatementExportSheet extends StatefulWidget {
  final LinkedBankAccount account;
  const LinkedBankStatementExportSheet({super.key, required this.account});

  static Future<void> show(BuildContext context,
      {required LinkedBankAccount account}) {
    return showModalBottomSheet(
      context: context,
      isScrollControlled: true,
      backgroundColor: Colors.transparent,
      builder: (_) => LinkedBankStatementExportSheet(account: account),
    );
  }

  @override
  State<LinkedBankStatementExportSheet> createState() =>
      _LinkedBankStatementExportSheetState();
}

class _LinkedBankStatementExportSheetState
    extends State<LinkedBankStatementExportSheet> {
  int _rangeDays = 90; // 30 | 90 | 365 | 0 = everything synced
  bool _asPdf = false;
  bool _exporting = false;

  static const _card = Color(0xFF1F1F1F);
  static const _accent = Color(0xFF581CD9);
  static const _sub = Color(0xFF8E8E93);

  Future<void> _export() async {
    setState(() => _exporting = true);
    try {
      final since = _rangeDays > 0
          ? DateTime.now().subtract(Duration(days: _rangeDays))
          : null;

      // Page through the statement store. The backend caps a page at 100;
      // stop when a page comes back short, when we have everything, or when
      // rows fall behind the requested window (rows arrive newest-first).
      final ds = serviceLocator<OpenBankingCubit>().grpcDataSource;
      if (ds == null) {
        throw Exception('statement source unavailable');
      }
      final rows = <dynamic>[];
      var offset = 0;
      const page = 100;
      var total = -1;
      for (var i = 0; i < 50; i++) {
        final res = await ds.getAccountWithTransactions(
            accountId: widget.account.id, limit: page, offset: offset);
        total = res.totalTransactions;
        if (res.transactions.isEmpty) break;
        var pastWindow = false;
        for (final t in res.transactions) {
          final d = t.transactionDate ?? t.createdAt;
          if (since != null && d != null && d.isBefore(since)) {
            pastWindow = true;
            continue;
          }
          rows.add(t);
        }
        offset += res.transactions.length;
        // Stop on: window covered, server exhausted (authoritative total), or
        // an empty page. Deliberately NOT on "short page" — the server may
        // clamp the page size below what we requested, and treating a clamped
        // page as the end would silently truncate the export.
        if (pastWindow) break;
        if (total >= 0 && offset >= total) break;
      }

      if (rows.isEmpty) {
        _snack(
            'No transactions in this period yet — refresh the bank balance to sync its latest statement.',
            error: false);
        return;
      }

      final file = _asPdf ? await _writePdf(rows) : await _writeCsv(rows);
      await SharePlus.instance.share(ShareParams(
        files: [XFile(file.path)],
        text:
            '${widget.account.bankName} statement · Lazervault AI analytics',
        // iOS: non-zero popover anchor required (CGRectZero throws).
        sharePositionOrigin: const Rect.fromLTWH(0, 0, 1, 1),
      ));
      if (mounted) Navigator.pop(context);
    } catch (_) {
      _snack("Couldn't export the statement. Please try again.", error: true);
    } finally {
      if (mounted) setState(() => _exporting = false);
    }
  }

  void _snack(String msg, {required bool error}) {
    if (!mounted) return;
    ScaffoldMessenger.of(context).showSnackBar(SnackBar(
      content: Text(msg, style: TextStyle(fontSize: 13.sp)),
      backgroundColor:
          error ? const Color(0xFFEF4444) : const Color(0xFF10B981),
      behavior: SnackBarBehavior.floating,
    ));
  }

  String _fmtAmount(dynamic t) {
    final naira = (t.amount as int) / 100.0;
    final sign =
        (t.transactionType as String).toLowerCase() == 'debit' ? '-' : '+';
    return '$sign${naira.toStringAsFixed(2)}';
  }

  Future<File> _writeCsv(List<dynamic> rows) async {
    final data = <List<String>>[
      ['Date', 'Type', 'Description', 'Category', 'Amount', 'Currency'],
    ];
    for (final t in rows) {
      final d = t.transactionDate ?? t.createdAt;
      data.add([
        d != null ? DateFormat('yyyy-MM-dd HH:mm').format(d) : '',
        (t.transactionType as String),
        (t.description as String),
        (t.category as String?) ?? '',
        _fmtAmount(t),
        (t.currency as String),
      ]);
    }
    final csv = const ListToCsvConverter().convert(data);
    final dir = await getTemporaryDirectory();
    final safeBank = widget.account.bankName
        .replaceAll(RegExp(r'[^A-Za-z0-9]'), '_');
    final file = File(
        '${dir.path}/${safeBank}_statement_${DateFormat('yyyyMMdd').format(DateTime.now())}.csv');
    await file.writeAsString(csv);
    return file;
  }

  Future<File> _writePdf(List<dynamic> rows) async {
    final pdf = pw.Document();
    const perPage = 28;
    final pages = (rows.length / perPage).ceil();
    final bank = widget.account.bankName;
    for (var p = 0; p < pages; p++) {
      final items = rows.skip(p * perPage).take(perPage).toList();
      pdf.addPage(pw.Page(
        pageFormat: PdfPageFormat.a4,
        margin: const pw.EdgeInsets.all(24),
        build: (_) => pw.Column(
          crossAxisAlignment: pw.CrossAxisAlignment.start,
          children: [
            if (p == 0) ...[
              pw.Text('Lazervault',
                  style: pw.TextStyle(
                      fontSize: 18, fontWeight: pw.FontWeight.bold)),
              pw.SizedBox(height: 2),
              pw.Text('$bank — bank statement',
                  style: const pw.TextStyle(fontSize: 12)),
              pw.SizedBox(height: 2),
              pw.Text(
                  '${rows.length} transaction${rows.length == 1 ? '' : 's'} · synced via secure open banking',
                  style: pw.TextStyle(
                      fontSize: 9, color: PdfColors.grey600)),
              pw.SizedBox(height: 10),
            ],
            pw.TableHelper.fromTextArray(
              headerStyle: pw.TextStyle(
                  fontSize: 8, fontWeight: pw.FontWeight.bold),
              cellStyle: const pw.TextStyle(fontSize: 7.5),
              headerDecoration:
                  const pw.BoxDecoration(color: PdfColors.grey200),
              cellHeight: 18,
              columnWidths: {
                0: const pw.FlexColumnWidth(1.8),
                1: const pw.FlexColumnWidth(1),
                2: const pw.FlexColumnWidth(3.4),
                3: const pw.FlexColumnWidth(1.3),
                4: const pw.FlexColumnWidth(1.1),
              },
              headers: ['Date', 'Type', 'Description', 'Amount', 'Currency'],
              data: items.map((t) {
                final d = t.transactionDate ?? t.createdAt;
                return [
                  d != null ? DateFormat('dd/MM/yy HH:mm').format(d) : '',
                  (t.transactionType as String),
                  (t.description as String),
                  _fmtAmount(t),
                  (t.currency as String),
                ];
              }).toList(),
            ),
            pw.Spacer(),
            pw.Text(
                'Generated ${DateFormat('d MMM yyyy, h:mm a').format(DateTime.now())} · page ${p + 1}/$pages',
                style:
                    pw.TextStyle(fontSize: 7, color: PdfColors.grey500)),
          ],
        ),
      ));
    }
    final dir = await getTemporaryDirectory();
    final safeBank =
        bank.replaceAll(RegExp(r'[^A-Za-z0-9]'), '_');
    final file = File(
        '${dir.path}/${safeBank}_statement_${DateFormat('yyyyMMdd').format(DateTime.now())}.pdf');
    await file.writeAsBytes(await pdf.save());
    return file;
  }

  Widget _rangeChip(String label, int days) {
    final sel = _rangeDays == days;
    return GestureDetector(
      onTap: () => setState(() => _rangeDays = days),
      child: Container(
        padding: EdgeInsets.symmetric(horizontal: 14.w, vertical: 8.h),
        decoration: BoxDecoration(
          color: sel ? _accent.withValues(alpha: 0.18) : _card,
          borderRadius: BorderRadius.circular(16.r),
          border: Border.all(color: sel ? _accent : Colors.transparent),
        ),
        child: Text(label,
            style: GoogleFonts.inter(
                fontSize: 12.sp,
                fontWeight: FontWeight.w500,
                color: sel ? Colors.white : _sub)),
      ),
    );
  }

  Widget _formatOption(String label, IconData icon, bool pdf) {
    final sel = _asPdf == pdf;
    return Expanded(
      child: GestureDetector(
        onTap: () => setState(() => _asPdf = pdf),
        child: Container(
          padding: EdgeInsets.symmetric(vertical: 13.h),
          decoration: BoxDecoration(
            color: sel ? _accent.withValues(alpha: 0.15) : _card,
            borderRadius: BorderRadius.circular(12.r),
            border: Border.all(
                color: sel ? _accent : Colors.transparent, width: 1.5),
          ),
          child: Column(children: [
            Icon(icon, color: sel ? _accent : _sub, size: 22.sp),
            SizedBox(height: 5.h),
            Text(label,
                style: GoogleFonts.inter(
                    fontSize: 12.5.sp,
                    fontWeight: FontWeight.w500,
                    color: sel ? Colors.white : _sub)),
          ]),
        ),
      ),
    );
  }

  @override
  Widget build(BuildContext context) {
    return Container(
      decoration: BoxDecoration(
        color: const Color(0xFF141414),
        borderRadius: BorderRadius.vertical(top: Radius.circular(20.r)),
      ),
      padding: EdgeInsets.fromLTRB(
          20.w, 12.h, 20.w, MediaQuery.of(context).viewInsets.bottom + 20.h),
      child: Column(
        mainAxisSize: MainAxisSize.min,
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Center(
            child: Container(
              width: 36.w,
              height: 4.h,
              decoration: BoxDecoration(
                  color: Colors.white.withValues(alpha: 0.2),
                  borderRadius: BorderRadius.circular(2.r)),
            ),
          ),
          SizedBox(height: 18.h),
          Text('Export bank statement',
              style: GoogleFonts.inter(
                  fontSize: 18.sp,
                  fontWeight: FontWeight.w600,
                  color: Colors.white)),
          SizedBox(height: 4.h),
          Text(
              '${widget.account.bankName} · transactions synced via open banking',
              style: GoogleFonts.inter(fontSize: 13.sp, color: _sub)),
          SizedBox(height: 18.h),
          Text('Period',
              style: GoogleFonts.inter(
                  fontSize: 13.sp,
                  fontWeight: FontWeight.w500,
                  color: _sub)),
          SizedBox(height: 10.h),
          Wrap(spacing: 8.w, runSpacing: 8.h, children: [
            _rangeChip('Last 30 days', 30),
            _rangeChip('Last 90 days', 90),
            _rangeChip('Last 12 months', 365),
            _rangeChip('Everything synced', 0),
          ]),
          SizedBox(height: 18.h),
          Text('Format',
              style: GoogleFonts.inter(
                  fontSize: 13.sp,
                  fontWeight: FontWeight.w500,
                  color: _sub)),
          SizedBox(height: 10.h),
          Row(children: [
            _formatOption('CSV', Icons.table_chart_outlined, false),
            SizedBox(width: 12.w),
            _formatOption('PDF', Icons.picture_as_pdf_outlined, true),
          ]),
          SizedBox(height: 20.h),
          SizedBox(
            width: double.infinity,
            height: 50.h,
            child: ElevatedButton(
              onPressed: _exporting ? null : _export,
              style: ElevatedButton.styleFrom(
                backgroundColor: _accent,
                disabledBackgroundColor: _accent.withValues(alpha: 0.5),
                shape: RoundedRectangleBorder(
                    borderRadius: BorderRadius.circular(14.r)),
              ),
              child: _exporting
                  ? LazerVaultLoader(size: 22)
                  : Text('Export & share',
                      style: GoogleFonts.inter(
                          fontSize: 15.sp,
                          fontWeight: FontWeight.w600,
                          color: Colors.white)),
            ),
          ),
        ],
      ),
    );
  }
}
