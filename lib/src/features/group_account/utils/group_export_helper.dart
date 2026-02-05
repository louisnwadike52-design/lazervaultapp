import 'dart:io';
import 'package:intl/intl.dart';
import 'package:path_provider/path_provider.dart';
import 'package:share_plus/share_plus.dart';
import '../domain/entities/group_entities.dart';

/// Helper class for exporting group account data to CSV format
class GroupExportHelper {
  /// Export payments to CSV format
  static Future<File> exportPaymentsCSV({
    required Contribution contribution,
    required List<ContributionPayment> payments,
  }) async {
    final dateFormat = DateFormat('yyyy-MM-dd HH:mm:ss');
    final currencyFormat = NumberFormat.currency(symbol: '', decimalDigits: 2);

    final buffer = StringBuffer();

    // CSV Header
    buffer.writeln('Payment ID,Date,Member Name,Amount (Kobo),Amount (Naira),Currency,Status,Transaction ID,Notes');

    // Data rows
    for (final payment in payments) {
      final row = [
        _escapeCSV(payment.id),
        _escapeCSV(dateFormat.format(payment.paymentDate)),
        _escapeCSV(payment.userName),
        payment.amount.toString(),
        _escapeCSV(currencyFormat.format(payment.amount / 100)),
        _escapeCSV(payment.currency),
        _escapeCSV(_getPaymentStatusLabel(payment.status)),
        _escapeCSV(payment.transactionId ?? ''),
        _escapeCSV(payment.notes ?? ''),
      ].join(',');

      buffer.writeln(row);
    }

    final filename = 'payments_${contribution.id}_${DateTime.now().millisecondsSinceEpoch}.csv';
    return _saveCSV(buffer.toString(), filename);
  }

  /// Export member payment summary to CSV
  static Future<File> exportMemberSummaryCSV({
    required Contribution contribution,
    required List<GroupMember> members,
    required List<ContributionPayment> payments,
  }) async {
    final dateFormat = DateFormat('yyyy-MM-dd');
    final currencyFormat = NumberFormat.currency(symbol: '', decimalDigits: 2);

    // Calculate member totals
    final memberPayments = <String, List<ContributionPayment>>{};
    for (final payment in payments) {
      memberPayments.putIfAbsent(payment.userId, () => []);
      memberPayments[payment.userId]!.add(payment);
    }

    // Calculate expected amount per member
    final expectedAmount = contribution.regularAmount ??
        (contribution.targetAmount / members.length).round();

    final buffer = StringBuffer();

    // CSV Header
    buffer.writeln('Member Name,Email,Phone,Expected Amount,Total Paid,Remaining,Payment Count,Status,Last Payment Date');

    // Data rows
    for (final member in members) {
      final memberPaymentList = memberPayments[member.userId] ?? [];
      final totalPaid = memberPaymentList.fold<double>(
        0,
        (sum, p) => p.status == PaymentStatus.completed ? sum + p.amount : sum,
      );
      final remaining = (expectedAmount - totalPaid).clamp(0, double.infinity);

      String status;
      if (totalPaid >= expectedAmount) {
        status = 'Paid';
      } else if (totalPaid > 0) {
        status = 'Partial';
      } else {
        status = 'Unpaid';
      }

      DateTime? lastPaymentDate;
      for (final p in memberPaymentList) {
        if (p.status == PaymentStatus.completed) {
          if (lastPaymentDate == null || p.paymentDate.isAfter(lastPaymentDate)) {
            lastPaymentDate = p.paymentDate;
          }
        }
      }

      final row = [
        _escapeCSV(member.userName),
        _escapeCSV(member.email ?? ''),
        _escapeCSV(member.phoneNumber ?? ''),
        _escapeCSV(currencyFormat.format(expectedAmount / 100)),
        _escapeCSV(currencyFormat.format(totalPaid / 100)),
        _escapeCSV(currencyFormat.format(remaining / 100)),
        memberPaymentList.length.toString(),
        status,
        lastPaymentDate != null ? dateFormat.format(lastPaymentDate) : '-',
      ].join(',');

      buffer.writeln(row);
    }

    // Add summary row
    final totalExpected = expectedAmount * members.length;
    final totalCollected = payments
        .where((p) => p.status == PaymentStatus.completed)
        .fold<double>(0, (sum, p) => sum + p.amount);
    final totalRemaining = totalExpected - totalCollected;

    buffer.writeln('');
    buffer.writeln('SUMMARY');
    buffer.writeln('Total Members,${members.length}');
    buffer.writeln('Total Expected,${currencyFormat.format(totalExpected / 100)}');
    buffer.writeln('Total Collected,${currencyFormat.format(totalCollected / 100)}');
    buffer.writeln('Total Remaining,${currencyFormat.format(totalRemaining / 100)}');

    final filename = 'member_summary_${contribution.id}_${DateTime.now().millisecondsSinceEpoch}.csv';
    return _saveCSV(buffer.toString(), filename);
  }

