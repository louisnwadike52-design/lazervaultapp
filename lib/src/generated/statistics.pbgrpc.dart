//
//  Generated code. Do not modify.
//  source: statistics.proto
//
// @dart = 2.12

// ignore_for_file: annotate_overrides, camel_case_types, comment_references
// ignore_for_file: constant_identifier_names, library_prefixes
// ignore_for_file: non_constant_identifier_names, prefer_final_fields
// ignore_for_file: unnecessary_import, unnecessary_this, unused_import

import 'dart:async' as $async;
import 'dart:core' as $core;

import 'package:grpc/service_api.dart' as $grpc;
import 'package:protobuf/protobuf.dart' as $pb;

import 'statistics.pb.dart' as $30;

export 'statistics.pb.dart';

@$pb.GrpcServiceName('pb.StatisticsService')
class StatisticsServiceClient extends $grpc.Client {
  static final _$createExpense = $grpc.ClientMethod<$30.CreateExpenseRequest, $30.CreateExpenseResponse>(
      '/pb.StatisticsService/CreateExpense',
      ($30.CreateExpenseRequest value) => value.writeToBuffer(),
      ($core.List<$core.int> value) => $30.CreateExpenseResponse.fromBuffer(value));
  static final _$getExpenses = $grpc.ClientMethod<$30.GetExpensesRequest, $30.GetExpensesResponse>(
      '/pb.StatisticsService/GetExpenses',
      ($30.GetExpensesRequest value) => value.writeToBuffer(),
      ($core.List<$core.int> value) => $30.GetExpensesResponse.fromBuffer(value));
  static final _$getExpenseById = $grpc.ClientMethod<$30.GetExpenseByIdRequest, $30.GetExpenseByIdResponse>(
      '/pb.StatisticsService/GetExpenseById',
      ($30.GetExpenseByIdRequest value) => value.writeToBuffer(),
      ($core.List<$core.int> value) => $30.GetExpenseByIdResponse.fromBuffer(value));
  static final _$updateExpense = $grpc.ClientMethod<$30.UpdateExpenseRequest, $30.UpdateExpenseResponse>(
      '/pb.StatisticsService/UpdateExpense',
      ($30.UpdateExpenseRequest value) => value.writeToBuffer(),
      ($core.List<$core.int> value) => $30.UpdateExpenseResponse.fromBuffer(value));
  static final _$deleteExpense = $grpc.ClientMethod<$30.DeleteExpenseRequest, $30.DeleteExpenseResponse>(
      '/pb.StatisticsService/DeleteExpense',
      ($30.DeleteExpenseRequest value) => value.writeToBuffer(),
      ($core.List<$core.int> value) => $30.DeleteExpenseResponse.fromBuffer(value));
  static final _$createBudget = $grpc.ClientMethod<$30.CreateBudgetRequest, $30.CreateBudgetResponse>(
      '/pb.StatisticsService/CreateBudget',
      ($30.CreateBudgetRequest value) => value.writeToBuffer(),
      ($core.List<$core.int> value) => $30.CreateBudgetResponse.fromBuffer(value));
  static final _$getBudgets = $grpc.ClientMethod<$30.GetBudgetsRequest, $30.GetBudgetsResponse>(
      '/pb.StatisticsService/GetBudgets',
      ($30.GetBudgetsRequest value) => value.writeToBuffer(),
      ($core.List<$core.int> value) => $30.GetBudgetsResponse.fromBuffer(value));
  static final _$getBudgetById = $grpc.ClientMethod<$30.GetBudgetByIdRequest, $30.GetBudgetByIdResponse>(
      '/pb.StatisticsService/GetBudgetById',
      ($30.GetBudgetByIdRequest value) => value.writeToBuffer(),
      ($core.List<$core.int> value) => $30.GetBudgetByIdResponse.fromBuffer(value));
  static final _$updateBudget = $grpc.ClientMethod<$30.UpdateBudgetRequest, $30.UpdateBudgetResponse>(
      '/pb.StatisticsService/UpdateBudget',
      ($30.UpdateBudgetRequest value) => value.writeToBuffer(),
      ($core.List<$core.int> value) => $30.UpdateBudgetResponse.fromBuffer(value));
  static final _$deleteBudget = $grpc.ClientMethod<$30.DeleteBudgetRequest, $30.DeleteBudgetResponse>(
      '/pb.StatisticsService/DeleteBudget',
      ($30.DeleteBudgetRequest value) => value.writeToBuffer(),
      ($core.List<$core.int> value) => $30.DeleteBudgetResponse.fromBuffer(value));
  static final _$getSpendingAnalytics = $grpc.ClientMethod<$30.GetSpendingAnalyticsRequest, $30.GetSpendingAnalyticsResponse>(
      '/pb.StatisticsService/GetSpendingAnalytics',
      ($30.GetSpendingAnalyticsRequest value) => value.writeToBuffer(),
      ($core.List<$core.int> value) => $30.GetSpendingAnalyticsResponse.fromBuffer(value));
  static final _$getCategoryBreakdown = $grpc.ClientMethod<$30.GetCategoryBreakdownRequest, $30.GetCategoryBreakdownResponse>(
      '/pb.StatisticsService/GetCategoryBreakdown',
      ($30.GetCategoryBreakdownRequest value) => value.writeToBuffer(),
      ($core.List<$core.int> value) => $30.GetCategoryBreakdownResponse.fromBuffer(value));
  static final _$getBudgetProgress = $grpc.ClientMethod<$30.GetBudgetProgressRequest, $30.GetBudgetProgressResponse>(
      '/pb.StatisticsService/GetBudgetProgress',
      ($30.GetBudgetProgressRequest value) => value.writeToBuffer(),
      ($core.List<$core.int> value) => $30.GetBudgetProgressResponse.fromBuffer(value));
  static final _$getSpendingTrends = $grpc.ClientMethod<$30.GetSpendingTrendsRequest, $30.GetSpendingTrendsResponse>(
      '/pb.StatisticsService/GetSpendingTrends',
      ($30.GetSpendingTrendsRequest value) => value.writeToBuffer(),
      ($core.List<$core.int> value) => $30.GetSpendingTrendsResponse.fromBuffer(value));
  static final _$getBudgetAlerts = $grpc.ClientMethod<$30.GetBudgetAlertsRequest, $30.GetBudgetAlertsResponse>(
      '/pb.StatisticsService/GetBudgetAlerts',
      ($30.GetBudgetAlertsRequest value) => value.writeToBuffer(),
      ($core.List<$core.int> value) => $30.GetBudgetAlertsResponse.fromBuffer(value));
  static final _$markAlertAsRead = $grpc.ClientMethod<$30.MarkAlertAsReadRequest, $30.MarkAlertAsReadResponse>(
      '/pb.StatisticsService/MarkAlertAsRead',
      ($30.MarkAlertAsReadRequest value) => value.writeToBuffer(),
      ($core.List<$core.int> value) => $30.MarkAlertAsReadResponse.fromBuffer(value));
  static final _$getAISpendingInsights = $grpc.ClientMethod<$30.GetAISpendingInsightsRequest, $30.GetAISpendingInsightsResponse>(
      '/pb.StatisticsService/GetAISpendingInsights',
      ($30.GetAISpendingInsightsRequest value) => value.writeToBuffer(),
      ($core.List<$core.int> value) => $30.GetAISpendingInsightsResponse.fromBuffer(value));
  static final _$getAIBudgetingRecommendations = $grpc.ClientMethod<$30.GetAIBudgetingRecommendationsRequest, $30.GetAIBudgetingRecommendationsResponse>(
      '/pb.StatisticsService/GetAIBudgetingRecommendations',
      ($30.GetAIBudgetingRecommendationsRequest value) => value.writeToBuffer(),
      ($core.List<$core.int> value) => $30.GetAIBudgetingRecommendationsResponse.fromBuffer(value));
  static final _$autoCategorizeExpense = $grpc.ClientMethod<$30.AutoCategorizeExpenseRequest, $30.AutoCategorizeExpenseResponse>(
      '/pb.StatisticsService/AutoCategorizeExpense',
      ($30.AutoCategorizeExpenseRequest value) => value.writeToBuffer(),
      ($core.List<$core.int> value) => $30.AutoCategorizeExpenseResponse.fromBuffer(value));
  static final _$getAIFinancialAdvice = $grpc.ClientMethod<$30.GetAIFinancialAdviceRequest, $30.GetAIFinancialAdviceResponse>(
      '/pb.StatisticsService/GetAIFinancialAdvice',
      ($30.GetAIFinancialAdviceRequest value) => value.writeToBuffer(),
      ($core.List<$core.int> value) => $30.GetAIFinancialAdviceResponse.fromBuffer(value));
  static final _$getIncomeSources = $grpc.ClientMethod<$30.GetIncomeSourcesRequest, $30.GetIncomeSourcesResponse>(
      '/pb.StatisticsService/GetIncomeSources',
      ($30.GetIncomeSourcesRequest value) => value.writeToBuffer(),
      ($core.List<$core.int> value) => $30.GetIncomeSourcesResponse.fromBuffer(value));
  static final _$getIncomeBreakdown = $grpc.ClientMethod<$30.GetIncomeBreakdownRequest, $30.GetIncomeBreakdownResponse>(
      '/pb.StatisticsService/GetIncomeBreakdown',
      ($30.GetIncomeBreakdownRequest value) => value.writeToBuffer(),
      ($core.List<$core.int> value) => $30.GetIncomeBreakdownResponse.fromBuffer(value));
  static final _$createIncomeSource = $grpc.ClientMethod<$30.CreateIncomeSourceRequest, $30.CreateIncomeSourceResponse>(
      '/pb.StatisticsService/CreateIncomeSource',
      ($30.CreateIncomeSourceRequest value) => value.writeToBuffer(),
      ($core.List<$core.int> value) => $30.CreateIncomeSourceResponse.fromBuffer(value));
  static final _$getInvestmentPortfolio = $grpc.ClientMethod<$30.GetInvestmentPortfolioRequest, $30.GetInvestmentPortfolioResponse>(
      '/pb.StatisticsService/GetInvestmentPortfolio',
      ($30.GetInvestmentPortfolioRequest value) => value.writeToBuffer(),
      ($core.List<$core.int> value) => $30.GetInvestmentPortfolioResponse.fromBuffer(value));
  static final _$createInvestment = $grpc.ClientMethod<$30.CreateInvestmentRequest, $30.CreateInvestmentResponse>(
      '/pb.StatisticsService/CreateInvestment',
      ($30.CreateInvestmentRequest value) => value.writeToBuffer(),
      ($core.List<$core.int> value) => $30.CreateInvestmentResponse.fromBuffer(value));
  static final _$getFinancialGoals = $grpc.ClientMethod<$30.GetFinancialGoalsRequest, $30.GetFinancialGoalsResponse>(
      '/pb.StatisticsService/GetFinancialGoals',
      ($30.GetFinancialGoalsRequest value) => value.writeToBuffer(),
      ($core.List<$core.int> value) => $30.GetFinancialGoalsResponse.fromBuffer(value));
  static final _$createFinancialGoal = $grpc.ClientMethod<$30.CreateFinancialGoalRequest, $30.CreateFinancialGoalResponse>(
      '/pb.StatisticsService/CreateFinancialGoal',
      ($30.CreateFinancialGoalRequest value) => value.writeToBuffer(),
      ($core.List<$core.int> value) => $30.CreateFinancialGoalResponse.fromBuffer(value));
  static final _$updateFinancialGoalProgress = $grpc.ClientMethod<$30.UpdateFinancialGoalProgressRequest, $30.UpdateFinancialGoalProgressResponse>(
      '/pb.StatisticsService/UpdateFinancialGoalProgress',
      ($30.UpdateFinancialGoalProgressRequest value) => value.writeToBuffer(),
      ($core.List<$core.int> value) => $30.UpdateFinancialGoalProgressResponse.fromBuffer(value));
  static final _$getSavingsGoal = $grpc.ClientMethod<$30.GetSavingsGoalRequest, $30.GetSavingsGoalResponse>(
      '/pb.StatisticsService/GetSavingsGoal',
      ($30.GetSavingsGoalRequest value) => value.writeToBuffer(),
      ($core.List<$core.int> value) => $30.GetSavingsGoalResponse.fromBuffer(value));
  static final _$createOrUpdateSavingsGoal = $grpc.ClientMethod<$30.CreateOrUpdateSavingsGoalRequest, $30.CreateOrUpdateSavingsGoalResponse>(
      '/pb.StatisticsService/CreateOrUpdateSavingsGoal',
      ($30.CreateOrUpdateSavingsGoalRequest value) => value.writeToBuffer(),
      ($core.List<$core.int> value) => $30.CreateOrUpdateSavingsGoalResponse.fromBuffer(value));
  static final _$getUpcomingBills = $grpc.ClientMethod<$30.GetUpcomingBillsRequest, $30.GetUpcomingBillsResponse>(
      '/pb.StatisticsService/GetUpcomingBills',
      ($30.GetUpcomingBillsRequest value) => value.writeToBuffer(),
      ($core.List<$core.int> value) => $30.GetUpcomingBillsResponse.fromBuffer(value));
  static final _$createRecurringBill = $grpc.ClientMethod<$30.CreateRecurringBillRequest, $30.CreateRecurringBillResponse>(
      '/pb.StatisticsService/CreateRecurringBill',
      ($30.CreateRecurringBillRequest value) => value.writeToBuffer(),
      ($core.List<$core.int> value) => $30.CreateRecurringBillResponse.fromBuffer(value));
  static final _$getTrackedIncome = $grpc.ClientMethod<$30.GetTrackedIncomeRequest, $30.GetTrackedIncomeResponse>(
      '/pb.StatisticsService/GetTrackedIncome',
      ($30.GetTrackedIncomeRequest value) => value.writeToBuffer(),
      ($core.List<$core.int> value) => $30.GetTrackedIncomeResponse.fromBuffer(value));
  static final _$getTrackedExpenditure = $grpc.ClientMethod<$30.GetTrackedExpenditureRequest, $30.GetTrackedExpenditureResponse>(
      '/pb.StatisticsService/GetTrackedExpenditure',
      ($30.GetTrackedExpenditureRequest value) => value.writeToBuffer(),
      ($core.List<$core.int> value) => $30.GetTrackedExpenditureResponse.fromBuffer(value));
  static final _$getTrackedIncomeBreakdown = $grpc.ClientMethod<$30.GetTrackedIncomeBreakdownRequest, $30.GetTrackedIncomeBreakdownResponse>(
      '/pb.StatisticsService/GetTrackedIncomeBreakdown',
      ($30.GetTrackedIncomeBreakdownRequest value) => value.writeToBuffer(),
      ($core.List<$core.int> value) => $30.GetTrackedIncomeBreakdownResponse.fromBuffer(value));
  static final _$getTrackedExpenditureBreakdown = $grpc.ClientMethod<$30.GetTrackedExpenditureBreakdownRequest, $30.GetTrackedExpenditureBreakdownResponse>(
      '/pb.StatisticsService/GetTrackedExpenditureBreakdown',
      ($30.GetTrackedExpenditureBreakdownRequest value) => value.writeToBuffer(),
      ($core.List<$core.int> value) => $30.GetTrackedExpenditureBreakdownResponse.fromBuffer(value));
  static final _$getTrackedIncomeTransactions = $grpc.ClientMethod<$30.GetTrackedIncomeTransactionsRequest, $30.GetTrackedIncomeTransactionsResponse>(
      '/pb.StatisticsService/GetTrackedIncomeTransactions',
      ($30.GetTrackedIncomeTransactionsRequest value) => value.writeToBuffer(),
      ($core.List<$core.int> value) => $30.GetTrackedIncomeTransactionsResponse.fromBuffer(value));
  static final _$getTrackedExpenditureTransactions = $grpc.ClientMethod<$30.GetTrackedExpenditureTransactionsRequest, $30.GetTrackedExpenditureTransactionsResponse>(
      '/pb.StatisticsService/GetTrackedExpenditureTransactions',
      ($30.GetTrackedExpenditureTransactionsRequest value) => value.writeToBuffer(),
      ($core.List<$core.int> value) => $30.GetTrackedExpenditureTransactionsResponse.fromBuffer(value));
  static final _$getComprehensiveFinancialSummary = $grpc.ClientMethod<$30.GetComprehensiveFinancialSummaryRequest, $30.GetComprehensiveFinancialSummaryResponse>(
      '/pb.StatisticsService/GetComprehensiveFinancialSummary',
      ($30.GetComprehensiveFinancialSummaryRequest value) => value.writeToBuffer(),
      ($core.List<$core.int> value) => $30.GetComprehensiveFinancialSummaryResponse.fromBuffer(value));

