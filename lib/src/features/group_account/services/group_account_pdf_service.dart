import 'dart:io';
import 'package:csv/csv.dart';
import 'package:flutter/services.dart';
import 'package:intl/intl.dart';
import 'package:path_provider/path_provider.dart';
import 'package:pdf/pdf.dart';
import 'package:pdf/widgets.dart' as pw;
import 'package:share_plus/share_plus.dart';
import '../domain/entities/group_entities.dart';

/// Service for generating PDF reports for group accounts
class GroupAccountPdfService {
  static const _primaryColor = PdfColor.fromInt(0xFF4E03D0);
  static const _successColor = PdfColor.fromInt(0xFF10B981);
  static const _warningColor = PdfColor.fromInt(0xFFFB923C);

  /// Generate a contribution report PDF
  static Future<File> generateContributionReport({
    required Contribution contribution,
    required List<ContributionPayment> payments,
    required List<GroupMember> members,
    required String groupName,
  }) async {
    final pdf = pw.Document();
    final dateFormat = DateFormat('MMMM d, yyyy');
    final currencyFormat = NumberFormat.currency(symbol: '\u20A6', decimalDigits: 0);

    pdf.addPage(
      pw.MultiPage(
        pageFormat: PdfPageFormat.a4,
        margin: const pw.EdgeInsets.all(40),
        build: (context) => [
          // Header
          _buildHeader(
            title: contribution.title,
            subtitle: groupName,
            date: DateTime.now(),
          ),
          pw.SizedBox(height: 24),

          // Summary Section
          _buildSummarySection(contribution, currencyFormat, dateFormat),
          pw.SizedBox(height: 24),

          // Progress Section
          _buildProgressSection(contribution),
          pw.SizedBox(height: 24),

          // Member Contributions
          _buildMemberContributionsSection(members, payments, currencyFormat),
          pw.SizedBox(height: 24),

          // Payment History
          if (payments.isNotEmpty) ...[
            _buildPaymentHistorySection(payments, currencyFormat, dateFormat),
          ],
        ],
        footer: (context) => _buildFooter(context),
      ),
    );

    return _savePdf(pdf, 'contribution_report_${contribution.id}');
  }

