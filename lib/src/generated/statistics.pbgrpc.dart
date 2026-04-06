///
//  Generated code. Do not modify.
//  source: statistics.proto
//
// @dart = 2.12
// ignore_for_file: annotate_overrides,camel_case_types,constant_identifier_names,directives_ordering,library_prefixes,non_constant_identifier_names,prefer_final_fields,return_of_invalid_type,unnecessary_const,unnecessary_import,unnecessary_this,unused_import,unused_shown_name

import 'dart:async' as $async;

import 'dart:core' as $core;

import 'package:grpc/service_api.dart' as $grpc;
import 'statistics.pb.dart' as $34;
export 'statistics.pb.dart';

class StatisticsServiceClient extends $grpc.Client {
  static final _$createExpense =
      $grpc.ClientMethod<$34.CreateExpenseRequest, $34.CreateExpenseResponse>(
          '/pb.StatisticsService/CreateExpense',
          ($34.CreateExpenseRequest value) => value.writeToBuffer(),
          ($core.List<$core.int> value) =>
              $34.CreateExpenseResponse.fromBuffer(value));
  static final _$getExpenses =
      $grpc.ClientMethod<$34.GetExpensesRequest, $34.GetExpensesResponse>(
          '/pb.StatisticsService/GetExpenses',
          ($34.GetExpensesRequest value) => value.writeToBuffer(),
          ($core.List<$core.int> value) =>
              $34.GetExpensesResponse.fromBuffer(value));
  static final _$getExpenseById =
      $grpc.ClientMethod<$34.GetExpenseByIdRequest, $34.GetExpenseByIdResponse>(
          '/pb.StatisticsService/GetExpenseById',
          ($34.GetExpenseByIdRequest value) => value.writeToBuffer(),
          ($core.List<$core.int> value) =>
              $34.GetExpenseByIdResponse.fromBuffer(value));
  static final _$updateExpense =
      $grpc.ClientMethod<$34.UpdateExpenseRequest, $34.UpdateExpenseResponse>(
          '/pb.StatisticsService/UpdateExpense',
          ($34.UpdateExpenseRequest value) => value.writeToBuffer(),
          ($core.List<$core.int> value) =>
              $34.UpdateExpenseResponse.fromBuffer(value));
  static final _$deleteExpense =
      $grpc.ClientMethod<$34.DeleteExpenseRequest, $34.DeleteExpenseResponse>(
          '/pb.StatisticsService/DeleteExpense',
          ($34.DeleteExpenseRequest value) => value.writeToBuffer(),
          ($core.List<$core.int> value) =>
              $34.DeleteExpenseResponse.fromBuffer(value));
  static final _$createBudget =
      $grpc.ClientMethod<$34.CreateBudgetRequest, $34.CreateBudgetResponse>(
          '/pb.StatisticsService/CreateBudget',
          ($34.CreateBudgetRequest value) => value.writeToBuffer(),
          ($core.List<$core.int> value) =>
              $34.CreateBudgetResponse.fromBuffer(value));
  static final _$getBudgets =
      $grpc.ClientMethod<$34.GetBudgetsRequest, $34.GetBudgetsResponse>(
          '/pb.StatisticsService/GetBudgets',
          ($34.GetBudgetsRequest value) => value.writeToBuffer(),
          ($core.List<$core.int> value) =>
              $34.GetBudgetsResponse.fromBuffer(value));
  static final _$getBudgetById =
      $grpc.ClientMethod<$34.GetBudgetByIdRequest, $34.GetBudgetByIdResponse>(
          '/pb.StatisticsService/GetBudgetById',
          ($34.GetBudgetByIdRequest value) => value.writeToBuffer(),
          ($core.List<$core.int> value) =>
              $34.GetBudgetByIdResponse.fromBuffer(value));
  static final _$updateBudget =
      $grpc.ClientMethod<$34.UpdateBudgetRequest, $34.UpdateBudgetResponse>(
          '/pb.StatisticsService/UpdateBudget',
          ($34.UpdateBudgetRequest value) => value.writeToBuffer(),
          ($core.List<$core.int> value) =>
              $34.UpdateBudgetResponse.fromBuffer(value));
  static final _$deleteBudget =
      $grpc.ClientMethod<$34.DeleteBudgetRequest, $34.DeleteBudgetResponse>(
          '/pb.StatisticsService/DeleteBudget',
          ($34.DeleteBudgetRequest value) => value.writeToBuffer(),
          ($core.List<$core.int> value) =>
              $34.DeleteBudgetResponse.fromBuffer(value));
  static final _$getSpendingAnalytics = $grpc.ClientMethod<
          $34.GetSpendingAnalyticsRequest, $34.GetSpendingAnalyticsResponse>(
      '/pb.StatisticsService/GetSpendingAnalytics',
      ($34.GetSpendingAnalyticsRequest value) => value.writeToBuffer(),
      ($core.List<$core.int> value) =>
          $34.GetSpendingAnalyticsResponse.fromBuffer(value));
  static final _$getCategoryBreakdown = $grpc.ClientMethod<
          $34.GetCategoryBreakdownRequest, $34.GetCategoryBreakdownResponse>(
      '/pb.StatisticsService/GetCategoryBreakdown',
      ($34.GetCategoryBreakdownRequest value) => value.writeToBuffer(),
      ($core.List<$core.int> value) =>
          $34.GetCategoryBreakdownResponse.fromBuffer(value));
  static final _$getBudgetProgress = $grpc.ClientMethod<
          $34.GetBudgetProgressRequest, $34.GetBudgetProgressResponse>(
      '/pb.StatisticsService/GetBudgetProgress',
      ($34.GetBudgetProgressRequest value) => value.writeToBuffer(),
      ($core.List<$core.int> value) =>
          $34.GetBudgetProgressResponse.fromBuffer(value));
  static final _$getSpendingTrends = $grpc.ClientMethod<
          $34.GetSpendingTrendsRequest, $34.GetSpendingTrendsResponse>(
      '/pb.StatisticsService/GetSpendingTrends',
      ($34.GetSpendingTrendsRequest value) => value.writeToBuffer(),
      ($core.List<$core.int> value) =>
          $34.GetSpendingTrendsResponse.fromBuffer(value));
  static final _$getBudgetAlerts = $grpc.ClientMethod<
          $34.GetBudgetAlertsRequest, $34.GetBudgetAlertsResponse>(
      '/pb.StatisticsService/GetBudgetAlerts',
      ($34.GetBudgetAlertsRequest value) => value.writeToBuffer(),
      ($core.List<$core.int> value) =>
          $34.GetBudgetAlertsResponse.fromBuffer(value));
  static final _$markAlertAsRead = $grpc.ClientMethod<
          $34.MarkAlertAsReadRequest, $34.MarkAlertAsReadResponse>(
      '/pb.StatisticsService/MarkAlertAsRead',
      ($34.MarkAlertAsReadRequest value) => value.writeToBuffer(),
      ($core.List<$core.int> value) =>
          $34.MarkAlertAsReadResponse.fromBuffer(value));
  static final _$getAISpendingInsights = $grpc.ClientMethod<
          $34.GetAISpendingInsightsRequest, $34.GetAISpendingInsightsResponse>(
      '/pb.StatisticsService/GetAISpendingInsights',
      ($34.GetAISpendingInsightsRequest value) => value.writeToBuffer(),
      ($core.List<$core.int> value) =>
          $34.GetAISpendingInsightsResponse.fromBuffer(value));
  static final _$getAIBudgetingRecommendations = $grpc.ClientMethod<
          $34.GetAIBudgetingRecommendationsRequest,
          $34.GetAIBudgetingRecommendationsResponse>(
      '/pb.StatisticsService/GetAIBudgetingRecommendations',
      ($34.GetAIBudgetingRecommendationsRequest value) => value.writeToBuffer(),
      ($core.List<$core.int> value) =>
          $34.GetAIBudgetingRecommendationsResponse.fromBuffer(value));
  static final _$autoCategorizeExpense = $grpc.ClientMethod<
          $34.AutoCategorizeExpenseRequest, $34.AutoCategorizeExpenseResponse>(
      '/pb.StatisticsService/AutoCategorizeExpense',
      ($34.AutoCategorizeExpenseRequest value) => value.writeToBuffer(),
      ($core.List<$core.int> value) =>
          $34.AutoCategorizeExpenseResponse.fromBuffer(value));
  static final _$getAIFinancialAdvice = $grpc.ClientMethod<
          $34.GetAIFinancialAdviceRequest, $34.GetAIFinancialAdviceResponse>(
      '/pb.StatisticsService/GetAIFinancialAdvice',
      ($34.GetAIFinancialAdviceRequest value) => value.writeToBuffer(),
      ($core.List<$core.int> value) =>
          $34.GetAIFinancialAdviceResponse.fromBuffer(value));
  static final _$getIncomeSources = $grpc.ClientMethod<
          $34.GetIncomeSourcesRequest, $34.GetIncomeSourcesResponse>(
      '/pb.StatisticsService/GetIncomeSources',
      ($34.GetIncomeSourcesRequest value) => value.writeToBuffer(),
      ($core.List<$core.int> value) =>
          $34.GetIncomeSourcesResponse.fromBuffer(value));
  static final _$getIncomeBreakdown = $grpc.ClientMethod<
          $34.GetIncomeBreakdownRequest, $34.GetIncomeBreakdownResponse>(
      '/pb.StatisticsService/GetIncomeBreakdown',
      ($34.GetIncomeBreakdownRequest value) => value.writeToBuffer(),
      ($core.List<$core.int> value) =>
          $34.GetIncomeBreakdownResponse.fromBuffer(value));
  static final _$createIncomeSource = $grpc.ClientMethod<
          $34.CreateIncomeSourceRequest, $34.CreateIncomeSourceResponse>(
      '/pb.StatisticsService/CreateIncomeSource',
      ($34.CreateIncomeSourceRequest value) => value.writeToBuffer(),
      ($core.List<$core.int> value) =>
          $34.CreateIncomeSourceResponse.fromBuffer(value));
  static final _$getInvestmentPortfolio = $grpc.ClientMethod<
          $34.GetInvestmentPortfolioRequest,
          $34.GetInvestmentPortfolioResponse>(
      '/pb.StatisticsService/GetInvestmentPortfolio',
      ($34.GetInvestmentPortfolioRequest value) => value.writeToBuffer(),
      ($core.List<$core.int> value) =>
          $34.GetInvestmentPortfolioResponse.fromBuffer(value));
  static final _$createInvestment = $grpc.ClientMethod<
          $34.CreateInvestmentRequest, $34.CreateInvestmentResponse>(
      '/pb.StatisticsService/CreateInvestment',
      ($34.CreateInvestmentRequest value) => value.writeToBuffer(),
      ($core.List<$core.int> value) =>
          $34.CreateInvestmentResponse.fromBuffer(value));
  static final _$getFinancialGoals = $grpc.ClientMethod<
          $34.GetFinancialGoalsRequest, $34.GetFinancialGoalsResponse>(
      '/pb.StatisticsService/GetFinancialGoals',
      ($34.GetFinancialGoalsRequest value) => value.writeToBuffer(),
      ($core.List<$core.int> value) =>
          $34.GetFinancialGoalsResponse.fromBuffer(value));
  static final _$createFinancialGoal = $grpc.ClientMethod<
          $34.CreateFinancialGoalRequest, $34.CreateFinancialGoalResponse>(
      '/pb.StatisticsService/CreateFinancialGoal',
      ($34.CreateFinancialGoalRequest value) => value.writeToBuffer(),
      ($core.List<$core.int> value) =>
          $34.CreateFinancialGoalResponse.fromBuffer(value));
  static final _$updateFinancialGoalProgress = $grpc.ClientMethod<
          $34.UpdateFinancialGoalProgressRequest,
          $34.UpdateFinancialGoalProgressResponse>(
      '/pb.StatisticsService/UpdateFinancialGoalProgress',
      ($34.UpdateFinancialGoalProgressRequest value) => value.writeToBuffer(),
      ($core.List<$core.int> value) =>
          $34.UpdateFinancialGoalProgressResponse.fromBuffer(value));
  static final _$getSavingsGoal =
      $grpc.ClientMethod<$34.GetSavingsGoalRequest, $34.GetSavingsGoalResponse>(
          '/pb.StatisticsService/GetSavingsGoal',
          ($34.GetSavingsGoalRequest value) => value.writeToBuffer(),
          ($core.List<$core.int> value) =>
              $34.GetSavingsGoalResponse.fromBuffer(value));
  static final _$createOrUpdateSavingsGoal = $grpc.ClientMethod<
          $34.CreateOrUpdateSavingsGoalRequest,
          $34.CreateOrUpdateSavingsGoalResponse>(
      '/pb.StatisticsService/CreateOrUpdateSavingsGoal',
      ($34.CreateOrUpdateSavingsGoalRequest value) => value.writeToBuffer(),
      ($core.List<$core.int> value) =>
          $34.CreateOrUpdateSavingsGoalResponse.fromBuffer(value));
  static final _$getUpcomingBills = $grpc.ClientMethod<
          $34.GetUpcomingBillsRequest, $34.GetUpcomingBillsResponse>(
      '/pb.StatisticsService/GetUpcomingBills',
      ($34.GetUpcomingBillsRequest value) => value.writeToBuffer(),
      ($core.List<$core.int> value) =>
          $34.GetUpcomingBillsResponse.fromBuffer(value));
  static final _$createRecurringBill = $grpc.ClientMethod<
          $34.CreateRecurringBillRequest, $34.CreateRecurringBillResponse>(
      '/pb.StatisticsService/CreateRecurringBill',
      ($34.CreateRecurringBillRequest value) => value.writeToBuffer(),
      ($core.List<$core.int> value) =>
          $34.CreateRecurringBillResponse.fromBuffer(value));
  static final _$getTrackedIncome = $grpc.ClientMethod<
          $34.GetTrackedIncomeRequest, $34.GetTrackedIncomeResponse>(
      '/pb.StatisticsService/GetTrackedIncome',
      ($34.GetTrackedIncomeRequest value) => value.writeToBuffer(),
      ($core.List<$core.int> value) =>
          $34.GetTrackedIncomeResponse.fromBuffer(value));
  static final _$getTrackedExpenditure = $grpc.ClientMethod<
          $34.GetTrackedExpenditureRequest, $34.GetTrackedExpenditureResponse>(
      '/pb.StatisticsService/GetTrackedExpenditure',
      ($34.GetTrackedExpenditureRequest value) => value.writeToBuffer(),
      ($core.List<$core.int> value) =>
          $34.GetTrackedExpenditureResponse.fromBuffer(value));
  static final _$getTrackedIncomeBreakdown = $grpc.ClientMethod<
          $34.GetTrackedIncomeBreakdownRequest,
          $34.GetTrackedIncomeBreakdownResponse>(
      '/pb.StatisticsService/GetTrackedIncomeBreakdown',
      ($34.GetTrackedIncomeBreakdownRequest value) => value.writeToBuffer(),
      ($core.List<$core.int> value) =>
          $34.GetTrackedIncomeBreakdownResponse.fromBuffer(value));
  static final _$getTrackedExpenditureBreakdown = $grpc.ClientMethod<
          $34.GetTrackedExpenditureBreakdownRequest,
          $34.GetTrackedExpenditureBreakdownResponse>(
      '/pb.StatisticsService/GetTrackedExpenditureBreakdown',
      ($34.GetTrackedExpenditureBreakdownRequest value) =>
          value.writeToBuffer(),
      ($core.List<$core.int> value) =>
          $34.GetTrackedExpenditureBreakdownResponse.fromBuffer(value));
  static final _$getTrackedIncomeTransactions = $grpc.ClientMethod<
          $34.GetTrackedIncomeTransactionsRequest,
          $34.GetTrackedIncomeTransactionsResponse>(
      '/pb.StatisticsService/GetTrackedIncomeTransactions',
      ($34.GetTrackedIncomeTransactionsRequest value) => value.writeToBuffer(),
      ($core.List<$core.int> value) =>
          $34.GetTrackedIncomeTransactionsResponse.fromBuffer(value));
  static final _$getTrackedExpenditureTransactions = $grpc.ClientMethod<
          $34.GetTrackedExpenditureTransactionsRequest,
          $34.GetTrackedExpenditureTransactionsResponse>(
      '/pb.StatisticsService/GetTrackedExpenditureTransactions',
      ($34.GetTrackedExpenditureTransactionsRequest value) =>
          value.writeToBuffer(),
      ($core.List<$core.int> value) =>
          $34.GetTrackedExpenditureTransactionsResponse.fromBuffer(value));
  static final _$getComprehensiveFinancialSummary = $grpc.ClientMethod<
          $34.GetComprehensiveFinancialSummaryRequest,
          $34.GetComprehensiveFinancialSummaryResponse>(
      '/pb.StatisticsService/GetComprehensiveFinancialSummary',
      ($34.GetComprehensiveFinancialSummaryRequest value) =>
          value.writeToBuffer(),
      ($core.List<$core.int> value) =>
          $34.GetComprehensiveFinancialSummaryResponse.fromBuffer(value));
  static final _$validateCategoryBudget = $grpc.ClientMethod<
          $34.ValidateCategoryBudgetRequest,
          $34.ValidateCategoryBudgetResponse>(
      '/pb.StatisticsService/ValidateCategoryBudget',
      ($34.ValidateCategoryBudgetRequest value) => value.writeToBuffer(),
      ($core.List<$core.int> value) =>
          $34.ValidateCategoryBudgetResponse.fromBuffer(value));
  static final _$getServiceCategories = $grpc.ClientMethod<
          $34.GetServiceCategoriesRequest, $34.GetServiceCategoriesResponse>(
      '/pb.StatisticsService/GetServiceCategories',
      ($34.GetServiceCategoriesRequest value) => value.writeToBuffer(),
      ($core.List<$core.int> value) =>
          $34.GetServiceCategoriesResponse.fromBuffer(value));
  static final _$createCustomCategory = $grpc.ClientMethod<
          $34.CreateCustomCategoryRequest, $34.CreateCustomCategoryResponse>(
      '/pb.StatisticsService/CreateCustomCategory',
      ($34.CreateCustomCategoryRequest value) => value.writeToBuffer(),
      ($core.List<$core.int> value) =>
          $34.CreateCustomCategoryResponse.fromBuffer(value));
  static final _$deleteCustomCategory = $grpc.ClientMethod<
          $34.DeleteCustomCategoryRequest, $34.DeleteCustomCategoryResponse>(
      '/pb.StatisticsService/DeleteCustomCategory',
      ($34.DeleteCustomCategoryRequest value) => value.writeToBuffer(),
      ($core.List<$core.int> value) =>
          $34.DeleteCustomCategoryResponse.fromBuffer(value));

