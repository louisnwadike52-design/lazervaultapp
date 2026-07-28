/// Aggregated Lazavote Business KPIs from business-gateway
/// `GET /api/v1/business/overview`. All money values are in MINOR units (kobo);
/// convert at the UI boundary. The business account BALANCE is NOT part of this
/// payload — the dashboard combines this with the balance it already has from
/// the accounts carousel.
class BusinessOverviewEntity {
  final String currency;

  // Payroll
  final int payrollNetPaid;
  final int payrollGrossPaid;
  final int payrollDeductions;
  final int totalEmployees;
  final int totalPayRuns;

  // Expenses
  final int expensesTotal;
  final int expensesPending;
  final int expensesReimbursed;
  final int expenseCount;

  // Inventory
  final int inventoryValue;
  final int inventoryItems;

  // Tax
  final int taxTotalDue;
  final int vatDue;
  final int payeDue;
  final int whtDue;
  final int citEstimated;
  final int pendingObligations;
  final int overdueObligations;

  // Customers
  final int customerCount;

  // Sales (Phase 5 — 0 until the revenue engine is wired)
  final int revenue;
  final int receivables;
  final int netCashFlow;

  const BusinessOverviewEntity({
    this.currency = 'NGN',
    this.payrollNetPaid = 0,
    this.payrollGrossPaid = 0,
    this.payrollDeductions = 0,
    this.totalEmployees = 0,
    this.totalPayRuns = 0,
    this.expensesTotal = 0,
    this.expensesPending = 0,
    this.expensesReimbursed = 0,
    this.expenseCount = 0,
    this.inventoryValue = 0,
    this.inventoryItems = 0,
    this.taxTotalDue = 0,
    this.vatDue = 0,
    this.payeDue = 0,
    this.whtDue = 0,
    this.citEstimated = 0,
    this.pendingObligations = 0,
    this.overdueObligations = 0,
    this.customerCount = 0,
    this.revenue = 0,
    this.receivables = 0,
    this.netCashFlow = 0,
  });

  factory BusinessOverviewEntity.fromJson(Map<String, dynamic> json) {
    int i(dynamic v) => v is num ? v.toInt() : int.tryParse('${v ?? 0}') ?? 0;
    final payroll = (json['payroll'] as Map?)?.cast<String, dynamic>() ?? {};
    final expenses = (json['expenses'] as Map?)?.cast<String, dynamic>() ?? {};
    final inventory = (json['inventory'] as Map?)?.cast<String, dynamic>() ?? {};
    final tax = (json['tax'] as Map?)?.cast<String, dynamic>() ?? {};
    final customers = (json['customers'] as Map?)?.cast<String, dynamic>() ?? {};
    return BusinessOverviewEntity(
      currency: (json['currency'] as String?) ?? 'NGN',
      payrollNetPaid: i(payroll['net_paid']),
      payrollGrossPaid: i(payroll['gross_paid']),
      payrollDeductions: i(payroll['deductions']),
      totalEmployees: i(payroll['total_employees']),
      totalPayRuns: i(payroll['total_pay_runs']),
      expensesTotal: i(expenses['total']),
      expensesPending: i(expenses['pending']),
      expensesReimbursed: i(expenses['reimbursed']),
      expenseCount: i(expenses['count']),
      inventoryValue: i(inventory['total_value']),
      inventoryItems: i(inventory['total_items']),
      taxTotalDue: i(tax['total_due']),
      vatDue: i(tax['vat_due']),
      payeDue: i(tax['paye_due']),
      whtDue: i(tax['wht_due']),
      citEstimated: i(tax['cit_estimated']),
      pendingObligations: i(tax['pending_obligations']),
      overdueObligations: i(tax['overdue_obligations']),
      customerCount: i(customers['count']),
      revenue: i(json['revenue']),
      receivables: i(json['receivables']),
      netCashFlow: i(json['net_cash_flow']),
    );
  }

  /// Money in major units for display.
  double get payrollMajor => payrollNetPaid / 100;
  double get expensesMajor => expensesTotal / 100;
  double get inventoryMajor => inventoryValue / 100;
  double get taxMajor => taxTotalDue / 100;
  double get revenueMajor => revenue / 100;
  double get receivablesMajor => receivables / 100;
  double get netCashFlowMajor => netCashFlow / 100;
}
