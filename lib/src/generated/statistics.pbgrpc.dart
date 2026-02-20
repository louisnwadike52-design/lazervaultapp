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

import 'statistics.pb.dart' as $0;

export 'statistics.pb.dart';

@$pb.GrpcServiceName('pb.StatisticsService')
class StatisticsServiceClient extends $grpc.Client {
  static final _$createExpense = $grpc.ClientMethod<$0.CreateExpenseRequest, $0.CreateExpenseResponse>(
      '/pb.StatisticsService/CreateExpense',
      ($0.CreateExpenseRequest value) => value.writeToBuffer(),
      ($core.List<$core.int> value) => $0.CreateExpenseResponse.fromBuffer(value));
  static final _$getExpenses = $grpc.ClientMethod<$0.GetExpensesRequest, $0.GetExpensesResponse>(
      '/pb.StatisticsService/GetExpenses',
      ($0.GetExpensesRequest value) => value.writeToBuffer(),
      ($core.List<$core.int> value) => $0.GetExpensesResponse.fromBuffer(value));
  static final _$getExpenseById = $grpc.ClientMethod<$0.GetExpenseByIdRequest, $0.GetExpenseByIdResponse>(
      '/pb.StatisticsService/GetExpenseById',
      ($0.GetExpenseByIdRequest value) => value.writeToBuffer(),
      ($core.List<$core.int> value) => $0.GetExpenseByIdResponse.fromBuffer(value));
  static final _$updateExpense = $grpc.ClientMethod<$0.UpdateExpenseRequest, $0.UpdateExpenseResponse>(
      '/pb.StatisticsService/UpdateExpense',
      ($0.UpdateExpenseRequest value) => value.writeToBuffer(),
      ($core.List<$core.int> value) => $0.UpdateExpenseResponse.fromBuffer(value));
  static final _$deleteExpense = $grpc.ClientMethod<$0.DeleteExpenseRequest, $0.DeleteExpenseResponse>(
      '/pb.StatisticsService/DeleteExpense',
      ($0.DeleteExpenseRequest value) => value.writeToBuffer(),
      ($core.List<$core.int> value) => $0.DeleteExpenseResponse.fromBuffer(value));
  static final _$createBudget = $grpc.ClientMethod<$0.CreateBudgetRequest, $0.CreateBudgetResponse>(
      '/pb.StatisticsService/CreateBudget',
      ($0.CreateBudgetRequest value) => value.writeToBuffer(),
      ($core.List<$core.int> value) => $0.CreateBudgetResponse.fromBuffer(value));
  static final _$getBudgets = $grpc.ClientMethod<$0.GetBudgetsRequest, $0.GetBudgetsResponse>(
      '/pb.StatisticsService/GetBudgets',
      ($0.GetBudgetsRequest value) => value.writeToBuffer(),
      ($core.List<$core.int> value) => $0.GetBudgetsResponse.fromBuffer(value));
  static final _$getBudgetById = $grpc.ClientMethod<$0.GetBudgetByIdRequest, $0.GetBudgetByIdResponse>(
      '/pb.StatisticsService/GetBudgetById',
      ($0.GetBudgetByIdRequest value) => value.writeToBuffer(),
      ($core.List<$core.int> value) => $0.GetBudgetByIdResponse.fromBuffer(value));
  static final _$updateBudget = $grpc.ClientMethod<$0.UpdateBudgetRequest, $0.UpdateBudgetResponse>(
      '/pb.StatisticsService/UpdateBudget',
      ($0.UpdateBudgetRequest value) => value.writeToBuffer(),
      ($core.List<$core.int> value) => $0.UpdateBudgetResponse.fromBuffer(value));
  static final _$deleteBudget = $grpc.ClientMethod<$0.DeleteBudgetRequest, $0.DeleteBudgetResponse>(
      '/pb.StatisticsService/DeleteBudget',
      ($0.DeleteBudgetRequest value) => value.writeToBuffer(),
      ($core.List<$core.int> value) => $0.DeleteBudgetResponse.fromBuffer(value));
  static final _$getSpendingAnalytics = $grpc.ClientMethod<$0.GetSpendingAnalyticsRequest, $0.GetSpendingAnalyticsResponse>(
      '/pb.StatisticsService/GetSpendingAnalytics',
      ($0.GetSpendingAnalyticsRequest value) => value.writeToBuffer(),
      ($core.List<$core.int> value) => $0.GetSpendingAnalyticsResponse.fromBuffer(value));
  static final _$getCategoryBreakdown = $grpc.ClientMethod<$0.GetCategoryBreakdownRequest, $0.GetCategoryBreakdownResponse>(
      '/pb.StatisticsService/GetCategoryBreakdown',
      ($0.GetCategoryBreakdownRequest value) => value.writeToBuffer(),
      ($core.List<$core.int> value) => $0.GetCategoryBreakdownResponse.fromBuffer(value));
  static final _$getBudgetProgress = $grpc.ClientMethod<$0.GetBudgetProgressRequest, $0.GetBudgetProgressResponse>(
      '/pb.StatisticsService/GetBudgetProgress',
      ($0.GetBudgetProgressRequest value) => value.writeToBuffer(),
      ($core.List<$core.int> value) => $0.GetBudgetProgressResponse.fromBuffer(value));
  static final _$getSpendingTrends = $grpc.ClientMethod<$0.GetSpendingTrendsRequest, $0.GetSpendingTrendsResponse>(
      '/pb.StatisticsService/GetSpendingTrends',
      ($0.GetSpendingTrendsRequest value) => value.writeToBuffer(),
      ($core.List<$core.int> value) => $0.GetSpendingTrendsResponse.fromBuffer(value));
  static final _$getBudgetAlerts = $grpc.ClientMethod<$0.GetBudgetAlertsRequest, $0.GetBudgetAlertsResponse>(
      '/pb.StatisticsService/GetBudgetAlerts',
      ($0.GetBudgetAlertsRequest value) => value.writeToBuffer(),
      ($core.List<$core.int> value) => $0.GetBudgetAlertsResponse.fromBuffer(value));
  static final _$markAlertAsRead = $grpc.ClientMethod<$0.MarkAlertAsReadRequest, $0.MarkAlertAsReadResponse>(
      '/pb.StatisticsService/MarkAlertAsRead',
      ($0.MarkAlertAsReadRequest value) => value.writeToBuffer(),
      ($core.List<$core.int> value) => $0.MarkAlertAsReadResponse.fromBuffer(value));
  static final _$getAISpendingInsights = $grpc.ClientMethod<$0.GetAISpendingInsightsRequest, $0.GetAISpendingInsightsResponse>(
      '/pb.StatisticsService/GetAISpendingInsights',
      ($0.GetAISpendingInsightsRequest value) => value.writeToBuffer(),
      ($core.List<$core.int> value) => $0.GetAISpendingInsightsResponse.fromBuffer(value));
  static final _$getAIBudgetingRecommendations = $grpc.ClientMethod<$0.GetAIBudgetingRecommendationsRequest, $0.GetAIBudgetingRecommendationsResponse>(
      '/pb.StatisticsService/GetAIBudgetingRecommendations',
      ($0.GetAIBudgetingRecommendationsRequest value) => value.writeToBuffer(),
      ($core.List<$core.int> value) => $0.GetAIBudgetingRecommendationsResponse.fromBuffer(value));
  static final _$autoCategorizeExpense = $grpc.ClientMethod<$0.AutoCategorizeExpenseRequest, $0.AutoCategorizeExpenseResponse>(
      '/pb.StatisticsService/AutoCategorizeExpense',
      ($0.AutoCategorizeExpenseRequest value) => value.writeToBuffer(),
      ($core.List<$core.int> value) => $0.AutoCategorizeExpenseResponse.fromBuffer(value));
  static final _$getAIFinancialAdvice = $grpc.ClientMethod<$0.GetAIFinancialAdviceRequest, $0.GetAIFinancialAdviceResponse>(
      '/pb.StatisticsService/GetAIFinancialAdvice',
      ($0.GetAIFinancialAdviceRequest value) => value.writeToBuffer(),
      ($core.List<$core.int> value) => $0.GetAIFinancialAdviceResponse.fromBuffer(value));
  static final _$getIncomeSources = $grpc.ClientMethod<$0.GetIncomeSourcesRequest, $0.GetIncomeSourcesResponse>(
      '/pb.StatisticsService/GetIncomeSources',
      ($0.GetIncomeSourcesRequest value) => value.writeToBuffer(),
      ($core.List<$core.int> value) => $0.GetIncomeSourcesResponse.fromBuffer(value));
  static final _$getIncomeBreakdown = $grpc.ClientMethod<$0.GetIncomeBreakdownRequest, $0.GetIncomeBreakdownResponse>(
      '/pb.StatisticsService/GetIncomeBreakdown',
      ($0.GetIncomeBreakdownRequest value) => value.writeToBuffer(),
      ($core.List<$core.int> value) => $0.GetIncomeBreakdownResponse.fromBuffer(value));
  static final _$createIncomeSource = $grpc.ClientMethod<$0.CreateIncomeSourceRequest, $0.CreateIncomeSourceResponse>(
      '/pb.StatisticsService/CreateIncomeSource',
      ($0.CreateIncomeSourceRequest value) => value.writeToBuffer(),
      ($core.List<$core.int> value) => $0.CreateIncomeSourceResponse.fromBuffer(value));
  static final _$getInvestmentPortfolio = $grpc.ClientMethod<$0.GetInvestmentPortfolioRequest, $0.GetInvestmentPortfolioResponse>(
      '/pb.StatisticsService/GetInvestmentPortfolio',
      ($0.GetInvestmentPortfolioRequest value) => value.writeToBuffer(),
      ($core.List<$core.int> value) => $0.GetInvestmentPortfolioResponse.fromBuffer(value));
  static final _$createInvestment = $grpc.ClientMethod<$0.CreateInvestmentRequest, $0.CreateInvestmentResponse>(
      '/pb.StatisticsService/CreateInvestment',
      ($0.CreateInvestmentRequest value) => value.writeToBuffer(),
      ($core.List<$core.int> value) => $0.CreateInvestmentResponse.fromBuffer(value));
  static final _$getFinancialGoals = $grpc.ClientMethod<$0.GetFinancialGoalsRequest, $0.GetFinancialGoalsResponse>(
      '/pb.StatisticsService/GetFinancialGoals',
      ($0.GetFinancialGoalsRequest value) => value.writeToBuffer(),
      ($core.List<$core.int> value) => $0.GetFinancialGoalsResponse.fromBuffer(value));
  static final _$createFinancialGoal = $grpc.ClientMethod<$0.CreateFinancialGoalRequest, $0.CreateFinancialGoalResponse>(
      '/pb.StatisticsService/CreateFinancialGoal',
      ($0.CreateFinancialGoalRequest value) => value.writeToBuffer(),
      ($core.List<$core.int> value) => $0.CreateFinancialGoalResponse.fromBuffer(value));
  static final _$updateFinancialGoalProgress = $grpc.ClientMethod<$0.UpdateFinancialGoalProgressRequest, $0.UpdateFinancialGoalProgressResponse>(
      '/pb.StatisticsService/UpdateFinancialGoalProgress',
      ($0.UpdateFinancialGoalProgressRequest value) => value.writeToBuffer(),
      ($core.List<$core.int> value) => $0.UpdateFinancialGoalProgressResponse.fromBuffer(value));
  static final _$getSavingsGoal = $grpc.ClientMethod<$0.GetSavingsGoalRequest, $0.GetSavingsGoalResponse>(
      '/pb.StatisticsService/GetSavingsGoal',
      ($0.GetSavingsGoalRequest value) => value.writeToBuffer(),
      ($core.List<$core.int> value) => $0.GetSavingsGoalResponse.fromBuffer(value));
  static final _$createOrUpdateSavingsGoal = $grpc.ClientMethod<$0.CreateOrUpdateSavingsGoalRequest, $0.CreateOrUpdateSavingsGoalResponse>(
      '/pb.StatisticsService/CreateOrUpdateSavingsGoal',
      ($0.CreateOrUpdateSavingsGoalRequest value) => value.writeToBuffer(),
      ($core.List<$core.int> value) => $0.CreateOrUpdateSavingsGoalResponse.fromBuffer(value));
  static final _$getUpcomingBills = $grpc.ClientMethod<$0.GetUpcomingBillsRequest, $0.GetUpcomingBillsResponse>(
      '/pb.StatisticsService/GetUpcomingBills',
      ($0.GetUpcomingBillsRequest value) => value.writeToBuffer(),
      ($core.List<$core.int> value) => $0.GetUpcomingBillsResponse.fromBuffer(value));
  static final _$createRecurringBill = $grpc.ClientMethod<$0.CreateRecurringBillRequest, $0.CreateRecurringBillResponse>(
      '/pb.StatisticsService/CreateRecurringBill',
      ($0.CreateRecurringBillRequest value) => value.writeToBuffer(),
      ($core.List<$core.int> value) => $0.CreateRecurringBillResponse.fromBuffer(value));
  static final _$getTrackedIncome = $grpc.ClientMethod<$0.GetTrackedIncomeRequest, $0.GetTrackedIncomeResponse>(
      '/pb.StatisticsService/GetTrackedIncome',
      ($0.GetTrackedIncomeRequest value) => value.writeToBuffer(),
      ($core.List<$core.int> value) => $0.GetTrackedIncomeResponse.fromBuffer(value));
  static final _$getTrackedExpenditure = $grpc.ClientMethod<$0.GetTrackedExpenditureRequest, $0.GetTrackedExpenditureResponse>(
      '/pb.StatisticsService/GetTrackedExpenditure',
      ($0.GetTrackedExpenditureRequest value) => value.writeToBuffer(),
      ($core.List<$core.int> value) => $0.GetTrackedExpenditureResponse.fromBuffer(value));
  static final _$getTrackedIncomeBreakdown = $grpc.ClientMethod<$0.GetTrackedIncomeBreakdownRequest, $0.GetTrackedIncomeBreakdownResponse>(
      '/pb.StatisticsService/GetTrackedIncomeBreakdown',
      ($0.GetTrackedIncomeBreakdownRequest value) => value.writeToBuffer(),
      ($core.List<$core.int> value) => $0.GetTrackedIncomeBreakdownResponse.fromBuffer(value));
  static final _$getTrackedExpenditureBreakdown = $grpc.ClientMethod<$0.GetTrackedExpenditureBreakdownRequest, $0.GetTrackedExpenditureBreakdownResponse>(
      '/pb.StatisticsService/GetTrackedExpenditureBreakdown',
      ($0.GetTrackedExpenditureBreakdownRequest value) => value.writeToBuffer(),
      ($core.List<$core.int> value) => $0.GetTrackedExpenditureBreakdownResponse.fromBuffer(value));
  static final _$getTrackedIncomeTransactions = $grpc.ClientMethod<$0.GetTrackedIncomeTransactionsRequest, $0.GetTrackedIncomeTransactionsResponse>(
      '/pb.StatisticsService/GetTrackedIncomeTransactions',
      ($0.GetTrackedIncomeTransactionsRequest value) => value.writeToBuffer(),
      ($core.List<$core.int> value) => $0.GetTrackedIncomeTransactionsResponse.fromBuffer(value));
  static final _$getTrackedExpenditureTransactions = $grpc.ClientMethod<$0.GetTrackedExpenditureTransactionsRequest, $0.GetTrackedExpenditureTransactionsResponse>(
      '/pb.StatisticsService/GetTrackedExpenditureTransactions',
      ($0.GetTrackedExpenditureTransactionsRequest value) => value.writeToBuffer(),
      ($core.List<$core.int> value) => $0.GetTrackedExpenditureTransactionsResponse.fromBuffer(value));
  static final _$getComprehensiveFinancialSummary = $grpc.ClientMethod<$0.GetComprehensiveFinancialSummaryRequest, $0.GetComprehensiveFinancialSummaryResponse>(
      '/pb.StatisticsService/GetComprehensiveFinancialSummary',
      ($0.GetComprehensiveFinancialSummaryRequest value) => value.writeToBuffer(),
      ($core.List<$core.int> value) => $0.GetComprehensiveFinancialSummaryResponse.fromBuffer(value));
  static final _$validateCategoryBudget = $grpc.ClientMethod<$0.ValidateCategoryBudgetRequest, $0.ValidateCategoryBudgetResponse>(
      '/pb.StatisticsService/ValidateCategoryBudget',
      ($0.ValidateCategoryBudgetRequest value) => value.writeToBuffer(),
      ($core.List<$core.int> value) => $0.ValidateCategoryBudgetResponse.fromBuffer(value));
  static final _$getServiceCategories = $grpc.ClientMethod<$0.GetServiceCategoriesRequest, $0.GetServiceCategoriesResponse>(
      '/pb.StatisticsService/GetServiceCategories',
      ($0.GetServiceCategoriesRequest value) => value.writeToBuffer(),
      ($core.List<$core.int> value) => $0.GetServiceCategoriesResponse.fromBuffer(value));

