class BusinessSummaryEntity {
  final int totalRevenue;
  final int totalExpenses;
  final int netProfit;
  final int pendingInvoices;
  final int overdueInvoices;
  final int totalEmployees;
  final int lastPayRunTotal;
  final String lastPayRunDate;
  final String currency;

  const BusinessSummaryEntity({
    required this.totalRevenue,
    required this.totalExpenses,
    required this.netProfit,
    required this.pendingInvoices,
    required this.overdueInvoices,
    required this.totalEmployees,
    required this.lastPayRunTotal,
    required this.lastPayRunDate,
    required this.currency,
  });
}

class RecentBusinessTransaction {
  final String id;
  final String description;
  final int amount;
  final String type;
  final String status;
  final String date;
  final String currency;

  const RecentBusinessTransaction({
    required this.id,
    required this.description,
    required this.amount,
    required this.type,
    required this.status,
    required this.date,
    required this.currency,
  });

  bool get isCredit => type == 'credit';
}
