///
//  Generated code. Do not modify.
//  source: statistics.proto
//
// @dart = 2.12
// ignore_for_file: annotate_overrides,camel_case_types,constant_identifier_names,directives_ordering,library_prefixes,non_constant_identifier_names,prefer_final_fields,return_of_invalid_type,unnecessary_const,unnecessary_import,unnecessary_this,unused_import,unused_shown_name

import 'dart:async' as $async;

import 'dart:core' as $core;

import 'package:grpc/service_api.dart' as $grpc;
import 'statistics.pb.dart' as $35;
export 'statistics.pb.dart';

class StatisticsServiceClient extends $grpc.Client {
  static final _$createExpense =
      $grpc.ClientMethod<$35.CreateExpenseRequest, $35.CreateExpenseResponse>(
          '/pb.StatisticsService/CreateExpense',
          ($35.CreateExpenseRequest value) => value.writeToBuffer(),
          ($core.List<$core.int> value) =>
              $35.CreateExpenseResponse.fromBuffer(value));
  static final _$getExpenses =
      $grpc.ClientMethod<$35.GetExpensesRequest, $35.GetExpensesResponse>(
          '/pb.StatisticsService/GetExpenses',
          ($35.GetExpensesRequest value) => value.writeToBuffer(),
          ($core.List<$core.int> value) =>
              $35.GetExpensesResponse.fromBuffer(value));
  static final _$getExpenseById =
      $grpc.ClientMethod<$35.GetExpenseByIdRequest, $35.GetExpenseByIdResponse>(
          '/pb.StatisticsService/GetExpenseById',
          ($35.GetExpenseByIdRequest value) => value.writeToBuffer(),
          ($core.List<$core.int> value) =>
              $35.GetExpenseByIdResponse.fromBuffer(value));
  static final _$updateExpense =
      $grpc.ClientMethod<$35.UpdateExpenseRequest, $35.UpdateExpenseResponse>(
          '/pb.StatisticsService/UpdateExpense',
          ($35.UpdateExpenseRequest value) => value.writeToBuffer(),
          ($core.List<$core.int> value) =>
              $35.UpdateExpenseResponse.fromBuffer(value));
  static final _$deleteExpense =
      $grpc.ClientMethod<$35.DeleteExpenseRequest, $35.DeleteExpenseResponse>(
          '/pb.StatisticsService/DeleteExpense',
          ($35.DeleteExpenseRequest value) => value.writeToBuffer(),
          ($core.List<$core.int> value) =>
              $35.DeleteExpenseResponse.fromBuffer(value));
  static final _$createBudget =
      $grpc.ClientMethod<$35.CreateBudgetRequest, $35.CreateBudgetResponse>(
          '/pb.StatisticsService/CreateBudget',
          ($35.CreateBudgetRequest value) => value.writeToBuffer(),
          ($core.List<$core.int> value) =>
              $35.CreateBudgetResponse.fromBuffer(value));
  static final _$getBudgets =
      $grpc.ClientMethod<$35.GetBudgetsRequest, $35.GetBudgetsResponse>(
          '/pb.StatisticsService/GetBudgets',
          ($35.GetBudgetsRequest value) => value.writeToBuffer(),
          ($core.List<$core.int> value) =>
              $35.GetBudgetsResponse.fromBuffer(value));
  static final _$getBudgetById =
      $grpc.ClientMethod<$35.GetBudgetByIdRequest, $35.GetBudgetByIdResponse>(
          '/pb.StatisticsService/GetBudgetById',
          ($35.GetBudgetByIdRequest value) => value.writeToBuffer(),
          ($core.List<$core.int> value) =>
              $35.GetBudgetByIdResponse.fromBuffer(value));
  static final _$updateBudget =
      $grpc.ClientMethod<$35.UpdateBudgetRequest, $35.UpdateBudgetResponse>(
          '/pb.StatisticsService/UpdateBudget',
          ($35.UpdateBudgetRequest value) => value.writeToBuffer(),
          ($core.List<$core.int> value) =>
              $35.UpdateBudgetResponse.fromBuffer(value));
  static final _$deleteBudget =
      $grpc.ClientMethod<$35.DeleteBudgetRequest, $35.DeleteBudgetResponse>(
          '/pb.StatisticsService/DeleteBudget',
          ($35.DeleteBudgetRequest value) => value.writeToBuffer(),
          ($core.List<$core.int> value) =>
              $35.DeleteBudgetResponse.fromBuffer(value));
  static final _$getSpendingAnalytics = $grpc.ClientMethod<
          $35.GetSpendingAnalyticsRequest, $35.GetSpendingAnalyticsResponse>(
      '/pb.StatisticsService/GetSpendingAnalytics',
      ($35.GetSpendingAnalyticsRequest value) => value.writeToBuffer(),
      ($core.List<$core.int> value) =>
          $35.GetSpendingAnalyticsResponse.fromBuffer(value));
  static final _$getCategoryBreakdown = $grpc.ClientMethod<
          $35.GetCategoryBreakdownRequest, $35.GetCategoryBreakdownResponse>(
      '/pb.StatisticsService/GetCategoryBreakdown',
      ($35.GetCategoryBreakdownRequest value) => value.writeToBuffer(),
      ($core.List<$core.int> value) =>
          $35.GetCategoryBreakdownResponse.fromBuffer(value));
  static final _$getBudgetProgress = $grpc.ClientMethod<
          $35.GetBudgetProgressRequest, $35.GetBudgetProgressResponse>(
      '/pb.StatisticsService/GetBudgetProgress',
      ($35.GetBudgetProgressRequest value) => value.writeToBuffer(),
      ($core.List<$core.int> value) =>
          $35.GetBudgetProgressResponse.fromBuffer(value));
  static final _$getSpendingTrends = $grpc.ClientMethod<
          $35.GetSpendingTrendsRequest, $35.GetSpendingTrendsResponse>(
      '/pb.StatisticsService/GetSpendingTrends',
      ($35.GetSpendingTrendsRequest value) => value.writeToBuffer(),
      ($core.List<$core.int> value) =>
          $35.GetSpendingTrendsResponse.fromBuffer(value));
  static final _$getBudgetAlerts = $grpc.ClientMethod<
          $35.GetBudgetAlertsRequest, $35.GetBudgetAlertsResponse>(
      '/pb.StatisticsService/GetBudgetAlerts',
      ($35.GetBudgetAlertsRequest value) => value.writeToBuffer(),
      ($core.List<$core.int> value) =>
          $35.GetBudgetAlertsResponse.fromBuffer(value));
  static final _$markAlertAsRead = $grpc.ClientMethod<
          $35.MarkAlertAsReadRequest, $35.MarkAlertAsReadResponse>(
      '/pb.StatisticsService/MarkAlertAsRead',
      ($35.MarkAlertAsReadRequest value) => value.writeToBuffer(),
      ($core.List<$core.int> value) =>
          $35.MarkAlertAsReadResponse.fromBuffer(value));
  static final _$getAISpendingInsights = $grpc.ClientMethod<
          $35.GetAISpendingInsightsRequest, $35.GetAISpendingInsightsResponse>(
      '/pb.StatisticsService/GetAISpendingInsights',
      ($35.GetAISpendingInsightsRequest value) => value.writeToBuffer(),
      ($core.List<$core.int> value) =>
          $35.GetAISpendingInsightsResponse.fromBuffer(value));
  static final _$getAIBudgetingRecommendations = $grpc.ClientMethod<
          $35.GetAIBudgetingRecommendationsRequest,
          $35.GetAIBudgetingRecommendationsResponse>(
      '/pb.StatisticsService/GetAIBudgetingRecommendations',
      ($35.GetAIBudgetingRecommendationsRequest value) => value.writeToBuffer(),
      ($core.List<$core.int> value) =>
          $35.GetAIBudgetingRecommendationsResponse.fromBuffer(value));
  static final _$autoCategorizeExpense = $grpc.ClientMethod<
          $35.AutoCategorizeExpenseRequest, $35.AutoCategorizeExpenseResponse>(
      '/pb.StatisticsService/AutoCategorizeExpense',
      ($35.AutoCategorizeExpenseRequest value) => value.writeToBuffer(),
      ($core.List<$core.int> value) =>
          $35.AutoCategorizeExpenseResponse.fromBuffer(value));
  static final _$getAIFinancialAdvice = $grpc.ClientMethod<
          $35.GetAIFinancialAdviceRequest, $35.GetAIFinancialAdviceResponse>(
      '/pb.StatisticsService/GetAIFinancialAdvice',
      ($35.GetAIFinancialAdviceRequest value) => value.writeToBuffer(),
      ($core.List<$core.int> value) =>
          $35.GetAIFinancialAdviceResponse.fromBuffer(value));
  static final _$getIncomeSources = $grpc.ClientMethod<
          $35.GetIncomeSourcesRequest, $35.GetIncomeSourcesResponse>(
      '/pb.StatisticsService/GetIncomeSources',
      ($35.GetIncomeSourcesRequest value) => value.writeToBuffer(),
      ($core.List<$core.int> value) =>
          $35.GetIncomeSourcesResponse.fromBuffer(value));
  static final _$getIncomeBreakdown = $grpc.ClientMethod<
          $35.GetIncomeBreakdownRequest, $35.GetIncomeBreakdownResponse>(
      '/pb.StatisticsService/GetIncomeBreakdown',
      ($35.GetIncomeBreakdownRequest value) => value.writeToBuffer(),
      ($core.List<$core.int> value) =>
          $35.GetIncomeBreakdownResponse.fromBuffer(value));
  static final _$createIncomeSource = $grpc.ClientMethod<
          $35.CreateIncomeSourceRequest, $35.CreateIncomeSourceResponse>(
      '/pb.StatisticsService/CreateIncomeSource',
      ($35.CreateIncomeSourceRequest value) => value.writeToBuffer(),
      ($core.List<$core.int> value) =>
          $35.CreateIncomeSourceResponse.fromBuffer(value));
  static final _$getInvestmentPortfolio = $grpc.ClientMethod<
          $35.GetInvestmentPortfolioRequest,
          $35.GetInvestmentPortfolioResponse>(
      '/pb.StatisticsService/GetInvestmentPortfolio',
      ($35.GetInvestmentPortfolioRequest value) => value.writeToBuffer(),
      ($core.List<$core.int> value) =>
          $35.GetInvestmentPortfolioResponse.fromBuffer(value));
  static final _$createInvestment = $grpc.ClientMethod<
          $35.CreateInvestmentRequest, $35.CreateInvestmentResponse>(
      '/pb.StatisticsService/CreateInvestment',
      ($35.CreateInvestmentRequest value) => value.writeToBuffer(),
      ($core.List<$core.int> value) =>
          $35.CreateInvestmentResponse.fromBuffer(value));
  static final _$getFinancialGoals = $grpc.ClientMethod<
          $35.GetFinancialGoalsRequest, $35.GetFinancialGoalsResponse>(
      '/pb.StatisticsService/GetFinancialGoals',
      ($35.GetFinancialGoalsRequest value) => value.writeToBuffer(),
      ($core.List<$core.int> value) =>
          $35.GetFinancialGoalsResponse.fromBuffer(value));
  static final _$createFinancialGoal = $grpc.ClientMethod<
          $35.CreateFinancialGoalRequest, $35.CreateFinancialGoalResponse>(
      '/pb.StatisticsService/CreateFinancialGoal',
      ($35.CreateFinancialGoalRequest value) => value.writeToBuffer(),
      ($core.List<$core.int> value) =>
          $35.CreateFinancialGoalResponse.fromBuffer(value));
  static final _$updateFinancialGoalProgress = $grpc.ClientMethod<
          $35.UpdateFinancialGoalProgressRequest,
          $35.UpdateFinancialGoalProgressResponse>(
      '/pb.StatisticsService/UpdateFinancialGoalProgress',
      ($35.UpdateFinancialGoalProgressRequest value) => value.writeToBuffer(),
      ($core.List<$core.int> value) =>
          $35.UpdateFinancialGoalProgressResponse.fromBuffer(value));
  static final _$getSavingsGoal =
      $grpc.ClientMethod<$35.GetSavingsGoalRequest, $35.GetSavingsGoalResponse>(
          '/pb.StatisticsService/GetSavingsGoal',
          ($35.GetSavingsGoalRequest value) => value.writeToBuffer(),
          ($core.List<$core.int> value) =>
              $35.GetSavingsGoalResponse.fromBuffer(value));
  static final _$createOrUpdateSavingsGoal = $grpc.ClientMethod<
          $35.CreateOrUpdateSavingsGoalRequest,
          $35.CreateOrUpdateSavingsGoalResponse>(
      '/pb.StatisticsService/CreateOrUpdateSavingsGoal',
      ($35.CreateOrUpdateSavingsGoalRequest value) => value.writeToBuffer(),
      ($core.List<$core.int> value) =>
          $35.CreateOrUpdateSavingsGoalResponse.fromBuffer(value));
  static final _$getUpcomingBills = $grpc.ClientMethod<
          $35.GetUpcomingBillsRequest, $35.GetUpcomingBillsResponse>(
      '/pb.StatisticsService/GetUpcomingBills',
      ($35.GetUpcomingBillsRequest value) => value.writeToBuffer(),
      ($core.List<$core.int> value) =>
          $35.GetUpcomingBillsResponse.fromBuffer(value));
  static final _$createRecurringBill = $grpc.ClientMethod<
          $35.CreateRecurringBillRequest, $35.CreateRecurringBillResponse>(
      '/pb.StatisticsService/CreateRecurringBill',
      ($35.CreateRecurringBillRequest value) => value.writeToBuffer(),
      ($core.List<$core.int> value) =>
          $35.CreateRecurringBillResponse.fromBuffer(value));
  static final _$getTrackedIncome = $grpc.ClientMethod<
          $35.GetTrackedIncomeRequest, $35.GetTrackedIncomeResponse>(
      '/pb.StatisticsService/GetTrackedIncome',
      ($35.GetTrackedIncomeRequest value) => value.writeToBuffer(),
      ($core.List<$core.int> value) =>
          $35.GetTrackedIncomeResponse.fromBuffer(value));
  static final _$getTrackedExpenditure = $grpc.ClientMethod<
          $35.GetTrackedExpenditureRequest, $35.GetTrackedExpenditureResponse>(
      '/pb.StatisticsService/GetTrackedExpenditure',
      ($35.GetTrackedExpenditureRequest value) => value.writeToBuffer(),
      ($core.List<$core.int> value) =>
          $35.GetTrackedExpenditureResponse.fromBuffer(value));
  static final _$getTrackedIncomeBreakdown = $grpc.ClientMethod<
          $35.GetTrackedIncomeBreakdownRequest,
          $35.GetTrackedIncomeBreakdownResponse>(
      '/pb.StatisticsService/GetTrackedIncomeBreakdown',
      ($35.GetTrackedIncomeBreakdownRequest value) => value.writeToBuffer(),
      ($core.List<$core.int> value) =>
          $35.GetTrackedIncomeBreakdownResponse.fromBuffer(value));
  static final _$getTrackedExpenditureBreakdown = $grpc.ClientMethod<
          $35.GetTrackedExpenditureBreakdownRequest,
          $35.GetTrackedExpenditureBreakdownResponse>(
      '/pb.StatisticsService/GetTrackedExpenditureBreakdown',
      ($35.GetTrackedExpenditureBreakdownRequest value) =>
          value.writeToBuffer(),
      ($core.List<$core.int> value) =>
          $35.GetTrackedExpenditureBreakdownResponse.fromBuffer(value));
  static final _$getTrackedIncomeTransactions = $grpc.ClientMethod<
          $35.GetTrackedIncomeTransactionsRequest,
          $35.GetTrackedIncomeTransactionsResponse>(
      '/pb.StatisticsService/GetTrackedIncomeTransactions',
      ($35.GetTrackedIncomeTransactionsRequest value) => value.writeToBuffer(),
      ($core.List<$core.int> value) =>
          $35.GetTrackedIncomeTransactionsResponse.fromBuffer(value));
  static final _$getTrackedExpenditureTransactions = $grpc.ClientMethod<
          $35.GetTrackedExpenditureTransactionsRequest,
          $35.GetTrackedExpenditureTransactionsResponse>(
      '/pb.StatisticsService/GetTrackedExpenditureTransactions',
      ($35.GetTrackedExpenditureTransactionsRequest value) =>
          value.writeToBuffer(),
      ($core.List<$core.int> value) =>
          $35.GetTrackedExpenditureTransactionsResponse.fromBuffer(value));
  static final _$getComprehensiveFinancialSummary = $grpc.ClientMethod<
          $35.GetComprehensiveFinancialSummaryRequest,
          $35.GetComprehensiveFinancialSummaryResponse>(
      '/pb.StatisticsService/GetComprehensiveFinancialSummary',
      ($35.GetComprehensiveFinancialSummaryRequest value) =>
          value.writeToBuffer(),
      ($core.List<$core.int> value) =>
          $35.GetComprehensiveFinancialSummaryResponse.fromBuffer(value));
  static final _$validateCategoryBudget = $grpc.ClientMethod<
          $35.ValidateCategoryBudgetRequest,
          $35.ValidateCategoryBudgetResponse>(
      '/pb.StatisticsService/ValidateCategoryBudget',
      ($35.ValidateCategoryBudgetRequest value) => value.writeToBuffer(),
      ($core.List<$core.int> value) =>
          $35.ValidateCategoryBudgetResponse.fromBuffer(value));
  static final _$getServiceCategories = $grpc.ClientMethod<
          $35.GetServiceCategoriesRequest, $35.GetServiceCategoriesResponse>(
      '/pb.StatisticsService/GetServiceCategories',
      ($35.GetServiceCategoriesRequest value) => value.writeToBuffer(),
      ($core.List<$core.int> value) =>
          $35.GetServiceCategoriesResponse.fromBuffer(value));
  static final _$createCustomCategory = $grpc.ClientMethod<
          $35.CreateCustomCategoryRequest, $35.CreateCustomCategoryResponse>(
      '/pb.StatisticsService/CreateCustomCategory',
      ($35.CreateCustomCategoryRequest value) => value.writeToBuffer(),
      ($core.List<$core.int> value) =>
          $35.CreateCustomCategoryResponse.fromBuffer(value));
  static final _$deleteCustomCategory = $grpc.ClientMethod<
          $35.DeleteCustomCategoryRequest, $35.DeleteCustomCategoryResponse>(
      '/pb.StatisticsService/DeleteCustomCategory',
      ($35.DeleteCustomCategoryRequest value) => value.writeToBuffer(),
      ($core.List<$core.int> value) =>
          $35.DeleteCustomCategoryResponse.fromBuffer(value));