  StatisticsServiceClient($grpc.ClientChannel channel,
      {$grpc.CallOptions? options,
      $core.Iterable<$grpc.ClientInterceptor>? interceptors})
      : super(channel, options: options,
        interceptors: interceptors);

  $grpc.ResponseFuture<$30.CreateExpenseResponse> createExpense($30.CreateExpenseRequest request, {$grpc.CallOptions? options}) {
    return $createUnaryCall(_$createExpense, request, options: options);
  }

  $grpc.ResponseFuture<$30.GetExpensesResponse> getExpenses($30.GetExpensesRequest request, {$grpc.CallOptions? options}) {
    return $createUnaryCall(_$getExpenses, request, options: options);
  }

  $grpc.ResponseFuture<$30.GetExpenseByIdResponse> getExpenseById($30.GetExpenseByIdRequest request, {$grpc.CallOptions? options}) {
    return $createUnaryCall(_$getExpenseById, request, options: options);
  }

  $grpc.ResponseFuture<$30.UpdateExpenseResponse> updateExpense($30.UpdateExpenseRequest request, {$grpc.CallOptions? options}) {
    return $createUnaryCall(_$updateExpense, request, options: options);
  }

  $grpc.ResponseFuture<$30.DeleteExpenseResponse> deleteExpense($30.DeleteExpenseRequest request, {$grpc.CallOptions? options}) {
    return $createUnaryCall(_$deleteExpense, request, options: options);
  }