  StatisticsServiceClient($grpc.ClientChannel channel,
      {$grpc.CallOptions? options,
      $core.Iterable<$grpc.ClientInterceptor>? interceptors})
      : super(channel, options: options,
        interceptors: interceptors);

  $grpc.ResponseFuture<$0.CreateExpenseResponse> createExpense($0.CreateExpenseRequest request, {$grpc.CallOptions? options}) {
    return $createUnaryCall(_$createExpense, request, options: options);
  }

  $grpc.ResponseFuture<$0.GetExpensesResponse> getExpenses($0.GetExpensesRequest request, {$grpc.CallOptions? options}) {
    return $createUnaryCall(_$getExpenses, request, options: options);
  }

  $grpc.ResponseFuture<$0.GetExpenseByIdResponse> getExpenseById($0.GetExpenseByIdRequest request, {$grpc.CallOptions? options}) {
    return $createUnaryCall(_$getExpenseById, request, options: options);
  }

  $grpc.ResponseFuture<$0.UpdateExpenseResponse> updateExpense($0.UpdateExpenseRequest request, {$grpc.CallOptions? options}) {
    return $createUnaryCall(_$updateExpense, request, options: options);
  }

  $grpc.ResponseFuture<$0.DeleteExpenseResponse> deleteExpense($0.DeleteExpenseRequest request, {$grpc.CallOptions? options}) {
    return $createUnaryCall(_$deleteExpense, request, options: options);
  }