  StatisticsServiceClient($grpc.ClientChannel channel,
      {$grpc.CallOptions? options,
      $core.Iterable<$grpc.ClientInterceptor>? interceptors})
      : super(channel, options: options, interceptors: interceptors);

  $grpc.ResponseFuture<$35.CreateExpenseResponse> createExpense(
      $35.CreateExpenseRequest request,
      {$grpc.CallOptions? options}) {
    return $createUnaryCall(_$createExpense, request, options: options);
  }

  $grpc.ResponseFuture<$35.GetExpensesResponse> getExpenses(
      $35.GetExpensesRequest request,
      {$grpc.CallOptions? options}) {
    return $createUnaryCall(_$getExpenses, request, options: options);
  }

  $grpc.ResponseFuture<$35.GetExpenseByIdResponse> getExpenseById(
      $35.GetExpenseByIdRequest request,
      {$grpc.CallOptions? options}) {
    return $createUnaryCall(_$getExpenseById, request, options: options);
  }

  $grpc.ResponseFuture<$35.UpdateExpenseResponse> updateExpense(
      $35.UpdateExpenseRequest request,
      {$grpc.CallOptions? options}) {
    return $createUnaryCall(_$updateExpense, request, options: options);
  }

  $grpc.ResponseFuture<$35.DeleteExpenseResponse> deleteExpense(
      $35.DeleteExpenseRequest request,
      {$grpc.CallOptions? options}) {
    return $createUnaryCall(_$deleteExpense, request, options: options);
  }