  StatisticsServiceClient($grpc.ClientChannel channel,
      {$grpc.CallOptions? options,
      $core.Iterable<$grpc.ClientInterceptor>? interceptors})
      : super(channel, options: options, interceptors: interceptors);

  $grpc.ResponseFuture<$34.CreateExpenseResponse> createExpense(
      $34.CreateExpenseRequest request,
      {$grpc.CallOptions? options}) {
    return $createUnaryCall(_$createExpense, request, options: options);
  }

  $grpc.ResponseFuture<$34.GetExpensesResponse> getExpenses(
      $34.GetExpensesRequest request,
      {$grpc.CallOptions? options}) {
    return $createUnaryCall(_$getExpenses, request, options: options);
  }

  $grpc.ResponseFuture<$34.GetExpenseByIdResponse> getExpenseById(
      $34.GetExpenseByIdRequest request,
      {$grpc.CallOptions? options}) {
    return $createUnaryCall(_$getExpenseById, request, options: options);
  }

  $grpc.ResponseFuture<$34.UpdateExpenseResponse> updateExpense(
      $34.UpdateExpenseRequest request,
      {$grpc.CallOptions? options}) {
    return $createUnaryCall(_$updateExpense, request, options: options);
  }

  $grpc.ResponseFuture<$34.DeleteExpenseResponse> deleteExpense(
      $34.DeleteExpenseRequest request,
      {$grpc.CallOptions? options}) {
    return $createUnaryCall(_$deleteExpense, request, options: options);
  }