  /// Generate a group summary PDF
  static Future<File> generateGroupSummary({
    required GroupAccount group,
    required List<GroupMember> members,
    required List<Contribution> contributions,
  }) async {
    final pdf = pw.Document();
    final dateFormat = DateFormat('MMMM d, yyyy');
    final currencyFormat = NumberFormat.currency(symbol: '\u20A6', decimalDigits: 0);

    final totalTarget = contributions.fold<double>(0, (sum, c) => sum + c.targetAmount);
    final totalCurrent = contributions.fold<double>(0, (sum, c) => sum + c.currentAmount);
    final activeContributions = contributions.where((c) => c.status == ContributionStatus.active).length;
    final completedContributions = contributions.where((c) => c.status == ContributionStatus.completed).length;

    pdf.addPage(
      pw.MultiPage(
        pageFormat: PdfPageFormat.a4,
        margin: const pw.EdgeInsets.all(40),
        build: (context) => [
          // Header
          _buildHeader(
            title: group.name,
            subtitle: 'Group Summary Report',
            date: DateTime.now(),
          ),
          pw.SizedBox(height: 24),

          // Overview Stats
          pw.Row(
            mainAxisAlignment: pw.MainAxisAlignment.spaceBetween,
            children: [
              _buildStatBox('Members', members.length.toString()),
              _buildStatBox('Contributions', contributions.length.toString()),
              _buildStatBox('Active', activeContributions.toString()),
              _buildStatBox('Completed', completedContributions.toString()),
            ],
          ),
          pw.SizedBox(height: 24),

          // Financial Summary
          pw.Container(
            padding: const pw.EdgeInsets.all(16),
            decoration: pw.BoxDecoration(
              border: pw.Border.all(color: PdfColors.grey300),
              borderRadius: pw.BorderRadius.circular(8),
            ),
            child: pw.Column(
              crossAxisAlignment: pw.CrossAxisAlignment.start,
              children: [
                pw.Text(
                  'Financial Summary',
                  style: pw.TextStyle(
                    fontSize: 14,
                    fontWeight: pw.FontWeight.bold,
                  ),
                ),
                pw.SizedBox(height: 12),
                pw.Row(
                  mainAxisAlignment: pw.MainAxisAlignment.spaceBetween,
                  children: [
                    pw.Text('Total Target:'),
                    pw.Text(
                      currencyFormat.format(totalTarget / 100),
                      style: pw.TextStyle(fontWeight: pw.FontWeight.bold),
                    ),
                  ],
                ),
                pw.SizedBox(height: 8),
                pw.Row(
                  mainAxisAlignment: pw.MainAxisAlignment.spaceBetween,
                  children: [
                    pw.Text('Total Collected:'),
                    pw.Text(
                      currencyFormat.format(totalCurrent / 100),
                      style: pw.TextStyle(
                        fontWeight: pw.FontWeight.bold,
                        color: _successColor,
                      ),
                    ),
                  ],
                ),
                pw.SizedBox(height: 8),
                pw.Row(
                  mainAxisAlignment: pw.MainAxisAlignment.spaceBetween,
                  children: [
                    pw.Text('Remaining:'),
                    pw.Text(
                      currencyFormat.format((totalTarget - totalCurrent) / 100),
                      style: pw.TextStyle(
                        fontWeight: pw.FontWeight.bold,
                        color: _warningColor,
                      ),
                    ),
                  ],
                ),
              ],
            ),
          ),
          pw.SizedBox(height: 24),

          // Members List
          pw.Text(
            'Members',
            style: pw.TextStyle(
              fontSize: 14,
              fontWeight: pw.FontWeight.bold,
            ),
          ),
          pw.SizedBox(height: 12),
          _buildMembersTable(members),
          pw.SizedBox(height: 24),

          // Contributions List
          pw.Text(
            'Contributions',
            style: pw.TextStyle(
              fontSize: 14,
              fontWeight: pw.FontWeight.bold,
            ),
          ),
          pw.SizedBox(height: 12),
          _buildContributionsTable(contributions, currencyFormat, dateFormat),
        ],
        footer: (context) => _buildFooter(context),
      ),
    );

    return _savePdf(pdf, 'group_summary_${group.id}');
  }

  /// Generate payment statement PDF
  static Future<File> generatePaymentStatement({
    required String userName,
    required String groupName,
    required List<ContributionPayment> payments,
    required DateTime startDate,
    required DateTime endDate,
  }) async {
    final pdf = pw.Document();
    final dateFormat = DateFormat('MMMM d, yyyy');
    final currencyFormat = NumberFormat.currency(symbol: '\u20A6', decimalDigits: 0);

    final totalPaid = payments.fold<double>(0, (sum, p) => sum + p.amount);

    pdf.addPage(
      pw.MultiPage(
        pageFormat: PdfPageFormat.a4,
        margin: const pw.EdgeInsets.all(40),
        build: (context) => [
          _buildHeader(
            title: 'Payment Statement',
            subtitle: '$userName - $groupName',
            date: DateTime.now(),
          ),
          pw.SizedBox(height: 16),
          pw.Text(
            'Period: ${dateFormat.format(startDate)} - ${dateFormat.format(endDate)}',
            style: const pw.TextStyle(fontSize: 12, color: PdfColors.grey700),
          ),
          pw.SizedBox(height: 24),
          pw.Container(
            padding: const pw.EdgeInsets.all(16),
            decoration: pw.BoxDecoration(
              color: PdfColors.grey100,
              borderRadius: pw.BorderRadius.circular(8),
            ),
            child: pw.Row(
              mainAxisAlignment: pw.MainAxisAlignment.spaceBetween,
              children: [
                pw.Text(
                  'Total Payments:',
                  style: pw.TextStyle(fontSize: 14, fontWeight: pw.FontWeight.bold),
                ),
                pw.Text(
                  currencyFormat.format(totalPaid / 100),
                  style: pw.TextStyle(
                    fontSize: 18,
                    fontWeight: pw.FontWeight.bold,
                    color: _primaryColor,
                  ),
                ),
              ],
            ),
          ),
          pw.SizedBox(height: 24),
          _buildPaymentHistorySection(payments, currencyFormat, dateFormat),
        ],
        footer: (context) => _buildFooter(context),
      ),
    );

    return _savePdf(pdf, 'payment_statement_${DateTime.now().millisecondsSinceEpoch}');
  }

