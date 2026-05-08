import 'dart:io';
import 'dart:ui' as ui;

import 'package:intl/intl.dart';
import 'package:path_provider/path_provider.dart';
import 'package:pdf/pdf.dart';
import 'package:pdf/widgets.dart' as pw;

// AutoSaveTransactionEntity lives in the same file as the rule entity.
import '../domain/entities/autosave_rule_entity.dart';

/// Generates PDF reports for autosave rules. Mirrors the layout of
/// `GroupAccountPdfService` (header / summary / details / footer) so
/// the two reports look like they came from the same product.
///
/// Used by the rule-details screen's 3-dot "Export Details" action.
/// The caller hands in everything we surface — we deliberately don't
/// re-fetch from inside the service so the PDF reflects the snapshot
/// the user is looking at.
class AutoSavePdfService {
  static const _primaryColor = PdfColor.fromInt(0xFF4E03D0);
  static const _successColor = PdfColor.fromInt(0xFF10B981);
  static const _warningColor = PdfColor.fromInt(0xFFFB923C);
  static const _mutedColor = PdfColor.fromInt(0xFF6B7280);

  /// Generate the per-rule export PDF. Captures every field the
  /// detail screen renders, plus the recent-transactions feed when
  /// supplied.
  static Future<File> generateRuleDetails({
    required AutoSaveRuleEntity rule,
    required String sourceAccountLabel,
    required String destinationAccountLabel,
    required String triggerDescription,
    required String amountDescription,
    List<AutoSaveTransactionEntity> recentTransactions = const [],
  }) async {
    final pdf = pw.Document();
    // Resolve the active device locale so date / number / currency
    // formatters use the user's grouping (1,234 vs 1.234) + decimal
    // separator. Wrap in try/catch — Dart's Intl throws when the
    // locale's symbol data hasn't been loaded for this app build,
    // and we'd rather render in the fallback locale than fail the
    // whole export over a missing date dictionary.
    final rawLocale =
        ui.PlatformDispatcher.instance.locale.toLanguageTag();
    DateFormat dateFormat;
    DateFormat dateTimeFormat;
    NumberFormat currencyFormat;
    try {
      dateFormat = DateFormat('MMMM d, yyyy', rawLocale);
      dateTimeFormat = DateFormat('MMM d, yyyy - HH:mm', rawLocale);
      currencyFormat = NumberFormat.currency(
        locale: rawLocale,
        symbol: '${rule.currency} ',
        decimalDigits: 2,
      );
    } catch (_) {
      dateFormat = DateFormat('MMMM d, yyyy');
      dateTimeFormat = DateFormat('MMM d, yyyy - HH:mm');
      currencyFormat = NumberFormat.currency(
        symbol: '${rule.currency} ',
        decimalDigits: 2,
      );
    }

    pdf.addPage(
      pw.MultiPage(
        pageFormat: PdfPageFormat.a4,
        margin: const pw.EdgeInsets.all(36),
        build: (context) => [
          _header(rule: rule, dateFormat: dateFormat),
          pw.SizedBox(height: 18),
          _summaryRow(
            rule: rule,
            currencyFormat: currencyFormat,
          ),
          pw.SizedBox(height: 18),
          _section(
            title: 'Trigger configuration',
            rows: [
              _row('Trigger', triggerDescription),
              _row('Amount', amountDescription),
              // Hyphen instead of em-dash for empty-value rows so the
              // default Helvetica font renders cleanly (em-dash is
              // outside its glyph set and would show as a tofu box).
              _row('Frequency',
                  rule.frequency?.name.toUpperCase() ?? '-'),
              _row('Schedule day',
                  rule.scheduleDay?.toString() ?? '-'),
              _row('Schedule time', rule.scheduleTime ?? '-'),
              if (rule.roundUpTo != null)
                _row('Round up to',
                    currencyFormat.format(rule.roundUpTo)),
            ],
          ),
          pw.SizedBox(height: 14),
          _section(
            title: 'Accounts',
            rows: [
              _row('Source', sourceAccountLabel),
              _row('Destination', destinationAccountLabel),
            ],
          ),
          pw.SizedBox(height: 14),
          _section(
            title: 'Limits & targets',
            rows: [
              if (rule.targetAmount != null)
                _row('Target amount',
                    currencyFormat.format(rule.targetAmount)),
              if (rule.minimumBalance != null)
                _row('Minimum balance',
                    currencyFormat.format(rule.minimumBalance)),
              if (rule.maximumPerSave != null)
                _row('Maximum per save',
                    currencyFormat.format(rule.maximumPerSave)),
              if (rule.targetAmount == null &&
                  rule.minimumBalance == null &&
                  rule.maximumPerSave == null)
                _row('Limits', 'No limits configured'),
            ],
          ),
          pw.SizedBox(height: 14),
          _section(
            title: 'Lifetime activity',
            rows: [
              _row('Total saved',
                  currencyFormat.format(rule.totalSaved)),
              _row('Times triggered', rule.triggerCount.toString()),
              _row(
                  'Last triggered',
                  rule.lastTriggeredAt != null
                      ? dateTimeFormat.format(rule.lastTriggeredAt!)
                      : 'Never'),
              _row('Created on', dateFormat.format(rule.createdAt)),
              _row('Last updated',
                  dateTimeFormat.format(rule.updatedAt)),
            ],
          ),
          if (rule.description.isNotEmpty) ...[
            pw.SizedBox(height: 14),
            _section(
              title: 'Description',
              rows: [_row('Notes', rule.description)],
            ),
          ],
          if (recentTransactions.isNotEmpty) ...[
            pw.SizedBox(height: 18),
            pw.Text(
              'Recent transactions',
              style: pw.TextStyle(
                fontSize: 14,
                fontWeight: pw.FontWeight.bold,
              ),
            ),
            pw.SizedBox(height: 8),
            _transactionsTable(
                recentTransactions, currencyFormat, dateTimeFormat),
          ],
        ],
        footer: (context) => _footer(context),
      ),
    );

    return _savePdf(pdf, 'autosave_rule_${rule.id}');
  }