  $grpc.ResponseFuture<$34.CreateBudgetResponse> createBudget(
      $34.CreateBudgetRequest request,
      {$grpc.CallOptions? options}) {
    return $createUnaryCall(_$createBudget, request, options: options);
  }

  $grpc.ResponseFuture<$34.GetBudgetsResponse> getBudgets(
      $34.GetBudgetsRequest request,
      {$grpc.CallOptions? options}) {
    return $createUnaryCall(_$getBudgets, request, options: options);
  }

  $grpc.ResponseFuture<$34.GetBudgetByIdResponse> getBudgetById(
      $34.GetBudgetByIdRequest request,
      {$grpc.CallOptions? options}) {
    return $createUnaryCall(_$getBudgetById, request, options: options);
  }

  $grpc.ResponseFuture<$34.UpdateBudgetResponse> updateBudget(
      $34.UpdateBudgetRequest request,
      {$grpc.CallOptions? options}) {
    return $createUnaryCall(_$updateBudget, request, options: options);
  }

  $grpc.ResponseFuture<$34.DeleteBudgetResponse> deleteBudget(
      $34.DeleteBudgetRequest request,
      {$grpc.CallOptions? options}) {
    return $createUnaryCall(_$deleteBudget, request, options: options);
  }

  $grpc.ResponseFuture<$34.GetSpendingAnalyticsResponse> getSpendingAnalytics(
      $34.GetSpendingAnalyticsRequest request,
      {$grpc.CallOptions? options}) {
    return $createUnaryCall(_$getSpendingAnalytics, request, options: options);
  }

  $grpc.ResponseFuture<$34.GetCategoryBreakdownResponse> getCategoryBreakdown(
      $34.GetCategoryBreakdownRequest request,
      {$grpc.CallOptions? options}) {
    return $createUnaryCall(_$getCategoryBreakdown, request, options: options);
  }

  $grpc.ResponseFuture<$34.GetBudgetProgressResponse> getBudgetProgress(
      $34.GetBudgetProgressRequest request,
      {$grpc.CallOptions? options}) {
    return $createUnaryCall(_$getBudgetProgress, request, options: options);
  }

  $grpc.ResponseFuture<$34.GetSpendingTrendsResponse> getSpendingTrends(
      $34.GetSpendingTrendsRequest request,
      {$grpc.CallOptions? options}) {
    return $createUnaryCall(_$getSpendingTrends, request, options: options);
  }

  $grpc.ResponseFuture<$34.GetBudgetAlertsResponse> getBudgetAlerts(
      $34.GetBudgetAlertsRequest request,
      {$grpc.CallOptions? options}) {
    return $createUnaryCall(_$getBudgetAlerts, request, options: options);
  }

  $grpc.ResponseFuture<$34.MarkAlertAsReadResponse> markAlertAsRead(
      $34.MarkAlertAsReadRequest request,
      {$grpc.CallOptions? options}) {
    return $createUnaryCall(_$markAlertAsRead, request, options: options);
  }

  $grpc.ResponseFuture<$34.GetAISpendingInsightsResponse> getAISpendingInsights(
      $34.GetAISpendingInsightsRequest request,
      {$grpc.CallOptions? options}) {
    return $createUnaryCall(_$getAISpendingInsights, request, options: options);
  }

  $grpc.ResponseFuture<$34.GetAIBudgetingRecommendationsResponse>
      getAIBudgetingRecommendations(
          $34.GetAIBudgetingRecommendationsRequest request,
          {$grpc.CallOptions? options}) {
    return $createUnaryCall(_$getAIBudgetingRecommendations, request,
        options: options);
  }

  $grpc.ResponseFuture<$34.AutoCategorizeExpenseResponse> autoCategorizeExpense(
      $34.AutoCategorizeExpenseRequest request,
      {$grpc.CallOptions? options}) {
    return $createUnaryCall(_$autoCategorizeExpense, request, options: options);
  }

  $grpc.ResponseFuture<$34.GetAIFinancialAdviceResponse> getAIFinancialAdvice(
      $34.GetAIFinancialAdviceRequest request,
      {$grpc.CallOptions? options}) {
    return $createUnaryCall(_$getAIFinancialAdvice, request, options: options);
  }

  $grpc.ResponseFuture<$34.GetIncomeSourcesResponse> getIncomeSources(
      $34.GetIncomeSourcesRequest request,
      {$grpc.CallOptions? options}) {
    return $createUnaryCall(_$getIncomeSources, request, options: options);
  }

  $grpc.ResponseFuture<$34.GetIncomeBreakdownResponse> getIncomeBreakdown(
      $34.GetIncomeBreakdownRequest request,
      {$grpc.CallOptions? options}) {
    return $createUnaryCall(_$getIncomeBreakdown, request, options: options);
  }

  $grpc.ResponseFuture<$34.CreateIncomeSourceResponse> createIncomeSource(
      $34.CreateIncomeSourceRequest request,
      {$grpc.CallOptions? options}) {
    return $createUnaryCall(_$createIncomeSource, request, options: options);
  }

  $grpc.ResponseFuture<$34.GetInvestmentPortfolioResponse>
      getInvestmentPortfolio($34.GetInvestmentPortfolioRequest request,
          {$grpc.CallOptions? options}) {
    return $createUnaryCall(_$getInvestmentPortfolio, request,
        options: options);
  }