  $grpc.ResponseFuture<$30.CreateBudgetResponse> createBudget($30.CreateBudgetRequest request, {$grpc.CallOptions? options}) {
    return $createUnaryCall(_$createBudget, request, options: options);
  }

  $grpc.ResponseFuture<$30.GetBudgetsResponse> getBudgets($30.GetBudgetsRequest request, {$grpc.CallOptions? options}) {
    return $createUnaryCall(_$getBudgets, request, options: options);
  }

  $grpc.ResponseFuture<$30.GetBudgetByIdResponse> getBudgetById($30.GetBudgetByIdRequest request, {$grpc.CallOptions? options}) {
    return $createUnaryCall(_$getBudgetById, request, options: options);
  }

  $grpc.ResponseFuture<$30.UpdateBudgetResponse> updateBudget($30.UpdateBudgetRequest request, {$grpc.CallOptions? options}) {
    return $createUnaryCall(_$updateBudget, request, options: options);
  }

  $grpc.ResponseFuture<$30.DeleteBudgetResponse> deleteBudget($30.DeleteBudgetRequest request, {$grpc.CallOptions? options}) {
    return $createUnaryCall(_$deleteBudget, request, options: options);
  }

  $grpc.ResponseFuture<$30.GetSpendingAnalyticsResponse> getSpendingAnalytics($30.GetSpendingAnalyticsRequest request, {$grpc.CallOptions? options}) {
    return $createUnaryCall(_$getSpendingAnalytics, request, options: options);
  }

  $grpc.ResponseFuture<$30.GetCategoryBreakdownResponse> getCategoryBreakdown($30.GetCategoryBreakdownRequest request, {$grpc.CallOptions? options}) {
    return $createUnaryCall(_$getCategoryBreakdown, request, options: options);
  }

  $grpc.ResponseFuture<$30.GetBudgetProgressResponse> getBudgetProgress($30.GetBudgetProgressRequest request, {$grpc.CallOptions? options}) {
    return $createUnaryCall(_$getBudgetProgress, request, options: options);
  }

  $grpc.ResponseFuture<$30.GetSpendingTrendsResponse> getSpendingTrends($30.GetSpendingTrendsRequest request, {$grpc.CallOptions? options}) {
    return $createUnaryCall(_$getSpendingTrends, request, options: options);
  }

  $grpc.ResponseFuture<$30.GetBudgetAlertsResponse> getBudgetAlerts($30.GetBudgetAlertsRequest request, {$grpc.CallOptions? options}) {
    return $createUnaryCall(_$getBudgetAlerts, request, options: options);
  }

  $grpc.ResponseFuture<$30.MarkAlertAsReadResponse> markAlertAsRead($30.MarkAlertAsReadRequest request, {$grpc.CallOptions? options}) {
    return $createUnaryCall(_$markAlertAsRead, request, options: options);
  }

  $grpc.ResponseFuture<$30.GetAISpendingInsightsResponse> getAISpendingInsights($30.GetAISpendingInsightsRequest request, {$grpc.CallOptions? options}) {
    return $createUnaryCall(_$getAISpendingInsights, request, options: options);
  }

  $grpc.ResponseFuture<$30.GetAIBudgetingRecommendationsResponse> getAIBudgetingRecommendations($30.GetAIBudgetingRecommendationsRequest request, {$grpc.CallOptions? options}) {
    return $createUnaryCall(_$getAIBudgetingRecommendations, request, options: options);
  }

  $grpc.ResponseFuture<$30.AutoCategorizeExpenseResponse> autoCategorizeExpense($30.AutoCategorizeExpenseRequest request, {$grpc.CallOptions? options}) {
    return $createUnaryCall(_$autoCategorizeExpense, request, options: options);
  }

  $grpc.ResponseFuture<$30.GetAIFinancialAdviceResponse> getAIFinancialAdvice($30.GetAIFinancialAdviceRequest request, {$grpc.CallOptions? options}) {
    return $createUnaryCall(_$getAIFinancialAdvice, request, options: options);
  }

  $grpc.ResponseFuture<$30.GetIncomeSourcesResponse> getIncomeSources($30.GetIncomeSourcesRequest request, {$grpc.CallOptions? options}) {
    return $createUnaryCall(_$getIncomeSources, request, options: options);
  }

  $grpc.ResponseFuture<$30.GetIncomeBreakdownResponse> getIncomeBreakdown($30.GetIncomeBreakdownRequest request, {$grpc.CallOptions? options}) {
    return $createUnaryCall(_$getIncomeBreakdown, request, options: options);
  }