  // ============= layout helpers =============

  static pw.Widget _header({
    required AutoSaveRuleEntity rule,
    required DateFormat dateFormat,
  }) {
    final statusColor = rule.isActive
        ? _successColor
        : rule.isPaused
            ? _warningColor
            : _mutedColor;
    final statusLabel = rule.status.toString().split('.').last.toUpperCase();
    return pw.Container(
      padding: const pw.EdgeInsets.all(16),
      decoration: pw.BoxDecoration(
        color: _primaryColor,
        borderRadius: pw.BorderRadius.circular(10),
      ),
      child: pw.Column(
        crossAxisAlignment: pw.CrossAxisAlignment.start,
        children: [
          pw.Row(
            mainAxisAlignment: pw.MainAxisAlignment.spaceBetween,
            children: [
              pw.Text(
                'Autosave rule report',
                style: pw.TextStyle(
                  color: PdfColors.white,
                  fontSize: 11,
                  letterSpacing: 1.2,
                ),
              ),
              pw.Text(
                'Generated ${dateFormat.format(DateTime.now())}',
                style: const pw.TextStyle(
                  color: PdfColors.white,
                  fontSize: 9,
                ),
              ),
            ],
          ),
          pw.SizedBox(height: 10),
          pw.Text(
            rule.name,
            style: pw.TextStyle(
              color: PdfColors.white,
              fontSize: 22,
              fontWeight: pw.FontWeight.bold,
            ),
          ),
          pw.SizedBox(height: 6),
          pw.Container(
            padding:
                const pw.EdgeInsets.symmetric(horizontal: 10, vertical: 4),
            decoration: pw.BoxDecoration(
              color: statusColor,
              borderRadius: pw.BorderRadius.circular(20),
            ),
            child: pw.Text(
              statusLabel,
              style: pw.TextStyle(
                color: PdfColors.white,
                fontSize: 9,
                fontWeight: pw.FontWeight.bold,
              ),
            ),
          ),
        ],
      ),
    );
  }

  static pw.Widget _summaryRow({
    required AutoSaveRuleEntity rule,
    required NumberFormat currencyFormat,
  }) {
    return pw.Row(
      children: [
        _stat('Total saved', currencyFormat.format(rule.totalSaved)),
        pw.SizedBox(width: 10),
        _stat('Triggers', rule.triggerCount.toString()),
        pw.SizedBox(width: 10),
        _stat(
          'Status',
          rule.isActive
              ? 'Active'
              : rule.isPaused
                  ? 'Paused'
                  : rule.status.toString().split('.').last.toUpperCase(),
        ),
      ],
    );
  }

  static pw.Widget _stat(String label, String value) {
    return pw.Expanded(
      child: pw.Container(
        padding: const pw.EdgeInsets.all(12),
        decoration: pw.BoxDecoration(
          border: pw.Border.all(color: PdfColors.grey300),
          borderRadius: pw.BorderRadius.circular(8),
        ),
        child: pw.Column(
          crossAxisAlignment: pw.CrossAxisAlignment.start,
          children: [
            pw.Text(
              label,
              style: pw.TextStyle(
                color: _mutedColor,
                fontSize: 9,
                letterSpacing: 0.6,
              ),
            ),
            pw.SizedBox(height: 4),
            pw.Text(
              value,
              style: pw.TextStyle(
                fontSize: 13,
                fontWeight: pw.FontWeight.bold,
              ),
            ),
          ],
        ),
      ),
    );
  }

