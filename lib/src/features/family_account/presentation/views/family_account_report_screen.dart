import 'dart:typed_data';

import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:get/get.dart' hide Trans;
import 'package:google_fonts/google_fonts.dart';
import 'package:intl/intl.dart';
import 'package:pdf/pdf.dart';
import 'package:pdf/widgets.dart' as pw;
import 'package:printing/printing.dart';

import 'package:lazervault/core/services/injection_container.dart';
import 'package:lazervault/core/utils/currency_formatter.dart';
import 'package:lazervault/src/features/family_account/domain/entities/family_account_entities.dart';
import 'package:lazervault/src/features/family_account/presentation/cubit/family_account_cubit.dart';
import 'package:lazervault/src/features/family_account/presentation/cubit/family_account_state.dart';
import 'package:lazervault/core/shared_widgets/lazer_vault_loader.dart';

/// A deterministic Family & Friends account statement: a header, totals, the
/// per-member allocation breakdown, and the recent transaction list — rendered
/// to a shareable PDF. No AI / no extra backend: it reuses the already-wired
/// GetFamilyTransactions data.
class FamilyAccountReportScreen extends StatefulWidget {
  final FamilyAccount account;

  const FamilyAccountReportScreen({super.key, required this.account});

  @override
  State<FamilyAccountReportScreen> createState() => _FamilyAccountReportScreenState();
}

class _FamilyAccountReportScreenState extends State<FamilyAccountReportScreen> {
  final FamilyAccountCubit _cubit = serviceLocator<FamilyAccountCubit>();
  static const Color _purple = Color.fromARGB(255, 78, 3, 208);

  @override
  void initState() {
    super.initState();
    _cubit.loadTransactions(familyId: widget.account.id);
  }

  @override
  void dispose() {
    _cubit.close();
    super.dispose();
  }

  String _money(double v) =>
      '${CurrencySymbols.currentSymbol}${v.toStringAsFixed(2)}';

  /// ASCII-safe currency label for the SHARED PDF. The default PDF font
  /// (Helvetica) has no glyph for '₦', so a naira symbol renders as tofu/□ in
  /// the exported statement. Use the ISO code prefix (e.g. "NGN ") instead —
  /// mirrors group_contribution_pdf_service._currencySymbolFor. On-screen widgets
  /// keep the real symbol (Flutter fonts render it fine).
  static String _pdfCurrencyLabel(String code) {
    switch (code.toUpperCase()) {
      case 'NGN':
        return 'NGN ';
      case 'GBP':
        return 'GBP ';
      case 'EUR':
        return 'EUR ';
      case 'USD':
        return 'USD ';
      case 'ZAR':
        return 'ZAR ';
      case 'GHS':
        return 'GHS ';
      case 'KES':
        return 'KES ';
      default:
        return '$code ';
    }
  }

  Future<void> _share(List<FamilyTransaction> txns) async {
    final bytes = await _buildPdf(txns);
    await Printing.sharePdf(
      bytes: bytes,
      filename: 'family-statement-${widget.account.name.replaceAll(' ', '-')}.pdf',
    );
  }