  $grpc.ResponseFuture<$30.CreateIncomeSourceResponse> createIncomeSource($30.CreateIncomeSourceRequest request, {$grpc.CallOptions? options}) {
    return $createUnaryCall(_$createIncomeSource, request, options: options);
  }

  $grpc.ResponseFuture<$30.GetInvestmentPortfolioResponse> getInvestmentPortfolio($30.GetInvestmentPortfolioRequest request, {$grpc.CallOptions? options}) {
    return $createUnaryCall(_$getInvestmentPortfolio, request, options: options);
  }

  $grpc.ResponseFuture<$30.CreateInvestmentResponse> createInvestment($30.CreateInvestmentRequest request, {$grpc.CallOptions? options}) {
    return $createUnaryCall(_$createInvestment, request, options: options);
  }

  $grpc.ResponseFuture<$30.GetFinancialGoalsResponse> getFinancialGoals($30.GetFinancialGoalsRequest request, {$grpc.CallOptions? options}) {
    return $createUnaryCall(_$getFinancialGoals, request, options: options);
  }

  $grpc.ResponseFuture<$30.CreateFinancialGoalResponse> createFinancialGoal($30.CreateFinancialGoalRequest request, {$grpc.CallOptions? options}) {
    return $createUnaryCall(_$createFinancialGoal, request, options: options);
  }

  $grpc.ResponseFuture<$30.UpdateFinancialGoalProgressResponse> updateFinancialGoalProgress($30.UpdateFinancialGoalProgressRequest request, {$grpc.CallOptions? options}) {
    return $createUnaryCall(_$updateFinancialGoalProgress, request, options: options);
  }

  $grpc.ResponseFuture<$30.GetSavingsGoalResponse> getSavingsGoal($30.GetSavingsGoalRequest request, {$grpc.CallOptions? options}) {
    return $createUnaryCall(_$getSavingsGoal, request, options: options);
  }

  $grpc.ResponseFuture<$30.CreateOrUpdateSavingsGoalResponse> createOrUpdateSavingsGoal($30.CreateOrUpdateSavingsGoalRequest request, {$grpc.CallOptions? options}) {
    return $createUnaryCall(_$createOrUpdateSavingsGoal, request, options: options);
  }

  $grpc.ResponseFuture<$30.GetUpcomingBillsResponse> getUpcomingBills($30.GetUpcomingBillsRequest request, {$grpc.CallOptions? options}) {
    return $createUnaryCall(_$getUpcomingBills, request, options: options);
  }

  $grpc.ResponseFuture<$30.CreateRecurringBillResponse> createRecurringBill($30.CreateRecurringBillRequest request, {$grpc.CallOptions? options}) {
    return $createUnaryCall(_$createRecurringBill, request, options: options);
  }

  $grpc.ResponseFuture<$30.GetTrackedIncomeResponse> getTrackedIncome($30.GetTrackedIncomeRequest request, {$grpc.CallOptions? options}) {
    return $createUnaryCall(_$getTrackedIncome, request, options: options);
  }

  $grpc.ResponseFuture<$30.GetTrackedExpenditureResponse> getTrackedExpenditure($30.GetTrackedExpenditureRequest request, {$grpc.CallOptions? options}) {
    return $createUnaryCall(_$getTrackedExpenditure, request, options: options);
  }

  $grpc.ResponseFuture<$30.GetTrackedIncomeBreakdownResponse> getTrackedIncomeBreakdown($30.GetTrackedIncomeBreakdownRequest request, {$grpc.CallOptions? options}) {
    return $createUnaryCall(_$getTrackedIncomeBreakdown, request, options: options);
  }

  $grpc.ResponseFuture<$30.GetTrackedExpenditureBreakdownResponse> getTrackedExpenditureBreakdown($30.GetTrackedExpenditureBreakdownRequest request, {$grpc.CallOptions? options}) {
    return $createUnaryCall(_$getTrackedExpenditureBreakdown, request, options: options);
  }

  $grpc.ResponseFuture<$30.GetTrackedIncomeTransactionsResponse> getTrackedIncomeTransactions($30.GetTrackedIncomeTransactionsRequest request, {$grpc.CallOptions? options}) {
    return $createUnaryCall(_$getTrackedIncomeTransactions, request, options: options);
  }

  $grpc.ResponseFuture<$30.GetTrackedExpenditureTransactionsResponse> getTrackedExpenditureTransactions($30.GetTrackedExpenditureTransactionsRequest request, {$grpc.CallOptions? options}) {
    return $createUnaryCall(_$getTrackedExpenditureTransactions, request, options: options);
  }

  $grpc.ResponseFuture<$30.GetComprehensiveFinancialSummaryResponse> getComprehensiveFinancialSummary($30.GetComprehensiveFinancialSummaryRequest request, {$grpc.CallOptions? options}) {
    return $createUnaryCall(_$getComprehensiveFinancialSummary, request, options: options);
  }
}

@$pb.GrpcServiceName('pb.StatisticsService')
abstract class StatisticsServiceBase extends $grpc.Service {
  $core.String get $name => 'pb.StatisticsService';

