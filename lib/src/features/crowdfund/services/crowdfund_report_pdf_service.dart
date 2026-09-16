import 'dart:io';
import 'dart:ui' show Rect;

import 'package:intl/intl.dart';
import 'package:path_provider/path_provider.dart';
import 'package:pdf/pdf.dart';
import 'package:pdf/widgets.dart' as pw;
import 'package:share_plus/share_plus.dart';

import 'package:lazervault/core/utils/receipt_fonts.dart';
import 'package:lazervault/src/features/crowdfund/domain/entities/crowdfund_entities.dart';

/// Builds the campaign report as a PDF and hands it to the OS share sheet.
///
/// The report was share-only as TEXT (WhatsApp / Facebook / Telegram / Twitter
/// blurbs). That is fine for promotion but useless as a record: a campaign
/// creator accounting to donors, a sponsor, or an auditor needs a document that
/// states what was raised, from how many people, against what target, over what
/// period, and when it was produced.
///
/// Currency is rendered through an embedded TrueType face so "₦" prints as ₦.
/// When the font can't be loaded the built-in Helvetica has no naira glyph and
/// would emit a blank box, so every string routes through [_safe], which
/// substitutes the ISO code ("NGN 1,500.00"). That is the documented
/// ASCII-fallback rule for this codebase — the number is never lost, only the
/// symbol degrades.
class CrowdfundReportPdfService {
  const CrowdfundReportPdfService._();

  static final NumberFormat _amount = NumberFormat('#,##0.00');
  static final DateFormat _date = DateFormat('d MMMM yyyy');
  static final DateFormat _dateTime = DateFormat('d MMM yyyy, HH:mm');

  /// Generates the PDF and opens the native share sheet.
  ///
  /// [sharePositionOrigin] is required for iPad, where a share sheet without an
  /// anchor rect throws. Callers capture it from the tapped widget BEFORE
  /// popping any sheet — the render box is gone afterwards.
  static Future<void> shareReport({
    required Crowdfund crowdfund,
    required CrowdfundReport report,
    CrowdfundStatistics? statistics,
    String? campaignUrl,
    Rect? sharePositionOrigin,
  }) async {
    final file = await buildReport(
      crowdfund: crowdfund,
      report: report,
      statistics: statistics,
      campaignUrl: campaignUrl,
    );
    await SharePlus.instance.share(
      ShareParams(
        files: [XFile(file.path)],
        subject: '${crowdfund.title} — campaign report',
        text: report.summary.trim().isNotEmpty
            ? report.summary.trim()
            : 'Campaign report for ${crowdfund.title}',
        sharePositionOrigin: sharePositionOrigin,
      ),
    );
  }

  /// Renders the document and returns the written file.
  static Future<File> buildReport({
    required Crowdfund crowdfund,
    required CrowdfundReport report,
    CrowdfundStatistics? statistics,
    String? campaignUrl,
  }) async {
    await ReceiptFonts.load();
    final theme = ReceiptFonts.embedded
        ? pw.ThemeData.withFont(
            base: ReceiptFonts.regular!, bold: ReceiptFonts.bold!)
        : pw.ThemeData.base();

    final doc = pw.Document(
      title: '${crowdfund.title} — Campaign Report',
      author: 'LazerVault',
      subject: 'Crowdfunding campaign report',
    );

    final raised = statistics?.totalRaised ?? crowdfund.currentAmount;
    final target = statistics?.targetAmount ?? crowdfund.targetAmount;
    final donors = statistics?.donorCount ?? crowdfund.donorCount;
    final progress = target > 0 ? (raised / target) * 100 : 0.0;

    doc.addPage(
      pw.MultiPage(
        theme: theme,
        pageFormat: PdfPageFormat.a4,
        margin: const pw.EdgeInsets.fromLTRB(40, 36, 40, 44),
        header: (ctx) => ctx.pageNumber == 1
            ? pw.SizedBox()
            : _runningHeader(crowdfund),
        footer: (ctx) => _footer(ctx, crowdfund),
        build: (ctx) => [
          _titleBlock(crowdfund, report),
          pw.SizedBox(height: 18),
          _financialSummary(
            currency: crowdfund.currency,
            raised: raised,
            target: target,
            donors: donors,
            progress: progress,
            statistics: statistics,
          ),
          pw.SizedBox(height: 18),
          _campaignFacts(crowdfund, campaignUrl),
          if (report.summary.trim().isNotEmpty) ...[
            pw.SizedBox(height: 18),
            _section('Summary', report.summary),
          ],
          if (report.impactStory.trim().isNotEmpty) ...[
            pw.SizedBox(height: 14),
            _section('Impact', report.impactStory),
          ],
          if (report.milestones.isNotEmpty) ...[
            pw.SizedBox(height: 18),
            _milestones(report.milestones, crowdfund.currency),
          ],
          if (report.contributorHighlights.isNotEmpty) ...[
            pw.SizedBox(height: 18),
            _highlights(report.contributorHighlights),
          ],
          pw.SizedBox(height: 22),
          _provenance(report),
        ],
      ),
    );

    final dir = await getTemporaryDirectory();
    final safeTitle = crowdfund.title
        .replaceAll(RegExp(r'[^A-Za-z0-9]+'), '-')
        .replaceAll(RegExp(r'-+'), '-')
        .replaceAll(RegExp(r'^-|-$'), '');
    final file = File(
        '${dir.path}/campaign-report-${safeTitle.isEmpty ? crowdfund.crowdfundCode : safeTitle}.pdf');
    await file.writeAsBytes(await doc.save());
    return file;
  }