  $grpc.ResponseFuture<$35.CreateBudgetResponse> createBudget(
      $35.CreateBudgetRequest request,
      {$grpc.CallOptions? options}) {
    return $createUnaryCall(_$createBudget, request, options: options);
  }

  $grpc.ResponseFuture<$35.GetBudgetsResponse> getBudgets(
      $35.GetBudgetsRequest request,
      {$grpc.CallOptions? options}) {
    return $createUnaryCall(_$getBudgets, request, options: options);
  }

  $grpc.ResponseFuture<$35.GetBudgetByIdResponse> getBudgetById(
      $35.GetBudgetByIdRequest request,
      {$grpc.CallOptions? options}) {
    return $createUnaryCall(_$getBudgetById, request, options: options);
  }

  $grpc.ResponseFuture<$35.UpdateBudgetResponse> updateBudget(
      $35.UpdateBudgetRequest request,
      {$grpc.CallOptions? options}) {
    return $createUnaryCall(_$updateBudget, request, options: options);
  }

  $grpc.ResponseFuture<$35.DeleteBudgetResponse> deleteBudget(
      $35.DeleteBudgetRequest request,
      {$grpc.CallOptions? options}) {
    return $createUnaryCall(_$deleteBudget, request, options: options);
  }

  $grpc.ResponseFuture<$35.GetSpendingAnalyticsResponse> getSpendingAnalytics(
      $35.GetSpendingAnalyticsRequest request,
      {$grpc.CallOptions? options}) {
    return $createUnaryCall(_$getSpendingAnalytics, request, options: options);
  }

  $grpc.ResponseFuture<$35.GetCategoryBreakdownResponse> getCategoryBreakdown(
      $35.GetCategoryBreakdownRequest request,
      {$grpc.CallOptions? options}) {
    return $createUnaryCall(_$getCategoryBreakdown, request, options: options);
  }

  $grpc.ResponseFuture<$35.GetBudgetProgressResponse> getBudgetProgress(
      $35.GetBudgetProgressRequest request,
      {$grpc.CallOptions? options}) {
    return $createUnaryCall(_$getBudgetProgress, request, options: options);
  }

  $grpc.ResponseFuture<$35.GetSpendingTrendsResponse> getSpendingTrends(
      $35.GetSpendingTrendsRequest request,
      {$grpc.CallOptions? options}) {
    return $createUnaryCall(_$getSpendingTrends, request, options: options);
  }

  $grpc.ResponseFuture<$35.GetBudgetAlertsResponse> getBudgetAlerts(
      $35.GetBudgetAlertsRequest request,
      {$grpc.CallOptions? options}) {
    return $createUnaryCall(_$getBudgetAlerts, request, options: options);
  }

  $grpc.ResponseFuture<$35.MarkAlertAsReadResponse> markAlertAsRead(
      $35.MarkAlertAsReadRequest request,
      {$grpc.CallOptions? options}) {
    return $createUnaryCall(_$markAlertAsRead, request, options: options);
  }

  $grpc.ResponseFuture<$35.GetAISpendingInsightsResponse> getAISpendingInsights(
      $35.GetAISpendingInsightsRequest request,
      {$grpc.CallOptions? options}) {
    return $createUnaryCall(_$getAISpendingInsights, request, options: options);
  }

  $grpc.ResponseFuture<$35.GetAIBudgetingRecommendationsResponse>
      getAIBudgetingRecommendations(
          $35.GetAIBudgetingRecommendationsRequest request,
          {$grpc.CallOptions? options}) {
    return $createUnaryCall(_$getAIBudgetingRecommendations, request,
        options: options);
  }

  $grpc.ResponseFuture<$35.AutoCategorizeExpenseResponse> autoCategorizeExpense(
      $35.AutoCategorizeExpenseRequest request,
      {$grpc.CallOptions? options}) {
    return $createUnaryCall(_$autoCategorizeExpense, request, options: options);
  }

  $grpc.ResponseFuture<$35.GetAIFinancialAdviceResponse> getAIFinancialAdvice(
      $35.GetAIFinancialAdviceRequest request,
      {$grpc.CallOptions? options}) {
    return $createUnaryCall(_$getAIFinancialAdvice, request, options: options);
  }

  $grpc.ResponseFuture<$35.GetIncomeSourcesResponse> getIncomeSources(
      $35.GetIncomeSourcesRequest request,
      {$grpc.CallOptions? options}) {
    return $createUnaryCall(_$getIncomeSources, request, options: options);
  }

  $grpc.ResponseFuture<$35.GetIncomeBreakdownResponse> getIncomeBreakdown(
      $35.GetIncomeBreakdownRequest request,
      {$grpc.CallOptions? options}) {
    return $createUnaryCall(_$getIncomeBreakdown, request, options: options);
  }

  $grpc.ResponseFuture<$35.CreateIncomeSourceResponse> createIncomeSource(
      $35.CreateIncomeSourceRequest request,
      {$grpc.CallOptions? options}) {
    return $createUnaryCall(_$createIncomeSource, request, options: options);
  }

  $grpc.ResponseFuture<$35.GetInvestmentPortfolioResponse>
      getInvestmentPortfolio($35.GetInvestmentPortfolioRequest request,
          {$grpc.CallOptions? options}) {
    return $createUnaryCall(_$getInvestmentPortfolio, request,
        options: options);
  }

  $grpc.ResponseFuture<$35.CreateInvestmentResponse> createInvestment(
      $35.CreateInvestmentRequest request,
      {$grpc.CallOptions? options}) {
    return $createUnaryCall(_$createInvestment, request, options: options);
  }