  Future<Uint8List> _buildPdf(List<FamilyTransaction> txns) async {
    final a = widget.account;
    final doc = pw.Document();
    // ASCII-safe currency label so the naira symbol doesn't render as tofu in the
    // exported PDF (default Helvetica has no '₦' glyph).
    final sym = _pdfCurrencyLabel(CurrencySymbols.currentCurrency);
    final df = DateFormat('d MMM y, HH:mm');
    String m(double v) => '$sym${v.toStringAsFixed(2)}';

    doc.addPage(
      pw.MultiPage(
        pageFormat: PdfPageFormat.a4,
        build: (ctx) => [
          pw.Header(
            level: 0,
            child: pw.Column(crossAxisAlignment: pw.CrossAxisAlignment.start, children: [
              pw.Text('Family & Friends Statement',
                  style: pw.TextStyle(fontSize: 20, fontWeight: pw.FontWeight.bold)),
              pw.SizedBox(height: 2),
              pw.Text(a.name, style: const pw.TextStyle(fontSize: 14)),
              pw.Text('Generated ${df.format(DateTime.now())}',
                  style: const pw.TextStyle(fontSize: 9, color: PdfColors.grey600)),
            ]),
          ),
          pw.SizedBox(height: 12),
          pw.Text('Summary', style: pw.TextStyle(fontSize: 13, fontWeight: pw.FontWeight.bold)),
          pw.SizedBox(height: 6),
          pw.Table(
            border: pw.TableBorder.all(color: PdfColors.grey300),
            children: [
              _row('Total pool balance', m(a.totalPoolBalance)),
              _row('Total allocated', m(a.totalAllocatedBalance)),
              _row('Total balance', m(a.totalBalance)),
              _row('Members', '${a.activeMemberCount}'),
              _row('Distribution mode', a.fundDistributionMode.displayName),
            ],
          ),
          pw.SizedBox(height: 16),
          pw.Text('Members', style: pw.TextStyle(fontSize: 13, fontWeight: pw.FontWeight.bold)),
          pw.SizedBox(height: 6),
          pw.Table(
            border: pw.TableBorder.all(color: PdfColors.grey300),
            columnWidths: {
              0: const pw.FlexColumnWidth(3),
              1: const pw.FlexColumnWidth(2),
              2: const pw.FlexColumnWidth(2),
              3: const pw.FlexColumnWidth(2),
            },
            children: [
              pw.TableRow(
                decoration: const pw.BoxDecoration(color: PdfColors.grey200),
                children: [
                  _cell('Member', bold: true),
                  _cell('Allocated', bold: true),
                  _cell('Spent (month)', bold: true),
                  _cell('Role', bold: true),
                ],
              ),
              ...a.members.map((mem) => pw.TableRow(children: [
                    _cell(mem.fullName.isNotEmpty ? mem.fullName : (mem.username ?? 'Member')),
                    _cell(m(mem.allocatedBalance)),
                    _cell(m(mem.spentThisMonth)),
                    _cell(mem.role == FamilyMemberRole.admin ? 'Admin' : 'Member'),
                  ])),
            ],
          ),
          pw.SizedBox(height: 16),
          pw.Text('Activity', style: pw.TextStyle(fontSize: 13, fontWeight: pw.FontWeight.bold)),
          pw.SizedBox(height: 6),
          if (txns.isEmpty)
            pw.Text('No transactions for this account.', style: const pw.TextStyle(fontSize: 10, color: PdfColors.grey600))
          else
            pw.Table(
              border: pw.TableBorder.all(color: PdfColors.grey300),
              columnWidths: {
                0: const pw.FlexColumnWidth(3),
                1: const pw.FlexColumnWidth(2),
                2: const pw.FlexColumnWidth(2),
                3: const pw.FlexColumnWidth(3),
              },
              children: [
                pw.TableRow(
                  decoration: const pw.BoxDecoration(color: PdfColors.grey200),
                  children: [
                    _cell('Date', bold: true),
                    _cell('Type', bold: true),
                    _cell('Amount', bold: true),
                    _cell('By / detail', bold: true),
                  ],
                ),
                ...txns.map((t) => pw.TableRow(children: [
                      _cell(df.format(t.createdAt)),
                      _cell(t.type.displayName),
                      _cell(m(t.amount.abs())),
                      _cell('${t.memberName.isNotEmpty ? t.memberName : 'Member'}'
                          '${t.description != null && t.description!.isNotEmpty ? ' — ${t.description}' : ''}'),
                    ])),
              ],
            ),
        ],
      ),
    );
    return doc.save();
  }

  pw.TableRow _row(String k, String v) => pw.TableRow(children: [
        _cell(k, bold: true),
        _cell(v),
      ]);

  pw.Widget _cell(String s, {bool bold = false}) => pw.Padding(
        padding: const pw.EdgeInsets.all(5),
        child: pw.Text(s,
            style: pw.TextStyle(fontSize: 9, fontWeight: bold ? pw.FontWeight.bold : pw.FontWeight.normal)),
      );