  static pw.Widget _section({
    required String title,
    required List<pw.Widget> rows,
  }) {
    return pw.Container(
      width: double.infinity,
      padding: const pw.EdgeInsets.all(14),
      decoration: pw.BoxDecoration(
        border: pw.Border.all(color: PdfColors.grey300),
        borderRadius: pw.BorderRadius.circular(8),
      ),
      child: pw.Column(
        crossAxisAlignment: pw.CrossAxisAlignment.start,
        children: [
          pw.Text(
            title,
            style: pw.TextStyle(
              fontSize: 12,
              fontWeight: pw.FontWeight.bold,
              color: _primaryColor,
            ),
          ),
          pw.SizedBox(height: 8),
          ...rows,
        ],
      ),
    );
  }

  static pw.Widget _row(String label, String value) {
    return pw.Padding(
      padding: const pw.EdgeInsets.symmetric(vertical: 3),
      child: pw.Row(
        crossAxisAlignment: pw.CrossAxisAlignment.start,
        children: [
          pw.SizedBox(
            width: 130,
            child: pw.Text(
              label,
              style: pw.TextStyle(
                color: _mutedColor,
                fontSize: 10,
              ),
            ),
          ),
          pw.Expanded(
            child: pw.Text(
              value,
              style: pw.TextStyle(
                fontSize: 11,
                fontWeight: pw.FontWeight.bold,
              ),
            ),
          ),
        ],
      ),
    );
  }

  static pw.Widget _transactionsTable(
    List<AutoSaveTransactionEntity> txs,
    NumberFormat currencyFormat,
    DateFormat dateTimeFormat,
  ) {
    final headerStyle = pw.TextStyle(
      fontSize: 9,
      color: _mutedColor,
      fontWeight: pw.FontWeight.bold,
    );
    final cellStyle = pw.TextStyle(fontSize: 10);
    return pw.Table(
      columnWidths: const {
        0: pw.FlexColumnWidth(2.4),
        1: pw.FlexColumnWidth(1.4),
        2: pw.FlexColumnWidth(1.0),
        3: pw.FlexColumnWidth(1.4),
      },
      children: [
        pw.TableRow(
          decoration: const pw.BoxDecoration(color: PdfColors.grey100),
          children: [
            pw.Padding(
                padding: const pw.EdgeInsets.all(6),
                child: pw.Text('When', style: headerStyle)),
            pw.Padding(
                padding: const pw.EdgeInsets.all(6),
                child: pw.Text('Amount', style: headerStyle)),
            pw.Padding(
                padding: const pw.EdgeInsets.all(6),
                child: pw.Text('Trigger', style: headerStyle)),
            pw.Padding(
                padding: const pw.EdgeInsets.all(6),
                child: pw.Text('Outcome', style: headerStyle)),
          ],
        ),
        ...txs.take(20).map(
              (t) => pw.TableRow(
                children: [
                  pw.Padding(
                      padding: const pw.EdgeInsets.all(6),
                      child: pw.Text(
                          dateTimeFormat.format(t.createdAt),
                          style: cellStyle)),
                  pw.Padding(
                      padding: const pw.EdgeInsets.all(6),
                      child: pw.Text(
                          currencyFormat.format(t.amount),
                          style: cellStyle)),
                  pw.Padding(
                      padding: const pw.EdgeInsets.all(6),
                      child: pw.Text(t.triggerType.toString().split('.').last,
                          style: cellStyle)),
                  pw.Padding(
                      padding: const pw.EdgeInsets.all(6),
                      child: pw.Text(t.success ? 'Success' : 'Failed',
                          style: cellStyle.copyWith(
                            color:
                                t.success ? _successColor : _warningColor,
                          ))),
                ],
              ),
            ),
      ],
    );
  }

  static pw.Widget _footer(pw.Context ctx) {
    return pw.Container(
      alignment: pw.Alignment.centerRight,
      padding: const pw.EdgeInsets.only(top: 6),
      child: pw.Text(
        // Pipe separator instead of a middle-dot/bullet — same
        // glyph-coverage reason as the row placeholders above.
        'Page ${ctx.pageNumber} of ${ctx.pagesCount}   |   LazerVault',
        style: pw.TextStyle(
          color: _mutedColor,
          fontSize: 8,
        ),
      ),
    );
  }

  static Future<File> _savePdf(pw.Document pdf, String basename) async {
    Directory dir;
    try {
      dir = await getTemporaryDirectory();
    } catch (_) {
      // Locked-down devices (some MDM profiles) can refuse the temp
      // directory. Fall back to the application support dir; if THAT
      // also fails, the SharePlus call will surface a clean error.
      try {
        dir = await getApplicationSupportDirectory();
      } catch (_) {
        rethrow;
      }
    }
    final f = File(
        '${dir.path}/${basename}_${DateTime.now().millisecondsSinceEpoch}.pdf');
    await f.writeAsBytes(await pdf.save());
    return f;
  }
}