  StatisticsServiceBase() {
    $addMethod($grpc.ServiceMethod<$30.CreateExpenseRequest, $30.CreateExpenseResponse>(
        'CreateExpense',
        createExpense_Pre,
        false,
        false,
        ($core.List<$core.int> value) => $30.CreateExpenseRequest.fromBuffer(value),
        ($30.CreateExpenseResponse value) => value.writeToBuffer()));
    $addMethod($grpc.ServiceMethod<$30.GetExpensesRequest, $30.GetExpensesResponse>(
        'GetExpenses',
        getExpenses_Pre,
        false,
        false,
        ($core.List<$core.int> value) => $30.GetExpensesRequest.fromBuffer(value),
        ($30.GetExpensesResponse value) => value.writeToBuffer()));
    $addMethod($grpc.ServiceMethod<$30.GetExpenseByIdRequest, $30.GetExpenseByIdResponse>(
        'GetExpenseById',
        getExpenseById_Pre,
        false,
        false,
        ($core.List<$core.int> value) => $30.GetExpenseByIdRequest.fromBuffer(value),
        ($30.GetExpenseByIdResponse value) => value.writeToBuffer()));
    $addMethod($grpc.ServiceMethod<$30.UpdateExpenseRequest, $30.UpdateExpenseResponse>(
        'UpdateExpense',
        updateExpense_Pre,
        false,
        false,
        ($core.List<$core.int> value) => $30.UpdateExpenseRequest.fromBuffer(value),
        ($30.UpdateExpenseResponse value) => value.writeToBuffer()));
    $addMethod($grpc.ServiceMethod<$30.DeleteExpenseRequest, $30.DeleteExpenseResponse>(
        'DeleteExpense',
        deleteExpense_Pre,
        false,
        false,
        ($core.List<$core.int> value) => $30.DeleteExpenseRequest.fromBuffer(value),
        ($30.DeleteExpenseResponse value) => value.writeToBuffer()));
    $addMethod($grpc.ServiceMethod<$30.CreateBudgetRequest, $30.CreateBudgetResponse>(
        'CreateBudget',
        createBudget_Pre,
        false,
        false,
        ($core.List<$core.int> value) => $30.CreateBudgetRequest.fromBuffer(value),
        ($30.CreateBudgetResponse value) => value.writeToBuffer()));
    $addMethod($grpc.ServiceMethod<$30.GetBudgetsRequest, $30.GetBudgetsResponse>(
        'GetBudgets',
        getBudgets_Pre,
        false,
        false,
        ($core.List<$core.int> value) => $30.GetBudgetsRequest.fromBuffer(value),
        ($30.GetBudgetsResponse value) => value.writeToBuffer()));
    $addMethod($grpc.ServiceMethod<$30.GetBudgetByIdRequest, $30.GetBudgetByIdResponse>(
        'GetBudgetById',
        getBudgetById_Pre,
        false,
        false,
        ($core.List<$core.int> value) => $30.GetBudgetByIdRequest.fromBuffer(value),
        ($30.GetBudgetByIdResponse value) => value.writeToBuffer()));
    $addMethod($grpc.ServiceMethod<$30.UpdateBudgetRequest, $30.UpdateBudgetResponse>(
        'UpdateBudget',
        updateBudget_Pre,
        false,
        false,
        ($core.List<$core.int> value) => $30.UpdateBudgetRequest.fromBuffer(value),
        ($30.UpdateBudgetResponse value) => value.writeToBuffer()));
    $addMethod($grpc.ServiceMethod<$30.DeleteBudgetRequest, $30.DeleteBudgetResponse>(
        'DeleteBudget',
        deleteBudget_Pre,
        false,
        false,
        ($core.List<$core.int> value) => $30.DeleteBudgetRequest.fromBuffer(value),
        ($30.DeleteBudgetResponse value) => value.writeToBuffer()));
    $addMethod($grpc.ServiceMethod<$30.GetSpendingAnalyticsRequest, $30.GetSpendingAnalyticsResponse>(
        'GetSpendingAnalytics',
        getSpendingAnalytics_Pre,
        false,
        false,
        ($core.List<$core.int> value) => $30.GetSpendingAnalyticsRequest.fromBuffer(value),
        ($30.GetSpendingAnalyticsResponse value) => value.writeToBuffer()));
    $addMethod($grpc.ServiceMethod<$30.GetCategoryBreakdownRequest, $30.GetCategoryBreakdownResponse>(
        'GetCategoryBreakdown',
        getCategoryBreakdown_Pre,
        false,
        false,
        ($core.List<$core.int> value) => $30.GetCategoryBreakdownRequest.fromBuffer(value),
        ($30.GetCategoryBreakdownResponse value) => value.writeToBuffer()));
    $addMethod($grpc.ServiceMethod<$30.GetBudgetProgressRequest, $30.GetBudgetProgressResponse>(
        'GetBudgetProgress',
        getBudgetProgress_Pre,
        false,
        false,
        ($core.List<$core.int> value) => $30.GetBudgetProgressRequest.fromBuffer(value),
        ($30.GetBudgetProgressResponse value) => value.writeToBuffer()));
    $addMethod($grpc.ServiceMethod<$30.GetSpendingTrendsRequest, $30.GetSpendingTrendsResponse>(
        'GetSpendingTrends',
        getSpendingTrends_Pre,
        false,
        false,
        ($core.List<$core.int> value) => $30.GetSpendingTrendsRequest.fromBuffer(value),
        ($30.GetSpendingTrendsResponse value) => value.writeToBuffer()));
    $addMethod($grpc.ServiceMethod<$30.GetBudgetAlertsRequest, $30.GetBudgetAlertsResponse>(
        'GetBudgetAlerts',
        getBudgetAlerts_Pre,
        false,
        false,
        ($core.List<$core.int> value) => $30.GetBudgetAlertsRequest.fromBuffer(value),
        ($30.GetBudgetAlertsResponse value) => value.writeToBuffer()));
    $addMethod($grpc.ServiceMethod<$30.MarkAlertAsReadRequest, $30.MarkAlertAsReadResponse>(
        'MarkAlertAsRead',
        markAlertAsRead_Pre,
        false,
        false,
        ($core.List<$core.int> value) => $30.MarkAlertAsReadRequest.fromBuffer(value),
        ($30.MarkAlertAsReadResponse value) => value.writeToBuffer()));
    $addMethod($grpc.ServiceMethod<$30.GetAISpendingInsightsRequest, $30.GetAISpendingInsightsResponse>(
        'GetAISpendingInsights',
        getAISpendingInsights_Pre,
        false,
        false,
        ($core.List<$core.int> value) => $30.GetAISpendingInsightsRequest.fromBuffer(value),
        ($30.GetAISpendingInsightsResponse value) => value.writeToBuffer()));
    $addMethod($grpc.ServiceMethod<$30.GetAIBudgetingRecommendationsRequest, $30.GetAIBudgetingRecommendationsResponse>(
        'GetAIBudgetingRecommendations',
        getAIBudgetingRecommendations_Pre,
        false,
        false,
        ($core.List<$core.int> value) => $30.GetAIBudgetingRecommendationsRequest.fromBuffer(value),
        ($30.GetAIBudgetingRecommendationsResponse value) => value.writeToBuffer()));
    $addMethod($grpc.ServiceMethod<$30.AutoCategorizeExpenseRequest, $30.AutoCategorizeExpenseResponse>(
        'AutoCategorizeExpense',
        autoCategorizeExpense_Pre,
        false,
        false,
        ($core.List<$core.int> value) => $30.AutoCategorizeExpenseRequest.fromBuffer(value),
        ($30.AutoCategorizeExpenseResponse value) => value.writeToBuffer()));
    $addMethod($grpc.ServiceMethod<$30.GetAIFinancialAdviceRequest, $30.GetAIFinancialAdviceResponse>(
        'GetAIFinancialAdvice',
        getAIFinancialAdvice_Pre,
        false,
        false,
        ($core.List<$core.int> value) => $30.GetAIFinancialAdviceRequest.fromBuffer(value),
        ($30.GetAIFinancialAdviceResponse value) => value.writeToBuffer()));
    $addMethod($grpc.ServiceMethod<$30.GetIncomeSourcesRequest, $30.GetIncomeSourcesResponse>(
        'GetIncomeSources',
        getIncomeSources_Pre,
        false,
        false,
        ($core.List<$core.int> value) => $30.GetIncomeSourcesRequest.fromBuffer(value),
        ($30.GetIncomeSourcesResponse value) => value.writeToBuffer()));
    $addMethod($grpc.ServiceMethod<$30.GetIncomeBreakdownRequest, $30.GetIncomeBreakdownResponse>(
        'GetIncomeBreakdown',
        getIncomeBreakdown_Pre,
        false,
        false,
        ($core.List<$core.int> value) => $30.GetIncomeBreakdownRequest.fromBuffer(value),
        ($30.GetIncomeBreakdownResponse value) => value.writeToBuffer()));
    $addMethod($grpc.ServiceMethod<$30.CreateIncomeSourceRequest, $30.CreateIncomeSourceResponse>(
        'CreateIncomeSource',
        createIncomeSource_Pre,
        false,
        false,
        ($core.List<$core.int> value) => $30.CreateIncomeSourceRequest.fromBuffer(value),
        ($30.CreateIncomeSourceResponse value) => value.writeToBuffer()));
    $addMethod($grpc.ServiceMethod<$30.GetInvestmentPortfolioRequest, $30.GetInvestmentPortfolioResponse>(
        'GetInvestmentPortfolio',
        getInvestmentPortfolio_Pre,
        false,
        false,
        ($core.List<$core.int> value) => $30.GetInvestmentPortfolioRequest.fromBuffer(value),
        ($30.GetInvestmentPortfolioResponse value) => value.writeToBuffer()));
    $addMethod($grpc.ServiceMethod<$30.CreateInvestmentRequest, $30.CreateInvestmentResponse>(
        'CreateInvestment',
        createInvestment_Pre,
        false,
        false,
        ($core.List<$core.int> value) => $30.CreateInvestmentRequest.fromBuffer(value),
        ($30.CreateInvestmentResponse value) => value.writeToBuffer()));
    $addMethod($grpc.ServiceMethod<$30.GetFinancialGoalsRequest, $30.GetFinancialGoalsResponse>(
        'GetFinancialGoals',
        getFinancialGoals_Pre,
        false,
        false,
        ($core.List<$core.int> value) => $30.GetFinancialGoalsRequest.fromBuffer(value),
        ($30.GetFinancialGoalsResponse value) => value.writeToBuffer()));
    $addMethod($grpc.ServiceMethod<$30.CreateFinancialGoalRequest, $30.CreateFinancialGoalResponse>(
        'CreateFinancialGoal',
        createFinancialGoal_Pre,
        false,
        false,
        ($core.List<$core.int> value) => $30.CreateFinancialGoalRequest.fromBuffer(value),
        ($30.CreateFinancialGoalResponse value) => value.writeToBuffer()));
    $addMethod($grpc.ServiceMethod<$30.UpdateFinancialGoalProgressRequest, $30.UpdateFinancialGoalProgressResponse>(
        'UpdateFinancialGoalProgress',
        updateFinancialGoalProgress_Pre,
        false,
        false,
        ($core.List<$core.int> value) => $30.UpdateFinancialGoalProgressRequest.fromBuffer(value),
        ($30.UpdateFinancialGoalProgressResponse value) => value.writeToBuffer()));
    $addMethod($grpc.ServiceMethod<$30.GetSavingsGoalRequest, $30.GetSavingsGoalResponse>(
        'GetSavingsGoal',
        getSavingsGoal_Pre,
        false,
        false,
        ($core.List<$core.int> value) => $30.GetSavingsGoalRequest.fromBuffer(value),
        ($30.GetSavingsGoalResponse value) => value.writeToBuffer()));
    $addMethod($grpc.ServiceMethod<$30.CreateOrUpdateSavingsGoalRequest, $30.CreateOrUpdateSavingsGoalResponse>(
        'CreateOrUpdateSavingsGoal',
        createOrUpdateSavingsGoal_Pre,
        false,
        false,
        ($core.List<$core.int> value) => $30.CreateOrUpdateSavingsGoalRequest.fromBuffer(value),
        ($30.CreateOrUpdateSavingsGoalResponse value) => value.writeToBuffer()));
    $addMethod($grpc.ServiceMethod<$30.GetUpcomingBillsRequest, $30.GetUpcomingBillsResponse>(
        'GetUpcomingBills',
        getUpcomingBills_Pre,
        false,
        false,
        ($core.List<$core.int> value) => $30.GetUpcomingBillsRequest.fromBuffer(value),
        ($30.GetUpcomingBillsResponse value) => value.writeToBuffer()));
    $addMethod($grpc.ServiceMethod<$30.CreateRecurringBillRequest, $30.CreateRecurringBillResponse>(
        'CreateRecurringBill',
        createRecurringBill_Pre,
        false,
        false,
        ($core.List<$core.int> value) => $30.CreateRecurringBillRequest.fromBuffer(value),
        ($30.CreateRecurringBillResponse value) => value.writeToBuffer()));
    $addMethod($grpc.ServiceMethod<$30.GetTrackedIncomeRequest, $30.GetTrackedIncomeResponse>(
        'GetTrackedIncome',
        getTrackedIncome_Pre,
        false,
        false,
        ($core.List<$core.int> value) => $30.GetTrackedIncomeRequest.fromBuffer(value),
        ($30.GetTrackedIncomeResponse value) => value.writeToBuffer()));
    $addMethod($grpc.ServiceMethod<$30.GetTrackedExpenditureRequest, $30.GetTrackedExpenditureResponse>(
        'GetTrackedExpenditure',
        getTrackedExpenditure_Pre,
        false,
        false,
        ($core.List<$core.int> value) => $30.GetTrackedExpenditureRequest.fromBuffer(value),
        ($30.GetTrackedExpenditureResponse value) => value.writeToBuffer()));
    $addMethod($grpc.ServiceMethod<$30.GetTrackedIncomeBreakdownRequest, $30.GetTrackedIncomeBreakdownResponse>(
        'GetTrackedIncomeBreakdown',
        getTrackedIncomeBreakdown_Pre,
        false,
        false,
        ($core.List<$core.int> value) => $30.GetTrackedIncomeBreakdownRequest.fromBuffer(value),
        ($30.GetTrackedIncomeBreakdownResponse value) => value.writeToBuffer()));
    $addMethod($grpc.ServiceMethod<$30.GetTrackedExpenditureBreakdownRequest, $30.GetTrackedExpenditureBreakdownResponse>(
        'GetTrackedExpenditureBreakdown',
        getTrackedExpenditureBreakdown_Pre,
        false,
        false,
        ($core.List<$core.int> value) => $30.GetTrackedExpenditureBreakdownRequest.fromBuffer(value),
        ($30.GetTrackedExpenditureBreakdownResponse value) => value.writeToBuffer()));
    $addMethod($grpc.ServiceMethod<$30.GetTrackedIncomeTransactionsRequest, $30.GetTrackedIncomeTransactionsResponse>(
        'GetTrackedIncomeTransactions',
        getTrackedIncomeTransactions_Pre,
        false,
        false,
        ($core.List<$core.int> value) => $30.GetTrackedIncomeTransactionsRequest.fromBuffer(value),
        ($30.GetTrackedIncomeTransactionsResponse value) => value.writeToBuffer()));
    $addMethod($grpc.ServiceMethod<$30.GetTrackedExpenditureTransactionsRequest, $30.GetTrackedExpenditureTransactionsResponse>(
        'GetTrackedExpenditureTransactions',
        getTrackedExpenditureTransactions_Pre,
        false,
        false,
        ($core.List<$core.int> value) => $30.GetTrackedExpenditureTransactionsRequest.fromBuffer(value),
        ($30.GetTrackedExpenditureTransactionsResponse value) => value.writeToBuffer()));
    $addMethod($grpc.ServiceMethod<$30.GetComprehensiveFinancialSummaryRequest, $30.GetComprehensiveFinancialSummaryResponse>(
        'GetComprehensiveFinancialSummary',
        getComprehensiveFinancialSummary_Pre,
        false,
        false,
        ($core.List<$core.int> value) => $30.GetComprehensiveFinancialSummaryRequest.fromBuffer(value),
        ($30.GetComprehensiveFinancialSummaryResponse value) => value.writeToBuffer()));
  }