  // Helper methods for building PDF sections

  static pw.Widget _buildHeader({
    required String title,
    required String subtitle,
    required DateTime date,
  }) {
    return pw.Container(
      padding: const pw.EdgeInsets.only(bottom: 16),
      decoration: const pw.BoxDecoration(
        border: pw.Border(bottom: pw.BorderSide(color: PdfColors.grey300)),
      ),
      child: pw.Row(
        mainAxisAlignment: pw.MainAxisAlignment.spaceBetween,
        children: [
          pw.Column(
            crossAxisAlignment: pw.CrossAxisAlignment.start,
            children: [
              pw.Text(
                title,
                style: pw.TextStyle(
                  fontSize: 24,
                  fontWeight: pw.FontWeight.bold,
                  color: _primaryColor,
                ),
              ),
              pw.SizedBox(height: 4),
              pw.Text(
                subtitle,
                style: const pw.TextStyle(
                  fontSize: 14,
                  color: PdfColors.grey700,
                ),
              ),
            ],
          ),
          pw.Column(
            crossAxisAlignment: pw.CrossAxisAlignment.end,
            children: [
              pw.Text(
                'LazerVault',
                style: pw.TextStyle(
                  fontSize: 16,
                  fontWeight: pw.FontWeight.bold,
                  color: _primaryColor,
                ),
              ),
              pw.SizedBox(height: 4),
              pw.Text(
                DateFormat('MMM d, yyyy').format(date),
                style: const pw.TextStyle(
                  fontSize: 12,
                  color: PdfColors.grey600,
                ),
              ),
            ],
          ),
        ],
      ),
    );
  }

  static pw.Widget _buildSummarySection(
    Contribution contribution,
    NumberFormat currencyFormat,
    DateFormat dateFormat,
  ) {
    return pw.Container(
      padding: const pw.EdgeInsets.all(16),
      decoration: pw.BoxDecoration(
        border: pw.Border.all(color: PdfColors.grey300),
        borderRadius: pw.BorderRadius.circular(8),
      ),
      child: pw.Column(
        children: [
          _buildSummaryRow('Type', _getTypeLabel(contribution.type)),
          _buildSummaryRow('Target Amount', currencyFormat.format(contribution.targetAmount / 100)),
          _buildSummaryRow('Current Amount', currencyFormat.format(contribution.currentAmount / 100)),
          _buildSummaryRow('Status', _getStatusLabel(contribution.status)),
          _buildSummaryRow('Deadline', dateFormat.format(contribution.deadline)),
        ],
      ),
    );
  }

  static pw.Widget _buildSummaryRow(String label, String value) {
    return pw.Padding(
      padding: const pw.EdgeInsets.symmetric(vertical: 4),
      child: pw.Row(
        mainAxisAlignment: pw.MainAxisAlignment.spaceBetween,
        children: [
          pw.Text(label, style: const pw.TextStyle(color: PdfColors.grey700)),
          pw.Text(value, style: pw.TextStyle(fontWeight: pw.FontWeight.bold)),
        ],
      ),
    );
  }