  $grpc.ResponseFuture<$34.CreateInvestmentResponse> createInvestment(
      $34.CreateInvestmentRequest request,
      {$grpc.CallOptions? options}) {
    return $createUnaryCall(_$createInvestment, request, options: options);
  }

  $grpc.ResponseFuture<$34.GetFinancialGoalsResponse> getFinancialGoals(
      $34.GetFinancialGoalsRequest request,
      {$grpc.CallOptions? options}) {
    return $createUnaryCall(_$getFinancialGoals, request, options: options);
  }

  $grpc.ResponseFuture<$34.CreateFinancialGoalResponse> createFinancialGoal(
      $34.CreateFinancialGoalRequest request,
      {$grpc.CallOptions? options}) {
    return $createUnaryCall(_$createFinancialGoal, request, options: options);
  }

  $grpc.ResponseFuture<$34.UpdateFinancialGoalProgressResponse>
      updateFinancialGoalProgress(
          $34.UpdateFinancialGoalProgressRequest request,
          {$grpc.CallOptions? options}) {
    return $createUnaryCall(_$updateFinancialGoalProgress, request,
        options: options);
  }

  $grpc.ResponseFuture<$34.GetSavingsGoalResponse> getSavingsGoal(
      $34.GetSavingsGoalRequest request,
      {$grpc.CallOptions? options}) {
    return $createUnaryCall(_$getSavingsGoal, request, options: options);
  }

  $grpc.ResponseFuture<$34.CreateOrUpdateSavingsGoalResponse>
      createOrUpdateSavingsGoal($34.CreateOrUpdateSavingsGoalRequest request,
          {$grpc.CallOptions? options}) {
    return $createUnaryCall(_$createOrUpdateSavingsGoal, request,
        options: options);
  }

  $grpc.ResponseFuture<$34.GetUpcomingBillsResponse> getUpcomingBills(
      $34.GetUpcomingBillsRequest request,
      {$grpc.CallOptions? options}) {
    return $createUnaryCall(_$getUpcomingBills, request, options: options);
  }

  $grpc.ResponseFuture<$34.CreateRecurringBillResponse> createRecurringBill(
      $34.CreateRecurringBillRequest request,
      {$grpc.CallOptions? options}) {
    return $createUnaryCall(_$createRecurringBill, request, options: options);
  }

  $grpc.ResponseFuture<$34.GetTrackedIncomeResponse> getTrackedIncome(
      $34.GetTrackedIncomeRequest request,
      {$grpc.CallOptions? options}) {
    return $createUnaryCall(_$getTrackedIncome, request, options: options);
  }

  $grpc.ResponseFuture<$34.GetTrackedExpenditureResponse> getTrackedExpenditure(
      $34.GetTrackedExpenditureRequest request,
      {$grpc.CallOptions? options}) {
    return $createUnaryCall(_$getTrackedExpenditure, request, options: options);
  }

  $grpc.ResponseFuture<$34.GetTrackedIncomeBreakdownResponse>
      getTrackedIncomeBreakdown($34.GetTrackedIncomeBreakdownRequest request,
          {$grpc.CallOptions? options}) {
    return $createUnaryCall(_$getTrackedIncomeBreakdown, request,
        options: options);
  }

  $grpc.ResponseFuture<$34.GetTrackedExpenditureBreakdownResponse>
      getTrackedExpenditureBreakdown(
          $34.GetTrackedExpenditureBreakdownRequest request,
          {$grpc.CallOptions? options}) {
    return $createUnaryCall(_$getTrackedExpenditureBreakdown, request,
        options: options);
  }

  $grpc.ResponseFuture<$34.GetTrackedIncomeTransactionsResponse>
      getTrackedIncomeTransactions(
          $34.GetTrackedIncomeTransactionsRequest request,
          {$grpc.CallOptions? options}) {
    return $createUnaryCall(_$getTrackedIncomeTransactions, request,
        options: options);
  }

  $grpc.ResponseFuture<$34.GetTrackedExpenditureTransactionsResponse>
      getTrackedExpenditureTransactions(
          $34.GetTrackedExpenditureTransactionsRequest request,
          {$grpc.CallOptions? options}) {
    return $createUnaryCall(_$getTrackedExpenditureTransactions, request,
        options: options);
  }

  $grpc.ResponseFuture<$34.GetComprehensiveFinancialSummaryResponse>
      getComprehensiveFinancialSummary(
          $34.GetComprehensiveFinancialSummaryRequest request,
          {$grpc.CallOptions? options}) {
    return $createUnaryCall(_$getComprehensiveFinancialSummary, request,
        options: options);
  }

  $grpc.ResponseFuture<$34.ValidateCategoryBudgetResponse>
      validateCategoryBudget($34.ValidateCategoryBudgetRequest request,
          {$grpc.CallOptions? options}) {
    return $createUnaryCall(_$validateCategoryBudget, request,
        options: options);
  }

  $grpc.ResponseFuture<$34.GetServiceCategoriesResponse> getServiceCategories(
      $34.GetServiceCategoriesRequest request,
      {$grpc.CallOptions? options}) {
    return $createUnaryCall(_$getServiceCategories, request, options: options);
  }

  $grpc.ResponseFuture<$34.CreateCustomCategoryResponse> createCustomCategory(
      $34.CreateCustomCategoryRequest request,
      {$grpc.CallOptions? options}) {
    return $createUnaryCall(_$createCustomCategory, request, options: options);
  }

  $grpc.ResponseFuture<$34.DeleteCustomCategoryResponse> deleteCustomCategory(
      $34.DeleteCustomCategoryRequest request,
      {$grpc.CallOptions? options}) {
    return $createUnaryCall(_$deleteCustomCategory, request, options: options);
  }
}

abstract class StatisticsServiceBase extends $grpc.Service {
  $core.String get $name => 'pb.StatisticsService';