  $async.Future<$30.CreateExpenseResponse> createExpense_Pre($grpc.ServiceCall call, $async.Future<$30.CreateExpenseRequest> request) async {
    return createExpense(call, await request);
  }

  $async.Future<$30.GetExpensesResponse> getExpenses_Pre($grpc.ServiceCall call, $async.Future<$30.GetExpensesRequest> request) async {
    return getExpenses(call, await request);
  }

  $async.Future<$30.GetExpenseByIdResponse> getExpenseById_Pre($grpc.ServiceCall call, $async.Future<$30.GetExpenseByIdRequest> request) async {
    return getExpenseById(call, await request);
  }

  $async.Future<$30.UpdateExpenseResponse> updateExpense_Pre($grpc.ServiceCall call, $async.Future<$30.UpdateExpenseRequest> request) async {
    return updateExpense(call, await request);
  }

  $async.Future<$30.DeleteExpenseResponse> deleteExpense_Pre($grpc.ServiceCall call, $async.Future<$30.DeleteExpenseRequest> request) async {
    return deleteExpense(call, await request);
  }

  $async.Future<$30.CreateBudgetResponse> createBudget_Pre($grpc.ServiceCall call, $async.Future<$30.CreateBudgetRequest> request) async {
    return createBudget(call, await request);
  }