  $grpc.ResponseFuture<$35.GetFinancialGoalsResponse> getFinancialGoals(
      $35.GetFinancialGoalsRequest request,
      {$grpc.CallOptions? options}) {
    return $createUnaryCall(_$getFinancialGoals, request, options: options);
  }

  $grpc.ResponseFuture<$35.CreateFinancialGoalResponse> createFinancialGoal(
      $35.CreateFinancialGoalRequest request,
      {$grpc.CallOptions? options}) {
    return $createUnaryCall(_$createFinancialGoal, request, options: options);
  }

  $grpc.ResponseFuture<$35.UpdateFinancialGoalProgressResponse>
      updateFinancialGoalProgress(
          $35.UpdateFinancialGoalProgressRequest request,
          {$grpc.CallOptions? options}) {
    return $createUnaryCall(_$updateFinancialGoalProgress, request,
        options: options);
  }

  $grpc.ResponseFuture<$35.GetSavingsGoalResponse> getSavingsGoal(
      $35.GetSavingsGoalRequest request,
      {$grpc.CallOptions? options}) {
    return $createUnaryCall(_$getSavingsGoal, request, options: options);
  }

  $grpc.ResponseFuture<$35.CreateOrUpdateSavingsGoalResponse>
      createOrUpdateSavingsGoal($35.CreateOrUpdateSavingsGoalRequest request,
          {$grpc.CallOptions? options}) {
    return $createUnaryCall(_$createOrUpdateSavingsGoal, request,
        options: options);
  }

  $grpc.ResponseFuture<$35.GetUpcomingBillsResponse> getUpcomingBills(
      $35.GetUpcomingBillsRequest request,
      {$grpc.CallOptions? options}) {
    return $createUnaryCall(_$getUpcomingBills, request, options: options);
  }

  $grpc.ResponseFuture<$35.CreateRecurringBillResponse> createRecurringBill(
      $35.CreateRecurringBillRequest request,
      {$grpc.CallOptions? options}) {
    return $createUnaryCall(_$createRecurringBill, request, options: options);
  }

  $grpc.ResponseFuture<$35.GetTrackedIncomeResponse> getTrackedIncome(
      $35.GetTrackedIncomeRequest request,
      {$grpc.CallOptions? options}) {
    return $createUnaryCall(_$getTrackedIncome, request, options: options);
  }

  $grpc.ResponseFuture<$35.GetTrackedExpenditureResponse> getTrackedExpenditure(
      $35.GetTrackedExpenditureRequest request,
      {$grpc.CallOptions? options}) {
    return $createUnaryCall(_$getTrackedExpenditure, request, options: options);
  }

  $grpc.ResponseFuture<$35.GetTrackedIncomeBreakdownResponse>
      getTrackedIncomeBreakdown($35.GetTrackedIncomeBreakdownRequest request,
          {$grpc.CallOptions? options}) {
    return $createUnaryCall(_$getTrackedIncomeBreakdown, request,
        options: options);
  }

  $grpc.ResponseFuture<$35.GetTrackedExpenditureBreakdownResponse>
      getTrackedExpenditureBreakdown(
          $35.GetTrackedExpenditureBreakdownRequest request,
          {$grpc.CallOptions? options}) {
    return $createUnaryCall(_$getTrackedExpenditureBreakdown, request,
        options: options);
  }

  $grpc.ResponseFuture<$35.GetTrackedIncomeTransactionsResponse>
      getTrackedIncomeTransactions(
          $35.GetTrackedIncomeTransactionsRequest request,
          {$grpc.CallOptions? options}) {
    return $createUnaryCall(_$getTrackedIncomeTransactions, request,
        options: options);
  }

  $grpc.ResponseFuture<$35.GetTrackedExpenditureTransactionsResponse>
      getTrackedExpenditureTransactions(
          $35.GetTrackedExpenditureTransactionsRequest request,
          {$grpc.CallOptions? options}) {
    return $createUnaryCall(_$getTrackedExpenditureTransactions, request,
        options: options);
  }

  $grpc.ResponseFuture<$35.GetComprehensiveFinancialSummaryResponse>
      getComprehensiveFinancialSummary(
          $35.GetComprehensiveFinancialSummaryRequest request,
          {$grpc.CallOptions? options}) {
    return $createUnaryCall(_$getComprehensiveFinancialSummary, request,
        options: options);
  }

  $grpc.ResponseFuture<$35.ValidateCategoryBudgetResponse>
      validateCategoryBudget($35.ValidateCategoryBudgetRequest request,
          {$grpc.CallOptions? options}) {
    return $createUnaryCall(_$validateCategoryBudget, request,
        options: options);
  }

  $grpc.ResponseFuture<$35.GetServiceCategoriesResponse> getServiceCategories(
      $35.GetServiceCategoriesRequest request,
      {$grpc.CallOptions? options}) {
    return $createUnaryCall(_$getServiceCategories, request, options: options);
  }

  $grpc.ResponseFuture<$35.CreateCustomCategoryResponse> createCustomCategory(
      $35.CreateCustomCategoryRequest request,
      {$grpc.CallOptions? options}) {
    return $createUnaryCall(_$createCustomCategory, request, options: options);
  }

  $grpc.ResponseFuture<$35.DeleteCustomCategoryResponse> deleteCustomCategory(
      $35.DeleteCustomCategoryRequest request,
      {$grpc.CallOptions? options}) {
    return $createUnaryCall(_$deleteCustomCategory, request, options: options);
  }
}

abstract class StatisticsServiceBase extends $grpc.Service {
  $core.String get $name => 'pb.StatisticsService';