  /// Export payout schedule to CSV (for rotating savings)
  static Future<File> exportPayoutScheduleCSV({
    required Contribution contribution,
    required List<PayoutSchedule> schedule,
    required List<GroupMember> members,
  }) async {
    final dateFormat = DateFormat('yyyy-MM-dd');
    final currencyFormat = NumberFormat.currency(symbol: '', decimalDigits: 2);

    // Create member lookup
    final memberMap = <String, GroupMember>{};
    for (final member in members) {
      memberMap[member.userId] = member;
    }

    final buffer = StringBuffer();

    // CSV Header
    buffer.writeln('Position,Member Name,Scheduled Date,Expected Amount,Status,Received Date,Actual Amount');

    // Data rows
    for (final entry in schedule) {
      final member = memberMap[entry.userId];

      final row = [
        entry.position.toString(),
        _escapeCSV(member?.userName ?? 'Unknown'),
        _escapeCSV(dateFormat.format(entry.scheduledDate)),
        _escapeCSV(currencyFormat.format(entry.expectedAmount / 100)),
        _escapeCSV(_getPayoutStatusLabel(entry.status)),
        entry.receivedDate != null ? dateFormat.format(entry.receivedDate!) : '-',
        entry.actualAmount != null ? currencyFormat.format(entry.actualAmount! / 100) : '-',
      ].join(',');

      buffer.writeln(row);
    }

    final filename = 'payout_schedule_${contribution.id}_${DateTime.now().millisecondsSinceEpoch}.csv';
    return _saveCSV(buffer.toString(), filename);
  }

  /// Export group members list to CSV
  static Future<File> exportMembersListCSV({
    required GroupAccount group,
    required List<GroupMember> members,
  }) async {
    final dateFormat = DateFormat('yyyy-MM-dd');

    final buffer = StringBuffer();

    // CSV Header
    buffer.writeln('Member Name,Email,Phone,Role,Status,Joined Date');

    // Data rows
    for (final member in members) {
      final row = [
        _escapeCSV(member.userName),
        _escapeCSV(member.email ?? ''),
        _escapeCSV(member.phoneNumber ?? ''),
        _escapeCSV(_getRoleLabel(member.role)),
        _escapeCSV(_getMemberStatusLabel(member.status)),
        _escapeCSV(dateFormat.format(member.joinedAt)),
      ].join(',');

      buffer.writeln(row);
    }

    final filename = 'members_${group.id}_${DateTime.now().millisecondsSinceEpoch}.csv';
    return _saveCSV(buffer.toString(), filename);
  }

  /// Export all contributions summary to CSV
  static Future<File> exportContributionsSummaryCSV({
    required GroupAccount group,
    required List<Contribution> contributions,
  }) async {
    final dateFormat = DateFormat('yyyy-MM-dd');
    final currencyFormat = NumberFormat.currency(symbol: '', decimalDigits: 2);

    final buffer = StringBuffer();

    // CSV Header
    buffer.writeln('Title,Type,Target Amount,Current Amount,Progress %,Status,Deadline,Created Date');

    // Data rows
    for (final contribution in contributions) {
      final progress = contribution.targetAmount > 0
          ? ((contribution.currentAmount / contribution.targetAmount) * 100).toStringAsFixed(1)
          : '0.0';

      final row = [
        _escapeCSV(contribution.title),
        _escapeCSV(_getTypeLabel(contribution.type)),
        _escapeCSV(currencyFormat.format(contribution.targetAmount / 100)),
        _escapeCSV(currencyFormat.format(contribution.currentAmount / 100)),
        progress,
        _escapeCSV(_getContributionStatusLabel(contribution.status)),
        _escapeCSV(dateFormat.format(contribution.deadline)),
        _escapeCSV(dateFormat.format(contribution.createdAt ?? DateTime.now())),
      ].join(',');

      buffer.writeln(row);
    }

    final filename = 'contributions_${group.id}_${DateTime.now().millisecondsSinceEpoch}.csv';
    return _saveCSV(buffer.toString(), filename);
  }