  $async.Future<$30.GetBudgetsResponse> getBudgets_Pre($grpc.ServiceCall call, $async.Future<$30.GetBudgetsRequest> request) async {
    return getBudgets(call, await request);
  }

  $async.Future<$30.GetBudgetByIdResponse> getBudgetById_Pre($grpc.ServiceCall call, $async.Future<$30.GetBudgetByIdRequest> request) async {
    return getBudgetById(call, await request);
  }

  $async.Future<$30.UpdateBudgetResponse> updateBudget_Pre($grpc.ServiceCall call, $async.Future<$30.UpdateBudgetRequest> request) async {
    return updateBudget(call, await request);
  }

  $async.Future<$30.DeleteBudgetResponse> deleteBudget_Pre($grpc.ServiceCall call, $async.Future<$30.DeleteBudgetRequest> request) async {
    return deleteBudget(call, await request);
  }

  $async.Future<$30.GetSpendingAnalyticsResponse> getSpendingAnalytics_Pre($grpc.ServiceCall call, $async.Future<$30.GetSpendingAnalyticsRequest> request) async {
    return getSpendingAnalytics(call, await request);
  }

  $async.Future<$30.GetCategoryBreakdownResponse> getCategoryBreakdown_Pre($grpc.ServiceCall call, $async.Future<$30.GetCategoryBreakdownRequest> request) async {
    return getCategoryBreakdown(call, await request);
  }

  $async.Future<$30.GetBudgetProgressResponse> getBudgetProgress_Pre($grpc.ServiceCall call, $async.Future<$30.GetBudgetProgressRequest> request) async {
    return getBudgetProgress(call, await request);
  }

  $async.Future<$30.GetSpendingTrendsResponse> getSpendingTrends_Pre($grpc.ServiceCall call, $async.Future<$30.GetSpendingTrendsRequest> request) async {
    return getSpendingTrends(call, await request);
  }

  $async.Future<$30.GetBudgetAlertsResponse> getBudgetAlerts_Pre($grpc.ServiceCall call, $async.Future<$30.GetBudgetAlertsRequest> request) async {
    return getBudgetAlerts(call, await request);
  }

  $async.Future<$30.MarkAlertAsReadResponse> markAlertAsRead_Pre($grpc.ServiceCall call, $async.Future<$30.MarkAlertAsReadRequest> request) async {
    return markAlertAsRead(call, await request);
  }

  $async.Future<$30.GetAISpendingInsightsResponse> getAISpendingInsights_Pre($grpc.ServiceCall call, $async.Future<$30.GetAISpendingInsightsRequest> request) async {
    return getAISpendingInsights(call, await request);
  }

  $async.Future<$30.GetAIBudgetingRecommendationsResponse> getAIBudgetingRecommendations_Pre($grpc.ServiceCall call, $async.Future<$30.GetAIBudgetingRecommendationsRequest> request) async {
    return getAIBudgetingRecommendations(call, await request);
  }

  $async.Future<$30.AutoCategorizeExpenseResponse> autoCategorizeExpense_Pre($grpc.ServiceCall call, $async.Future<$30.AutoCategorizeExpenseRequest> request) async {
    return autoCategorizeExpense(call, await request);
  }

  $async.Future<$30.GetAIFinancialAdviceResponse> getAIFinancialAdvice_Pre($grpc.ServiceCall call, $async.Future<$30.GetAIFinancialAdviceRequest> request) async {
    return getAIFinancialAdvice(call, await request);
  }

  $async.Future<$30.GetIncomeSourcesResponse> getIncomeSources_Pre($grpc.ServiceCall call, $async.Future<$30.GetIncomeSourcesRequest> request) async {
    return getIncomeSources(call, await request);
  }

  $async.Future<$30.GetIncomeBreakdownResponse> getIncomeBreakdown_Pre($grpc.ServiceCall call, $async.Future<$30.GetIncomeBreakdownRequest> request) async {
    return getIncomeBreakdown(call, await request);
  }

  $async.Future<$30.CreateIncomeSourceResponse> createIncomeSource_Pre($grpc.ServiceCall call, $async.Future<$30.CreateIncomeSourceRequest> request) async {
    return createIncomeSource(call, await request);
  }

  $async.Future<$30.GetInvestmentPortfolioResponse> getInvestmentPortfolio_Pre($grpc.ServiceCall call, $async.Future<$30.GetInvestmentPortfolioRequest> request) async {
    return getInvestmentPortfolio(call, await request);
  }

  $async.Future<$30.CreateInvestmentResponse> createInvestment_Pre($grpc.ServiceCall call, $async.Future<$30.CreateInvestmentRequest> request) async {
    return createInvestment(call, await request);
  }

  $async.Future<$30.GetFinancialGoalsResponse> getFinancialGoals_Pre($grpc.ServiceCall call, $async.Future<$30.GetFinancialGoalsRequest> request) async {
    return getFinancialGoals(call, await request);
  }

  $async.Future<$30.CreateFinancialGoalResponse> createFinancialGoal_Pre($grpc.ServiceCall call, $async.Future<$30.CreateFinancialGoalRequest> request) async {
    return createFinancialGoal(call, await request);
  }

  $async.Future<$30.UpdateFinancialGoalProgressResponse> updateFinancialGoalProgress_Pre($grpc.ServiceCall call, $async.Future<$30.UpdateFinancialGoalProgressRequest> request) async {
    return updateFinancialGoalProgress(call, await request);
  }

  $async.Future<$30.GetSavingsGoalResponse> getSavingsGoal_Pre($grpc.ServiceCall call, $async.Future<$30.GetSavingsGoalRequest> request) async {
    return getSavingsGoal(call, await request);
  }

  $async.Future<$30.CreateOrUpdateSavingsGoalResponse> createOrUpdateSavingsGoal_Pre($grpc.ServiceCall call, $async.Future<$30.CreateOrUpdateSavingsGoalRequest> request) async {
    return createOrUpdateSavingsGoal(call, await request);
  }

  $async.Future<$30.GetUpcomingBillsResponse> getUpcomingBills_Pre($grpc.ServiceCall call, $async.Future<$30.GetUpcomingBillsRequest> request) async {
    return getUpcomingBills(call, await request);
  }

  $async.Future<$30.CreateRecurringBillResponse> createRecurringBill_Pre($grpc.ServiceCall call, $async.Future<$30.CreateRecurringBillRequest> request) async {
    return createRecurringBill(call, await request);
  }

  $async.Future<$30.GetTrackedIncomeResponse> getTrackedIncome_Pre($grpc.ServiceCall call, $async.Future<$30.GetTrackedIncomeRequest> request) async {
    return getTrackedIncome(call, await request);
  }

  $async.Future<$30.GetTrackedExpenditureResponse> getTrackedExpenditure_Pre($grpc.ServiceCall call, $async.Future<$30.GetTrackedExpenditureRequest> request) async {
    return getTrackedExpenditure(call, await request);
  }

  $async.Future<$30.GetTrackedIncomeBreakdownResponse> getTrackedIncomeBreakdown_Pre($grpc.ServiceCall call, $async.Future<$30.GetTrackedIncomeBreakdownRequest> request) async {
    return getTrackedIncomeBreakdown(call, await request);
  }