  StatisticsServiceBase() {
    $addMethod($grpc.ServiceMethod<$34.CreateExpenseRequest,
            $34.CreateExpenseResponse>(
        'CreateExpense',
        createExpense_Pre,
        false,
        false,
        ($core.List<$core.int> value) =>
            $34.CreateExpenseRequest.fromBuffer(value),
        ($34.CreateExpenseResponse value) => value.writeToBuffer()));
    $addMethod(
        $grpc.ServiceMethod<$34.GetExpensesRequest, $34.GetExpensesResponse>(
            'GetExpenses',
            getExpenses_Pre,
            false,
            false,
            ($core.List<$core.int> value) =>
                $34.GetExpensesRequest.fromBuffer(value),
            ($34.GetExpensesResponse value) => value.writeToBuffer()));
    $addMethod($grpc.ServiceMethod<$34.GetExpenseByIdRequest,
            $34.GetExpenseByIdResponse>(
        'GetExpenseById',
        getExpenseById_Pre,
        false,
        false,
        ($core.List<$core.int> value) =>
            $34.GetExpenseByIdRequest.fromBuffer(value),
        ($34.GetExpenseByIdResponse value) => value.writeToBuffer()));
    $addMethod($grpc.ServiceMethod<$34.UpdateExpenseRequest,
            $34.UpdateExpenseResponse>(
        'UpdateExpense',
        updateExpense_Pre,
        false,
        false,
        ($core.List<$core.int> value) =>
            $34.UpdateExpenseRequest.fromBuffer(value),
        ($34.UpdateExpenseResponse value) => value.writeToBuffer()));
    $addMethod($grpc.ServiceMethod<$34.DeleteExpenseRequest,
            $34.DeleteExpenseResponse>(
        'DeleteExpense',
        deleteExpense_Pre,
        false,
        false,
        ($core.List<$core.int> value) =>
            $34.DeleteExpenseRequest.fromBuffer(value),
        ($34.DeleteExpenseResponse value) => value.writeToBuffer()));
    $addMethod(
        $grpc.ServiceMethod<$34.CreateBudgetRequest, $34.CreateBudgetResponse>(
            'CreateBudget',
            createBudget_Pre,
            false,
            false,
            ($core.List<$core.int> value) =>
                $34.CreateBudgetRequest.fromBuffer(value),
            ($34.CreateBudgetResponse value) => value.writeToBuffer()));
    $addMethod(
        $grpc.ServiceMethod<$34.GetBudgetsRequest, $34.GetBudgetsResponse>(
            'GetBudgets',
            getBudgets_Pre,
            false,
            false,
            ($core.List<$core.int> value) =>
                $34.GetBudgetsRequest.fromBuffer(value),
            ($34.GetBudgetsResponse value) => value.writeToBuffer()));
    $addMethod($grpc.ServiceMethod<$34.GetBudgetByIdRequest,
            $34.GetBudgetByIdResponse>(
        'GetBudgetById',
        getBudgetById_Pre,
        false,
        false,
        ($core.List<$core.int> value) =>
            $34.GetBudgetByIdRequest.fromBuffer(value),
        ($34.GetBudgetByIdResponse value) => value.writeToBuffer()));
    $addMethod(
        $grpc.ServiceMethod<$34.UpdateBudgetRequest, $34.UpdateBudgetResponse>(
            'UpdateBudget',
            updateBudget_Pre,
            false,
            false,
            ($core.List<$core.int> value) =>
                $34.UpdateBudgetRequest.fromBuffer(value),
            ($34.UpdateBudgetResponse value) => value.writeToBuffer()));
    $addMethod(
        $grpc.ServiceMethod<$34.DeleteBudgetRequest, $34.DeleteBudgetResponse>(
            'DeleteBudget',
            deleteBudget_Pre,
            false,
            false,
            ($core.List<$core.int> value) =>
                $34.DeleteBudgetRequest.fromBuffer(value),
            ($34.DeleteBudgetResponse value) => value.writeToBuffer()));
    $addMethod($grpc.ServiceMethod<$34.GetSpendingAnalyticsRequest,
            $34.GetSpendingAnalyticsResponse>(
        'GetSpendingAnalytics',
        getSpendingAnalytics_Pre,
        false,
        false,
        ($core.List<$core.int> value) =>
            $34.GetSpendingAnalyticsRequest.fromBuffer(value),
        ($34.GetSpendingAnalyticsResponse value) => value.writeToBuffer()));
    $addMethod($grpc.ServiceMethod<$34.GetCategoryBreakdownRequest,
            $34.GetCategoryBreakdownResponse>(
        'GetCategoryBreakdown',
        getCategoryBreakdown_Pre,
        false,
        false,
        ($core.List<$core.int> value) =>
            $34.GetCategoryBreakdownRequest.fromBuffer(value),
        ($34.GetCategoryBreakdownResponse value) => value.writeToBuffer()));
    $addMethod($grpc.ServiceMethod<$34.GetBudgetProgressRequest,
            $34.GetBudgetProgressResponse>(
        'GetBudgetProgress',
        getBudgetProgress_Pre,
        false,
        false,
        ($core.List<$core.int> value) =>
            $34.GetBudgetProgressRequest.fromBuffer(value),
        ($34.GetBudgetProgressResponse value) => value.writeToBuffer()));
    $addMethod($grpc.ServiceMethod<$34.GetSpendingTrendsRequest,
            $34.GetSpendingTrendsResponse>(
        'GetSpendingTrends',
        getSpendingTrends_Pre,
        false,
        false,
        ($core.List<$core.int> value) =>
            $34.GetSpendingTrendsRequest.fromBuffer(value),
        ($34.GetSpendingTrendsResponse value) => value.writeToBuffer()));
    $addMethod($grpc.ServiceMethod<$34.GetBudgetAlertsRequest,
            $34.GetBudgetAlertsResponse>(
        'GetBudgetAlerts',
        getBudgetAlerts_Pre,
        false,
        false,
        ($core.List<$core.int> value) =>
            $34.GetBudgetAlertsRequest.fromBuffer(value),
        ($34.GetBudgetAlertsResponse value) => value.writeToBuffer()));
    $addMethod($grpc.ServiceMethod<$34.MarkAlertAsReadRequest,
            $34.MarkAlertAsReadResponse>(
        'MarkAlertAsRead',
        markAlertAsRead_Pre,
        false,
        false,
        ($core.List<$core.int> value) =>
            $34.MarkAlertAsReadRequest.fromBuffer(value),
        ($34.MarkAlertAsReadResponse value) => value.writeToBuffer()));
    $addMethod($grpc.ServiceMethod<$34.GetAISpendingInsightsRequest,
            $34.GetAISpendingInsightsResponse>(
        'GetAISpendingInsights',
        getAISpendingInsights_Pre,
        false,
        false,
        ($core.List<$core.int> value) =>
            $34.GetAISpendingInsightsRequest.fromBuffer(value),
        ($34.GetAISpendingInsightsResponse value) => value.writeToBuffer()));
    $addMethod($grpc.ServiceMethod<$34.GetAIBudgetingRecommendationsRequest,
            $34.GetAIBudgetingRecommendationsResponse>(
        'GetAIBudgetingRecommendations',
        getAIBudgetingRecommendations_Pre,
        false,
        false,
        ($core.List<$core.int> value) =>
            $34.GetAIBudgetingRecommendationsRequest.fromBuffer(value),
        ($34.GetAIBudgetingRecommendationsResponse value) =>
            value.writeToBuffer()));
    $addMethod($grpc.ServiceMethod<$34.AutoCategorizeExpenseRequest,
            $34.AutoCategorizeExpenseResponse>(
        'AutoCategorizeExpense',
        autoCategorizeExpense_Pre,
        false,
        false,
        ($core.List<$core.int> value) =>
            $34.AutoCategorizeExpenseRequest.fromBuffer(value),
        ($34.AutoCategorizeExpenseResponse value) => value.writeToBuffer()));
    $addMethod($grpc.ServiceMethod<$34.GetAIFinancialAdviceRequest,
            $34.GetAIFinancialAdviceResponse>(
        'GetAIFinancialAdvice',
        getAIFinancialAdvice_Pre,
        false,
        false,
        ($core.List<$core.int> value) =>
            $34.GetAIFinancialAdviceRequest.fromBuffer(value),
        ($34.GetAIFinancialAdviceResponse value) => value.writeToBuffer()));
    $addMethod($grpc.ServiceMethod<$34.GetIncomeSourcesRequest,
            $34.GetIncomeSourcesResponse>(
        'GetIncomeSources',
        getIncomeSources_Pre,
        false,
        false,
        ($core.List<$core.int> value) =>
            $34.GetIncomeSourcesRequest.fromBuffer(value),
        ($34.GetIncomeSourcesResponse value) => value.writeToBuffer()));
    $addMethod($grpc.ServiceMethod<$34.GetIncomeBreakdownRequest,
            $34.GetIncomeBreakdownResponse>(
        'GetIncomeBreakdown',
        getIncomeBreakdown_Pre,
        false,
        false,
        ($core.List<$core.int> value) =>
            $34.GetIncomeBreakdownRequest.fromBuffer(value),
        ($34.GetIncomeBreakdownResponse value) => value.writeToBuffer()));
    $addMethod($grpc.ServiceMethod<$34.CreateIncomeSourceRequest,
            $34.CreateIncomeSourceResponse>(
        'CreateIncomeSource',
        createIncomeSource_Pre,
        false,
        false,
        ($core.List<$core.int> value) =>
            $34.CreateIncomeSourceRequest.fromBuffer(value),
        ($34.CreateIncomeSourceResponse value) => value.writeToBuffer()));
    $addMethod($grpc.ServiceMethod<$34.GetInvestmentPortfolioRequest,
            $34.GetInvestmentPortfolioResponse>(
        'GetInvestmentPortfolio',
        getInvestmentPortfolio_Pre,
        false,
        false,
        ($core.List<$core.int> value) =>
            $34.GetInvestmentPortfolioRequest.fromBuffer(value),
        ($34.GetInvestmentPortfolioResponse value) => value.writeToBuffer()));
    $addMethod($grpc.ServiceMethod<$34.CreateInvestmentRequest,
            $34.CreateInvestmentResponse>(
        'CreateInvestment',
        createInvestment_Pre,
        false,
        false,
        ($core.List<$core.int> value) =>
            $34.CreateInvestmentRequest.fromBuffer(value),
        ($34.CreateInvestmentResponse value) => value.writeToBuffer()));
    $addMethod($grpc.ServiceMethod<$34.GetFinancialGoalsRequest,
            $34.GetFinancialGoalsResponse>(
        'GetFinancialGoals',
        getFinancialGoals_Pre,
        false,
        false,
        ($core.List<$core.int> value) =>
            $34.GetFinancialGoalsRequest.fromBuffer(value),
        ($34.GetFinancialGoalsResponse value) => value.writeToBuffer()));
    $addMethod($grpc.ServiceMethod<$34.CreateFinancialGoalRequest,
            $34.CreateFinancialGoalResponse>(
        'CreateFinancialGoal',
        createFinancialGoal_Pre,
        false,
        false,
        ($core.List<$core.int> value) =>
            $34.CreateFinancialGoalRequest.fromBuffer(value),
        ($34.CreateFinancialGoalResponse value) => value.writeToBuffer()));
    $addMethod($grpc.ServiceMethod<$34.UpdateFinancialGoalProgressRequest,
            $34.UpdateFinancialGoalProgressResponse>(
        'UpdateFinancialGoalProgress',
        updateFinancialGoalProgress_Pre,
        false,
        false,
        ($core.List<$core.int> value) =>
            $34.UpdateFinancialGoalProgressRequest.fromBuffer(value),
        ($34.UpdateFinancialGoalProgressResponse value) =>
            value.writeToBuffer()));
    $addMethod($grpc.ServiceMethod<$34.GetSavingsGoalRequest,
            $34.GetSavingsGoalResponse>(
        'GetSavingsGoal',
        getSavingsGoal_Pre,
        false,
        false,
        ($core.List<$core.int> value) =>
            $34.GetSavingsGoalRequest.fromBuffer(value),
        ($34.GetSavingsGoalResponse value) => value.writeToBuffer()));
    $addMethod($grpc.ServiceMethod<$34.CreateOrUpdateSavingsGoalRequest,
            $34.CreateOrUpdateSavingsGoalResponse>(
        'CreateOrUpdateSavingsGoal',
        createOrUpdateSavingsGoal_Pre,
        false,
        false,
        ($core.List<$core.int> value) =>
            $34.CreateOrUpdateSavingsGoalRequest.fromBuffer(value),
        ($34.CreateOrUpdateSavingsGoalResponse value) =>
            value.writeToBuffer()));
    $addMethod($grpc.ServiceMethod<$34.GetUpcomingBillsRequest,
            $34.GetUpcomingBillsResponse>(
        'GetUpcomingBills',
        getUpcomingBills_Pre,
        false,
        false,
        ($core.List<$core.int> value) =>
            $34.GetUpcomingBillsRequest.fromBuffer(value),
        ($34.GetUpcomingBillsResponse value) => value.writeToBuffer()));
    $addMethod($grpc.ServiceMethod<$34.CreateRecurringBillRequest,
            $34.CreateRecurringBillResponse>(
        'CreateRecurringBill',
        createRecurringBill_Pre,
        false,
        false,
        ($core.List<$core.int> value) =>
            $34.CreateRecurringBillRequest.fromBuffer(value),
        ($34.CreateRecurringBillResponse value) => value.writeToBuffer()));
    $addMethod($grpc.ServiceMethod<$34.GetTrackedIncomeRequest,
            $34.GetTrackedIncomeResponse>(
        'GetTrackedIncome',
        getTrackedIncome_Pre,
        false,
        false,
        ($core.List<$core.int> value) =>
            $34.GetTrackedIncomeRequest.fromBuffer(value),
        ($34.GetTrackedIncomeResponse value) => value.writeToBuffer()));
    $addMethod($grpc.ServiceMethod<$34.GetTrackedExpenditureRequest,
            $34.GetTrackedExpenditureResponse>(
        'GetTrackedExpenditure',
        getTrackedExpenditure_Pre,
        false,
        false,
        ($core.List<$core.int> value) =>
            $34.GetTrackedExpenditureRequest.fromBuffer(value),
        ($34.GetTrackedExpenditureResponse value) => value.writeToBuffer()));
    $addMethod($grpc.ServiceMethod<$34.GetTrackedIncomeBreakdownRequest,
            $34.GetTrackedIncomeBreakdownResponse>(
        'GetTrackedIncomeBreakdown',
        getTrackedIncomeBreakdown_Pre,
        false,
        false,
        ($core.List<$core.int> value) =>
            $34.GetTrackedIncomeBreakdownRequest.fromBuffer(value),
        ($34.GetTrackedIncomeBreakdownResponse value) =>
            value.writeToBuffer()));
    $addMethod($grpc.ServiceMethod<$34.GetTrackedExpenditureBreakdownRequest,
            $34.GetTrackedExpenditureBreakdownResponse>(
        'GetTrackedExpenditureBreakdown',
        getTrackedExpenditureBreakdown_Pre,
        false,
        false,
        ($core.List<$core.int> value) =>
            $34.GetTrackedExpenditureBreakdownRequest.fromBuffer(value),
        ($34.GetTrackedExpenditureBreakdownResponse value) =>
            value.writeToBuffer()));
    $addMethod($grpc.ServiceMethod<$34.GetTrackedIncomeTransactionsRequest,
            $34.GetTrackedIncomeTransactionsResponse>(
        'GetTrackedIncomeTransactions',
        getTrackedIncomeTransactions_Pre,
        false,
        false,
        ($core.List<$core.int> value) =>
            $34.GetTrackedIncomeTransactionsRequest.fromBuffer(value),
        ($34.GetTrackedIncomeTransactionsResponse value) =>
            value.writeToBuffer()));
    $addMethod($grpc.ServiceMethod<$34.GetTrackedExpenditureTransactionsRequest,
            $34.GetTrackedExpenditureTransactionsResponse>(
        'GetTrackedExpenditureTransactions',
        getTrackedExpenditureTransactions_Pre,
        false,
        false,
        ($core.List<$core.int> value) =>
            $34.GetTrackedExpenditureTransactionsRequest.fromBuffer(value),
        ($34.GetTrackedExpenditureTransactionsResponse value) =>
            value.writeToBuffer()));
    $addMethod($grpc.ServiceMethod<$34.GetComprehensiveFinancialSummaryRequest,
            $34.GetComprehensiveFinancialSummaryResponse>(
        'GetComprehensiveFinancialSummary',
        getComprehensiveFinancialSummary_Pre,
        false,
        false,
        ($core.List<$core.int> value) =>
            $34.GetComprehensiveFinancialSummaryRequest.fromBuffer(value),
        ($34.GetComprehensiveFinancialSummaryResponse value) =>
            value.writeToBuffer()));
    $addMethod($grpc.ServiceMethod<$34.ValidateCategoryBudgetRequest,
            $34.ValidateCategoryBudgetResponse>(
        'ValidateCategoryBudget',
        validateCategoryBudget_Pre,
        false,
        false,
        ($core.List<$core.int> value) =>
            $34.ValidateCategoryBudgetRequest.fromBuffer(value),
        ($34.ValidateCategoryBudgetResponse value) => value.writeToBuffer()));
    $addMethod($grpc.ServiceMethod<$34.GetServiceCategoriesRequest,
            $34.GetServiceCategoriesResponse>(
        'GetServiceCategories',
        getServiceCategories_Pre,
        false,
        false,
        ($core.List<$core.int> value) =>
            $34.GetServiceCategoriesRequest.fromBuffer(value),
        ($34.GetServiceCategoriesResponse value) => value.writeToBuffer()));
    $addMethod($grpc.ServiceMethod<$34.CreateCustomCategoryRequest,
            $34.CreateCustomCategoryResponse>(
        'CreateCustomCategory',
        createCustomCategory_Pre,
        false,
        false,
        ($core.List<$core.int> value) =>
            $34.CreateCustomCategoryRequest.fromBuffer(value),
        ($34.CreateCustomCategoryResponse value) => value.writeToBuffer()));
    $addMethod($grpc.ServiceMethod<$34.DeleteCustomCategoryRequest,
            $34.DeleteCustomCategoryResponse>(
        'DeleteCustomCategory',
        deleteCustomCategory_Pre,
        false,
        false,
        ($core.List<$core.int> value) =>
            $34.DeleteCustomCategoryRequest.fromBuffer(value),
        ($34.DeleteCustomCategoryResponse value) => value.writeToBuffer()));
  }