  StatisticsServiceBase() {
    $addMethod($grpc.ServiceMethod<$35.CreateExpenseRequest,
            $35.CreateExpenseResponse>(
        'CreateExpense',
        createExpense_Pre,
        false,
        false,
        ($core.List<$core.int> value) =>
            $35.CreateExpenseRequest.fromBuffer(value),
        ($35.CreateExpenseResponse value) => value.writeToBuffer()));
    $addMethod(
        $grpc.ServiceMethod<$35.GetExpensesRequest, $35.GetExpensesResponse>(
            'GetExpenses',
            getExpenses_Pre,
            false,
            false,
            ($core.List<$core.int> value) =>
                $35.GetExpensesRequest.fromBuffer(value),
            ($35.GetExpensesResponse value) => value.writeToBuffer()));
    $addMethod($grpc.ServiceMethod<$35.GetExpenseByIdRequest,
            $35.GetExpenseByIdResponse>(
        'GetExpenseById',
        getExpenseById_Pre,
        false,
        false,
        ($core.List<$core.int> value) =>
            $35.GetExpenseByIdRequest.fromBuffer(value),
        ($35.GetExpenseByIdResponse value) => value.writeToBuffer()));
    $addMethod($grpc.ServiceMethod<$35.UpdateExpenseRequest,
            $35.UpdateExpenseResponse>(
        'UpdateExpense',
        updateExpense_Pre,
        false,
        false,
        ($core.List<$core.int> value) =>
            $35.UpdateExpenseRequest.fromBuffer(value),
        ($35.UpdateExpenseResponse value) => value.writeToBuffer()));
    $addMethod($grpc.ServiceMethod<$35.DeleteExpenseRequest,
            $35.DeleteExpenseResponse>(
        'DeleteExpense',
        deleteExpense_Pre,
        false,
        false,
        ($core.List<$core.int> value) =>
            $35.DeleteExpenseRequest.fromBuffer(value),
        ($35.DeleteExpenseResponse value) => value.writeToBuffer()));
    $addMethod(
        $grpc.ServiceMethod<$35.CreateBudgetRequest, $35.CreateBudgetResponse>(
            'CreateBudget',
            createBudget_Pre,
            false,
            false,
            ($core.List<$core.int> value) =>
                $35.CreateBudgetRequest.fromBuffer(value),
            ($35.CreateBudgetResponse value) => value.writeToBuffer()));
    $addMethod(
        $grpc.ServiceMethod<$35.GetBudgetsRequest, $35.GetBudgetsResponse>(
            'GetBudgets',
            getBudgets_Pre,
            false,
            false,
            ($core.List<$core.int> value) =>
                $35.GetBudgetsRequest.fromBuffer(value),
            ($35.GetBudgetsResponse value) => value.writeToBuffer()));
    $addMethod($grpc.ServiceMethod<$35.GetBudgetByIdRequest,
            $35.GetBudgetByIdResponse>(
        'GetBudgetById',
        getBudgetById_Pre,
        false,
        false,
        ($core.List<$core.int> value) =>
            $35.GetBudgetByIdRequest.fromBuffer(value),
        ($35.GetBudgetByIdResponse value) => value.writeToBuffer()));
    $addMethod(
        $grpc.ServiceMethod<$35.UpdateBudgetRequest, $35.UpdateBudgetResponse>(
            'UpdateBudget',
            updateBudget_Pre,
            false,
            false,
            ($core.List<$core.int> value) =>
                $35.UpdateBudgetRequest.fromBuffer(value),
            ($35.UpdateBudgetResponse value) => value.writeToBuffer()));
    $addMethod(
        $grpc.ServiceMethod<$35.DeleteBudgetRequest, $35.DeleteBudgetResponse>(
            'DeleteBudget',
            deleteBudget_Pre,
            false,
            false,
            ($core.List<$core.int> value) =>
                $35.DeleteBudgetRequest.fromBuffer(value),
            ($35.DeleteBudgetResponse value) => value.writeToBuffer()));
    $addMethod($grpc.ServiceMethod<$35.GetSpendingAnalyticsRequest,
            $35.GetSpendingAnalyticsResponse>(
        'GetSpendingAnalytics',
        getSpendingAnalytics_Pre,
        false,
        false,
        ($core.List<$core.int> value) =>
            $35.GetSpendingAnalyticsRequest.fromBuffer(value),
        ($35.GetSpendingAnalyticsResponse value) => value.writeToBuffer()));
    $addMethod($grpc.ServiceMethod<$35.GetCategoryBreakdownRequest,
            $35.GetCategoryBreakdownResponse>(
        'GetCategoryBreakdown',
        getCategoryBreakdown_Pre,
        false,
        false,
        ($core.List<$core.int> value) =>
            $35.GetCategoryBreakdownRequest.fromBuffer(value),
        ($35.GetCategoryBreakdownResponse value) => value.writeToBuffer()));
    $addMethod($grpc.ServiceMethod<$35.GetBudgetProgressRequest,
            $35.GetBudgetProgressResponse>(
        'GetBudgetProgress',
        getBudgetProgress_Pre,
        false,
        false,
        ($core.List<$core.int> value) =>
            $35.GetBudgetProgressRequest.fromBuffer(value),
        ($35.GetBudgetProgressResponse value) => value.writeToBuffer()));
    $addMethod($grpc.ServiceMethod<$35.GetSpendingTrendsRequest,
            $35.GetSpendingTrendsResponse>(
        'GetSpendingTrends',
        getSpendingTrends_Pre,
        false,
        false,
        ($core.List<$core.int> value) =>
            $35.GetSpendingTrendsRequest.fromBuffer(value),
        ($35.GetSpendingTrendsResponse value) => value.writeToBuffer()));
    $addMethod($grpc.ServiceMethod<$35.GetBudgetAlertsRequest,
            $35.GetBudgetAlertsResponse>(
        'GetBudgetAlerts',
        getBudgetAlerts_Pre,
        false,
        false,
        ($core.List<$core.int> value) =>
            $35.GetBudgetAlertsRequest.fromBuffer(value),
        ($35.GetBudgetAlertsResponse value) => value.writeToBuffer()));
    $addMethod($grpc.ServiceMethod<$35.MarkAlertAsReadRequest,
            $35.MarkAlertAsReadResponse>(
        'MarkAlertAsRead',
        markAlertAsRead_Pre,
        false,
        false,
        ($core.List<$core.int> value) =>
            $35.MarkAlertAsReadRequest.fromBuffer(value),
        ($35.MarkAlertAsReadResponse value) => value.writeToBuffer()));
    $addMethod($grpc.ServiceMethod<$35.GetAISpendingInsightsRequest,
            $35.GetAISpendingInsightsResponse>(
        'GetAISpendingInsights',
        getAISpendingInsights_Pre,
        false,
        false,
        ($core.List<$core.int> value) =>
            $35.GetAISpendingInsightsRequest.fromBuffer(value),
        ($35.GetAISpendingInsightsResponse value) => value.writeToBuffer()));
    $addMethod($grpc.ServiceMethod<$35.GetAIBudgetingRecommendationsRequest,
            $35.GetAIBudgetingRecommendationsResponse>(
        'GetAIBudgetingRecommendations',
        getAIBudgetingRecommendations_Pre,
        false,
        false,
        ($core.List<$core.int> value) =>
            $35.GetAIBudgetingRecommendationsRequest.fromBuffer(value),
        ($35.GetAIBudgetingRecommendationsResponse value) =>
            value.writeToBuffer()));
    $addMethod($grpc.ServiceMethod<$35.AutoCategorizeExpenseRequest,
            $35.AutoCategorizeExpenseResponse>(
        'AutoCategorizeExpense',
        autoCategorizeExpense_Pre,
        false,
        false,
        ($core.List<$core.int> value) =>
            $35.AutoCategorizeExpenseRequest.fromBuffer(value),
        ($35.AutoCategorizeExpenseResponse value) => value.writeToBuffer()));
    $addMethod($grpc.ServiceMethod<$35.GetAIFinancialAdviceRequest,
            $35.GetAIFinancialAdviceResponse>(
        'GetAIFinancialAdvice',
        getAIFinancialAdvice_Pre,
        false,
        false,
        ($core.List<$core.int> value) =>
            $35.GetAIFinancialAdviceRequest.fromBuffer(value),
        ($35.GetAIFinancialAdviceResponse value) => value.writeToBuffer()));
    $addMethod($grpc.ServiceMethod<$35.GetIncomeSourcesRequest,
            $35.GetIncomeSourcesResponse>(
        'GetIncomeSources',
        getIncomeSources_Pre,
        false,
        false,
        ($core.List<$core.int> value) =>
            $35.GetIncomeSourcesRequest.fromBuffer(value),
        ($35.GetIncomeSourcesResponse value) => value.writeToBuffer()));
    $addMethod($grpc.ServiceMethod<$35.GetIncomeBreakdownRequest,
            $35.GetIncomeBreakdownResponse>(
        'GetIncomeBreakdown',
        getIncomeBreakdown_Pre,
        false,
        false,
        ($core.List<$core.int> value) =>
            $35.GetIncomeBreakdownRequest.fromBuffer(value),
        ($35.GetIncomeBreakdownResponse value) => value.writeToBuffer()));
    $addMethod($grpc.ServiceMethod<$35.CreateIncomeSourceRequest,
            $35.CreateIncomeSourceResponse>(
        'CreateIncomeSource',
        createIncomeSource_Pre,
        false,
        false,
        ($core.List<$core.int> value) =>
            $35.CreateIncomeSourceRequest.fromBuffer(value),
        ($35.CreateIncomeSourceResponse value) => value.writeToBuffer()));
    $addMethod($grpc.ServiceMethod<$35.GetInvestmentPortfolioRequest,
            $35.GetInvestmentPortfolioResponse>(
        'GetInvestmentPortfolio',
        getInvestmentPortfolio_Pre,
        false,
        false,
        ($core.List<$core.int> value) =>
            $35.GetInvestmentPortfolioRequest.fromBuffer(value),
        ($35.GetInvestmentPortfolioResponse value) => value.writeToBuffer()));
    $addMethod($grpc.ServiceMethod<$35.CreateInvestmentRequest,
            $35.CreateInvestmentResponse>(
        'CreateInvestment',
        createInvestment_Pre,
        false,
        false,
        ($core.List<$core.int> value) =>
            $35.CreateInvestmentRequest.fromBuffer(value),
        ($35.CreateInvestmentResponse value) => value.writeToBuffer()));
    $addMethod($grpc.ServiceMethod<$35.GetFinancialGoalsRequest,
            $35.GetFinancialGoalsResponse>(
        'GetFinancialGoals',
        getFinancialGoals_Pre,
        false,
        false,
        ($core.List<$core.int> value) =>
            $35.GetFinancialGoalsRequest.fromBuffer(value),
        ($35.GetFinancialGoalsResponse value) => value.writeToBuffer()));
    $addMethod($grpc.ServiceMethod<$35.CreateFinancialGoalRequest,
            $35.CreateFinancialGoalResponse>(
        'CreateFinancialGoal',
        createFinancialGoal_Pre,
        false,
        false,
        ($core.List<$core.int> value) =>
            $35.CreateFinancialGoalRequest.fromBuffer(value),
        ($35.CreateFinancialGoalResponse value) => value.writeToBuffer()));
    $addMethod($grpc.ServiceMethod<$35.UpdateFinancialGoalProgressRequest,
            $35.UpdateFinancialGoalProgressResponse>(
        'UpdateFinancialGoalProgress',
        updateFinancialGoalProgress_Pre,
        false,
        false,
        ($core.List<$core.int> value) =>
            $35.UpdateFinancialGoalProgressRequest.fromBuffer(value),
        ($35.UpdateFinancialGoalProgressResponse value) =>
            value.writeToBuffer()));
    $addMethod($grpc.ServiceMethod<$35.GetSavingsGoalRequest,
            $35.GetSavingsGoalResponse>(
        'GetSavingsGoal',
        getSavingsGoal_Pre,
        false,
        false,
        ($core.List<$core.int> value) =>
            $35.GetSavingsGoalRequest.fromBuffer(value),
        ($35.GetSavingsGoalResponse value) => value.writeToBuffer()));
    $addMethod($grpc.ServiceMethod<$35.CreateOrUpdateSavingsGoalRequest,
            $35.CreateOrUpdateSavingsGoalResponse>(
        'CreateOrUpdateSavingsGoal',
        createOrUpdateSavingsGoal_Pre,
        false,
        false,
        ($core.List<$core.int> value) =>
            $35.CreateOrUpdateSavingsGoalRequest.fromBuffer(value),
        ($35.CreateOrUpdateSavingsGoalResponse value) =>
            value.writeToBuffer()));
    $addMethod($grpc.ServiceMethod<$35.GetUpcomingBillsRequest,
            $35.GetUpcomingBillsResponse>(
        'GetUpcomingBills',
        getUpcomingBills_Pre,
        false,
        false,
        ($core.List<$core.int> value) =>
            $35.GetUpcomingBillsRequest.fromBuffer(value),
        ($35.GetUpcomingBillsResponse value) => value.writeToBuffer()));
    $addMethod($grpc.ServiceMethod<$35.CreateRecurringBillRequest,
            $35.CreateRecurringBillResponse>(
        'CreateRecurringBill',
        createRecurringBill_Pre,
        false,
        false,
        ($core.List<$core.int> value) =>
            $35.CreateRecurringBillRequest.fromBuffer(value),
        ($35.CreateRecurringBillResponse value) => value.writeToBuffer()));
    $addMethod($grpc.ServiceMethod<$35.GetTrackedIncomeRequest,
            $35.GetTrackedIncomeResponse>(
        'GetTrackedIncome',
        getTrackedIncome_Pre,
        false,
        false,
        ($core.List<$core.int> value) =>
            $35.GetTrackedIncomeRequest.fromBuffer(value),
        ($35.GetTrackedIncomeResponse value) => value.writeToBuffer()));
    $addMethod($grpc.ServiceMethod<$35.GetTrackedExpenditureRequest,
            $35.GetTrackedExpenditureResponse>(
        'GetTrackedExpenditure',
        getTrackedExpenditure_Pre,
        false,
        false,
        ($core.List<$core.int> value) =>
            $35.GetTrackedExpenditureRequest.fromBuffer(value),
        ($35.GetTrackedExpenditureResponse value) => value.writeToBuffer()));
    $addMethod($grpc.ServiceMethod<$35.GetTrackedIncomeBreakdownRequest,
            $35.GetTrackedIncomeBreakdownResponse>(
        'GetTrackedIncomeBreakdown',
        getTrackedIncomeBreakdown_Pre,
        false,
        false,
        ($core.List<$core.int> value) =>
            $35.GetTrackedIncomeBreakdownRequest.fromBuffer(value),
        ($35.GetTrackedIncomeBreakdownResponse value) =>
            value.writeToBuffer()));
    $addMethod($grpc.ServiceMethod<$35.GetTrackedExpenditureBreakdownRequest,
            $35.GetTrackedExpenditureBreakdownResponse>(
        'GetTrackedExpenditureBreakdown',
        getTrackedExpenditureBreakdown_Pre,
        false,
        false,
        ($core.List<$core.int> value) =>
            $35.GetTrackedExpenditureBreakdownRequest.fromBuffer(value),
        ($35.GetTrackedExpenditureBreakdownResponse value) =>
            value.writeToBuffer()));
    $addMethod($grpc.ServiceMethod<$35.GetTrackedIncomeTransactionsRequest,
            $35.GetTrackedIncomeTransactionsResponse>(
        'GetTrackedIncomeTransactions',
        getTrackedIncomeTransactions_Pre,
        false,
        false,
        ($core.List<$core.int> value) =>
            $35.GetTrackedIncomeTransactionsRequest.fromBuffer(value),
        ($35.GetTrackedIncomeTransactionsResponse value) =>
            value.writeToBuffer()));
    $addMethod($grpc.ServiceMethod<$35.GetTrackedExpenditureTransactionsRequest,
            $35.GetTrackedExpenditureTransactionsResponse>(
        'GetTrackedExpenditureTransactions',
        getTrackedExpenditureTransactions_Pre,
        false,
        false,
        ($core.List<$core.int> value) =>
            $35.GetTrackedExpenditureTransactionsRequest.fromBuffer(value),
        ($35.GetTrackedExpenditureTransactionsResponse value) =>
            value.writeToBuffer()));
    $addMethod($grpc.ServiceMethod<$35.GetComprehensiveFinancialSummaryRequest,
            $35.GetComprehensiveFinancialSummaryResponse>(
        'GetComprehensiveFinancialSummary',
        getComprehensiveFinancialSummary_Pre,
        false,
        false,
        ($core.List<$core.int> value) =>
            $35.GetComprehensiveFinancialSummaryRequest.fromBuffer(value),
        ($35.GetComprehensiveFinancialSummaryResponse value) =>
            value.writeToBuffer()));
    $addMethod($grpc.ServiceMethod<$35.ValidateCategoryBudgetRequest,
            $35.ValidateCategoryBudgetResponse>(
        'ValidateCategoryBudget',
        validateCategoryBudget_Pre,
        false,
        false,
        ($core.List<$core.int> value) =>
            $35.ValidateCategoryBudgetRequest.fromBuffer(value),
        ($35.ValidateCategoryBudgetResponse value) => value.writeToBuffer()));
    $addMethod($grpc.ServiceMethod<$35.GetServiceCategoriesRequest,
            $35.GetServiceCategoriesResponse>(
        'GetServiceCategories',
        getServiceCategories_Pre,
        false,
        false,
        ($core.List<$core.int> value) =>
            $35.GetServiceCategoriesRequest.fromBuffer(value),
        ($35.GetServiceCategoriesResponse value) => value.writeToBuffer()));
    $addMethod($grpc.ServiceMethod<$35.CreateCustomCategoryRequest,
            $35.CreateCustomCategoryResponse>(
        'CreateCustomCategory',
        createCustomCategory_Pre,
        false,
        false,
        ($core.List<$core.int> value) =>
            $35.CreateCustomCategoryRequest.fromBuffer(value),
        ($35.CreateCustomCategoryResponse value) => value.writeToBuffer()));
    $addMethod($grpc.ServiceMethod<$35.DeleteCustomCategoryRequest,
            $35.DeleteCustomCategoryResponse>(
        'DeleteCustomCategory',
        deleteCustomCategory_Pre,
        false,
        false,
        ($core.List<$core.int> value) =>
            $35.DeleteCustomCategoryRequest.fromBuffer(value),
        ($35.DeleteCustomCategoryResponse value) => value.writeToBuffer()));
  }