  $grpc.ResponseFuture<$0.CreateBudgetResponse> createBudget($0.CreateBudgetRequest request, {$grpc.CallOptions? options}) {
    return $createUnaryCall(_$createBudget, request, options: options);
  }

  $grpc.ResponseFuture<$0.GetBudgetsResponse> getBudgets($0.GetBudgetsRequest request, {$grpc.CallOptions? options}) {
    return $createUnaryCall(_$getBudgets, request, options: options);
  }

  $grpc.ResponseFuture<$0.GetBudgetByIdResponse> getBudgetById($0.GetBudgetByIdRequest request, {$grpc.CallOptions? options}) {
    return $createUnaryCall(_$getBudgetById, request, options: options);
  }

  $grpc.ResponseFuture<$0.UpdateBudgetResponse> updateBudget($0.UpdateBudgetRequest request, {$grpc.CallOptions? options}) {
    return $createUnaryCall(_$updateBudget, request, options: options);
  }

  $grpc.ResponseFuture<$0.DeleteBudgetResponse> deleteBudget($0.DeleteBudgetRequest request, {$grpc.CallOptions? options}) {
    return $createUnaryCall(_$deleteBudget, request, options: options);
  }

  $grpc.ResponseFuture<$0.GetSpendingAnalyticsResponse> getSpendingAnalytics($0.GetSpendingAnalyticsRequest request, {$grpc.CallOptions? options}) {
    return $createUnaryCall(_$getSpendingAnalytics, request, options: options);
  }

  $grpc.ResponseFuture<$0.GetCategoryBreakdownResponse> getCategoryBreakdown($0.GetCategoryBreakdownRequest request, {$grpc.CallOptions? options}) {
    return $createUnaryCall(_$getCategoryBreakdown, request, options: options);
  }

  $grpc.ResponseFuture<$0.GetBudgetProgressResponse> getBudgetProgress($0.GetBudgetProgressRequest request, {$grpc.CallOptions? options}) {
    return $createUnaryCall(_$getBudgetProgress, request, options: options);
  }

  $grpc.ResponseFuture<$0.GetSpendingTrendsResponse> getSpendingTrends($0.GetSpendingTrendsRequest request, {$grpc.CallOptions? options}) {
    return $createUnaryCall(_$getSpendingTrends, request, options: options);
  }

  $grpc.ResponseFuture<$0.GetBudgetAlertsResponse> getBudgetAlerts($0.GetBudgetAlertsRequest request, {$grpc.CallOptions? options}) {
    return $createUnaryCall(_$getBudgetAlerts, request, options: options);
  }

  $grpc.ResponseFuture<$0.MarkAlertAsReadResponse> markAlertAsRead($0.MarkAlertAsReadRequest request, {$grpc.CallOptions? options}) {
    return $createUnaryCall(_$markAlertAsRead, request, options: options);
  }

  $grpc.ResponseFuture<$0.GetAISpendingInsightsResponse> getAISpendingInsights($0.GetAISpendingInsightsRequest request, {$grpc.CallOptions? options}) {
    return $createUnaryCall(_$getAISpendingInsights, request, options: options);
  }

  $grpc.ResponseFuture<$0.GetAIBudgetingRecommendationsResponse> getAIBudgetingRecommendations($0.GetAIBudgetingRecommendationsRequest request, {$grpc.CallOptions? options}) {
    return $createUnaryCall(_$getAIBudgetingRecommendations, request, options: options);
  }

  $grpc.ResponseFuture<$0.AutoCategorizeExpenseResponse> autoCategorizeExpense($0.AutoCategorizeExpenseRequest request, {$grpc.CallOptions? options}) {
    return $createUnaryCall(_$autoCategorizeExpense, request, options: options);
  }

  $grpc.ResponseFuture<$0.GetAIFinancialAdviceResponse> getAIFinancialAdvice($0.GetAIFinancialAdviceRequest request, {$grpc.CallOptions? options}) {
    return $createUnaryCall(_$getAIFinancialAdvice, request, options: options);
  }

  $grpc.ResponseFuture<$0.GetIncomeSourcesResponse> getIncomeSources($0.GetIncomeSourcesRequest request, {$grpc.CallOptions? options}) {
    return $createUnaryCall(_$getIncomeSources, request, options: options);
  }

  $grpc.ResponseFuture<$0.GetIncomeBreakdownResponse> getIncomeBreakdown($0.GetIncomeBreakdownRequest request, {$grpc.CallOptions? options}) {
    return $createUnaryCall(_$getIncomeBreakdown, request, options: options);
  }

  $grpc.ResponseFuture<$0.CreateIncomeSourceResponse> createIncomeSource($0.CreateIncomeSourceRequest request, {$grpc.CallOptions? options}) {
    return $createUnaryCall(_$createIncomeSource, request, options: options);
  }

  $grpc.ResponseFuture<$0.GetInvestmentPortfolioResponse> getInvestmentPortfolio($0.GetInvestmentPortfolioRequest request, {$grpc.CallOptions? options}) {
    return $createUnaryCall(_$getInvestmentPortfolio, request, options: options);
  }