  $async.Future<$34.CreateExpenseResponse> createExpense_Pre(
      $grpc.ServiceCall call,
      $async.Future<$34.CreateExpenseRequest> request) async {
    return createExpense(call, await request);
  }

  $async.Future<$34.GetExpensesResponse> getExpenses_Pre($grpc.ServiceCall call,
      $async.Future<$34.GetExpensesRequest> request) async {
    return getExpenses(call, await request);
  }

  $async.Future<$34.GetExpenseByIdResponse> getExpenseById_Pre(
      $grpc.ServiceCall call,
      $async.Future<$34.GetExpenseByIdRequest> request) async {
    return getExpenseById(call, await request);
  }

  $async.Future<$34.UpdateExpenseResponse> updateExpense_Pre(
      $grpc.ServiceCall call,
      $async.Future<$34.UpdateExpenseRequest> request) async {
    return updateExpense(call, await request);
  }

  $async.Future<$34.DeleteExpenseResponse> deleteExpense_Pre(
      $grpc.ServiceCall call,
      $async.Future<$34.DeleteExpenseRequest> request) async {
    return deleteExpense(call, await request);
  }

  $async.Future<$34.CreateBudgetResponse> createBudget_Pre(
      $grpc.ServiceCall call,
      $async.Future<$34.CreateBudgetRequest> request) async {
    return createBudget(call, await request);
  }