  $async.Future<$35.CreateExpenseResponse> createExpense_Pre(
      $grpc.ServiceCall call,
      $async.Future<$35.CreateExpenseRequest> request) async {
    return createExpense(call, await request);
  }

  $async.Future<$35.GetExpensesResponse> getExpenses_Pre($grpc.ServiceCall call,
      $async.Future<$35.GetExpensesRequest> request) async {
    return getExpenses(call, await request);
  }

  $async.Future<$35.GetExpenseByIdResponse> getExpenseById_Pre(
      $grpc.ServiceCall call,
      $async.Future<$35.GetExpenseByIdRequest> request) async {
    return getExpenseById(call, await request);
  }

  $async.Future<$35.UpdateExpenseResponse> updateExpense_Pre(
      $grpc.ServiceCall call,
      $async.Future<$35.UpdateExpenseRequest> request) async {
    return updateExpense(call, await request);
  }

  $async.Future<$35.DeleteExpenseResponse> deleteExpense_Pre(
      $grpc.ServiceCall call,
      $async.Future<$35.DeleteExpenseRequest> request) async {
    return deleteExpense(call, await request);
  }

  $async.Future<$35.CreateBudgetResponse> createBudget_Pre(
      $grpc.ServiceCall call,
      $async.Future<$35.CreateBudgetRequest> request) async {
    return createBudget(call, await request);
  }