  static pw.Widget _buildProgressSection(Contribution contribution) {
    final progress = contribution.targetAmount > 0
        ? (contribution.currentAmount / contribution.targetAmount).clamp(0.0, 1.0)
        : 0.0;

    return pw.Container(
      padding: const pw.EdgeInsets.all(16),
      decoration: pw.BoxDecoration(
        color: PdfColors.grey100,
        borderRadius: pw.BorderRadius.circular(8),
      ),
      child: pw.Column(
        crossAxisAlignment: pw.CrossAxisAlignment.start,
        children: [
          pw.Row(
            mainAxisAlignment: pw.MainAxisAlignment.spaceBetween,
            children: [
              pw.Text(
                'Progress',
                style: pw.TextStyle(fontWeight: pw.FontWeight.bold),
              ),
              pw.Text(
                '${(progress * 100).toStringAsFixed(1)}%',
                style: pw.TextStyle(
                  fontWeight: pw.FontWeight.bold,
                  color: _primaryColor,
                ),
              ),
            ],
          ),
          pw.SizedBox(height: 8),
          pw.Container(
            height: 12,
            width: double.infinity,
            decoration: pw.BoxDecoration(
              color: PdfColors.grey300,
              borderRadius: pw.BorderRadius.circular(6),
            ),
            child: pw.Stack(
              children: [
                pw.Container(
                  width: 400 * progress, // Using a fixed max width for progress bar
                  height: 12,
                  decoration: pw.BoxDecoration(
                    color: _successColor,
                    borderRadius: pw.BorderRadius.circular(6),
                  ),
                ),
              ],
            ),
          ),
        ],
      ),
    );
  }

  static pw.Widget _buildMemberContributionsSection(
    List<GroupMember> members,
    List<ContributionPayment> payments,
    NumberFormat currencyFormat,
  ) {
    // Calculate total paid per member
    final memberTotals = <String, double>{};
    for (final payment in payments) {
      memberTotals[payment.userId] = (memberTotals[payment.userId] ?? 0) + payment.amount;
    }

    return pw.Column(
      crossAxisAlignment: pw.CrossAxisAlignment.start,
      children: [
        pw.Text(
          'Member Contributions',
          style: pw.TextStyle(fontSize: 14, fontWeight: pw.FontWeight.bold),
        ),
        pw.SizedBox(height: 12),
        pw.Table(
          border: pw.TableBorder.all(color: PdfColors.grey300),
          children: [
            pw.TableRow(
              decoration: const pw.BoxDecoration(color: PdfColors.grey200),
              children: [
                _tableHeader('Member'),
                _tableHeader('Total Paid'),
                _tableHeader('Payments'),
                _tableHeader('Status'),
              ],
            ),
            ...members.map((member) {
              final totalPaid = memberTotals[member.userId] ?? 0;
              final paymentCount = payments.where((p) => p.userId == member.userId).length;

              return pw.TableRow(
                children: [
                  _tableCell(member.userName),
                  _tableCell(currencyFormat.format(totalPaid / 100)),
                  _tableCell(paymentCount.toString()),
                  _tableCell(totalPaid > 0 ? 'Paid' : 'Pending'),
                ],
              );
            }),
          ],
        ),
      ],
    );
  }

  static pw.Widget _buildPaymentHistorySection(
    List<ContributionPayment> payments,
    NumberFormat currencyFormat,
    DateFormat dateFormat,
  ) {
    return pw.Column(
      crossAxisAlignment: pw.CrossAxisAlignment.start,
      children: [
        pw.Text(
          'Payment History',
          style: pw.TextStyle(fontSize: 14, fontWeight: pw.FontWeight.bold),
        ),
        pw.SizedBox(height: 12),
        pw.Table(
          border: pw.TableBorder.all(color: PdfColors.grey300),
          children: [
            pw.TableRow(
              decoration: const pw.BoxDecoration(color: PdfColors.grey200),
              children: [
                _tableHeader('Date'),
                _tableHeader('Member'),
                _tableHeader('Amount'),
                _tableHeader('Status'),
              ],
            ),
            ...payments.map((payment) {
              return pw.TableRow(
                children: [
                  _tableCell(dateFormat.format(payment.paymentDate)),
                  _tableCell(payment.userName),
                  _tableCell(currencyFormat.format(payment.amount / 100)),
                  _tableCell(_getPaymentStatusLabel(payment.status)),
                ],
              );
            }),
          ],
        ),
      ],
    );
  }

  static pw.Widget _buildMembersTable(List<GroupMember> members) {
    return pw.Table(
      border: pw.TableBorder.all(color: PdfColors.grey300),
      children: [
        pw.TableRow(
          decoration: const pw.BoxDecoration(color: PdfColors.grey200),
          children: [
            _tableHeader('Name'),
            _tableHeader('Email'),
            _tableHeader('Role'),
            _tableHeader('Status'),
          ],
        ),
        ...members.map((member) {
          return pw.TableRow(
            children: [
              _tableCell(member.userName),
              _tableCell(member.email ?? '-'),
              _tableCell(_getRoleLabel(member.role)),
              _tableCell(_getMemberStatusLabel(member.status)),
            ],
          );
        }),
      ],
    );
  }