  $grpc.ResponseFuture<$0.CreateInvestmentResponse> createInvestment($0.CreateInvestmentRequest request, {$grpc.CallOptions? options}) {
    return $createUnaryCall(_$createInvestment, request, options: options);
  }

  $grpc.ResponseFuture<$0.GetFinancialGoalsResponse> getFinancialGoals($0.GetFinancialGoalsRequest request, {$grpc.CallOptions? options}) {
    return $createUnaryCall(_$getFinancialGoals, request, options: options);
  }

  $grpc.ResponseFuture<$0.CreateFinancialGoalResponse> createFinancialGoal($0.CreateFinancialGoalRequest request, {$grpc.CallOptions? options}) {
    return $createUnaryCall(_$createFinancialGoal, request, options: options);
  }

  $grpc.ResponseFuture<$0.UpdateFinancialGoalProgressResponse> updateFinancialGoalProgress($0.UpdateFinancialGoalProgressRequest request, {$grpc.CallOptions? options}) {
    return $createUnaryCall(_$updateFinancialGoalProgress, request, options: options);
  }

  $grpc.ResponseFuture<$0.GetSavingsGoalResponse> getSavingsGoal($0.GetSavingsGoalRequest request, {$grpc.CallOptions? options}) {
    return $createUnaryCall(_$getSavingsGoal, request, options: options);
  }

  $grpc.ResponseFuture<$0.CreateOrUpdateSavingsGoalResponse> createOrUpdateSavingsGoal($0.CreateOrUpdateSavingsGoalRequest request, {$grpc.CallOptions? options}) {
    return $createUnaryCall(_$createOrUpdateSavingsGoal, request, options: options);
  }

  $grpc.ResponseFuture<$0.GetUpcomingBillsResponse> getUpcomingBills($0.GetUpcomingBillsRequest request, {$grpc.CallOptions? options}) {
    return $createUnaryCall(_$getUpcomingBills, request, options: options);
  }

  $grpc.ResponseFuture<$0.CreateRecurringBillResponse> createRecurringBill($0.CreateRecurringBillRequest request, {$grpc.CallOptions? options}) {
    return $createUnaryCall(_$createRecurringBill, request, options: options);
  }

  $grpc.ResponseFuture<$0.GetTrackedIncomeResponse> getTrackedIncome($0.GetTrackedIncomeRequest request, {$grpc.CallOptions? options}) {
    return $createUnaryCall(_$getTrackedIncome, request, options: options);
  }

  $grpc.ResponseFuture<$0.GetTrackedExpenditureResponse> getTrackedExpenditure($0.GetTrackedExpenditureRequest request, {$grpc.CallOptions? options}) {
    return $createUnaryCall(_$getTrackedExpenditure, request, options: options);
  }

  $grpc.ResponseFuture<$0.GetTrackedIncomeBreakdownResponse> getTrackedIncomeBreakdown($0.GetTrackedIncomeBreakdownRequest request, {$grpc.CallOptions? options}) {
    return $createUnaryCall(_$getTrackedIncomeBreakdown, request, options: options);
  }

  $grpc.ResponseFuture<$0.GetTrackedExpenditureBreakdownResponse> getTrackedExpenditureBreakdown($0.GetTrackedExpenditureBreakdownRequest request, {$grpc.CallOptions? options}) {
    return $createUnaryCall(_$getTrackedExpenditureBreakdown, request, options: options);
  }

  $grpc.ResponseFuture<$0.GetTrackedIncomeTransactionsResponse> getTrackedIncomeTransactions($0.GetTrackedIncomeTransactionsRequest request, {$grpc.CallOptions? options}) {
    return $createUnaryCall(_$getTrackedIncomeTransactions, request, options: options);
  }

  $grpc.ResponseFuture<$0.GetTrackedExpenditureTransactionsResponse> getTrackedExpenditureTransactions($0.GetTrackedExpenditureTransactionsRequest request, {$grpc.CallOptions? options}) {
    return $createUnaryCall(_$getTrackedExpenditureTransactions, request, options: options);
  }

  $grpc.ResponseFuture<$0.GetComprehensiveFinancialSummaryResponse> getComprehensiveFinancialSummary($0.GetComprehensiveFinancialSummaryRequest request, {$grpc.CallOptions? options}) {
    return $createUnaryCall(_$getComprehensiveFinancialSummary, request, options: options);
  }

  $grpc.ResponseFuture<$0.ValidateCategoryBudgetResponse> validateCategoryBudget($0.ValidateCategoryBudgetRequest request, {$grpc.CallOptions? options}) {
    return $createUnaryCall(_$validateCategoryBudget, request, options: options);
  }

  $grpc.ResponseFuture<$0.GetServiceCategoriesResponse> getServiceCategories($0.GetServiceCategoriesRequest request, {$grpc.CallOptions? options}) {
    return $createUnaryCall(_$getServiceCategories, request, options: options);
  }
}

@$pb.GrpcServiceName('pb.StatisticsService')
abstract class StatisticsServiceBase extends $grpc.Service {
  $core.String get $name => 'pb.StatisticsService';