  $async.Future<$35.GetBudgetsResponse> getBudgets_Pre($grpc.ServiceCall call,
      $async.Future<$35.GetBudgetsRequest> request) async {
    return getBudgets(call, await request);
  }

  $async.Future<$35.GetBudgetByIdResponse> getBudgetById_Pre(
      $grpc.ServiceCall call,
      $async.Future<$35.GetBudgetByIdRequest> request) async {
    return getBudgetById(call, await request);
  }

  $async.Future<$35.UpdateBudgetResponse> updateBudget_Pre(
      $grpc.ServiceCall call,
      $async.Future<$35.UpdateBudgetRequest> request) async {
    return updateBudget(call, await request);
  }

  $async.Future<$35.DeleteBudgetResponse> deleteBudget_Pre(
      $grpc.ServiceCall call,
      $async.Future<$35.DeleteBudgetRequest> request) async {
    return deleteBudget(call, await request);
  }

  $async.Future<$35.GetSpendingAnalyticsResponse> getSpendingAnalytics_Pre(
      $grpc.ServiceCall call,
      $async.Future<$35.GetSpendingAnalyticsRequest> request) async {
    return getSpendingAnalytics(call, await request);
  }

  $async.Future<$35.GetCategoryBreakdownResponse> getCategoryBreakdown_Pre(
      $grpc.ServiceCall call,
      $async.Future<$35.GetCategoryBreakdownRequest> request) async {
    return getCategoryBreakdown(call, await request);
  }

  $async.Future<$35.GetBudgetProgressResponse> getBudgetProgress_Pre(
      $grpc.ServiceCall call,
      $async.Future<$35.GetBudgetProgressRequest> request) async {
    return getBudgetProgress(call, await request);
  }

  $async.Future<$35.GetSpendingTrendsResponse> getSpendingTrends_Pre(
      $grpc.ServiceCall call,
      $async.Future<$35.GetSpendingTrendsRequest> request) async {
    return getSpendingTrends(call, await request);
  }

  $async.Future<$35.GetBudgetAlertsResponse> getBudgetAlerts_Pre(
      $grpc.ServiceCall call,
      $async.Future<$35.GetBudgetAlertsRequest> request) async {
    return getBudgetAlerts(call, await request);
  }

  $async.Future<$35.MarkAlertAsReadResponse> markAlertAsRead_Pre(
      $grpc.ServiceCall call,
      $async.Future<$35.MarkAlertAsReadRequest> request) async {
    return markAlertAsRead(call, await request);
  }

  $async.Future<$35.GetAISpendingInsightsResponse> getAISpendingInsights_Pre(
      $grpc.ServiceCall call,
      $async.Future<$35.GetAISpendingInsightsRequest> request) async {
    return getAISpendingInsights(call, await request);
  }

  $async.Future<$35.GetAIBudgetingRecommendationsResponse>
      getAIBudgetingRecommendations_Pre(
          $grpc.ServiceCall call,
          $async.Future<$35.GetAIBudgetingRecommendationsRequest>
              request) async {
    return getAIBudgetingRecommendations(call, await request);
  }

  $async.Future<$35.AutoCategorizeExpenseResponse> autoCategorizeExpense_Pre(
      $grpc.ServiceCall call,
      $async.Future<$35.AutoCategorizeExpenseRequest> request) async {
    return autoCategorizeExpense(call, await request);
  }

  $async.Future<$35.GetAIFinancialAdviceResponse> getAIFinancialAdvice_Pre(
      $grpc.ServiceCall call,
      $async.Future<$35.GetAIFinancialAdviceRequest> request) async {
    return getAIFinancialAdvice(call, await request);
  }

  $async.Future<$35.GetIncomeSourcesResponse> getIncomeSources_Pre(
      $grpc.ServiceCall call,
      $async.Future<$35.GetIncomeSourcesRequest> request) async {
    return getIncomeSources(call, await request);
  }

  $async.Future<$35.GetIncomeBreakdownResponse> getIncomeBreakdown_Pre(
      $grpc.ServiceCall call,
      $async.Future<$35.GetIncomeBreakdownRequest> request) async {
    return getIncomeBreakdown(call, await request);
  }

  $async.Future<$35.CreateIncomeSourceResponse> createIncomeSource_Pre(
      $grpc.ServiceCall call,
      $async.Future<$35.CreateIncomeSourceRequest> request) async {
    return createIncomeSource(call, await request);
  }

  $async.Future<$35.GetInvestmentPortfolioResponse> getInvestmentPortfolio_Pre(
      $grpc.ServiceCall call,
      $async.Future<$35.GetInvestmentPortfolioRequest> request) async {
    return getInvestmentPortfolio(call, await request);
  }

  $async.Future<$35.CreateInvestmentResponse> createInvestment_Pre(
      $grpc.ServiceCall call,
      $async.Future<$35.CreateInvestmentRequest> request) async {
    return createInvestment(call, await request);
  }

  $async.Future<$35.GetFinancialGoalsResponse> getFinancialGoals_Pre(
      $grpc.ServiceCall call,
      $async.Future<$35.GetFinancialGoalsRequest> request) async {
    return getFinancialGoals(call, await request);
  }

  $async.Future<$35.CreateFinancialGoalResponse> createFinancialGoal_Pre(
      $grpc.ServiceCall call,
      $async.Future<$35.CreateFinancialGoalRequest> request) async {
    return createFinancialGoal(call, await request);
  }

  $async.Future<$35.UpdateFinancialGoalProgressResponse>
      updateFinancialGoalProgress_Pre($grpc.ServiceCall call,
          $async.Future<$35.UpdateFinancialGoalProgressRequest> request) async {
    return updateFinancialGoalProgress(call, await request);
  }

  $async.Future<$35.GetSavingsGoalResponse> getSavingsGoal_Pre(
      $grpc.ServiceCall call,
      $async.Future<$35.GetSavingsGoalRequest> request) async {
    return getSavingsGoal(call, await request);
  }

  $async.Future<$35.CreateOrUpdateSavingsGoalResponse>
      createOrUpdateSavingsGoal_Pre($grpc.ServiceCall call,
          $async.Future<$35.CreateOrUpdateSavingsGoalRequest> request) async {
    return createOrUpdateSavingsGoal(call, await request);
  }

  $async.Future<$35.GetUpcomingBillsResponse> getUpcomingBills_Pre(
      $grpc.ServiceCall call,
      $async.Future<$35.GetUpcomingBillsRequest> request) async {
    return getUpcomingBills(call, await request);
  }

  $async.Future<$35.CreateRecurringBillResponse> createRecurringBill_Pre(
      $grpc.ServiceCall call,
      $async.Future<$35.CreateRecurringBillRequest> request) async {
    return createRecurringBill(call, await request);
  }

  $async.Future<$35.GetTrackedIncomeResponse> getTrackedIncome_Pre(
      $grpc.ServiceCall call,
      $async.Future<$35.GetTrackedIncomeRequest> request) async {
    return getTrackedIncome(call, await request);
  }

  $async.Future<$35.GetTrackedExpenditureResponse> getTrackedExpenditure_Pre(
      $grpc.ServiceCall call,
      $async.Future<$35.GetTrackedExpenditureRequest> request) async {
    return getTrackedExpenditure(call, await request);
  }

  $async.Future<$35.GetTrackedIncomeBreakdownResponse>
      getTrackedIncomeBreakdown_Pre($grpc.ServiceCall call,
          $async.Future<$35.GetTrackedIncomeBreakdownRequest> request) async {
    return getTrackedIncomeBreakdown(call, await request);
  }

  $async.Future<$35.GetTrackedExpenditureBreakdownResponse>
      getTrackedExpenditureBreakdown_Pre(
          $grpc.ServiceCall call,
          $async.Future<$35.GetTrackedExpenditureBreakdownRequest>
              request) async {
    return getTrackedExpenditureBreakdown(call, await request);
  }

  $async.Future<$35.GetTrackedIncomeTransactionsResponse>
      getTrackedIncomeTransactions_Pre(
          $grpc.ServiceCall call,
          $async.Future<$35.GetTrackedIncomeTransactionsRequest>
              request) async {
    return getTrackedIncomeTransactions(call, await request);
  }

  $async.Future<$35.GetTrackedExpenditureTransactionsResponse>
      getTrackedExpenditureTransactions_Pre(
          $grpc.ServiceCall call,
          $async.Future<$35.GetTrackedExpenditureTransactionsRequest>
              request) async {
    return getTrackedExpenditureTransactions(call, await request);
  }