  $async.Future<$30.GetTrackedExpenditureBreakdownResponse> getTrackedExpenditureBreakdown_Pre($grpc.ServiceCall call, $async.Future<$30.GetTrackedExpenditureBreakdownRequest> request) async {
    return getTrackedExpenditureBreakdown(call, await request);
  }

  $async.Future<$30.GetTrackedIncomeTransactionsResponse> getTrackedIncomeTransactions_Pre($grpc.ServiceCall call, $async.Future<$30.GetTrackedIncomeTransactionsRequest> request) async {
    return getTrackedIncomeTransactions(call, await request);
  }

  $async.Future<$30.GetTrackedExpenditureTransactionsResponse> getTrackedExpenditureTransactions_Pre($grpc.ServiceCall call, $async.Future<$30.GetTrackedExpenditureTransactionsRequest> request) async {
    return getTrackedExpenditureTransactions(call, await request);
  }

  $async.Future<$30.GetComprehensiveFinancialSummaryResponse> getComprehensiveFinancialSummary_Pre($grpc.ServiceCall call, $async.Future<$30.GetComprehensiveFinancialSummaryRequest> request) async {
    return getComprehensiveFinancialSummary(call, await request);
  }

  $async.Future<$30.CreateExpenseResponse> createExpense($grpc.ServiceCall call, $30.CreateExpenseRequest request);
  $async.Future<$30.GetExpensesResponse> getExpenses($grpc.ServiceCall call, $30.GetExpensesRequest request);
  $async.Future<$30.GetExpenseByIdResponse> getExpenseById($grpc.ServiceCall call, $30.GetExpenseByIdRequest request);
  $async.Future<$30.UpdateExpenseResponse> updateExpense($grpc.ServiceCall call, $30.UpdateExpenseRequest request);
  $async.Future<$30.DeleteExpenseResponse> deleteExpense($grpc.ServiceCall call, $30.DeleteExpenseRequest request);
  $async.Future<$30.CreateBudgetResponse> createBudget($grpc.ServiceCall call, $30.CreateBudgetRequest request);
  $async.Future<$30.GetBudgetsResponse> getBudgets($grpc.ServiceCall call, $30.GetBudgetsRequest request);
  $async.Future<$30.GetBudgetByIdResponse> getBudgetById($grpc.ServiceCall call, $30.GetBudgetByIdRequest request);
  $async.Future<$30.UpdateBudgetResponse> updateBudget($grpc.ServiceCall call, $30.UpdateBudgetRequest request);
  $async.Future<$30.DeleteBudgetResponse> deleteBudget($grpc.ServiceCall call, $30.DeleteBudgetRequest request);
  $async.Future<$30.GetSpendingAnalyticsResponse> getSpendingAnalytics($grpc.ServiceCall call, $30.GetSpendingAnalyticsRequest request);
  $async.Future<$30.GetCategoryBreakdownResponse> getCategoryBreakdown($grpc.ServiceCall call, $30.GetCategoryBreakdownRequest request);
  $async.Future<$30.GetBudgetProgressResponse> getBudgetProgress($grpc.ServiceCall call, $30.GetBudgetProgressRequest request);
  $async.Future<$30.GetSpendingTrendsResponse> getSpendingTrends($grpc.ServiceCall call, $30.GetSpendingTrendsRequest request);
  $async.Future<$30.GetBudgetAlertsResponse> getBudgetAlerts($grpc.ServiceCall call, $30.GetBudgetAlertsRequest request);
  $async.Future<$30.MarkAlertAsReadResponse> markAlertAsRead($grpc.ServiceCall call, $30.MarkAlertAsReadRequest request);
  $async.Future<$30.GetAISpendingInsightsResponse> getAISpendingInsights($grpc.ServiceCall call, $30.GetAISpendingInsightsRequest request);
  $async.Future<$30.GetAIBudgetingRecommendationsResponse> getAIBudgetingRecommendations($grpc.ServiceCall call, $30.GetAIBudgetingRecommendationsRequest request);
  $async.Future<$30.AutoCategorizeExpenseResponse> autoCategorizeExpense($grpc.ServiceCall call, $30.AutoCategorizeExpenseRequest request);
  $async.Future<$30.GetAIFinancialAdviceResponse> getAIFinancialAdvice($grpc.ServiceCall call, $30.GetAIFinancialAdviceRequest request);
  $async.Future<$30.GetIncomeSourcesResponse> getIncomeSources($grpc.ServiceCall call, $30.GetIncomeSourcesRequest request);
  $async.Future<$30.GetIncomeBreakdownResponse> getIncomeBreakdown($grpc.ServiceCall call, $30.GetIncomeBreakdownRequest request);
  $async.Future<$30.CreateIncomeSourceResponse> createIncomeSource($grpc.ServiceCall call, $30.CreateIncomeSourceRequest request);
  $async.Future<$30.GetInvestmentPortfolioResponse> getInvestmentPortfolio($grpc.ServiceCall call, $30.GetInvestmentPortfolioRequest request);
  $async.Future<$30.CreateInvestmentResponse> createInvestment($grpc.ServiceCall call, $30.CreateInvestmentRequest request);
  $async.Future<$30.GetFinancialGoalsResponse> getFinancialGoals($grpc.ServiceCall call, $30.GetFinancialGoalsRequest request);
  $async.Future<$30.CreateFinancialGoalResponse> createFinancialGoal($grpc.ServiceCall call, $30.CreateFinancialGoalRequest request);
  $async.Future<$30.UpdateFinancialGoalProgressResponse> updateFinancialGoalProgress($grpc.ServiceCall call, $30.UpdateFinancialGoalProgressRequest request);
  $async.Future<$30.GetSavingsGoalResponse> getSavingsGoal($grpc.ServiceCall call, $30.GetSavingsGoalRequest request);
  $async.Future<$30.CreateOrUpdateSavingsGoalResponse> createOrUpdateSavingsGoal($grpc.ServiceCall call, $30.CreateOrUpdateSavingsGoalRequest request);
  $async.Future<$30.GetUpcomingBillsResponse> getUpcomingBills($grpc.ServiceCall call, $30.GetUpcomingBillsRequest request);
  $async.Future<$30.CreateRecurringBillResponse> createRecurringBill($grpc.ServiceCall call, $30.CreateRecurringBillRequest request);
  $async.Future<$30.GetTrackedIncomeResponse> getTrackedIncome($grpc.ServiceCall call, $30.GetTrackedIncomeRequest request);
  $async.Future<$30.GetTrackedExpenditureResponse> getTrackedExpenditure($grpc.ServiceCall call, $30.GetTrackedExpenditureRequest request);
  $async.Future<$30.GetTrackedIncomeBreakdownResponse> getTrackedIncomeBreakdown($grpc.ServiceCall call, $30.GetTrackedIncomeBreakdownRequest request);
  $async.Future<$30.GetTrackedExpenditureBreakdownResponse> getTrackedExpenditureBreakdown($grpc.ServiceCall call, $30.GetTrackedExpenditureBreakdownRequest request);
  $async.Future<$30.GetTrackedIncomeTransactionsResponse> getTrackedIncomeTransactions($grpc.ServiceCall call, $30.GetTrackedIncomeTransactionsRequest request);
  $async.Future<$30.GetTrackedExpenditureTransactionsResponse> getTrackedExpenditureTransactions($grpc.ServiceCall call, $30.GetTrackedExpenditureTransactionsRequest request);
  $async.Future<$30.GetComprehensiveFinancialSummaryResponse> getComprehensiveFinancialSummary($grpc.ServiceCall call, $30.GetComprehensiveFinancialSummaryRequest request);
}