  StatisticsServiceBase() {
    $addMethod($grpc.ServiceMethod<$0.CreateExpenseRequest, $0.CreateExpenseResponse>(
        'CreateExpense',
        createExpense_Pre,
        false,
        false,
        ($core.List<$core.int> value) => $0.CreateExpenseRequest.fromBuffer(value),
        ($0.CreateExpenseResponse value) => value.writeToBuffer()));
    $addMethod($grpc.ServiceMethod<$0.GetExpensesRequest, $0.GetExpensesResponse>(
        'GetExpenses',
        getExpenses_Pre,
        false,
        false,
        ($core.List<$core.int> value) => $0.GetExpensesRequest.fromBuffer(value),
        ($0.GetExpensesResponse value) => value.writeToBuffer()));
    $addMethod($grpc.ServiceMethod<$0.GetExpenseByIdRequest, $0.GetExpenseByIdResponse>(
        'GetExpenseById',
        getExpenseById_Pre,
        false,
        false,
        ($core.List<$core.int> value) => $0.GetExpenseByIdRequest.fromBuffer(value),
        ($0.GetExpenseByIdResponse value) => value.writeToBuffer()));
    $addMethod($grpc.ServiceMethod<$0.UpdateExpenseRequest, $0.UpdateExpenseResponse>(
        'UpdateExpense',
        updateExpense_Pre,
        false,
        false,
        ($core.List<$core.int> value) => $0.UpdateExpenseRequest.fromBuffer(value),
        ($0.UpdateExpenseResponse value) => value.writeToBuffer()));
    $addMethod($grpc.ServiceMethod<$0.DeleteExpenseRequest, $0.DeleteExpenseResponse>(
        'DeleteExpense',
        deleteExpense_Pre,
        false,
        false,
        ($core.List<$core.int> value) => $0.DeleteExpenseRequest.fromBuffer(value),
        ($0.DeleteExpenseResponse value) => value.writeToBuffer()));
    $addMethod($grpc.ServiceMethod<$0.CreateBudgetRequest, $0.CreateBudgetResponse>(
        'CreateBudget',
        createBudget_Pre,
        false,
        false,
        ($core.List<$core.int> value) => $0.CreateBudgetRequest.fromBuffer(value),
        ($0.CreateBudgetResponse value) => value.writeToBuffer()));
    $addMethod($grpc.ServiceMethod<$0.GetBudgetsRequest, $0.GetBudgetsResponse>(
        'GetBudgets',
        getBudgets_Pre,
        false,
        false,
        ($core.List<$core.int> value) => $0.GetBudgetsRequest.fromBuffer(value),
        ($0.GetBudgetsResponse value) => value.writeToBuffer()));
    $addMethod($grpc.ServiceMethod<$0.GetBudgetByIdRequest, $0.GetBudgetByIdResponse>(
        'GetBudgetById',
        getBudgetById_Pre,
        false,
        false,
        ($core.List<$core.int> value) => $0.GetBudgetByIdRequest.fromBuffer(value),
        ($0.GetBudgetByIdResponse value) => value.writeToBuffer()));
    $addMethod($grpc.ServiceMethod<$0.UpdateBudgetRequest, $0.UpdateBudgetResponse>(
        'UpdateBudget',
        updateBudget_Pre,
        false,
        false,
        ($core.List<$core.int> value) => $0.UpdateBudgetRequest.fromBuffer(value),
        ($0.UpdateBudgetResponse value) => value.writeToBuffer()));
    $addMethod($grpc.ServiceMethod<$0.DeleteBudgetRequest, $0.DeleteBudgetResponse>(
        'DeleteBudget',
        deleteBudget_Pre,
        false,
        false,
        ($core.List<$core.int> value) => $0.DeleteBudgetRequest.fromBuffer(value),
        ($0.DeleteBudgetResponse value) => value.writeToBuffer()));
    $addMethod($grpc.ServiceMethod<$0.GetSpendingAnalyticsRequest, $0.GetSpendingAnalyticsResponse>(
        'GetSpendingAnalytics',
        getSpendingAnalytics_Pre,
        false,
        false,
        ($core.List<$core.int> value) => $0.GetSpendingAnalyticsRequest.fromBuffer(value),
        ($0.GetSpendingAnalyticsResponse value) => value.writeToBuffer()));
    $addMethod($grpc.ServiceMethod<$0.GetCategoryBreakdownRequest, $0.GetCategoryBreakdownResponse>(
        'GetCategoryBreakdown',
        getCategoryBreakdown_Pre,
        false,
        false,
        ($core.List<$core.int> value) => $0.GetCategoryBreakdownRequest.fromBuffer(value),
        ($0.GetCategoryBreakdownResponse value) => value.writeToBuffer()));
    $addMethod($grpc.ServiceMethod<$0.GetBudgetProgressRequest, $0.GetBudgetProgressResponse>(
        'GetBudgetProgress',
        getBudgetProgress_Pre,
        false,
        false,
        ($core.List<$core.int> value) => $0.GetBudgetProgressRequest.fromBuffer(value),
        ($0.GetBudgetProgressResponse value) => value.writeToBuffer()));
    $addMethod($grpc.ServiceMethod<$0.GetSpendingTrendsRequest, $0.GetSpendingTrendsResponse>(
        'GetSpendingTrends',
        getSpendingTrends_Pre,
        false,
        false,
        ($core.List<$core.int> value) => $0.GetSpendingTrendsRequest.fromBuffer(value),
        ($0.GetSpendingTrendsResponse value) => value.writeToBuffer()));
    $addMethod($grpc.ServiceMethod<$0.GetBudgetAlertsRequest, $0.GetBudgetAlertsResponse>(
        'GetBudgetAlerts',
        getBudgetAlerts_Pre,
        false,
        false,
        ($core.List<$core.int> value) => $0.GetBudgetAlertsRequest.fromBuffer(value),
        ($0.GetBudgetAlertsResponse value) => value.writeToBuffer()));
    $addMethod($grpc.ServiceMethod<$0.MarkAlertAsReadRequest, $0.MarkAlertAsReadResponse>(
        'MarkAlertAsRead',
        markAlertAsRead_Pre,
        false,
        false,
        ($core.List<$core.int> value) => $0.MarkAlertAsReadRequest.fromBuffer(value),
        ($0.MarkAlertAsReadResponse value) => value.writeToBuffer()));
    $addMethod($grpc.ServiceMethod<$0.GetAISpendingInsightsRequest, $0.GetAISpendingInsightsResponse>(
        'GetAISpendingInsights',
        getAISpendingInsights_Pre,
        false,
        false,
        ($core.List<$core.int> value) => $0.GetAISpendingInsightsRequest.fromBuffer(value),
        ($0.GetAISpendingInsightsResponse value) => value.writeToBuffer()));
    $addMethod($grpc.ServiceMethod<$0.GetAIBudgetingRecommendationsRequest, $0.GetAIBudgetingRecommendationsResponse>(
        'GetAIBudgetingRecommendations',
        getAIBudgetingRecommendations_Pre,
        false,
        false,
        ($core.List<$core.int> value) => $0.GetAIBudgetingRecommendationsRequest.fromBuffer(value),
        ($0.GetAIBudgetingRecommendationsResponse value) => value.writeToBuffer()));
    $addMethod($grpc.ServiceMethod<$0.AutoCategorizeExpenseRequest, $0.AutoCategorizeExpenseResponse>(
        'AutoCategorizeExpense',
        autoCategorizeExpense_Pre,
        false,
        false,
        ($core.List<$core.int> value) => $0.AutoCategorizeExpenseRequest.fromBuffer(value),
        ($0.AutoCategorizeExpenseResponse value) => value.writeToBuffer()));
    $addMethod($grpc.ServiceMethod<$0.GetAIFinancialAdviceRequest, $0.GetAIFinancialAdviceResponse>(
        'GetAIFinancialAdvice',
        getAIFinancialAdvice_Pre,
        false,
        false,
        ($core.List<$core.int> value) => $0.GetAIFinancialAdviceRequest.fromBuffer(value),
        ($0.GetAIFinancialAdviceResponse value) => value.writeToBuffer()));
    $addMethod($grpc.ServiceMethod<$0.GetIncomeSourcesRequest, $0.GetIncomeSourcesResponse>(
        'GetIncomeSources',
        getIncomeSources_Pre,
        false,
        false,
        ($core.List<$core.int> value) => $0.GetIncomeSourcesRequest.fromBuffer(value),
        ($0.GetIncomeSourcesResponse value) => value.writeToBuffer()));
    $addMethod($grpc.ServiceMethod<$0.GetIncomeBreakdownRequest, $0.GetIncomeBreakdownResponse>(
        'GetIncomeBreakdown',
        getIncomeBreakdown_Pre,
        false,
        false,
        ($core.List<$core.int> value) => $0.GetIncomeBreakdownRequest.fromBuffer(value),
        ($0.GetIncomeBreakdownResponse value) => value.writeToBuffer()));
    $addMethod($grpc.ServiceMethod<$0.CreateIncomeSourceRequest, $0.CreateIncomeSourceResponse>(
        'CreateIncomeSource',
        createIncomeSource_Pre,
        false,
        false,
        ($core.List<$core.int> value) => $0.CreateIncomeSourceRequest.fromBuffer(value),
        ($0.CreateIncomeSourceResponse value) => value.writeToBuffer()));
    $addMethod($grpc.ServiceMethod<$0.GetInvestmentPortfolioRequest, $0.GetInvestmentPortfolioResponse>(
        'GetInvestmentPortfolio',
        getInvestmentPortfolio_Pre,
        false,
        false,
        ($core.List<$core.int> value) => $0.GetInvestmentPortfolioRequest.fromBuffer(value),
        ($0.GetInvestmentPortfolioResponse value) => value.writeToBuffer()));
    $addMethod($grpc.ServiceMethod<$0.CreateInvestmentRequest, $0.CreateInvestmentResponse>(
        'CreateInvestment',
        createInvestment_Pre,
        false,
        false,
        ($core.List<$core.int> value) => $0.CreateInvestmentRequest.fromBuffer(value),
        ($0.CreateInvestmentResponse value) => value.writeToBuffer()));
    $addMethod($grpc.ServiceMethod<$0.GetFinancialGoalsRequest, $0.GetFinancialGoalsResponse>(
        'GetFinancialGoals',
        getFinancialGoals_Pre,
        false,
        false,
        ($core.List<$core.int> value) => $0.GetFinancialGoalsRequest.fromBuffer(value),
        ($0.GetFinancialGoalsResponse value) => value.writeToBuffer()));
    $addMethod($grpc.ServiceMethod<$0.CreateFinancialGoalRequest, $0.CreateFinancialGoalResponse>(
        'CreateFinancialGoal',
        createFinancialGoal_Pre,
        false,
        false,
        ($core.List<$core.int> value) => $0.CreateFinancialGoalRequest.fromBuffer(value),
        ($0.CreateFinancialGoalResponse value) => value.writeToBuffer()));
    $addMethod($grpc.ServiceMethod<$0.UpdateFinancialGoalProgressRequest, $0.UpdateFinancialGoalProgressResponse>(
        'UpdateFinancialGoalProgress',
        updateFinancialGoalProgress_Pre,
        false,
        false,
        ($core.List<$core.int> value) => $0.UpdateFinancialGoalProgressRequest.fromBuffer(value),
        ($0.UpdateFinancialGoalProgressResponse value) => value.writeToBuffer()));
    $addMethod($grpc.ServiceMethod<$0.GetSavingsGoalRequest, $0.GetSavingsGoalResponse>(
        'GetSavingsGoal',
        getSavingsGoal_Pre,
        false,
        false,
        ($core.List<$core.int> value) => $0.GetSavingsGoalRequest.fromBuffer(value),
        ($0.GetSavingsGoalResponse value) => value.writeToBuffer()));
    $addMethod($grpc.ServiceMethod<$0.CreateOrUpdateSavingsGoalRequest, $0.CreateOrUpdateSavingsGoalResponse>(
        'CreateOrUpdateSavingsGoal',
        createOrUpdateSavingsGoal_Pre,
        false,
        false,
        ($core.List<$core.int> value) => $0.CreateOrUpdateSavingsGoalRequest.fromBuffer(value),
        ($0.CreateOrUpdateSavingsGoalResponse value) => value.writeToBuffer()));
    $addMethod($grpc.ServiceMethod<$0.GetUpcomingBillsRequest, $0.GetUpcomingBillsResponse>(
        'GetUpcomingBills',
        getUpcomingBills_Pre,
        false,
        false,
        ($core.List<$core.int> value) => $0.GetUpcomingBillsRequest.fromBuffer(value),
        ($0.GetUpcomingBillsResponse value) => value.writeToBuffer()));
    $addMethod($grpc.ServiceMethod<$0.CreateRecurringBillRequest, $0.CreateRecurringBillResponse>(
        'CreateRecurringBill',
        createRecurringBill_Pre,
        false,
        false,
        ($core.List<$core.int> value) => $0.CreateRecurringBillRequest.fromBuffer(value),
        ($0.CreateRecurringBillResponse value) => value.writeToBuffer()));
    $addMethod($grpc.ServiceMethod<$0.GetTrackedIncomeRequest, $0.GetTrackedIncomeResponse>(
        'GetTrackedIncome',
        getTrackedIncome_Pre,
        false,
        false,
        ($core.List<$core.int> value) => $0.GetTrackedIncomeRequest.fromBuffer(value),
        ($0.GetTrackedIncomeResponse value) => value.writeToBuffer()));
    $addMethod($grpc.ServiceMethod<$0.GetTrackedExpenditureRequest, $0.GetTrackedExpenditureResponse>(
        'GetTrackedExpenditure',
        getTrackedExpenditure_Pre,
        false,
        false,
        ($core.List<$core.int> value) => $0.GetTrackedExpenditureRequest.fromBuffer(value),
        ($0.GetTrackedExpenditureResponse value) => value.writeToBuffer()));
    $addMethod($grpc.ServiceMethod<$0.GetTrackedIncomeBreakdownRequest, $0.GetTrackedIncomeBreakdownResponse>(
        'GetTrackedIncomeBreakdown',
        getTrackedIncomeBreakdown_Pre,
        false,
        false,
        ($core.List<$core.int> value) => $0.GetTrackedIncomeBreakdownRequest.fromBuffer(value),
        ($0.GetTrackedIncomeBreakdownResponse value) => value.writeToBuffer()));
    $addMethod($grpc.ServiceMethod<$0.GetTrackedExpenditureBreakdownRequest, $0.GetTrackedExpenditureBreakdownResponse>(
        'GetTrackedExpenditureBreakdown',
        getTrackedExpenditureBreakdown_Pre,
        false,
        false,
        ($core.List<$core.int> value) => $0.GetTrackedExpenditureBreakdownRequest.fromBuffer(value),
        ($0.GetTrackedExpenditureBreakdownResponse value) => value.writeToBuffer()));
    $addMethod($grpc.ServiceMethod<$0.GetTrackedIncomeTransactionsRequest, $0.GetTrackedIncomeTransactionsResponse>(
        'GetTrackedIncomeTransactions',
        getTrackedIncomeTransactions_Pre,
        false,
        false,
        ($core.List<$core.int> value) => $0.GetTrackedIncomeTransactionsRequest.fromBuffer(value),
        ($0.GetTrackedIncomeTransactionsResponse value) => value.writeToBuffer()));
    $addMethod($grpc.ServiceMethod<$0.GetTrackedExpenditureTransactionsRequest, $0.GetTrackedExpenditureTransactionsResponse>(
        'GetTrackedExpenditureTransactions',
        getTrackedExpenditureTransactions_Pre,
        false,
        false,
        ($core.List<$core.int> value) => $0.GetTrackedExpenditureTransactionsRequest.fromBuffer(value),
        ($0.GetTrackedExpenditureTransactionsResponse value) => value.writeToBuffer()));
    $addMethod($grpc.ServiceMethod<$0.GetComprehensiveFinancialSummaryRequest, $0.GetComprehensiveFinancialSummaryResponse>(
        'GetComprehensiveFinancialSummary',
        getComprehensiveFinancialSummary_Pre,
        false,
        false,
        ($core.List<$core.int> value) => $0.GetComprehensiveFinancialSummaryRequest.fromBuffer(value),
        ($0.GetComprehensiveFinancialSummaryResponse value) => value.writeToBuffer()));
    $addMethod($grpc.ServiceMethod<$0.ValidateCategoryBudgetRequest, $0.ValidateCategoryBudgetResponse>(
        'ValidateCategoryBudget',
        validateCategoryBudget_Pre,
        false,
        false,
        ($core.List<$core.int> value) => $0.ValidateCategoryBudgetRequest.fromBuffer(value),
        ($0.ValidateCategoryBudgetResponse value) => value.writeToBuffer()));
    $addMethod($grpc.ServiceMethod<$0.GetServiceCategoriesRequest, $0.GetServiceCategoriesResponse>(
        'GetServiceCategories',
        getServiceCategories_Pre,
        false,
        false,
        ($core.List<$core.int> value) => $0.GetServiceCategoriesRequest.fromBuffer(value),
        ($0.GetServiceCategoriesResponse value) => value.writeToBuffer()));
  }