  // ── building blocks ───────────────────────────────────────────────────────

  static pw.Widget _titleBlock(Crowdfund c, CrowdfundReport r) {
    return pw.Column(
      crossAxisAlignment: pw.CrossAxisAlignment.start,
      children: [
        pw.Row(
          mainAxisAlignment: pw.MainAxisAlignment.spaceBetween,
          crossAxisAlignment: pw.CrossAxisAlignment.start,
          children: [
            pw.Text('LazerVault',
                style: pw.TextStyle(
                    fontSize: 11,
                    fontWeight: pw.FontWeight.bold,
                    color: PdfColors.grey600,
                    letterSpacing: 1.6)),
            pw.Text(_safe('Campaign report'),
                style: const pw.TextStyle(
                    fontSize: 10, color: PdfColors.grey600)),
          ],
        ),
        pw.SizedBox(height: 14),
        pw.Text(_safe(r.title.trim().isNotEmpty ? r.title : c.title),
            style: pw.TextStyle(fontSize: 21, fontWeight: pw.FontWeight.bold)),
        pw.SizedBox(height: 5),
        pw.Text(
          _safe('${_titleCase(c.category)} · Code ${c.crowdfundCode}'),
          style: const pw.TextStyle(fontSize: 10, color: PdfColors.grey700),
        ),
        pw.SizedBox(height: 12),
        pw.Container(height: 2.5, width: 54, color: PdfColors.deepPurple),
      ],
    );
  }

  /// The numbers an auditor actually checks, in one bordered block so they
  /// cannot be mistaken for narrative text.
  static pw.Widget _financialSummary({
    required String currency,
    required double raised,
    required double target,
    required int donors,
    required double progress,
    CrowdfundStatistics? statistics,
  }) {
    return pw.Container(
      padding: const pw.EdgeInsets.all(16),
      decoration: pw.BoxDecoration(
        color: PdfColors.grey100,
        borderRadius: pw.BorderRadius.circular(8),
        border: pw.Border.all(color: PdfColors.grey300),
      ),
      child: pw.Column(
        crossAxisAlignment: pw.CrossAxisAlignment.start,
        children: [
          _blockHeading('Financial summary'),
          pw.SizedBox(height: 10),
          pw.Row(children: [
            _stat('Raised', _money(currency, raised), emphasise: true),
            _stat('Target', _money(currency, target)),
            _stat('Progress', '${progress.toStringAsFixed(1)}%'),
            _stat('Donors', '$donors'),
          ]),
          if (statistics != null) ...[
            pw.SizedBox(height: 12),
            pw.Divider(color: PdfColors.grey300, height: 1),
            pw.SizedBox(height: 10),
            pw.Row(children: [
              _stat('Average donation',
                  _money(currency, statistics.averageDonation)),
              _stat('Largest donation',
                  _money(currency, statistics.largestDonation)),
              _stat('Days remaining', '${statistics.daysRemaining}'),
              _stat('Outstanding',
                  _money(currency, (target - raised).clamp(0, double.infinity))),
            ]),
          ],
        ],
      ),
    );
  }