  static pw.Widget _buildContributionsTable(
    List<Contribution> contributions,
    NumberFormat currencyFormat,
    DateFormat dateFormat,
  ) {
    return pw.Table(
      border: pw.TableBorder.all(color: PdfColors.grey300),
      children: [
        pw.TableRow(
          decoration: const pw.BoxDecoration(color: PdfColors.grey200),
          children: [
            _tableHeader('Title'),
            _tableHeader('Target'),
            _tableHeader('Current'),
            _tableHeader('Deadline'),
            _tableHeader('Status'),
          ],
        ),
        ...contributions.map((c) {
          return pw.TableRow(
            children: [
              _tableCell(c.title),
              _tableCell(currencyFormat.format(c.targetAmount / 100)),
              _tableCell(currencyFormat.format(c.currentAmount / 100)),
              _tableCell(dateFormat.format(c.deadline)),
              _tableCell(_getStatusLabel(c.status)),
            ],
          );
        }),
      ],
    );
  }

  static pw.Widget _buildStatBox(String label, String value) {
    return pw.Container(
      padding: const pw.EdgeInsets.all(12),
      decoration: pw.BoxDecoration(
        border: pw.Border.all(color: PdfColors.grey300),
        borderRadius: pw.BorderRadius.circular(8),
      ),
      child: pw.Column(
        children: [
          pw.Text(
            value,
            style: pw.TextStyle(
              fontSize: 20,
              fontWeight: pw.FontWeight.bold,
              color: _primaryColor,
            ),
          ),
          pw.SizedBox(height: 4),
          pw.Text(
            label,
            style: const pw.TextStyle(fontSize: 10, color: PdfColors.grey600),
          ),
        ],
      ),
    );
  }

  static pw.Widget _buildFooter(pw.Context context) {
    return pw.Container(
      alignment: pw.Alignment.centerRight,
      margin: const pw.EdgeInsets.only(top: 12),
      child: pw.Row(
        mainAxisAlignment: pw.MainAxisAlignment.spaceBetween,
        children: [
          pw.Text(
            'Generated by LazerVault',
            style: const pw.TextStyle(fontSize: 10, color: PdfColors.grey500),
          ),
          pw.Text(
            'Page ${context.pageNumber} of ${context.pagesCount}',
            style: const pw.TextStyle(fontSize: 10, color: PdfColors.grey500),
          ),
        ],
      ),
    );
  }

  static pw.Widget _tableHeader(String text) {
    return pw.Padding(
      padding: const pw.EdgeInsets.all(8),
      child: pw.Text(
        text,
        style: pw.TextStyle(fontWeight: pw.FontWeight.bold, fontSize: 10),
      ),
    );
  }

  static pw.Widget _tableCell(String text) {
    return pw.Padding(
      padding: const pw.EdgeInsets.all(8),
      child: pw.Text(text, style: const pw.TextStyle(fontSize: 10)),
    );
  }

  static Future<File> _savePdf(pw.Document pdf, String filename) async {
    final output = await getApplicationDocumentsDirectory();
    final file = File('${output.path}/$filename.pdf');
    await file.writeAsBytes(await pdf.save());
    return file;
  }

  /// Download report to device downloads folder
  static Future<String> downloadReport(File pdfFile) async {
    final downloadsDir = await getDownloadsDirectory();
    if (downloadsDir == null) {
      throw Exception('Unable to access downloads directory');
    }

    final filename = pdfFile.path.split('/').last;
    final targetPath = '${downloadsDir.path}/$filename';
    await pdfFile.copy(targetPath);

    return targetPath;
  }

  /// Share report via system share dialog
  static Future<void> shareReport(File pdfFile, {String? subject}) async {
    await SharePlus.instance.share(
      ShareParams(
        files: [XFile(pdfFile.path)],
        subject: subject ?? 'Group Account Report',
      ),
    );
  }

  // ignore: deprecated_member_use

  // Label helper methods