  $async.Future<$35.GetComprehensiveFinancialSummaryResponse>
      getComprehensiveFinancialSummary_Pre(
          $grpc.ServiceCall call,
          $async.Future<$35.GetComprehensiveFinancialSummaryRequest>
              request) async {
    return getComprehensiveFinancialSummary(call, await request);
  }

  $async.Future<$35.ValidateCategoryBudgetResponse> validateCategoryBudget_Pre(
      $grpc.ServiceCall call,
      $async.Future<$35.ValidateCategoryBudgetRequest> request) async {
    return validateCategoryBudget(call, await request);
  }

  $async.Future<$35.GetServiceCategoriesResponse> getServiceCategories_Pre(
      $grpc.ServiceCall call,
      $async.Future<$35.GetServiceCategoriesRequest> request) async {
    return getServiceCategories(call, await request);
  }

  $async.Future<$35.CreateCustomCategoryResponse> createCustomCategory_Pre(
      $grpc.ServiceCall call,
      $async.Future<$35.CreateCustomCategoryRequest> request) async {
    return createCustomCategory(call, await request);
  }

  $async.Future<$35.DeleteCustomCategoryResponse> deleteCustomCategory_Pre(
      $grpc.ServiceCall call,
      $async.Future<$35.DeleteCustomCategoryRequest> request) async {
    return deleteCustomCategory(call, await request);
  }

  $async.Future<$35.CreateExpenseResponse> createExpense(
      $grpc.ServiceCall call, $35.CreateExpenseRequest request);
  $async.Future<$35.GetExpensesResponse> getExpenses(
      $grpc.ServiceCall call, $35.GetExpensesRequest request);
  $async.Future<$35.GetExpenseByIdResponse> getExpenseById(
      $grpc.ServiceCall call, $35.GetExpenseByIdRequest request);
  $async.Future<$35.UpdateExpenseResponse> updateExpense(
      $grpc.ServiceCall call, $35.UpdateExpenseRequest request);
  $async.Future<$35.DeleteExpenseResponse> deleteExpense(
      $grpc.ServiceCall call, $35.DeleteExpenseRequest request);
  $async.Future<$35.CreateBudgetResponse> createBudget(
      $grpc.ServiceCall call, $35.CreateBudgetRequest request);
  $async.Future<$35.GetBudgetsResponse> getBudgets(
      $grpc.ServiceCall call, $35.GetBudgetsRequest request);
  $async.Future<$35.GetBudgetByIdResponse> getBudgetById(
      $grpc.ServiceCall call, $35.GetBudgetByIdRequest request);
  $async.Future<$35.UpdateBudgetResponse> updateBudget(
      $grpc.ServiceCall call, $35.UpdateBudgetRequest request);
  $async.Future<$35.DeleteBudgetResponse> deleteBudget(
      $grpc.ServiceCall call, $35.DeleteBudgetRequest request);
  $async.Future<$35.GetSpendingAnalyticsResponse> getSpendingAnalytics(
      $grpc.ServiceCall call, $35.GetSpendingAnalyticsRequest request);
  $async.Future<$35.GetCategoryBreakdownResponse> getCategoryBreakdown(
      $grpc.ServiceCall call, $35.GetCategoryBreakdownRequest request);
  $async.Future<$35.GetBudgetProgressResponse> getBudgetProgress(
      $grpc.ServiceCall call, $35.GetBudgetProgressRequest request);
  $async.Future<$35.GetSpendingTrendsResponse> getSpendingTrends(
      $grpc.ServiceCall call, $35.GetSpendingTrendsRequest request);
  $async.Future<$35.GetBudgetAlertsResponse> getBudgetAlerts(
      $grpc.ServiceCall call, $35.GetBudgetAlertsRequest request);
  $async.Future<$35.MarkAlertAsReadResponse> markAlertAsRead(
      $grpc.ServiceCall call, $35.MarkAlertAsReadRequest request);
  $async.Future<$35.GetAISpendingInsightsResponse> getAISpendingInsights(
      $grpc.ServiceCall call, $35.GetAISpendingInsightsRequest request);
  $async.Future<$35.GetAIBudgetingRecommendationsResponse>
      getAIBudgetingRecommendations($grpc.ServiceCall call,
          $35.GetAIBudgetingRecommendationsRequest request);
  $async.Future<$35.AutoCategorizeExpenseResponse> autoCategorizeExpense(
      $grpc.ServiceCall call, $35.AutoCategorizeExpenseRequest request);
  $async.Future<$35.GetAIFinancialAdviceResponse> getAIFinancialAdvice(
      $grpc.ServiceCall call, $35.GetAIFinancialAdviceRequest request);
  $async.Future<$35.GetIncomeSourcesResponse> getIncomeSources(
      $grpc.ServiceCall call, $35.GetIncomeSourcesRequest request);
  $async.Future<$35.GetIncomeBreakdownResponse> getIncomeBreakdown(
      $grpc.ServiceCall call, $35.GetIncomeBreakdownRequest request);
  $async.Future<$35.CreateIncomeSourceResponse> createIncomeSource(
      $grpc.ServiceCall call, $35.CreateIncomeSourceRequest request);
  $async.Future<$35.GetInvestmentPortfolioResponse> getInvestmentPortfolio(
      $grpc.ServiceCall call, $35.GetInvestmentPortfolioRequest request);
  $async.Future<$35.CreateInvestmentResponse> createInvestment(
      $grpc.ServiceCall call, $35.CreateInvestmentRequest request);
  $async.Future<$35.GetFinancialGoalsResponse> getFinancialGoals(
      $grpc.ServiceCall call, $35.GetFinancialGoalsRequest request);
  $async.Future<$35.CreateFinancialGoalResponse> createFinancialGoal(
      $grpc.ServiceCall call, $35.CreateFinancialGoalRequest request);
  $async.Future<$35.UpdateFinancialGoalProgressResponse>
      updateFinancialGoalProgress($grpc.ServiceCall call,
          $35.UpdateFinancialGoalProgressRequest request);
  $async.Future<$35.GetSavingsGoalResponse> getSavingsGoal(
      $grpc.ServiceCall call, $35.GetSavingsGoalRequest request);
  $async.Future<$35.CreateOrUpdateSavingsGoalResponse>
      createOrUpdateSavingsGoal(
          $grpc.ServiceCall call, $35.CreateOrUpdateSavingsGoalRequest request);
  $async.Future<$35.GetUpcomingBillsResponse> getUpcomingBills(
      $grpc.ServiceCall call, $35.GetUpcomingBillsRequest request);
  $async.Future<$35.CreateRecurringBillResponse> createRecurringBill(
      $grpc.ServiceCall call, $35.CreateRecurringBillRequest request);
  $async.Future<$35.GetTrackedIncomeResponse> getTrackedIncome(
      $grpc.ServiceCall call, $35.GetTrackedIncomeRequest request);
  $async.Future<$35.GetTrackedExpenditureResponse> getTrackedExpenditure(
      $grpc.ServiceCall call, $35.GetTrackedExpenditureRequest request);
  $async.Future<$35.GetTrackedIncomeBreakdownResponse>
      getTrackedIncomeBreakdown(
          $grpc.ServiceCall call, $35.GetTrackedIncomeBreakdownRequest request);
  $async.Future<$35.GetTrackedExpenditureBreakdownResponse>
      getTrackedExpenditureBreakdown($grpc.ServiceCall call,
          $35.GetTrackedExpenditureBreakdownRequest request);
  $async.Future<$35.GetTrackedIncomeTransactionsResponse>
      getTrackedIncomeTransactions($grpc.ServiceCall call,
          $35.GetTrackedIncomeTransactionsRequest request);
  $async.Future<$35.GetTrackedExpenditureTransactionsResponse>
      getTrackedExpenditureTransactions($grpc.ServiceCall call,
          $35.GetTrackedExpenditureTransactionsRequest request);
  $async.Future<$35.GetComprehensiveFinancialSummaryResponse>
      getComprehensiveFinancialSummary($grpc.ServiceCall call,
          $35.GetComprehensiveFinancialSummaryRequest request);
  $async.Future<$35.ValidateCategoryBudgetResponse> validateCategoryBudget(
      $grpc.ServiceCall call, $35.ValidateCategoryBudgetRequest request);
  $async.Future<$35.GetServiceCategoriesResponse> getServiceCategories(
      $grpc.ServiceCall call, $35.GetServiceCategoriesRequest request);
  $async.Future<$35.CreateCustomCategoryResponse> createCustomCategory(
      $grpc.ServiceCall call, $35.CreateCustomCategoryRequest request);
  $async.Future<$35.DeleteCustomCategoryResponse> deleteCustomCategory(
      $grpc.ServiceCall call, $35.DeleteCustomCategoryRequest request);
}