  $async.Future<$34.GetBudgetsResponse> getBudgets_Pre($grpc.ServiceCall call,
      $async.Future<$34.GetBudgetsRequest> request) async {
    return getBudgets(call, await request);
  }

  $async.Future<$34.GetBudgetByIdResponse> getBudgetById_Pre(
      $grpc.ServiceCall call,
      $async.Future<$34.GetBudgetByIdRequest> request) async {
    return getBudgetById(call, await request);
  }

  $async.Future<$34.UpdateBudgetResponse> updateBudget_Pre(
      $grpc.ServiceCall call,
      $async.Future<$34.UpdateBudgetRequest> request) async {
    return updateBudget(call, await request);
  }

  $async.Future<$34.DeleteBudgetResponse> deleteBudget_Pre(
      $grpc.ServiceCall call,
      $async.Future<$34.DeleteBudgetRequest> request) async {
    return deleteBudget(call, await request);
  }

  $async.Future<$34.GetSpendingAnalyticsResponse> getSpendingAnalytics_Pre(
      $grpc.ServiceCall call,
      $async.Future<$34.GetSpendingAnalyticsRequest> request) async {
    return getSpendingAnalytics(call, await request);
  }

  $async.Future<$34.GetCategoryBreakdownResponse> getCategoryBreakdown_Pre(
      $grpc.ServiceCall call,
      $async.Future<$34.GetCategoryBreakdownRequest> request) async {
    return getCategoryBreakdown(call, await request);
  }

  $async.Future<$34.GetBudgetProgressResponse> getBudgetProgress_Pre(
      $grpc.ServiceCall call,
      $async.Future<$34.GetBudgetProgressRequest> request) async {
    return getBudgetProgress(call, await request);
  }

  $async.Future<$34.GetSpendingTrendsResponse> getSpendingTrends_Pre(
      $grpc.ServiceCall call,
      $async.Future<$34.GetSpendingTrendsRequest> request) async {
    return getSpendingTrends(call, await request);
  }

  $async.Future<$34.GetBudgetAlertsResponse> getBudgetAlerts_Pre(
      $grpc.ServiceCall call,
      $async.Future<$34.GetBudgetAlertsRequest> request) async {
    return getBudgetAlerts(call, await request);
  }

  $async.Future<$34.MarkAlertAsReadResponse> markAlertAsRead_Pre(
      $grpc.ServiceCall call,
      $async.Future<$34.MarkAlertAsReadRequest> request) async {
    return markAlertAsRead(call, await request);
  }

  $async.Future<$34.GetAISpendingInsightsResponse> getAISpendingInsights_Pre(
      $grpc.ServiceCall call,
      $async.Future<$34.GetAISpendingInsightsRequest> request) async {
    return getAISpendingInsights(call, await request);
  }

  $async.Future<$34.GetAIBudgetingRecommendationsResponse>
      getAIBudgetingRecommendations_Pre(
          $grpc.ServiceCall call,
          $async.Future<$34.GetAIBudgetingRecommendationsRequest>
              request) async {
    return getAIBudgetingRecommendations(call, await request);
  }

  $async.Future<$34.AutoCategorizeExpenseResponse> autoCategorizeExpense_Pre(
      $grpc.ServiceCall call,
      $async.Future<$34.AutoCategorizeExpenseRequest> request) async {
    return autoCategorizeExpense(call, await request);
  }

  $async.Future<$34.GetAIFinancialAdviceResponse> getAIFinancialAdvice_Pre(
      $grpc.ServiceCall call,
      $async.Future<$34.GetAIFinancialAdviceRequest> request) async {
    return getAIFinancialAdvice(call, await request);
  }

  $async.Future<$34.GetIncomeSourcesResponse> getIncomeSources_Pre(
      $grpc.ServiceCall call,
      $async.Future<$34.GetIncomeSourcesRequest> request) async {
    return getIncomeSources(call, await request);
  }

  $async.Future<$34.GetIncomeBreakdownResponse> getIncomeBreakdown_Pre(
      $grpc.ServiceCall call,
      $async.Future<$34.GetIncomeBreakdownRequest> request) async {
    return getIncomeBreakdown(call, await request);
  }

  $async.Future<$34.CreateIncomeSourceResponse> createIncomeSource_Pre(
      $grpc.ServiceCall call,
      $async.Future<$34.CreateIncomeSourceRequest> request) async {
    return createIncomeSource(call, await request);
  }

  $async.Future<$34.GetInvestmentPortfolioResponse> getInvestmentPortfolio_Pre(
      $grpc.ServiceCall call,
      $async.Future<$34.GetInvestmentPortfolioRequest> request) async {
    return getInvestmentPortfolio(call, await request);
  }

  $async.Future<$34.CreateInvestmentResponse> createInvestment_Pre(
      $grpc.ServiceCall call,
      $async.Future<$34.CreateInvestmentRequest> request) async {
    return createInvestment(call, await request);
  }

  $async.Future<$34.GetFinancialGoalsResponse> getFinancialGoals_Pre(
      $grpc.ServiceCall call,
      $async.Future<$34.GetFinancialGoalsRequest> request) async {
    return getFinancialGoals(call, await request);
  }

  $async.Future<$34.CreateFinancialGoalResponse> createFinancialGoal_Pre(
      $grpc.ServiceCall call,
      $async.Future<$34.CreateFinancialGoalRequest> request) async {
    return createFinancialGoal(call, await request);
  }

  $async.Future<$34.UpdateFinancialGoalProgressResponse>
      updateFinancialGoalProgress_Pre($grpc.ServiceCall call,
          $async.Future<$34.UpdateFinancialGoalProgressRequest> request) async {
    return updateFinancialGoalProgress(call, await request);
  }

  $async.Future<$34.GetSavingsGoalResponse> getSavingsGoal_Pre(
      $grpc.ServiceCall call,
      $async.Future<$34.GetSavingsGoalRequest> request) async {
    return getSavingsGoal(call, await request);
  }

  $async.Future<$34.CreateOrUpdateSavingsGoalResponse>
      createOrUpdateSavingsGoal_Pre($grpc.ServiceCall call,
          $async.Future<$34.CreateOrUpdateSavingsGoalRequest> request) async {
    return createOrUpdateSavingsGoal(call, await request);
  }

  $async.Future<$34.GetUpcomingBillsResponse> getUpcomingBills_Pre(
      $grpc.ServiceCall call,
      $async.Future<$34.GetUpcomingBillsRequest> request) async {
    return getUpcomingBills(call, await request);
  }

  $async.Future<$34.CreateRecurringBillResponse> createRecurringBill_Pre(
      $grpc.ServiceCall call,
      $async.Future<$34.CreateRecurringBillRequest> request) async {
    return createRecurringBill(call, await request);
  }

  $async.Future<$34.GetTrackedIncomeResponse> getTrackedIncome_Pre(
      $grpc.ServiceCall call,
      $async.Future<$34.GetTrackedIncomeRequest> request) async {
    return getTrackedIncome(call, await request);
  }

  $async.Future<$34.GetTrackedExpenditureResponse> getTrackedExpenditure_Pre(
      $grpc.ServiceCall call,
      $async.Future<$34.GetTrackedExpenditureRequest> request) async {
    return getTrackedExpenditure(call, await request);
  }

  $async.Future<$34.GetTrackedIncomeBreakdownResponse>
      getTrackedIncomeBreakdown_Pre($grpc.ServiceCall call,
          $async.Future<$34.GetTrackedIncomeBreakdownRequest> request) async {
    return getTrackedIncomeBreakdown(call, await request);
  }

  $async.Future<$34.GetTrackedExpenditureBreakdownResponse>
      getTrackedExpenditureBreakdown_Pre(
          $grpc.ServiceCall call,
          $async.Future<$34.GetTrackedExpenditureBreakdownRequest>
              request) async {
    return getTrackedExpenditureBreakdown(call, await request);
  }

  $async.Future<$34.GetTrackedIncomeTransactionsResponse>
      getTrackedIncomeTransactions_Pre(
          $grpc.ServiceCall call,
          $async.Future<$34.GetTrackedIncomeTransactionsRequest>
              request) async {
    return getTrackedIncomeTransactions(call, await request);
  }

  $async.Future<$34.GetTrackedExpenditureTransactionsResponse>
      getTrackedExpenditureTransactions_Pre(
          $grpc.ServiceCall call,
          $async.Future<$34.GetTrackedExpenditureTransactionsRequest>
              request) async {
    return getTrackedExpenditureTransactions(call, await request);
  }

