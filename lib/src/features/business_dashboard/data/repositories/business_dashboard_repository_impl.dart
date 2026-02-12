import 'package:lazervault/core/services/grpc_call_options_helper.dart';
import 'package:lazervault/src/generated/accounts.pb.dart' as accounts_pb;
import 'package:lazervault/src/generated/accounts.pbgrpc.dart' as accounts_grpc;
import 'package:lazervault/src/generated/payroll.pb.dart' as payroll_pb;
import 'package:lazervault/src/generated/payroll.pbgrpc.dart' as payroll_grpc;
import '../../domain/entities/business_summary_entity.dart';
import '../../domain/repositories/business_dashboard_repository.dart';

class BusinessDashboardRepositoryImpl implements BusinessDashboardRepository {
  final accounts_grpc.AccountsServiceClient accountsClient;
  final payroll_grpc.PayrollServiceClient payrollClient;
  final GrpcCallOptionsHelper callOptionsHelper;

  BusinessDashboardRepositoryImpl({
    required this.accountsClient,
    required this.payrollClient,
    required this.callOptionsHelper,
  });

  @override
  Future<BusinessSummaryEntity> getBusinessSummary({
    required String accountId,
    required String period,
  }) async {
    final options = await callOptionsHelper.withAuth();
    final dateRange = _getDateRange(period);

    // Fetch transaction statistics and payroll summary in parallel
    final statsFuture = accountsClient.getTransactionStatistics(
      accounts_pb.GetTransactionStatisticsRequest(
        accountId: accountId,
        startDate: dateRange.$1,
        endDate: dateRange.$2,
      ),
      options: options,
    );

    final payrollFuture = payrollClient.getPayrollSummary(
      payroll_pb.GetPayrollSummaryRequest(
        periodStart: dateRange.$1,
        periodEnd: dateRange.$2,
      ),
      options: options,
    );

    try {
      final results = await Future.wait([statsFuture, payrollFuture]);
      final stats = results[0] as accounts_pb.GetTransactionStatisticsResponse;
      final payroll = results[1] as payroll_pb.GetPayrollSummaryResponse;

      return BusinessSummaryEntity(
        totalRevenue: (stats.totalCredits * 100).toInt(),
        totalExpenses: (stats.totalDebits * 100).toInt(),
        netProfit: (stats.netBalance * 100).toInt(),
        pendingInvoices: 0,
        overdueInvoices: 0,
        totalEmployees: payroll.totalEmployees,
        lastPayRunTotal: payroll.totalNetPaid.toInt(),
        lastPayRunDate: payroll.totalPayRuns > 0 ? dateRange.$2 : '',
        currency: 'NGN',
      );
    } catch (_) {
      // If payroll fails, still return stats-only data
      try {
        final stats = await statsFuture;
        return BusinessSummaryEntity(
          totalRevenue: (stats.totalCredits * 100).toInt(),
          totalExpenses: (stats.totalDebits * 100).toInt(),
          netProfit: (stats.netBalance * 100).toInt(),
          pendingInvoices: 0,
          overdueInvoices: 0,
          totalEmployees: 0,
          lastPayRunTotal: 0,
          lastPayRunDate: '',
          currency: 'NGN',
        );
      } catch (e) {
        rethrow;
      }
    }
  }

  @override
  Future<List<RecentBusinessTransaction>> getRecentTransactions({
    required String accountId,
    int limit = 10,
  }) async {
    final options = await callOptionsHelper.withAuth();

    final response = await accountsClient.getTransactions(
      accounts_pb.GetTransactionsRequest(
        accountId: accountId,
        limit: limit,
      ),
      options: options,
    );

    return response.transactions.map((tx) {
      return RecentBusinessTransaction(
        id: tx.id.toString(),
        description: tx.description,
        amount: (tx.amount * 100).toInt(),
        type: tx.type,
        status: tx.status,
        date: tx.createdAt,
        currency: 'NGN',
      );
    }).toList();
  }

  (String, String) _getDateRange(String period) {
    final now = DateTime.now();
    DateTime start;
    switch (period) {
      case 'today':
        start = DateTime(now.year, now.month, now.day);
      case 'week':
        start = now.subtract(const Duration(days: 7));
      case 'month':
        start = DateTime(now.year, now.month, 1);
      case 'quarter':
        final quarterStart = ((now.month - 1) ~/ 3) * 3 + 1;
        start = DateTime(now.year, quarterStart, 1);
      default:
        start = DateTime(now.year, now.month, 1);
    }
    String formatDate(DateTime d) =>
        '${d.year}-${d.month.toString().padLeft(2, '0')}-${d.day.toString().padLeft(2, '0')}';
    return (formatDate(start), formatDate(now));
  }
}