  static String _getTypeLabel(ContributionType type) {
    switch (type) {
      case ContributionType.oneTime:
        return 'One-Time Goal';
      case ContributionType.rotatingSavings:
        return 'Rotating Savings';
      case ContributionType.investmentPool:
        return 'Investment Pool';
      case ContributionType.recurringGoal:
        return 'Recurring Goal';
    }
  }

  static String _getStatusLabel(ContributionStatus status) {
    switch (status) {
      case ContributionStatus.active:
        return 'Active';
      case ContributionStatus.paused:
        return 'Paused';
      case ContributionStatus.completed:
        return 'Completed';
      case ContributionStatus.cancelled:
        return 'Cancelled';
    }
  }

  static String _getPaymentStatusLabel(PaymentStatus status) {
    switch (status) {
      case PaymentStatus.pending:
        return 'Pending';
      case PaymentStatus.processing:
        return 'Processing';
      case PaymentStatus.completed:
        return 'Completed';
      case PaymentStatus.failed:
        return 'Failed';
      case PaymentStatus.refunded:
        return 'Refunded';
      case PaymentStatus.cancelled:
        return 'Cancelled';
    }
  }

  static String _getRoleLabel(GroupMemberRole role) {
    switch (role) {
      case GroupMemberRole.admin:
        return 'Admin';
      case GroupMemberRole.moderator:
        return 'Moderator';
      case GroupMemberRole.member:
        return 'Member';
    }
  }

  static String _getMemberStatusLabel(GroupMemberStatus status) {
    switch (status) {
      case GroupMemberStatus.active:
        return 'Active';
      case GroupMemberStatus.pending:
        return 'Pending';
      case GroupMemberStatus.inactive:
        return 'Inactive';
      case GroupMemberStatus.removed:
        return 'Removed';
    }
  }

  // ========== CSV Export Methods ==========

  /// Export member statistics to CSV
  static Future<File> exportMemberStatsCsv({
    required String groupName,
    required List<GroupMember> members,
    required List<ContributionPayment> payments,
  }) async {
    // Calculate total paid per member
    final memberTotals = <String, double>{};
    final memberPaymentCount = <String, int>{};
    for (final payment in payments) {
      memberTotals[payment.userId] = (memberTotals[payment.userId] ?? 0) + payment.amount;
      memberPaymentCount[payment.userId] = (memberPaymentCount[payment.userId] ?? 0) + 1;
    }

    final rows = <List<String>>[
      ['Group: $groupName'],
      ['Generated: ${DateFormat('yyyy-MM-dd HH:mm').format(DateTime.now())}'],
      [],
      ['Name', 'Email', 'Role', 'Status', 'Joined Date', 'Total Paid', 'Payment Count'],
    ];

    for (final member in members) {
      final totalPaid = memberTotals[member.userId] ?? 0;
      final paymentCount = memberPaymentCount[member.userId] ?? 0;

      rows.add([
        member.userName,
        member.email ?? '-',
        _getRoleLabel(member.role),
        _getMemberStatusLabel(member.status),
        DateFormat('yyyy-MM-dd').format(member.joinedAt),
        (totalPaid / 100).toStringAsFixed(2),
        paymentCount.toString(),
      ]);
    }

    final csvString = const ListToCsvConverter().convert(rows);
    final dir = await getTemporaryDirectory();
    final timestamp = DateFormat('yyyyMMdd_HHmmss').format(DateTime.now());
    final sanitizedName = groupName.replaceAll(RegExp(r'[^a-zA-Z0-9]'), '_');
    final file = File('${dir.path}/member_stats_${sanitizedName}_$timestamp.csv');
    await file.writeAsString(csvString);
    return file;
  }