  static pw.Widget _campaignFacts(Crowdfund c, String? campaignUrl) {
    final rows = <List<String>>[
      ['Status', _titleCase(c.status.name)],
      ['Created', _date.format(c.createdAt)],
      if (c.deadline != null) ['Deadline', _date.format(c.deadline!)],
      ['Currency', c.currency],
      if ((campaignUrl ?? '').trim().isNotEmpty) ['Campaign link', campaignUrl!.trim()],
    ];
    return pw.Column(
      crossAxisAlignment: pw.CrossAxisAlignment.start,
      children: [
        _blockHeading('Campaign details'),
        pw.SizedBox(height: 8),
        pw.Table(
          columnWidths: const {
            0: pw.FlexColumnWidth(1.1),
            1: pw.FlexColumnWidth(2.4),
          },
          children: [
            for (final r in rows)
              pw.TableRow(children: [
                pw.Padding(
                  padding: const pw.EdgeInsets.symmetric(vertical: 4),
                  child: pw.Text(_safe(r[0]),
                      style: const pw.TextStyle(
                          fontSize: 10, color: PdfColors.grey700)),
                ),
                pw.Padding(
                  padding: const pw.EdgeInsets.symmetric(vertical: 4),
                  child: pw.Text(_safe(r[1]),
                      style: pw.TextStyle(
                          fontSize: 10, fontWeight: pw.FontWeight.bold)),
                ),
              ]),
          ],
        ),
      ],
    );
  }

  static pw.Widget _section(String heading, String body) {
    return pw.Column(
      crossAxisAlignment: pw.CrossAxisAlignment.start,
      children: [
        _blockHeading(heading),
        pw.SizedBox(height: 6),
        pw.Text(_safe(body.trim()),
            textAlign: pw.TextAlign.justify,
            style: const pw.TextStyle(fontSize: 10.5, lineSpacing: 2.2)),
      ],
    );
  }

  static pw.Widget _milestones(List<CrowdfundMilestone> ms, String currency) {
    return pw.Column(
      crossAxisAlignment: pw.CrossAxisAlignment.start,
      children: [
        _blockHeading('Milestones'),
        pw.SizedBox(height: 8),
        pw.Table(
          border: pw.TableBorder.all(color: PdfColors.grey300, width: 0.5),
          columnWidths: const {
            0: pw.FlexColumnWidth(2.2),
            1: pw.FlexColumnWidth(1.2),
            2: pw.FlexColumnWidth(1.2),
          },
          children: [
            pw.TableRow(
              decoration: const pw.BoxDecoration(color: PdfColors.grey200),
              children: [
                _cell('Milestone', bold: true),
                _cell('Target', bold: true),
                _cell('Reached', bold: true),
              ],
            ),
            for (final m in ms)
              pw.TableRow(children: [
                _cell(m.title),
                _cell(_money(currency, m.targetAmount)),
                _cell(m.isReached
                    ? (m.reachedAt != null
                        ? _date.format(m.reachedAt!)
                        : 'Yes')
                    : 'Not yet'),
              ]),
          ],
        ),
      ],
    );
  }

  static pw.Widget _highlights(List<String> items) {
    return pw.Column(
      crossAxisAlignment: pw.CrossAxisAlignment.start,
      children: [
        _blockHeading('Contributor highlights'),
        pw.SizedBox(height: 6),
        for (final h in items)
          pw.Padding(
            padding: const pw.EdgeInsets.only(bottom: 4),
            child: pw.Row(
              crossAxisAlignment: pw.CrossAxisAlignment.start,
              children: [
                pw.Text('•  ', style: const pw.TextStyle(fontSize: 10.5)),
                pw.Expanded(
                  child: pw.Text(_safe(h),
                      style: const pw.TextStyle(
                          fontSize: 10.5, lineSpacing: 2)),
                ),
              ],
            ),
          ),
      ],
    );
  }

  /// Where the document came from. An audit document that does not say when it
  /// was produced, or that its narrative was machine-generated, is misleading.
  static pw.Widget _provenance(CrowdfundReport report) {
    return pw.Container(
      padding: const pw.EdgeInsets.all(11),
      decoration: pw.BoxDecoration(
        border: pw.Border.all(color: PdfColors.grey300, width: 0.5),
        borderRadius: pw.BorderRadius.circular(6),
      ),
      child: pw.Column(
        crossAxisAlignment: pw.CrossAxisAlignment.start,
        children: [
          pw.Text(_safe('Generated ${_dateTime.format(report.generatedAt)}'),
              style: const pw.TextStyle(fontSize: 9, color: PdfColors.grey700)),
          pw.SizedBox(height: 3),
          pw.Text(
            _safe('Figures are taken from LazerVault campaign records at the '
                'time of generation. Narrative sections are AI-assisted and '
                'may be edited by the campaign creator.'),
            style: const pw.TextStyle(fontSize: 9, color: PdfColors.grey600),
          ),
        ],
      ),
    );
  }