  /// Export paid/unpaid spreadsheet for a contribution
  static Future<File> exportPaidUnpaidSpreadsheet({
    required Contribution contribution,
    required List<GroupMember> members,
    required List<ContributionPayment> payments,
  }) async {
    final dateFormat = DateFormat('yyyy-MM-dd');
    final currencyFormat = NumberFormat.currency(symbol: '\u20A6', decimalDigits: 0);

    // Calculate expected amount per member
    final expectedAmount = contribution.regularAmount ??
        (contribution.targetAmount / members.length).round();

    // Calculate member totals
    final memberPayments = <String, List<ContributionPayment>>{};
    for (final payment in payments) {
      if (payment.status == PaymentStatus.completed) {
        memberPayments.putIfAbsent(payment.userId, () => []);
        memberPayments[payment.userId]!.add(payment);
      }
    }

    final buffer = StringBuffer();

    // Title and metadata
    buffer.writeln('CONTRIBUTION PAYMENT STATUS REPORT');
    buffer.writeln('');
    buffer.writeln('Contribution,"${_escapeCSV(contribution.title)}"');
    buffer.writeln('Target Amount,"${currencyFormat.format(contribution.targetAmount / 100)}"');
    buffer.writeln('Current Amount,"${currencyFormat.format(contribution.currentAmount / 100)}"');
    buffer.writeln('Deadline,"${dateFormat.format(contribution.deadline)}"');
    buffer.writeln('');

    // CSV Header
    buffer.writeln('Member,Email,Phone,Expected,Paid,Remaining,Status,Last Payment');

    // Separate paid and unpaid
    final paidMembers = <GroupMember>[];
    final partialMembers = <GroupMember>[];
    final unpaidMembers = <GroupMember>[];

    for (final member in members) {
      final memberPaymentList = memberPayments[member.userId] ?? [];
      final totalPaid = memberPaymentList.fold<double>(0, (sum, p) => sum + p.amount);

      if (totalPaid >= expectedAmount) {
        paidMembers.add(member);
      } else if (totalPaid > 0) {
        partialMembers.add(member);
      } else {
        unpaidMembers.add(member);
      }
    }

    // Helper to write member rows
    void writeMemberRows(List<GroupMember> memberList, String status) {
      for (final member in memberList) {
        final memberPaymentList = memberPayments[member.userId] ?? [];
        final totalPaid = memberPaymentList.fold<double>(0, (sum, p) => sum + p.amount);
        final remaining = (expectedAmount - totalPaid).clamp(0, double.infinity);

        DateTime? lastPaymentDate;
        for (final p in memberPaymentList) {
          if (lastPaymentDate == null || p.paymentDate.isAfter(lastPaymentDate)) {
            lastPaymentDate = p.paymentDate;
          }
        }

        final row = [
          _escapeCSV(member.userName),
          _escapeCSV(member.email ?? ''),
          _escapeCSV(member.phoneNumber ?? ''),
          _escapeCSV(currencyFormat.format(expectedAmount / 100)),
          _escapeCSV(currencyFormat.format(totalPaid / 100)),
          _escapeCSV(currencyFormat.format(remaining / 100)),
          status,
          lastPaymentDate != null ? dateFormat.format(lastPaymentDate) : '-',
        ].join(',');

        buffer.writeln(row);
      }
    }

    // Write paid members first
    if (paidMembers.isNotEmpty) {
      buffer.writeln('');
      buffer.writeln('=== FULLY PAID (${paidMembers.length}) ===');
      writeMemberRows(paidMembers, 'Paid');
    }

    // Write partial payment members
    if (partialMembers.isNotEmpty) {
      buffer.writeln('');
      buffer.writeln('=== PARTIAL PAYMENT (${partialMembers.length}) ===');
      writeMemberRows(partialMembers, 'Partial');
    }

    // Write unpaid members
    if (unpaidMembers.isNotEmpty) {
      buffer.writeln('');
      buffer.writeln('=== UNPAID (${unpaidMembers.length}) ===');
      writeMemberRows(unpaidMembers, 'Unpaid');
    }

    // Summary
    buffer.writeln('');
    buffer.writeln('SUMMARY');
    buffer.writeln('Total Members,${members.length}');
    buffer.writeln('Fully Paid,${paidMembers.length}');
    buffer.writeln('Partial Payment,${partialMembers.length}');
    buffer.writeln('Unpaid,${unpaidMembers.length}');

    final filename = 'paid_unpaid_${contribution.id}_${DateTime.now().millisecondsSinceEpoch}.csv';
    return _saveCSV(buffer.toString(), filename);
  }

  // Helper methods

  static Future<File> _saveCSV(String content, String filename) async {
    final output = await getApplicationDocumentsDirectory();
    final file = File('${output.path}/$filename');
    await file.writeAsString(content);
    return file;
  }

  /// Download CSV to device downloads folder
  static Future<String> downloadCSV(File csvFile) async {
    final downloadsDir = await getDownloadsDirectory();
    if (downloadsDir == null) {
      throw Exception('Unable to access downloads directory');
    }

    final filename = csvFile.path.split('/').last;
    final targetPath = '${downloadsDir.path}/$filename';
    await csvFile.copy(targetPath);

    return targetPath;
  }

  /// Share CSV via system share dialog
  static Future<void> shareCSV(File csvFile, {String? subject}) async {
    await Share.shareXFiles(
      [XFile(csvFile.path)],
      subject: subject ?? 'Group Account Export',
    );
  }

  /// Escape CSV field value
  static String _escapeCSV(String value) {
    if (value.contains(',') || value.contains('"') || value.contains('\n')) {
      return '"${value.replaceAll('"', '""')}"';
    }
    return value;
  }

  // Label helper methods

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

  static String _getPayoutStatusLabel(PayoutStatus status) {
    switch (status) {
      case PayoutStatus.pending:
        return 'Pending';
      case PayoutStatus.processing:
        return 'Processing';
      case PayoutStatus.completed:
        return 'Completed';
      case PayoutStatus.overdue:
        return 'Overdue';
      case PayoutStatus.cancelled:
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

  static String _getContributionStatusLabel(ContributionStatus status) {
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
}