  /// Export contribution statistics to CSV
  static Future<File> exportContributionStatsCsv({
    required String groupName,
    required List<Contribution> contributions,
    required List<ContributionPayment> payments,
  }) async {
    final rows = <List<String>>[
      ['Group: $groupName'],
      ['Generated: ${DateFormat('yyyy-MM-dd HH:mm').format(DateTime.now())}'],
      [],
      ['Title', 'Type', 'Target Amount', 'Current Amount', 'Progress %', 'Status', 'Deadline', 'Created Date'],
    ];

    for (final contribution in contributions) {
      final progress = contribution.targetAmount > 0
          ? ((contribution.currentAmount / contribution.targetAmount) * 100).toStringAsFixed(1)
          : '0.0';

      rows.add([
        contribution.title,
        _getTypeLabel(contribution.type),
        (contribution.targetAmount / 100).toStringAsFixed(2),
        (contribution.currentAmount / 100).toStringAsFixed(2),
        progress,
        _getStatusLabel(contribution.status),
        DateFormat('yyyy-MM-dd').format(contribution.deadline),
        DateFormat('yyyy-MM-dd').format(contribution.createdAt),
      ]);
    }

    final csvString = const ListToCsvConverter().convert(rows);
    final dir = await getTemporaryDirectory();
    final timestamp = DateFormat('yyyyMMdd_HHmmss').format(DateTime.now());
    final sanitizedName = groupName.replaceAll(RegExp(r'[^a-zA-Z0-9]'), '_');
    final file = File('${dir.path}/contribution_stats_${sanitizedName}_$timestamp.csv');
    await file.writeAsString(csvString);
    return file;
  }

  /// Export payment history to CSV
  static Future<File> exportPaymentHistoryCsv({
    required String groupName,
    required String contributionTitle,
    required List<ContributionPayment> payments,
  }) async {
    final rows = <List<String>>[
      ['Group: $groupName'],
      ['Contribution: $contributionTitle'],
      ['Generated: ${DateFormat('yyyy-MM-dd HH:mm').format(DateTime.now())}'],
      [],
      ['Date', 'Time', 'Member', 'Amount', 'Currency', 'Status', 'Transaction ID', 'Notes'],
    ];

    for (final payment in payments) {
      rows.add([
        DateFormat('yyyy-MM-dd').format(payment.paymentDate),
        DateFormat('HH:mm:ss').format(payment.paymentDate),
        payment.userName,
        (payment.amount / 100).toStringAsFixed(2),
        payment.currency,
        _getPaymentStatusLabel(payment.status),
        payment.transactionId ?? '-',
        payment.notes ?? '-',
      ]);
    }

    final csvString = const ListToCsvConverter().convert(rows);
    final dir = await getTemporaryDirectory();
    final timestamp = DateFormat('yyyyMMdd_HHmmss').format(DateTime.now());
    final sanitizedTitle = contributionTitle.replaceAll(RegExp(r'[^a-zA-Z0-9]'), '_');
    final file = File('${dir.path}/payment_history_${sanitizedTitle}_$timestamp.csv');
    await file.writeAsString(csvString);
    return file;
  }

  /// Generate comprehensive report with PDF and CSV attachment
  static Future<Map<String, File>> generateComprehensiveReport({
    required GroupAccount group,
    required List<GroupMember> members,
    required List<Contribution> contributions,
    required List<ContributionPayment> payments,
  }) async {
    // Generate PDF report
    final pdfFile = await generateGroupSummary(
      group: group,
      members: members,
      contributions: contributions,
    );

    // Generate CSV exports
    final membersCsv = await exportMemberStatsCsv(
      groupName: group.name,
      members: members,
      payments: payments,
    );

    final contributionsCsv = await exportContributionStatsCsv(
      groupName: group.name,
      contributions: contributions,
      payments: payments,
    );

    return {
      'pdf': pdfFile,
      'members_csv': membersCsv,
      'contributions_csv': contributionsCsv,
    };
  }

  /// Share comprehensive report (PDF + CSVs)
  static Future<void> shareComprehensiveReport({
    required GroupAccount group,
    required List<GroupMember> members,
    required List<Contribution> contributions,
    required List<ContributionPayment> payments,
  }) async {
    final files = await generateComprehensiveReport(
      group: group,
      members: members,
      contributions: contributions,
      payments: payments,
    );

    await SharePlus.instance.share(
      ShareParams(
        files: files.values.map((f) => XFile(f.path)).toList(),
        text: '${group.name} - Group Report with Spreadsheets',
        subject: 'LazerVault Group Report: ${group.name}',
      ),
    );
  }
}
