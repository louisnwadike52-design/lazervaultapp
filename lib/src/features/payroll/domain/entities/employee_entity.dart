import 'package:equatable/equatable.dart';

class EmployeesPageResult {
  final List<EmployeeEntity> employees;
  final int totalItems;
  final int currentPage;
  final int totalPages;

  const EmployeesPageResult({
    required this.employees,
    required this.totalItems,
    required this.currentPage,
    required this.totalPages,
  });
}

enum EmploymentType { fullTime, partTime, contract }

enum PayFrequency { monthly, biweekly, weekly }

enum EmployeeStatus { active, inactive, terminated }

class EmployeeEntity extends Equatable {
  final String id;
  final String? userId;
  final String businessId;
  final String fullName;
  final String email;
  final String phone;
  final String nin;
  final String bankAccountNumber;
  final String bankCode;
  final String bankName;
  final String bankAccountName;
  final String payoutType; // "internal" (Lazervault user) | "external" (bank account)
  final EmploymentType employmentType;
  final double payRate; // Display amount (major units)
  final PayFrequency payFrequency;
  final String department;
  final String jobTitle;
  final String? startDate;
  final EmployeeStatus status;
  final DateTime createdAt;
  final DateTime updatedAt;

  const EmployeeEntity({
    required this.id,
    this.userId,
    required this.businessId,
    required this.fullName,
    required this.email,
    required this.phone,
    required this.nin,
    required this.bankAccountNumber,
    required this.bankCode,
    required this.bankName,
    this.bankAccountName = '',
    this.payoutType = 'external',
    required this.employmentType,
    required this.payRate,
    required this.payFrequency,
    required this.department,
    required this.jobTitle,
    this.startDate,
    required this.status,
    required this.createdAt,
    required this.updatedAt,
  });

  String get formattedPayRate => '\u20A6${payRate.toStringAsFixed(2)}';

  String get employmentTypeDisplay {
    switch (employmentType) {
      case EmploymentType.fullTime:
        return 'Full-Time';
      case EmploymentType.partTime:
        return 'Part-Time';
      case EmploymentType.contract:
        return 'Contract';
    }
  }

  String get payFrequencyDisplay {
    switch (payFrequency) {
      case PayFrequency.monthly:
        return 'Monthly';
      case PayFrequency.biweekly:
        return 'Bi-Weekly';
      case PayFrequency.weekly:
        return 'Weekly';
    }
  }

  String get statusDisplay {
    switch (status) {
      case EmployeeStatus.active:
        return 'Active';
      case EmployeeStatus.inactive:
        return 'Inactive';
      case EmployeeStatus.terminated:
        return 'Terminated';
    }
  }

  bool get isActive => status == EmployeeStatus.active;

  bool get isInternalPayout =>
      payoutType == 'internal' || (userId != null && userId!.isNotEmpty);

  /// Why this employee can't be paid, or null if they can — mirrors the backend
  /// `employeePayoutIssue`: a linked Lazervault user → internal wallet credit;
  /// else bank account number + code → external transfer; else NO destination.
  /// Used to flag/gate un-payable employees before a pay run is created.
  String? get payoutIssue {
    if (userId != null && userId!.trim().isNotEmpty) return null;
    if (bankAccountNumber.trim().isNotEmpty && bankCode.trim().isNotEmpty) {
      return null;
    }
    return payoutType == 'internal'
        ? 'No linked Lazervault user'
        : 'No bank account';
  }

  bool get isPayable => payoutIssue == null;

  /// Short label for where this employee is paid.
  String get payoutDisplay {
    if (isInternalPayout) return 'Lazervault';
    if (bankAccountNumber.length >= 4) {
      return 'Bank •••• ${bankAccountNumber.substring(bankAccountNumber.length - 4)}';
    }
    return 'Bank transfer';
  }

  @override
  List<Object?> get props => [id, fullName, email, status, payRate];
}