  $async.Future<$0.CreateExpenseResponse> createExpense_Pre($grpc.ServiceCall call, $async.Future<$0.CreateExpenseRequest> request) async {
    return createExpense(call, await request);
  }

  $async.Future<$0.GetExpensesResponse> getExpenses_Pre($grpc.ServiceCall call, $async.Future<$0.GetExpensesRequest> request) async {
    return getExpenses(call, await request);
  }

  $async.Future<$0.GetExpenseByIdResponse> getExpenseById_Pre($grpc.ServiceCall call, $async.Future<$0.GetExpenseByIdRequest> request) async {
    return getExpenseById(call, await request);
  }

  $async.Future<$0.UpdateExpenseResponse> updateExpense_Pre($grpc.ServiceCall call, $async.Future<$0.UpdateExpenseRequest> request) async {
    return updateExpense(call, await request);
  }

  $async.Future<$0.DeleteExpenseResponse> deleteExpense_Pre($grpc.ServiceCall call, $async.Future<$0.DeleteExpenseRequest> request) async {
    return deleteExpense(call, await request);
  }

  $async.Future<$0.CreateBudgetResponse> createBudget_Pre($grpc.ServiceCall call, $async.Future<$0.CreateBudgetRequest> request) async {
    return createBudget(call, await request);
  }