  static pw.Widget _runningHeader(Crowdfund c) => pw.Padding(
        padding: const pw.EdgeInsets.only(bottom: 10),
        child: pw.Row(
          mainAxisAlignment: pw.MainAxisAlignment.spaceBetween,
          children: [
            pw.Text(_safe(c.title),
                style: const pw.TextStyle(fontSize: 9, color: PdfColors.grey600)),
            pw.Text(_safe(c.crowdfundCode),
                style: const pw.TextStyle(fontSize: 9, color: PdfColors.grey600)),
          ],
        ),
      );

  static pw.Widget _footer(pw.Context ctx, Crowdfund c) => pw.Padding(
        padding: const pw.EdgeInsets.only(top: 10),
        child: pw.Row(
          mainAxisAlignment: pw.MainAxisAlignment.spaceBetween,
          children: [
            pw.Text(_safe('LazerVault · ${c.crowdfundCode}'),
                style: const pw.TextStyle(fontSize: 8, color: PdfColors.grey500)),
            pw.Text('Page ${ctx.pageNumber} of ${ctx.pagesCount}',
                style: const pw.TextStyle(fontSize: 8, color: PdfColors.grey500)),
          ],
        ),
      );

  static pw.Widget _blockHeading(String text) => pw.Text(
        _safe(text.toUpperCase()),
        style: pw.TextStyle(
            fontSize: 9.5,
            fontWeight: pw.FontWeight.bold,
            letterSpacing: 1.1,
            color: PdfColors.grey700),
      );

  static pw.Widget _stat(String label, String value, {bool emphasise = false}) {
    return pw.Expanded(
      child: pw.Column(
        crossAxisAlignment: pw.CrossAxisAlignment.start,
        children: [
          pw.Text(_safe(label),
              style: const pw.TextStyle(fontSize: 8.5, color: PdfColors.grey700)),
          pw.SizedBox(height: 3),
          pw.Text(_safe(value),
              style: pw.TextStyle(
                  fontSize: emphasise ? 14 : 11.5,
                  fontWeight: pw.FontWeight.bold,
                  color: emphasise ? PdfColors.deepPurple : PdfColors.black)),
        ],
      ),
    );
  }

  static pw.Widget _cell(String text, {bool bold = false}) => pw.Padding(
        padding: const pw.EdgeInsets.symmetric(horizontal: 7, vertical: 5),
        child: pw.Text(_safe(text),
            style: pw.TextStyle(
                fontSize: 9.5,
                fontWeight: bold ? pw.FontWeight.bold : pw.FontWeight.normal)),
      );

  // ── text safety ───────────────────────────────────────────────────────────

  /// Money with a real symbol when a TrueType face is embedded, and the ISO
  /// code otherwise. Helvetica has no ₦ glyph and silently draws a blank box.
  static String _money(String currency, double value) {
    final code = currency.trim().isEmpty ? 'NGN' : currency.trim().toUpperCase();
    if (!ReceiptFonts.embedded) return '$code ${_amount.format(value)}';
    const symbols = {'NGN': '₦', 'USD': '\$', 'GBP': '£', 'EUR': '€'};
    final symbol = symbols[code];
    return symbol == null
        ? '$code ${_amount.format(value)}'
        : '$symbol${_amount.format(value)}';
  }

  /// Strips characters the built-in font cannot draw. With a TrueType face
  /// embedded everything passes through untouched; without one, anything
  /// outside Latin-1 becomes a plain equivalent so the PDF never shows the
  /// empty-box glyph. AI-written narrative routinely contains curly quotes,
  /// em dashes and emoji, which is exactly where this used to break.
  static String _safe(String input) {
    if (ReceiptFonts.embedded) return input;
    return input
        .replaceAll('₦', 'NGN ')
        .replaceAll(RegExp(r'[‘’‛]'), "'")
        .replaceAll(RegExp(r'[“”]'), '"')
        .replaceAll(RegExp(r'[–—]'), '-')
        .replaceAll('…', '...')
        .replaceAll(' ', ' ')
        .replaceAll('•', '-')
        .replaceAll(RegExp(r'[^\x20-\xFF\n\r\t]'), '');
  }

  static String _titleCase(String s) {
    if (s.trim().isEmpty) return s;
    return s
        .trim()
        .split(RegExp(r'[\s_]+'))
        .map((w) => w.isEmpty
            ? w
            : '${w[0].toUpperCase()}${w.substring(1).toLowerCase()}')
        .join(' ');
  }
}