  @override
  Widget build(BuildContext context) {
    return BlocProvider.value(
      value: _cubit,
      child: Scaffold(
        backgroundColor: const Color(0xFF0A0A0A),
        appBar: AppBar(
          backgroundColor: const Color(0xFF0A0A0A),
          elevation: 0,
          leading: IconButton(
            icon: Icon(Icons.arrow_back, color: Colors.white, size: 22.sp),
            onPressed: () => Get.back(),
          ),
          title: Text('Account Statement',
              style: GoogleFonts.inter(color: Colors.white, fontSize: 18.sp, fontWeight: FontWeight.bold)),
        ),
        body: BlocBuilder<FamilyAccountCubit, FamilyAccountState>(
          bloc: _cubit,
          builder: (context, state) {
            final txns = state is FamilyTransactionsLoaded ? state.transactions : <FamilyTransaction>[];
            final loading = state is FamilyAccountLoading;
            return ListView(
              padding: EdgeInsets.all(20.w),
              children: [
                _summaryCard(),
                SizedBox(height: 16.h),
                Text('Activity (${txns.length})',
                    style: GoogleFonts.inter(color: Colors.white, fontSize: 15.sp, fontWeight: FontWeight.w600)),
                SizedBox(height: 8.h),
                if (loading)
                  Padding(
                    padding: EdgeInsets.symmetric(vertical: 24.h),
                    child: Center(child: LazerVaultLoader.small()),
                  )
                else if (txns.isEmpty)
                  Padding(
                    padding: EdgeInsets.symmetric(vertical: 16.h),
                    child: Text('No transactions yet.',
                        style: GoogleFonts.inter(color: Colors.grey[500], fontSize: 13.sp)),
                  )
                else
                  ...txns.take(50).map(_txnRow),
                SizedBox(height: 24.h),
                SizedBox(
                  width: double.infinity,
                  height: 50.h,
                  child: ElevatedButton.icon(
                    onPressed: loading ? null : () => _share(txns),
                    icon: Icon(Icons.ios_share, size: 18.sp),
                    label: Text('Share statement (PDF)',
                        style: GoogleFonts.inter(fontSize: 14.sp, fontWeight: FontWeight.w600)),
                    style: ElevatedButton.styleFrom(
                      backgroundColor: _purple,
                      foregroundColor: Colors.white,
                      shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(12.r)),
                    ),
                  ),
                ),
                SizedBox(height: 24.h),
              ],
            );
          },
        ),
      ),
    );
  }

  Widget _summaryCard() {
    final a = widget.account;
    return Container(
      padding: EdgeInsets.all(16.w),
      decoration: BoxDecoration(
        color: const Color(0xFF1F1F1F),
        borderRadius: BorderRadius.circular(12.r),
      ),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Text(a.name, style: GoogleFonts.inter(color: Colors.white, fontSize: 16.sp, fontWeight: FontWeight.w700)),
          SizedBox(height: 12.h),
          _kv('Total pool', _money(a.totalPoolBalance)),
          _kv('Total allocated', _money(a.totalAllocatedBalance)),
          _kv('Total balance', _money(a.totalBalance)),
          _kv('Members', '${a.activeMemberCount}'),
          _kv('Distribution', a.fundDistributionMode.displayName),
        ],
      ),
    );
  }

  Widget _kv(String k, String v) => Padding(
        padding: EdgeInsets.symmetric(vertical: 4.h),
        child: Row(
          mainAxisAlignment: MainAxisAlignment.spaceBetween,
          children: [
            Text(k, style: GoogleFonts.inter(color: Colors.grey[500], fontSize: 13.sp)),
            Text(v, style: GoogleFonts.inter(color: Colors.white, fontSize: 13.sp, fontWeight: FontWeight.w600)),
          ],
        ),
      );

  Widget _txnRow(FamilyTransaction t) {
    final isCredit = t.type == FamilyTransactionType.allocation ||
        t.type == FamilyTransactionType.refund ||
        t.type == FamilyTransactionType.contribution;
    final color = isCredit ? const Color(0xFF10B981) : const Color(0xFFEF4444);
    return Container(
      margin: EdgeInsets.only(bottom: 8.h),
      padding: EdgeInsets.all(12.w),
      decoration: BoxDecoration(
        color: const Color(0xFF1F1F1F),
        borderRadius: BorderRadius.circular(10.r),
      ),
      child: Row(
        children: [
          Expanded(
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Text(t.memberName.isNotEmpty ? t.memberName : 'Member',
                    style: GoogleFonts.inter(color: Colors.white, fontSize: 13.sp, fontWeight: FontWeight.w600)),
                SizedBox(height: 2.h),
                Text(t.description ?? t.type.displayName,
                    maxLines: 1, overflow: TextOverflow.ellipsis,
                    style: GoogleFonts.inter(color: Colors.grey[500], fontSize: 11.sp)),
              ],
            ),
          ),
          Text('${isCredit ? '+' : '-'}${_money(t.amount.abs())}',
              style: GoogleFonts.inter(color: color, fontSize: 13.sp, fontWeight: FontWeight.w700)),
        ],
      ),
    );
  }
}