  $async.Future<$0.GetBudgetsResponse> getBudgets_Pre($grpc.ServiceCall call, $async.Future<$0.GetBudgetsRequest> request) async {
    return getBudgets(call, await request);
  }

  $async.Future<$0.GetBudgetByIdResponse> getBudgetById_Pre($grpc.ServiceCall call, $async.Future<$0.GetBudgetByIdRequest> request) async {
    return getBudgetById(call, await request);
  }

  $async.Future<$0.UpdateBudgetResponse> updateBudget_Pre($grpc.ServiceCall call, $async.Future<$0.UpdateBudgetRequest> request) async {
    return updateBudget(call, await request);
  }

  $async.Future<$0.DeleteBudgetResponse> deleteBudget_Pre($grpc.ServiceCall call, $async.Future<$0.DeleteBudgetRequest> request) async {
    return deleteBudget(call, await request);
  }

  $async.Future<$0.GetSpendingAnalyticsResponse> getSpendingAnalytics_Pre($grpc.ServiceCall call, $async.Future<$0.GetSpendingAnalyticsRequest> request) async {
    return getSpendingAnalytics(call, await request);
  }

  $async.Future<$0.GetCategoryBreakdownResponse> getCategoryBreakdown_Pre($grpc.ServiceCall call, $async.Future<$0.GetCategoryBreakdownRequest> request) async {
    return getCategoryBreakdown(call, await request);
  }

  $async.Future<$0.GetBudgetProgressResponse> getBudgetProgress_Pre($grpc.ServiceCall call, $async.Future<$0.GetBudgetProgressRequest> request) async {
    return getBudgetProgress(call, await request);
  }

  $async.Future<$0.GetSpendingTrendsResponse> getSpendingTrends_Pre($grpc.ServiceCall call, $async.Future<$0.GetSpendingTrendsRequest> request) async {
    return getSpendingTrends(call, await request);
  }

  $async.Future<$0.GetBudgetAlertsResponse> getBudgetAlerts_Pre($grpc.ServiceCall call, $async.Future<$0.GetBudgetAlertsRequest> request) async {
    return getBudgetAlerts(call, await request);
  }

  $async.Future<$0.MarkAlertAsReadResponse> markAlertAsRead_Pre($grpc.ServiceCall call, $async.Future<$0.MarkAlertAsReadRequest> request) async {
    return markAlertAsRead(call, await request);
  }

  $async.Future<$0.GetAISpendingInsightsResponse> getAISpendingInsights_Pre($grpc.ServiceCall call, $async.Future<$0.GetAISpendingInsightsRequest> request) async {
    return getAISpendingInsights(call, await request);
  }

  $async.Future<$0.GetAIBudgetingRecommendationsResponse> getAIBudgetingRecommendations_Pre($grpc.ServiceCall call, $async.Future<$0.GetAIBudgetingRecommendationsRequest> request) async {
    return getAIBudgetingRecommendations(call, await request);
  }

  $async.Future<$0.AutoCategorizeExpenseResponse> autoCategorizeExpense_Pre($grpc.ServiceCall call, $async.Future<$0.AutoCategorizeExpenseRequest> request) async {
    return autoCategorizeExpense(call, await request);
  }

  $async.Future<$0.GetAIFinancialAdviceResponse> getAIFinancialAdvice_Pre($grpc.ServiceCall call, $async.Future<$0.GetAIFinancialAdviceRequest> request) async {
    return getAIFinancialAdvice(call, await request);
  }

  $async.Future<$0.GetIncomeSourcesResponse> getIncomeSources_Pre($grpc.ServiceCall call, $async.Future<$0.GetIncomeSourcesRequest> request) async {
    return getIncomeSources(call, await request);
  }

  $async.Future<$0.GetIncomeBreakdownResponse> getIncomeBreakdown_Pre($grpc.ServiceCall call, $async.Future<$0.GetIncomeBreakdownRequest> request) async {
    return getIncomeBreakdown(call, await request);
  }

  $async.Future<$0.CreateIncomeSourceResponse> createIncomeSource_Pre($grpc.ServiceCall call, $async.Future<$0.CreateIncomeSourceRequest> request) async {
    return createIncomeSource(call, await request);
  }

  $async.Future<$0.GetInvestmentPortfolioResponse> getInvestmentPortfolio_Pre($grpc.ServiceCall call, $async.Future<$0.GetInvestmentPortfolioRequest> request) async {
    return getInvestmentPortfolio(call, await request);
  }

  $async.Future<$0.CreateInvestmentResponse> createInvestment_Pre($grpc.ServiceCall call, $async.Future<$0.CreateInvestmentRequest> request) async {
    return createInvestment(call, await request);
  }

  $async.Future<$0.GetFinancialGoalsResponse> getFinancialGoals_Pre($grpc.ServiceCall call, $async.Future<$0.GetFinancialGoalsRequest> request) async {
    return getFinancialGoals(call, await request);
  }

  $async.Future<$0.CreateFinancialGoalResponse> createFinancialGoal_Pre($grpc.ServiceCall call, $async.Future<$0.CreateFinancialGoalRequest> request) async {
    return createFinancialGoal(call, await request);
  }

  $async.Future<$0.UpdateFinancialGoalProgressResponse> updateFinancialGoalProgress_Pre($grpc.ServiceCall call, $async.Future<$0.UpdateFinancialGoalProgressRequest> request) async {
    return updateFinancialGoalProgress(call, await request);
  }

  $async.Future<$0.GetSavingsGoalResponse> getSavingsGoal_Pre($grpc.ServiceCall call, $async.Future<$0.GetSavingsGoalRequest> request) async {
    return getSavingsGoal(call, await request);
  }

  $async.Future<$0.CreateOrUpdateSavingsGoalResponse> createOrUpdateSavingsGoal_Pre($grpc.ServiceCall call, $async.Future<$0.CreateOrUpdateSavingsGoalRequest> request) async {
    return createOrUpdateSavingsGoal(call, await request);
  }

  $async.Future<$0.GetUpcomingBillsResponse> getUpcomingBills_Pre($grpc.ServiceCall call, $async.Future<$0.GetUpcomingBillsRequest> request) async {
    return getUpcomingBills(call, await request);
  }

  $async.Future<$0.CreateRecurringBillResponse> createRecurringBill_Pre($grpc.ServiceCall call, $async.Future<$0.CreateRecurringBillRequest> request) async {
    return createRecurringBill(call, await request);
  }

  $async.Future<$0.GetTrackedIncomeResponse> getTrackedIncome_Pre($grpc.ServiceCall call, $async.Future<$0.GetTrackedIncomeRequest> request) async {
    return getTrackedIncome(call, await request);
  }

  $async.Future<$0.GetTrackedExpenditureResponse> getTrackedExpenditure_Pre($grpc.ServiceCall call, $async.Future<$0.GetTrackedExpenditureRequest> request) async {
    return getTrackedExpenditure(call, await request);
  }

  $async.Future<$0.GetTrackedIncomeBreakdownResponse> getTrackedIncomeBreakdown_Pre($grpc.ServiceCall call, $async.Future<$0.GetTrackedIncomeBreakdownRequest> request) async {
    return getTrackedIncomeBreakdown(call, await request);
  }

  $async.Future<$0.GetTrackedExpenditureBreakdownResponse> getTrackedExpenditureBreakdown_Pre($grpc.ServiceCall call, $async.Future<$0.GetTrackedExpenditureBreakdownRequest> request) async {
    return getTrackedExpenditureBreakdown(call, await request);
  }

  $async.Future<$0.GetTrackedIncomeTransactionsResponse> getTrackedIncomeTransactions_Pre($grpc.ServiceCall call, $async.Future<$0.GetTrackedIncomeTransactionsRequest> request) async {
    return getTrackedIncomeTransactions(call, await request);
  }