  $async.Future<$34.GetComprehensiveFinancialSummaryResponse>
      getComprehensiveFinancialSummary_Pre(
          $grpc.ServiceCall call,
          $async.Future<$34.GetComprehensiveFinancialSummaryRequest>
              request) async {
    return getComprehensiveFinancialSummary(call, await request);
  }

  $async.Future<$34.ValidateCategoryBudgetResponse> validateCategoryBudget_Pre(
      $grpc.ServiceCall call,
      $async.Future<$34.ValidateCategoryBudgetRequest> request) async {
    return validateCategoryBudget(call, await request);
  }

  $async.Future<$34.GetServiceCategoriesResponse> getServiceCategories_Pre(
      $grpc.ServiceCall call,
      $async.Future<$34.GetServiceCategoriesRequest> request) async {
    return getServiceCategories(call, await request);
  }

  $async.Future<$34.CreateCustomCategoryResponse> createCustomCategory_Pre(
      $grpc.ServiceCall call,
      $async.Future<$34.CreateCustomCategoryRequest> request) async {
    return createCustomCategory(call, await request);
  }

  $async.Future<$34.DeleteCustomCategoryResponse> deleteCustomCategory_Pre(
      $grpc.ServiceCall call,
      $async.Future<$34.DeleteCustomCategoryRequest> request) async {
    return deleteCustomCategory(call, await request);
  }

  $async.Future<$34.CreateExpenseResponse> createExpense(
      $grpc.ServiceCall call, $34.CreateExpenseRequest request);
  $async.Future<$34.GetExpensesResponse> getExpenses(
      $grpc.ServiceCall call, $34.GetExpensesRequest request);
  $async.Future<$34.GetExpenseByIdResponse> getExpenseById(
      $grpc.ServiceCall call, $34.GetExpenseByIdRequest request);
  $async.Future<$34.UpdateExpenseResponse> updateExpense(
      $grpc.ServiceCall call, $34.UpdateExpenseRequest request);
  $async.Future<$34.DeleteExpenseResponse> deleteExpense(
      $grpc.ServiceCall call, $34.DeleteExpenseRequest request);
  $async.Future<$34.CreateBudgetResponse> createBudget(
      $grpc.ServiceCall call, $34.CreateBudgetRequest request);
  $async.Future<$34.GetBudgetsResponse> getBudgets(
      $grpc.ServiceCall call, $34.GetBudgetsRequest request);
  $async.Future<$34.GetBudgetByIdResponse> getBudgetById(
      $grpc.ServiceCall call, $34.GetBudgetByIdRequest request);
  $async.Future<$34.UpdateBudgetResponse> updateBudget(
      $grpc.ServiceCall call, $34.UpdateBudgetRequest request);
  $async.Future<$34.DeleteBudgetResponse> deleteBudget(
      $grpc.ServiceCall call, $34.DeleteBudgetRequest request);
  $async.Future<$34.GetSpendingAnalyticsResponse> getSpendingAnalytics(
      $grpc.ServiceCall call, $34.GetSpendingAnalyticsRequest request);
  $async.Future<$34.GetCategoryBreakdownResponse> getCategoryBreakdown(
      $grpc.ServiceCall call, $34.GetCategoryBreakdownRequest request);
  $async.Future<$34.GetBudgetProgressResponse> getBudgetProgress(
      $grpc.ServiceCall call, $34.GetBudgetProgressRequest request);
  $async.Future<$34.GetSpendingTrendsResponse> getSpendingTrends(
      $grpc.ServiceCall call, $34.GetSpendingTrendsRequest request);
  $async.Future<$34.GetBudgetAlertsResponse> getBudgetAlerts(
      $grpc.ServiceCall call, $34.GetBudgetAlertsRequest request);
  $async.Future<$34.MarkAlertAsReadResponse> markAlertAsRead(
      $grpc.ServiceCall call, $34.MarkAlertAsReadRequest request);
  $async.Future<$34.GetAISpendingInsightsResponse> getAISpendingInsights(
      $grpc.ServiceCall call, $34.GetAISpendingInsightsRequest request);
  $async.Future<$34.GetAIBudgetingRecommendationsResponse>
      getAIBudgetingRecommendations($grpc.ServiceCall call,
          $34.GetAIBudgetingRecommendationsRequest request);
  $async.Future<$34.AutoCategorizeExpenseResponse> autoCategorizeExpense(
      $grpc.ServiceCall call, $34.AutoCategorizeExpenseRequest request);
  $async.Future<$34.GetAIFinancialAdviceResponse> getAIFinancialAdvice(
      $grpc.ServiceCall call, $34.GetAIFinancialAdviceRequest request);
  $async.Future<$34.GetIncomeSourcesResponse> getIncomeSources(
      $grpc.ServiceCall call, $34.GetIncomeSourcesRequest request);
  $async.Future<$34.GetIncomeBreakdownResponse> getIncomeBreakdown(
      $grpc.ServiceCall call, $34.GetIncomeBreakdownRequest request);
  $async.Future<$34.CreateIncomeSourceResponse> createIncomeSource(
      $grpc.ServiceCall call, $34.CreateIncomeSourceRequest request);
  $async.Future<$34.GetInvestmentPortfolioResponse> getInvestmentPortfolio(
      $grpc.ServiceCall call, $34.GetInvestmentPortfolioRequest request);
  $async.Future<$34.CreateInvestmentResponse> createInvestment(
      $grpc.ServiceCall call, $34.CreateInvestmentRequest request);
  $async.Future<$34.GetFinancialGoalsResponse> getFinancialGoals(
      $grpc.ServiceCall call, $34.GetFinancialGoalsRequest request);
  $async.Future<$34.CreateFinancialGoalResponse> createFinancialGoal(
      $grpc.ServiceCall call, $34.CreateFinancialGoalRequest request);
  $async.Future<$34.UpdateFinancialGoalProgressResponse>
      updateFinancialGoalProgress($grpc.ServiceCall call,
          $34.UpdateFinancialGoalProgressRequest request);
  $async.Future<$34.GetSavingsGoalResponse> getSavingsGoal(
      $grpc.ServiceCall call, $34.GetSavingsGoalRequest request);
  $async.Future<$34.CreateOrUpdateSavingsGoalResponse>
      createOrUpdateSavingsGoal(
          $grpc.ServiceCall call, $34.CreateOrUpdateSavingsGoalRequest request);
  $async.Future<$34.GetUpcomingBillsResponse> getUpcomingBills(
      $grpc.ServiceCall call, $34.GetUpcomingBillsRequest request);
  $async.Future<$34.CreateRecurringBillResponse> createRecurringBill(
      $grpc.ServiceCall call, $34.CreateRecurringBillRequest request);
  $async.Future<$34.GetTrackedIncomeResponse> getTrackedIncome(
      $grpc.ServiceCall call, $34.GetTrackedIncomeRequest request);
  $async.Future<$34.GetTrackedExpenditureResponse> getTrackedExpenditure(
      $grpc.ServiceCall call, $34.GetTrackedExpenditureRequest request);
  $async.Future<$34.GetTrackedIncomeBreakdownResponse>
      getTrackedIncomeBreakdown(
          $grpc.ServiceCall call, $34.GetTrackedIncomeBreakdownRequest request);
  $async.Future<$34.GetTrackedExpenditureBreakdownResponse>
      getTrackedExpenditureBreakdown($grpc.ServiceCall call,
          $34.GetTrackedExpenditureBreakdownRequest request);
  $async.Future<$34.GetTrackedIncomeTransactionsResponse>
      getTrackedIncomeTransactions($grpc.ServiceCall call,
          $34.GetTrackedIncomeTransactionsRequest request);
  $async.Future<$34.GetTrackedExpenditureTransactionsResponse>
      getTrackedExpenditureTransactions($grpc.ServiceCall call,
          $34.GetTrackedExpenditureTransactionsRequest request);
  $async.Future<$34.GetComprehensiveFinancialSummaryResponse>
      getComprehensiveFinancialSummary($grpc.ServiceCall call,
          $34.GetComprehensiveFinancialSummaryRequest request);
  $async.Future<$34.ValidateCategoryBudgetResponse> validateCategoryBudget(
      $grpc.ServiceCall call, $34.ValidateCategoryBudgetRequest request);
  $async.Future<$34.GetServiceCategoriesResponse> getServiceCategories(
      $grpc.ServiceCall call, $34.GetServiceCategoriesRequest request);
  $async.Future<$34.CreateCustomCategoryResponse> createCustomCategory(
      $grpc.ServiceCall call, $34.CreateCustomCategoryRequest request);
  $async.Future<$34.DeleteCustomCategoryResponse> deleteCustomCategory(
      $grpc.ServiceCall call, $34.DeleteCustomCategoryRequest request);
}
