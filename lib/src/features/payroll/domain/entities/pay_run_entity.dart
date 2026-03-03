import 'package:equatable/equatable.dart';

class PayRunsPageResult {
  final List<PayRunEntity> payRuns;
  final int totalItems;
  final int currentPage;
  final int totalPages;

  const PayRunsPageResult({
    required this.payRuns,
    required this.totalItems,
    required this.currentPage,
    required this.totalPages,
  });
}

enum PayRunStatus { draft, calculating, ready, approved, processing, completed, failed }

enum RecurrenceFrequency { none, weekly, biweekly, monthly }

class PayRunEntity extends Equatable {
  final String id;
  final String businessId;
  final String name;
  final String payPeriodStart;
  final String payPeriodEnd;
  final PayRunStatus status;
  final double totalGross;
  final double totalDeductions;
  final double totalNet;
  final double totalEmployerContributions;
  final int employeeCount;
  final bool isRecurring;
  final RecurrenceFrequency recurrenceFrequency;
  final String? nextScheduledDate;
  final bool autoApprove;
  final List<String> employeeIds;
  final String createdBy;
  final String? approvedBy;
  final DateTime createdAt;
  final DateTime? processedAt;

  const PayRunEntity({
    required this.id,
    required this.businessId,
    this.name = '',
    required this.payPeriodStart,
    required this.payPeriodEnd,
    required this.status,
    required this.totalGross,
    required this.totalDeductions,
    required this.totalNet,
    required this.totalEmployerContributions,
    required this.employeeCount,
    this.isRecurring = false,
    this.recurrenceFrequency = RecurrenceFrequency.none,
    this.nextScheduledDate,
    this.autoApprove = false,
    this.employeeIds = const [],
    required this.createdBy,
    this.approvedBy,
    required this.createdAt,
    this.processedAt,
  });

  String get formattedTotalGross => '\u20A6${totalGross.toStringAsFixed(2)}';
  String get formattedTotalNet => '\u20A6${totalNet.toStringAsFixed(2)}';
  String get formattedTotalDeductions => '\u20A6${totalDeductions.toStringAsFixed(2)}';

  String get statusDisplay {
    switch (status) {
      case PayRunStatus.draft:
        return 'Draft';
      case PayRunStatus.calculating:
        return 'Calculating';
      case PayRunStatus.ready:
        return 'Ready';
      case PayRunStatus.approved:
        return 'Approved';
      case PayRunStatus.processing:
        return 'Processing';
      case PayRunStatus.completed:
        return 'Completed';
      case PayRunStatus.failed:
        return 'Failed';
    }
  }

  bool get isDraft => status == PayRunStatus.draft;
  bool get isReady => status == PayRunStatus.ready;
  bool get isApproved => status == PayRunStatus.approved;
  bool get isCompleted => status == PayRunStatus.completed;
  bool get canApprove => status == PayRunStatus.ready;
  bool get canProcess => status == PayRunStatus.approved;

  String get displayName => name.isNotEmpty ? name : 'Pay Run ${payPeriodStart} - ${payPeriodEnd}';

  String get recurrenceFrequencyDisplay {
    switch (recurrenceFrequency) {
      case RecurrenceFrequency.none:
        return 'One-time';
      case RecurrenceFrequency.weekly:
        return 'Weekly';
      case RecurrenceFrequency.biweekly:
        return 'Bi-weekly';
      case RecurrenceFrequency.monthly:
        return 'Monthly';
    }
  }

  @override
  List<Object?> get props => [id, status, totalNet, employeeCount, name];
}