  $async.Future<$0.GetTrackedExpenditureTransactionsResponse> getTrackedExpenditureTransactions_Pre($grpc.ServiceCall call, $async.Future<$0.GetTrackedExpenditureTransactionsRequest> request) async {
    return getTrackedExpenditureTransactions(call, await request);
  }

  $async.Future<$0.GetComprehensiveFinancialSummaryResponse> getComprehensiveFinancialSummary_Pre($grpc.ServiceCall call, $async.Future<$0.GetComprehensiveFinancialSummaryRequest> request) async {
    return getComprehensiveFinancialSummary(call, await request);
  }

  $async.Future<$0.ValidateCategoryBudgetResponse> validateCategoryBudget_Pre($grpc.ServiceCall call, $async.Future<$0.ValidateCategoryBudgetRequest> request) async {
    return validateCategoryBudget(call, await request);
  }

  $async.Future<$0.GetServiceCategoriesResponse> getServiceCategories_Pre($grpc.ServiceCall call, $async.Future<$0.GetServiceCategoriesRequest> request) async {
    return getServiceCategories(call, await request);
  }

  $async.Future<$0.CreateExpenseResponse> createExpense($grpc.ServiceCall call, $0.CreateExpenseRequest request);
  $async.Future<$0.GetExpensesResponse> getExpenses($grpc.ServiceCall call, $0.GetExpensesRequest request);
  $async.Future<$0.GetExpenseByIdResponse> getExpenseById($grpc.ServiceCall call, $0.GetExpenseByIdRequest request);
  $async.Future<$0.UpdateExpenseResponse> updateExpense($grpc.ServiceCall call, $0.UpdateExpenseRequest request);
  $async.Future<$0.DeleteExpenseResponse> deleteExpense($grpc.ServiceCall call, $0.DeleteExpenseRequest request);
  $async.Future<$0.CreateBudgetResponse> createBudget($grpc.ServiceCall call, $0.CreateBudgetRequest request);
  $async.Future<$0.GetBudgetsResponse> getBudgets($grpc.ServiceCall call, $0.GetBudgetsRequest request);
  $async.Future<$0.GetBudgetByIdResponse> getBudgetById($grpc.ServiceCall call, $0.GetBudgetByIdRequest request);
  $async.Future<$0.UpdateBudgetResponse> updateBudget($grpc.ServiceCall call, $0.UpdateBudgetRequest request);
  $async.Future<$0.DeleteBudgetResponse> deleteBudget($grpc.ServiceCall call, $0.DeleteBudgetRequest request);
  $async.Future<$0.GetSpendingAnalyticsResponse> getSpendingAnalytics($grpc.ServiceCall call, $0.GetSpendingAnalyticsRequest request);
  $async.Future<$0.GetCategoryBreakdownResponse> getCategoryBreakdown($grpc.ServiceCall call, $0.GetCategoryBreakdownRequest request);
  $async.Future<$0.GetBudgetProgressResponse> getBudgetProgress($grpc.ServiceCall call, $0.GetBudgetProgressRequest request);
  $async.Future<$0.GetSpendingTrendsResponse> getSpendingTrends($grpc.ServiceCall call, $0.GetSpendingTrendsRequest request);
  $async.Future<$0.GetBudgetAlertsResponse> getBudgetAlerts($grpc.ServiceCall call, $0.GetBudgetAlertsRequest request);
  $async.Future<$0.MarkAlertAsReadResponse> markAlertAsRead($grpc.ServiceCall call, $0.MarkAlertAsReadRequest request);
  $async.Future<$0.GetAISpendingInsightsResponse> getAISpendingInsights($grpc.ServiceCall call, $0.GetAISpendingInsightsRequest request);
  $async.Future<$0.GetAIBudgetingRecommendationsResponse> getAIBudgetingRecommendations($grpc.ServiceCall call, $0.GetAIBudgetingRecommendationsRequest request);
  $async.Future<$0.AutoCategorizeExpenseResponse> autoCategorizeExpense($grpc.ServiceCall call, $0.AutoCategorizeExpenseRequest request);
  $async.Future<$0.GetAIFinancialAdviceResponse> getAIFinancialAdvice($grpc.ServiceCall call, $0.GetAIFinancialAdviceRequest request);
  $async.Future<$0.GetIncomeSourcesResponse> getIncomeSources($grpc.ServiceCall call, $0.GetIncomeSourcesRequest request);
  $async.Future<$0.GetIncomeBreakdownResponse> getIncomeBreakdown($grpc.ServiceCall call, $0.GetIncomeBreakdownRequest request);
  $async.Future<$0.CreateIncomeSourceResponse> createIncomeSource($grpc.ServiceCall call, $0.CreateIncomeSourceRequest request);
  $async.Future<$0.GetInvestmentPortfolioResponse> getInvestmentPortfolio($grpc.ServiceCall call, $0.GetInvestmentPortfolioRequest request);
  $async.Future<$0.CreateInvestmentResponse> createInvestment($grpc.ServiceCall call, $0.CreateInvestmentRequest request);
  $async.Future<$0.GetFinancialGoalsResponse> getFinancialGoals($grpc.ServiceCall call, $0.GetFinancialGoalsRequest request);
  $async.Future<$0.CreateFinancialGoalResponse> createFinancialGoal($grpc.ServiceCall call, $0.CreateFinancialGoalRequest request);
  $async.Future<$0.UpdateFinancialGoalProgressResponse> updateFinancialGoalProgress($grpc.ServiceCall call, $0.UpdateFinancialGoalProgressRequest request);
  $async.Future<$0.GetSavingsGoalResponse> getSavingsGoal($grpc.ServiceCall call, $0.GetSavingsGoalRequest request);
  $async.Future<$0.CreateOrUpdateSavingsGoalResponse> createOrUpdateSavingsGoal($grpc.ServiceCall call, $0.CreateOrUpdateSavingsGoalRequest request);
  $async.Future<$0.GetUpcomingBillsResponse> getUpcomingBills($grpc.ServiceCall call, $0.GetUpcomingBillsRequest request);
  $async.Future<$0.CreateRecurringBillResponse> createRecurringBill($grpc.ServiceCall call, $0.CreateRecurringBillRequest request);
  $async.Future<$0.GetTrackedIncomeResponse> getTrackedIncome($grpc.ServiceCall call, $0.GetTrackedIncomeRequest request);
  $async.Future<$0.GetTrackedExpenditureResponse> getTrackedExpenditure($grpc.ServiceCall call, $0.GetTrackedExpenditureRequest request);
  $async.Future<$0.GetTrackedIncomeBreakdownResponse> getTrackedIncomeBreakdown($grpc.ServiceCall call, $0.GetTrackedIncomeBreakdownRequest request);
  $async.Future<$0.GetTrackedExpenditureBreakdownResponse> getTrackedExpenditureBreakdown($grpc.ServiceCall call, $0.GetTrackedExpenditureBreakdownRequest request);
  $async.Future<$0.GetTrackedIncomeTransactionsResponse> getTrackedIncomeTransactions($grpc.ServiceCall call, $0.GetTrackedIncomeTransactionsRequest request);
  $async.Future<$0.GetTrackedExpenditureTransactionsResponse> getTrackedExpenditureTransactions($grpc.ServiceCall call, $0.GetTrackedExpenditureTransactionsRequest request);
  $async.Future<$0.GetComprehensiveFinancialSummaryResponse> getComprehensiveFinancialSummary($grpc.ServiceCall call, $0.GetComprehensiveFinancialSummaryRequest request);
  $async.Future<$0.ValidateCategoryBudgetResponse> validateCategoryBudget($grpc.ServiceCall call, $0.ValidateCategoryBudgetRequest request);
  $async.Future<$0.GetServiceCategoriesResponse> getServiceCategories($grpc.ServiceCall call, $0.GetServiceCategoriesRequest request);
}
