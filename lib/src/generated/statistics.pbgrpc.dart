///
//  Generated code. Do not modify.
//  source: statistics.proto
//
// @dart = 2.12
// ignore_for_file: annotate_overrides,camel_case_types,constant_identifier_names,directives_ordering,library_prefixes,non_constant_identifier_names,prefer_final_fields,return_of_invalid_type,unnecessary_const,unnecessary_import,unnecessary_this,unused_import,unused_shown_name

import 'dart:async' as $async;

import 'dart:core' as $core;

import 'package:grpc/service_api.dart' as $grpc;
import 'statistics.pb.dart' as $24;
export 'statistics.pb.dart';

class StatisticsServiceClient extends $grpc.Client {
  static final _$createExpense =
      $grpc.ClientMethod<$24.CreateExpenseRequest, $24.CreateExpenseResponse>(
          '/pb.StatisticsService/CreateExpense',
          ($24.CreateExpenseRequest value) => value.writeToBuffer(),
          ($core.List<$core.int> value) =>
              $24.CreateExpenseResponse.fromBuffer(value));
  static final _$getExpenses =
      $grpc.ClientMethod<$24.GetExpensesRequest, $24.GetExpensesResponse>(
          '/pb.StatisticsService/GetExpenses',
          ($24.GetExpensesRequest value) => value.writeToBuffer(),
          ($core.List<$core.int> value) =>
              $24.GetExpensesResponse.fromBuffer(value));
  static final _$getExpenseById =
      $grpc.ClientMethod<$24.GetExpenseByIdRequest, $24.GetExpenseByIdResponse>(
          '/pb.StatisticsService/GetExpenseById',
          ($24.GetExpenseByIdRequest value) => value.writeToBuffer(),
          ($core.List<$core.int> value) =>
              $24.GetExpenseByIdResponse.fromBuffer(value));
  static final _$updateExpense =
      $grpc.ClientMethod<$24.UpdateExpenseRequest, $24.UpdateExpenseResponse>(
          '/pb.StatisticsService/UpdateExpense',
          ($24.UpdateExpenseRequest value) => value.writeToBuffer(),
          ($core.List<$core.int> value) =>
              $24.UpdateExpenseResponse.fromBuffer(value));
  static final _$deleteExpense =
      $grpc.ClientMethod<$24.DeleteExpenseRequest, $24.DeleteExpenseResponse>(
          '/pb.StatisticsService/DeleteExpense',
          ($24.DeleteExpenseRequest value) => value.writeToBuffer(),
          ($core.List<$core.int> value) =>
              $24.DeleteExpenseResponse.fromBuffer(value));
  static final _$createBudget =
      $grpc.ClientMethod<$24.CreateBudgetRequest, $24.CreateBudgetResponse>(
          '/pb.StatisticsService/CreateBudget',
          ($24.CreateBudgetRequest value) => value.writeToBuffer(),
          ($core.List<$core.int> value) =>
              $24.CreateBudgetResponse.fromBuffer(value));
  static final _$getBudgets =
      $grpc.ClientMethod<$24.GetBudgetsRequest, $24.GetBudgetsResponse>(
          '/pb.StatisticsService/GetBudgets',
          ($24.GetBudgetsRequest value) => value.writeToBuffer(),
          ($core.List<$core.int> value) =>
              $24.GetBudgetsResponse.fromBuffer(value));
  static final _$getBudgetById =
      $grpc.ClientMethod<$24.GetBudgetByIdRequest, $24.GetBudgetByIdResponse>(
          '/pb.StatisticsService/GetBudgetById',
          ($24.GetBudgetByIdRequest value) => value.writeToBuffer(),
          ($core.List<$core.int> value) =>
              $24.GetBudgetByIdResponse.fromBuffer(value));
  static final _$updateBudget =
      $grpc.ClientMethod<$24.UpdateBudgetRequest, $24.UpdateBudgetResponse>(
          '/pb.StatisticsService/UpdateBudget',
          ($24.UpdateBudgetRequest value) => value.writeToBuffer(),
          ($core.List<$core.int> value) =>
              $24.UpdateBudgetResponse.fromBuffer(value));
  static final _$deleteBudget =
      $grpc.ClientMethod<$24.DeleteBudgetRequest, $24.DeleteBudgetResponse>(
          '/pb.StatisticsService/DeleteBudget',
          ($24.DeleteBudgetRequest value) => value.writeToBuffer(),
          ($core.List<$core.int> value) =>
              $24.DeleteBudgetResponse.fromBuffer(value));
  static final _$getSpendingAnalytics = $grpc.ClientMethod<
          $24.GetSpendingAnalyticsRequest, $24.GetSpendingAnalyticsResponse>(
      '/pb.StatisticsService/GetSpendingAnalytics',
      ($24.GetSpendingAnalyticsRequest value) => value.writeToBuffer(),
      ($core.List<$core.int> value) =>
          $24.GetSpendingAnalyticsResponse.fromBuffer(value));
  static final _$getCategoryBreakdown = $grpc.ClientMethod<
          $24.GetCategoryBreakdownRequest, $24.GetCategoryBreakdownResponse>(
      '/pb.StatisticsService/GetCategoryBreakdown',
      ($24.GetCategoryBreakdownRequest value) => value.writeToBuffer(),
      ($core.List<$core.int> value) =>
          $24.GetCategoryBreakdownResponse.fromBuffer(value));
  static final _$getBudgetProgress = $grpc.ClientMethod<
          $24.GetBudgetProgressRequest, $24.GetBudgetProgressResponse>(
      '/pb.StatisticsService/GetBudgetProgress',
      ($24.GetBudgetProgressRequest value) => value.writeToBuffer(),
      ($core.List<$core.int> value) =>
          $24.GetBudgetProgressResponse.fromBuffer(value));
  static final _$getSpendingTrends = $grpc.ClientMethod<
          $24.GetSpendingTrendsRequest, $24.GetSpendingTrendsResponse>(
      '/pb.StatisticsService/GetSpendingTrends',
      ($24.GetSpendingTrendsRequest value) => value.writeToBuffer(),
      ($core.List<$core.int> value) =>
          $24.GetSpendingTrendsResponse.fromBuffer(value));
  static final _$getBudgetAlerts = $grpc.ClientMethod<
          $24.GetBudgetAlertsRequest, $24.GetBudgetAlertsResponse>(
      '/pb.StatisticsService/GetBudgetAlerts',
      ($24.GetBudgetAlertsRequest value) => value.writeToBuffer(),
      ($core.List<$core.int> value) =>
          $24.GetBudgetAlertsResponse.fromBuffer(value));
  static final _$markAlertAsRead = $grpc.ClientMethod<
          $24.MarkAlertAsReadRequest, $24.MarkAlertAsReadResponse>(
      '/pb.StatisticsService/MarkAlertAsRead',
      ($24.MarkAlertAsReadRequest value) => value.writeToBuffer(),
      ($core.List<$core.int> value) =>
          $24.MarkAlertAsReadResponse.fromBuffer(value));
  static final _$getAISpendingInsights = $grpc.ClientMethod<
          $24.GetAISpendingInsightsRequest, $24.GetAISpendingInsightsResponse>(
      '/pb.StatisticsService/GetAISpendingInsights',
      ($24.GetAISpendingInsightsRequest value) => value.writeToBuffer(),
      ($core.List<$core.int> value) =>
          $24.GetAISpendingInsightsResponse.fromBuffer(value));
  static final _$getAIBudgetingRecommendations = $grpc.ClientMethod<
          $24.GetAIBudgetingRecommendationsRequest,
          $24.GetAIBudgetingRecommendationsResponse>(
      '/pb.StatisticsService/GetAIBudgetingRecommendations',
      ($24.GetAIBudgetingRecommendationsRequest value) => value.writeToBuffer(),
      ($core.List<$core.int> value) =>
          $24.GetAIBudgetingRecommendationsResponse.fromBuffer(value));
  static final _$autoCategorizeExpense = $grpc.ClientMethod<
          $24.AutoCategorizeExpenseRequest, $24.AutoCategorizeExpenseResponse>(
      '/pb.StatisticsService/AutoCategorizeExpense',
      ($24.AutoCategorizeExpenseRequest value) => value.writeToBuffer(),
      ($core.List<$core.int> value) =>
          $24.AutoCategorizeExpenseResponse.fromBuffer(value));
  static final _$getAIFinancialAdvice = $grpc.ClientMethod<
          $24.GetAIFinancialAdviceRequest, $24.GetAIFinancialAdviceResponse>(
      '/pb.StatisticsService/GetAIFinancialAdvice',
      ($24.GetAIFinancialAdviceRequest value) => value.writeToBuffer(),
      ($core.List<$core.int> value) =>
          $24.GetAIFinancialAdviceResponse.fromBuffer(value));
  static final _$getIncomeSources = $grpc.ClientMethod<
          $24.GetIncomeSourcesRequest, $24.GetIncomeSourcesResponse>(
      '/pb.StatisticsService/GetIncomeSources',
      ($24.GetIncomeSourcesRequest value) => value.writeToBuffer(),
      ($core.List<$core.int> value) =>
          $24.GetIncomeSourcesResponse.fromBuffer(value));
  static final _$getIncomeBreakdown = $grpc.ClientMethod<
          $24.GetIncomeBreakdownRequest, $24.GetIncomeBreakdownResponse>(
      '/pb.StatisticsService/GetIncomeBreakdown',
      ($24.GetIncomeBreakdownRequest value) => value.writeToBuffer(),
      ($core.List<$core.int> value) =>
          $24.GetIncomeBreakdownResponse.fromBuffer(value));
  static final _$createIncomeSource = $grpc.ClientMethod<
          $24.CreateIncomeSourceRequest, $24.CreateIncomeSourceResponse>(
      '/pb.StatisticsService/CreateIncomeSource',
      ($24.CreateIncomeSourceRequest value) => value.writeToBuffer(),
      ($core.List<$core.int> value) =>
          $24.CreateIncomeSourceResponse.fromBuffer(value));
  static final _$getInvestmentPortfolio = $grpc.ClientMethod<
          $24.GetInvestmentPortfolioRequest,
          $24.GetInvestmentPortfolioResponse>(
      '/pb.StatisticsService/GetInvestmentPortfolio',
      ($24.GetInvestmentPortfolioRequest value) => value.writeToBuffer(),
      ($core.List<$core.int> value) =>
          $24.GetInvestmentPortfolioResponse.fromBuffer(value));
  static final _$createInvestment = $grpc.ClientMethod<
          $24.CreateInvestmentRequest, $24.CreateInvestmentResponse>(
      '/pb.StatisticsService/CreateInvestment',
      ($24.CreateInvestmentRequest value) => value.writeToBuffer(),
      ($core.List<$core.int> value) =>
          $24.CreateInvestmentResponse.fromBuffer(value));
  static final _$getFinancialGoals = $grpc.ClientMethod<
          $24.GetFinancialGoalsRequest, $24.GetFinancialGoalsResponse>(
      '/pb.StatisticsService/GetFinancialGoals',
      ($24.GetFinancialGoalsRequest value) => value.writeToBuffer(),
      ($core.List<$core.int> value) =>
          $24.GetFinancialGoalsResponse.fromBuffer(value));
  static final _$createFinancialGoal = $grpc.ClientMethod<
          $24.CreateFinancialGoalRequest, $24.CreateFinancialGoalResponse>(
      '/pb.StatisticsService/CreateFinancialGoal',
      ($24.CreateFinancialGoalRequest value) => value.writeToBuffer(),
      ($core.List<$core.int> value) =>
          $24.CreateFinancialGoalResponse.fromBuffer(value));
  static final _$updateFinancialGoalProgress = $grpc.ClientMethod<
          $24.UpdateFinancialGoalProgressRequest,
          $24.UpdateFinancialGoalProgressResponse>(
      '/pb.StatisticsService/UpdateFinancialGoalProgress',
      ($24.UpdateFinancialGoalProgressRequest value) => value.writeToBuffer(),
      ($core.List<$core.int> value) =>
          $24.UpdateFinancialGoalProgressResponse.fromBuffer(value));
  static final _$getSavingsGoal =
      $grpc.ClientMethod<$24.GetSavingsGoalRequest, $24.GetSavingsGoalResponse>(
          '/pb.StatisticsService/GetSavingsGoal',
          ($24.GetSavingsGoalRequest value) => value.writeToBuffer(),
          ($core.List<$core.int> value) =>
              $24.GetSavingsGoalResponse.fromBuffer(value));
  static final _$createOrUpdateSavingsGoal = $grpc.ClientMethod<
          $24.CreateOrUpdateSavingsGoalRequest,
          $24.CreateOrUpdateSavingsGoalResponse>(
      '/pb.StatisticsService/CreateOrUpdateSavingsGoal',
      ($24.CreateOrUpdateSavingsGoalRequest value) => value.writeToBuffer(),
      ($core.List<$core.int> value) =>
          $24.CreateOrUpdateSavingsGoalResponse.fromBuffer(value));
  static final _$getUpcomingBills = $grpc.ClientMethod<
          $24.GetUpcomingBillsRequest, $24.GetUpcomingBillsResponse>(
      '/pb.StatisticsService/GetUpcomingBills',
      ($24.GetUpcomingBillsRequest value) => value.writeToBuffer(),
      ($core.List<$core.int> value) =>
          $24.GetUpcomingBillsResponse.fromBuffer(value));
  static final _$createRecurringBill = $grpc.ClientMethod<
          $24.CreateRecurringBillRequest, $24.CreateRecurringBillResponse>(
      '/pb.StatisticsService/CreateRecurringBill',
      ($24.CreateRecurringBillRequest value) => value.writeToBuffer(),
      ($core.List<$core.int> value) =>
          $24.CreateRecurringBillResponse.fromBuffer(value));
  static final _$getTrackedIncome = $grpc.ClientMethod<
          $24.GetTrackedIncomeRequest, $24.GetTrackedIncomeResponse>(
      '/pb.StatisticsService/GetTrackedIncome',
      ($24.GetTrackedIncomeRequest value) => value.writeToBuffer(),
      ($core.List<$core.int> value) =>
          $24.GetTrackedIncomeResponse.fromBuffer(value));
  static final _$getTrackedExpenditure = $grpc.ClientMethod<
          $24.GetTrackedExpenditureRequest, $24.GetTrackedExpenditureResponse>(
      '/pb.StatisticsService/GetTrackedExpenditure',
      ($24.GetTrackedExpenditureRequest value) => value.writeToBuffer(),
      ($core.List<$core.int> value) =>
          $24.GetTrackedExpenditureResponse.fromBuffer(value));
  static final _$getTrackedIncomeBreakdown = $grpc.ClientMethod<
          $24.GetTrackedIncomeBreakdownRequest,
          $24.GetTrackedIncomeBreakdownResponse>(
      '/pb.StatisticsService/GetTrackedIncomeBreakdown',
      ($24.GetTrackedIncomeBreakdownRequest value) => value.writeToBuffer(),
      ($core.List<$core.int> value) =>
          $24.GetTrackedIncomeBreakdownResponse.fromBuffer(value));
  static final _$getTrackedExpenditureBreakdown = $grpc.ClientMethod<
          $24.GetTrackedExpenditureBreakdownRequest,
          $24.GetTrackedExpenditureBreakdownResponse>(
      '/pb.StatisticsService/GetTrackedExpenditureBreakdown',
      ($24.GetTrackedExpenditureBreakdownRequest value) =>
          value.writeToBuffer(),
      ($core.List<$core.int> value) =>
          $24.GetTrackedExpenditureBreakdownResponse.fromBuffer(value));
  static final _$getTrackedIncomeTransactions = $grpc.ClientMethod<
          $24.GetTrackedIncomeTransactionsRequest,
          $24.GetTrackedIncomeTransactionsResponse>(
      '/pb.StatisticsService/GetTrackedIncomeTransactions',
      ($24.GetTrackedIncomeTransactionsRequest value) => value.writeToBuffer(),
      ($core.List<$core.int> value) =>
          $24.GetTrackedIncomeTransactionsResponse.fromBuffer(value));
  static final _$getTrackedExpenditureTransactions = $grpc.ClientMethod<
          $24.GetTrackedExpenditureTransactionsRequest,
          $24.GetTrackedExpenditureTransactionsResponse>(
      '/pb.StatisticsService/GetTrackedExpenditureTransactions',
      ($24.GetTrackedExpenditureTransactionsRequest value) =>
          value.writeToBuffer(),
      ($core.List<$core.int> value) =>
          $24.GetTrackedExpenditureTransactionsResponse.fromBuffer(value));
  static final _$getComprehensiveFinancialSummary = $grpc.ClientMethod<
          $24.GetComprehensiveFinancialSummaryRequest,
          $24.GetComprehensiveFinancialSummaryResponse>(
      '/pb.StatisticsService/GetComprehensiveFinancialSummary',
      ($24.GetComprehensiveFinancialSummaryRequest value) =>
          value.writeToBuffer(),
      ($core.List<$core.int> value) =>
          $24.GetComprehensiveFinancialSummaryResponse.fromBuffer(value));

  StatisticsServiceClient($grpc.ClientChannel channel,
      {$grpc.CallOptions? options,
      $core.Iterable<$grpc.ClientInterceptor>? interceptors})
      : super(channel, options: options, interceptors: interceptors);

  $grpc.ResponseFuture<$24.CreateExpenseResponse> createExpense(
      $24.CreateExpenseRequest request,
      {$grpc.CallOptions? options}) {
    return $createUnaryCall(_$createExpense, request, options: options);
  }

  $grpc.ResponseFuture<$24.GetExpensesResponse> getExpenses(
      $24.GetExpensesRequest request,
      {$grpc.CallOptions? options}) {
    return $createUnaryCall(_$getExpenses, request, options: options);
  }

  $grpc.ResponseFuture<$24.GetExpenseByIdResponse> getExpenseById(
      $24.GetExpenseByIdRequest request,
      {$grpc.CallOptions? options}) {
    return $createUnaryCall(_$getExpenseById, request, options: options);
  }

  $grpc.ResponseFuture<$24.UpdateExpenseResponse> updateExpense(
      $24.UpdateExpenseRequest request,
      {$grpc.CallOptions? options}) {
    return $createUnaryCall(_$updateExpense, request, options: options);
  }

  $grpc.ResponseFuture<$24.DeleteExpenseResponse> deleteExpense(
      $24.DeleteExpenseRequest request,
      {$grpc.CallOptions? options}) {
    return $createUnaryCall(_$deleteExpense, request, options: options);
  }

  $grpc.ResponseFuture<$24.CreateBudgetResponse> createBudget(
      $24.CreateBudgetRequest request,
      {$grpc.CallOptions? options}) {
    return $createUnaryCall(_$createBudget, request, options: options);
  }

  $grpc.ResponseFuture<$24.GetBudgetsResponse> getBudgets(
      $24.GetBudgetsRequest request,
      {$grpc.CallOptions? options}) {
    return $createUnaryCall(_$getBudgets, request, options: options);
  }

  $grpc.ResponseFuture<$24.GetBudgetByIdResponse> getBudgetById(
      $24.GetBudgetByIdRequest request,
      {$grpc.CallOptions? options}) {
    return $createUnaryCall(_$getBudgetById, request, options: options);
  }

  $grpc.ResponseFuture<$24.UpdateBudgetResponse> updateBudget(
      $24.UpdateBudgetRequest request,
      {$grpc.CallOptions? options}) {
    return $createUnaryCall(_$updateBudget, request, options: options);
  }

  $grpc.ResponseFuture<$24.DeleteBudgetResponse> deleteBudget(
      $24.DeleteBudgetRequest request,
      {$grpc.CallOptions? options}) {
    return $createUnaryCall(_$deleteBudget, request, options: options);
  }

  $grpc.ResponseFuture<$24.GetSpendingAnalyticsResponse> getSpendingAnalytics(
      $24.GetSpendingAnalyticsRequest request,
      {$grpc.CallOptions? options}) {
    return $createUnaryCall(_$getSpendingAnalytics, request, options: options);
  }

  $grpc.ResponseFuture<$24.GetCategoryBreakdownResponse> getCategoryBreakdown(
      $24.GetCategoryBreakdownRequest request,
      {$grpc.CallOptions? options}) {
    return $createUnaryCall(_$getCategoryBreakdown, request, options: options);
  }

  $grpc.ResponseFuture<$24.GetBudgetProgressResponse> getBudgetProgress(
      $24.GetBudgetProgressRequest request,
      {$grpc.CallOptions? options}) {
    return $createUnaryCall(_$getBudgetProgress, request, options: options);
  }

  $grpc.ResponseFuture<$24.GetSpendingTrendsResponse> getSpendingTrends(
      $24.GetSpendingTrendsRequest request,
      {$grpc.CallOptions? options}) {
    return $createUnaryCall(_$getSpendingTrends, request, options: options);
  }

  $grpc.ResponseFuture<$24.GetBudgetAlertsResponse> getBudgetAlerts(
      $24.GetBudgetAlertsRequest request,
      {$grpc.CallOptions? options}) {
    return $createUnaryCall(_$getBudgetAlerts, request, options: options);
  }

  $grpc.ResponseFuture<$24.MarkAlertAsReadResponse> markAlertAsRead(
      $24.MarkAlertAsReadRequest request,
      {$grpc.CallOptions? options}) {
    return $createUnaryCall(_$markAlertAsRead, request, options: options);
  }

  $grpc.ResponseFuture<$24.GetAISpendingInsightsResponse> getAISpendingInsights(
      $24.GetAISpendingInsightsRequest request,
      {$grpc.CallOptions? options}) {
    return $createUnaryCall(_$getAISpendingInsights, request, options: options);
  }

  $grpc.ResponseFuture<$24.GetAIBudgetingRecommendationsResponse>
      getAIBudgetingRecommendations(
          $24.GetAIBudgetingRecommendationsRequest request,
          {$grpc.CallOptions? options}) {
    return $createUnaryCall(_$getAIBudgetingRecommendations, request,
        options: options);
  }

  $grpc.ResponseFuture<$24.AutoCategorizeExpenseResponse> autoCategorizeExpense(
      $24.AutoCategorizeExpenseRequest request,
      {$grpc.CallOptions? options}) {
    return $createUnaryCall(_$autoCategorizeExpense, request, options: options);
  }

  $grpc.ResponseFuture<$24.GetAIFinancialAdviceResponse> getAIFinancialAdvice(
      $24.GetAIFinancialAdviceRequest request,
      {$grpc.CallOptions? options}) {
    return $createUnaryCall(_$getAIFinancialAdvice, request, options: options);
  }

  $grpc.ResponseFuture<$24.GetIncomeSourcesResponse> getIncomeSources(
      $24.GetIncomeSourcesRequest request,
      {$grpc.CallOptions? options}) {
    return $createUnaryCall(_$getIncomeSources, request, options: options);
  }

  $grpc.ResponseFuture<$24.GetIncomeBreakdownResponse> getIncomeBreakdown(
      $24.GetIncomeBreakdownRequest request,
      {$grpc.CallOptions? options}) {
    return $createUnaryCall(_$getIncomeBreakdown, request, options: options);
  }

  $grpc.ResponseFuture<$24.CreateIncomeSourceResponse> createIncomeSource(
      $24.CreateIncomeSourceRequest request,
      {$grpc.CallOptions? options}) {
    return $createUnaryCall(_$createIncomeSource, request, options: options);
  }

  $grpc.ResponseFuture<$24.GetInvestmentPortfolioResponse>
      getInvestmentPortfolio($24.GetInvestmentPortfolioRequest request,
          {$grpc.CallOptions? options}) {
    return $createUnaryCall(_$getInvestmentPortfolio, request,
        options: options);
  }

  $grpc.ResponseFuture<$24.CreateInvestmentResponse> createInvestment(
      $24.CreateInvestmentRequest request,
      {$grpc.CallOptions? options}) {
    return $createUnaryCall(_$createInvestment, request, options: options);
  }

  $grpc.ResponseFuture<$24.GetFinancialGoalsResponse> getFinancialGoals(
      $24.GetFinancialGoalsRequest request,
      {$grpc.CallOptions? options}) {
    return $createUnaryCall(_$getFinancialGoals, request, options: options);
  }

  $grpc.ResponseFuture<$24.CreateFinancialGoalResponse> createFinancialGoal(
      $24.CreateFinancialGoalRequest request,
      {$grpc.CallOptions? options}) {
    return $createUnaryCall(_$createFinancialGoal, request, options: options);
  }

  $grpc.ResponseFuture<$24.UpdateFinancialGoalProgressResponse>
      updateFinancialGoalProgress(
          $24.UpdateFinancialGoalProgressRequest request,
          {$grpc.CallOptions? options}) {
    return $createUnaryCall(_$updateFinancialGoalProgress, request,
        options: options);
  }

  $grpc.ResponseFuture<$24.GetSavingsGoalResponse> getSavingsGoal(
      $24.GetSavingsGoalRequest request,
      {$grpc.CallOptions? options}) {
    return $createUnaryCall(_$getSavingsGoal, request, options: options);
  }

  $grpc.ResponseFuture<$24.CreateOrUpdateSavingsGoalResponse>
      createOrUpdateSavingsGoal($24.CreateOrUpdateSavingsGoalRequest request,
          {$grpc.CallOptions? options}) {
    return $createUnaryCall(_$createOrUpdateSavingsGoal, request,
        options: options);
  }

  $grpc.ResponseFuture<$24.GetUpcomingBillsResponse> getUpcomingBills(
      $24.GetUpcomingBillsRequest request,
      {$grpc.CallOptions? options}) {
    return $createUnaryCall(_$getUpcomingBills, request, options: options);
  }

  $grpc.ResponseFuture<$24.CreateRecurringBillResponse> createRecurringBill(
      $24.CreateRecurringBillRequest request,
      {$grpc.CallOptions? options}) {
    return $createUnaryCall(_$createRecurringBill, request, options: options);
  }

  $grpc.ResponseFuture<$24.GetTrackedIncomeResponse> getTrackedIncome(
      $24.GetTrackedIncomeRequest request,
      {$grpc.CallOptions? options}) {
    return $createUnaryCall(_$getTrackedIncome, request, options: options);
  }

  $grpc.ResponseFuture<$24.GetTrackedExpenditureResponse> getTrackedExpenditure(
      $24.GetTrackedExpenditureRequest request,
      {$grpc.CallOptions? options}) {
    return $createUnaryCall(_$getTrackedExpenditure, request, options: options);
  }

  $grpc.ResponseFuture<$24.GetTrackedIncomeBreakdownResponse>
      getTrackedIncomeBreakdown($24.GetTrackedIncomeBreakdownRequest request,
          {$grpc.CallOptions? options}) {
    return $createUnaryCall(_$getTrackedIncomeBreakdown, request,
        options: options);
  }

  $grpc.ResponseFuture<$24.GetTrackedExpenditureBreakdownResponse>
      getTrackedExpenditureBreakdown(
          $24.GetTrackedExpenditureBreakdownRequest request,
          {$grpc.CallOptions? options}) {
    return $createUnaryCall(_$getTrackedExpenditureBreakdown, request,
        options: options);
  }

  $grpc.ResponseFuture<$24.GetTrackedIncomeTransactionsResponse>
      getTrackedIncomeTransactions(
          $24.GetTrackedIncomeTransactionsRequest request,
          {$grpc.CallOptions? options}) {
    return $createUnaryCall(_$getTrackedIncomeTransactions, request,
        options: options);
  }

  $grpc.ResponseFuture<$24.GetTrackedExpenditureTransactionsResponse>
      getTrackedExpenditureTransactions(
          $24.GetTrackedExpenditureTransactionsRequest request,
          {$grpc.CallOptions? options}) {
    return $createUnaryCall(_$getTrackedExpenditureTransactions, request,
        options: options);
  }

  $grpc.ResponseFuture<$24.GetComprehensiveFinancialSummaryResponse>
      getComprehensiveFinancialSummary(
          $24.GetComprehensiveFinancialSummaryRequest request,
          {$grpc.CallOptions? options}) {
    return $createUnaryCall(_$getComprehensiveFinancialSummary, request,
        options: options);
  }
}

abstract class StatisticsServiceBase extends $grpc.Service {
  $core.String get $name => 'pb.StatisticsService';

  StatisticsServiceBase() {
    $addMethod($grpc.ServiceMethod<$24.CreateExpenseRequest,
            $24.CreateExpenseResponse>(
        'CreateExpense',
        createExpense_Pre,
        false,
        false,
        ($core.List<$core.int> value) =>
            $24.CreateExpenseRequest.fromBuffer(value),
        ($24.CreateExpenseResponse value) => value.writeToBuffer()));
    $addMethod(
        $grpc.ServiceMethod<$24.GetExpensesRequest, $24.GetExpensesResponse>(
            'GetExpenses',
            getExpenses_Pre,
            false,
            false,
            ($core.List<$core.int> value) =>
                $24.GetExpensesRequest.fromBuffer(value),
            ($24.GetExpensesResponse value) => value.writeToBuffer()));
    $addMethod($grpc.ServiceMethod<$24.GetExpenseByIdRequest,
            $24.GetExpenseByIdResponse>(
        'GetExpenseById',
        getExpenseById_Pre,
        false,
        false,
        ($core.List<$core.int> value) =>
            $24.GetExpenseByIdRequest.fromBuffer(value),
        ($24.GetExpenseByIdResponse value) => value.writeToBuffer()));
    $addMethod($grpc.ServiceMethod<$24.UpdateExpenseRequest,
            $24.UpdateExpenseResponse>(
        'UpdateExpense',
        updateExpense_Pre,
        false,
        false,
        ($core.List<$core.int> value) =>
            $24.UpdateExpenseRequest.fromBuffer(value),
        ($24.UpdateExpenseResponse value) => value.writeToBuffer()));
    $addMethod($grpc.ServiceMethod<$24.DeleteExpenseRequest,
            $24.DeleteExpenseResponse>(
        'DeleteExpense',
        deleteExpense_Pre,
        false,
        false,
        ($core.List<$core.int> value) =>
            $24.DeleteExpenseRequest.fromBuffer(value),
        ($24.DeleteExpenseResponse value) => value.writeToBuffer()));
    $addMethod(
        $grpc.ServiceMethod<$24.CreateBudgetRequest, $24.CreateBudgetResponse>(
            'CreateBudget',
            createBudget_Pre,
            false,
            false,
            ($core.List<$core.int> value) =>
                $24.CreateBudgetRequest.fromBuffer(value),
            ($24.CreateBudgetResponse value) => value.writeToBuffer()));
    $addMethod(
        $grpc.ServiceMethod<$24.GetBudgetsRequest, $24.GetBudgetsResponse>(
            'GetBudgets',
            getBudgets_Pre,
            false,
            false,
            ($core.List<$core.int> value) =>
                $24.GetBudgetsRequest.fromBuffer(value),
            ($24.GetBudgetsResponse value) => value.writeToBuffer()));
    $addMethod($grpc.ServiceMethod<$24.GetBudgetByIdRequest,
            $24.GetBudgetByIdResponse>(
        'GetBudgetById',
        getBudgetById_Pre,
        false,
        false,
        ($core.List<$core.int> value) =>
            $24.GetBudgetByIdRequest.fromBuffer(value),
        ($24.GetBudgetByIdResponse value) => value.writeToBuffer()));
    $addMethod(
        $grpc.ServiceMethod<$24.UpdateBudgetRequest, $24.UpdateBudgetResponse>(
            'UpdateBudget',
            updateBudget_Pre,
            false,
            false,
            ($core.List<$core.int> value) =>
                $24.UpdateBudgetRequest.fromBuffer(value),
            ($24.UpdateBudgetResponse value) => value.writeToBuffer()));
    $addMethod(
        $grpc.ServiceMethod<$24.DeleteBudgetRequest, $24.DeleteBudgetResponse>(
            'DeleteBudget',
            deleteBudget_Pre,
            false,
            false,
            ($core.List<$core.int> value) =>
                $24.DeleteBudgetRequest.fromBuffer(value),
            ($24.DeleteBudgetResponse value) => value.writeToBuffer()));
    $addMethod($grpc.ServiceMethod<$24.GetSpendingAnalyticsRequest,
            $24.GetSpendingAnalyticsResponse>(
        'GetSpendingAnalytics',
        getSpendingAnalytics_Pre,
        false,
        false,
        ($core.List<$core.int> value) =>
            $24.GetSpendingAnalyticsRequest.fromBuffer(value),
        ($24.GetSpendingAnalyticsResponse value) => value.writeToBuffer()));
    $addMethod($grpc.ServiceMethod<$24.GetCategoryBreakdownRequest,
            $24.GetCategoryBreakdownResponse>(
        'GetCategoryBreakdown',
        getCategoryBreakdown_Pre,
        false,
        false,
        ($core.List<$core.int> value) =>
            $24.GetCategoryBreakdownRequest.fromBuffer(value),
        ($24.GetCategoryBreakdownResponse value) => value.writeToBuffer()));
    $addMethod($grpc.ServiceMethod<$24.GetBudgetProgressRequest,
            $24.GetBudgetProgressResponse>(
        'GetBudgetProgress',
        getBudgetProgress_Pre,
        false,
        false,
        ($core.List<$core.int> value) =>
            $24.GetBudgetProgressRequest.fromBuffer(value),
        ($24.GetBudgetProgressResponse value) => value.writeToBuffer()));
    $addMethod($grpc.ServiceMethod<$24.GetSpendingTrendsRequest,
            $24.GetSpendingTrendsResponse>(
        'GetSpendingTrends',
        getSpendingTrends_Pre,
        false,
        false,
        ($core.List<$core.int> value) =>
            $24.GetSpendingTrendsRequest.fromBuffer(value),
        ($24.GetSpendingTrendsResponse value) => value.writeToBuffer()));
    $addMethod($grpc.ServiceMethod<$24.GetBudgetAlertsRequest,
            $24.GetBudgetAlertsResponse>(
        'GetBudgetAlerts',
        getBudgetAlerts_Pre,
        false,
        false,
        ($core.List<$core.int> value) =>
            $24.GetBudgetAlertsRequest.fromBuffer(value),
        ($24.GetBudgetAlertsResponse value) => value.writeToBuffer()));
    $addMethod($grpc.ServiceMethod<$24.MarkAlertAsReadRequest,
            $24.MarkAlertAsReadResponse>(
        'MarkAlertAsRead',
        markAlertAsRead_Pre,
        false,
        false,
        ($core.List<$core.int> value) =>
            $24.MarkAlertAsReadRequest.fromBuffer(value),
        ($24.MarkAlertAsReadResponse value) => value.writeToBuffer()));
    $addMethod($grpc.ServiceMethod<$24.GetAISpendingInsightsRequest,
            $24.GetAISpendingInsightsResponse>(
        'GetAISpendingInsights',
        getAISpendingInsights_Pre,
        false,
        false,
        ($core.List<$core.int> value) =>
            $24.GetAISpendingInsightsRequest.fromBuffer(value),
        ($24.GetAISpendingInsightsResponse value) => value.writeToBuffer()));
    $addMethod($grpc.ServiceMethod<$24.GetAIBudgetingRecommendationsRequest,
            $24.GetAIBudgetingRecommendationsResponse>(
        'GetAIBudgetingRecommendations',
        getAIBudgetingRecommendations_Pre,
        false,
        false,
        ($core.List<$core.int> value) =>
            $24.GetAIBudgetingRecommendationsRequest.fromBuffer(value),
        ($24.GetAIBudgetingRecommendationsResponse value) =>
            value.writeToBuffer()));
    $addMethod($grpc.ServiceMethod<$24.AutoCategorizeExpenseRequest,
            $24.AutoCategorizeExpenseResponse>(
        'AutoCategorizeExpense',
        autoCategorizeExpense_Pre,
        false,
        false,
        ($core.List<$core.int> value) =>
            $24.AutoCategorizeExpenseRequest.fromBuffer(value),
        ($24.AutoCategorizeExpenseResponse value) => value.writeToBuffer()));
    $addMethod($grpc.ServiceMethod<$24.GetAIFinancialAdviceRequest,
            $24.GetAIFinancialAdviceResponse>(
        'GetAIFinancialAdvice',
        getAIFinancialAdvice_Pre,
        false,
        false,
        ($core.List<$core.int> value) =>
            $24.GetAIFinancialAdviceRequest.fromBuffer(value),
        ($24.GetAIFinancialAdviceResponse value) => value.writeToBuffer()));
    $addMethod($grpc.ServiceMethod<$24.GetIncomeSourcesRequest,
            $24.GetIncomeSourcesResponse>(
        'GetIncomeSources',
        getIncomeSources_Pre,
        false,
        false,
        ($core.List<$core.int> value) =>
            $24.GetIncomeSourcesRequest.fromBuffer(value),
        ($24.GetIncomeSourcesResponse value) => value.writeToBuffer()));
    $addMethod($grpc.ServiceMethod<$24.GetIncomeBreakdownRequest,
            $24.GetIncomeBreakdownResponse>(
        'GetIncomeBreakdown',
        getIncomeBreakdown_Pre,
        false,
        false,
        ($core.List<$core.int> value) =>
            $24.GetIncomeBreakdownRequest.fromBuffer(value),
        ($24.GetIncomeBreakdownResponse value) => value.writeToBuffer()));
    $addMethod($grpc.ServiceMethod<$24.CreateIncomeSourceRequest,
            $24.CreateIncomeSourceResponse>(
        'CreateIncomeSource',
        createIncomeSource_Pre,
        false,
        false,
        ($core.List<$core.int> value) =>
            $24.CreateIncomeSourceRequest.fromBuffer(value),
        ($24.CreateIncomeSourceResponse value) => value.writeToBuffer()));
    $addMethod($grpc.ServiceMethod<$24.GetInvestmentPortfolioRequest,
            $24.GetInvestmentPortfolioResponse>(
        'GetInvestmentPortfolio',
        getInvestmentPortfolio_Pre,
        false,
        false,
        ($core.List<$core.int> value) =>
            $24.GetInvestmentPortfolioRequest.fromBuffer(value),
        ($24.GetInvestmentPortfolioResponse value) => value.writeToBuffer()));
    $addMethod($grpc.ServiceMethod<$24.CreateInvestmentRequest,
            $24.CreateInvestmentResponse>(
        'CreateInvestment',
        createInvestment_Pre,
        false,
        false,
        ($core.List<$core.int> value) =>
            $24.CreateInvestmentRequest.fromBuffer(value),
        ($24.CreateInvestmentResponse value) => value.writeToBuffer()));
    $addMethod($grpc.ServiceMethod<$24.GetFinancialGoalsRequest,
            $24.GetFinancialGoalsResponse>(
        'GetFinancialGoals',
        getFinancialGoals_Pre,
        false,
        false,
        ($core.List<$core.int> value) =>
            $24.GetFinancialGoalsRequest.fromBuffer(value),
        ($24.GetFinancialGoalsResponse value) => value.writeToBuffer()));
    $addMethod($grpc.ServiceMethod<$24.CreateFinancialGoalRequest,
            $24.CreateFinancialGoalResponse>(
        'CreateFinancialGoal',
        createFinancialGoal_Pre,
        false,
        false,
        ($core.List<$core.int> value) =>
            $24.CreateFinancialGoalRequest.fromBuffer(value),
        ($24.CreateFinancialGoalResponse value) => value.writeToBuffer()));
    $addMethod($grpc.ServiceMethod<$24.UpdateFinancialGoalProgressRequest,
            $24.UpdateFinancialGoalProgressResponse>(
        'UpdateFinancialGoalProgress',
        updateFinancialGoalProgress_Pre,
        false,
        false,
        ($core.List<$core.int> value) =>
            $24.UpdateFinancialGoalProgressRequest.fromBuffer(value),
        ($24.UpdateFinancialGoalProgressResponse value) =>
            value.writeToBuffer()));
    $addMethod($grpc.ServiceMethod<$24.GetSavingsGoalRequest,
            $24.GetSavingsGoalResponse>(
        'GetSavingsGoal',
        getSavingsGoal_Pre,
        false,
        false,
        ($core.List<$core.int> value) =>
            $24.GetSavingsGoalRequest.fromBuffer(value),
        ($24.GetSavingsGoalResponse value) => value.writeToBuffer()));
    $addMethod($grpc.ServiceMethod<$24.CreateOrUpdateSavingsGoalRequest,
            $24.CreateOrUpdateSavingsGoalResponse>(
        'CreateOrUpdateSavingsGoal',
        createOrUpdateSavingsGoal_Pre,
        false,
        false,
        ($core.List<$core.int> value) =>
            $24.CreateOrUpdateSavingsGoalRequest.fromBuffer(value),
        ($24.CreateOrUpdateSavingsGoalResponse value) =>
            value.writeToBuffer()));
    $addMethod($grpc.ServiceMethod<$24.GetUpcomingBillsRequest,
            $24.GetUpcomingBillsResponse>(
        'GetUpcomingBills',
        getUpcomingBills_Pre,
        false,
        false,
        ($core.List<$core.int> value) =>
            $24.GetUpcomingBillsRequest.fromBuffer(value),
        ($24.GetUpcomingBillsResponse value) => value.writeToBuffer()));
    $addMethod($grpc.ServiceMethod<$24.CreateRecurringBillRequest,
            $24.CreateRecurringBillResponse>(
        'CreateRecurringBill',
        createRecurringBill_Pre,
        false,
        false,
        ($core.List<$core.int> value) =>
            $24.CreateRecurringBillRequest.fromBuffer(value),
        ($24.CreateRecurringBillResponse value) => value.writeToBuffer()));
    $addMethod($grpc.ServiceMethod<$24.GetTrackedIncomeRequest,
            $24.GetTrackedIncomeResponse>(
        'GetTrackedIncome',
        getTrackedIncome_Pre,
        false,
        false,
        ($core.List<$core.int> value) =>
            $24.GetTrackedIncomeRequest.fromBuffer(value),
        ($24.GetTrackedIncomeResponse value) => value.writeToBuffer()));
    $addMethod($grpc.ServiceMethod<$24.GetTrackedExpenditureRequest,
            $24.GetTrackedExpenditureResponse>(
        'GetTrackedExpenditure',
        getTrackedExpenditure_Pre,
        false,
        false,
        ($core.List<$core.int> value) =>
            $24.GetTrackedExpenditureRequest.fromBuffer(value),
        ($24.GetTrackedExpenditureResponse value) => value.writeToBuffer()));
    $addMethod($grpc.ServiceMethod<$24.GetTrackedIncomeBreakdownRequest,
            $24.GetTrackedIncomeBreakdownResponse>(
        'GetTrackedIncomeBreakdown',
        getTrackedIncomeBreakdown_Pre,
        false,
        false,
        ($core.List<$core.int> value) =>
            $24.GetTrackedIncomeBreakdownRequest.fromBuffer(value),
        ($24.GetTrackedIncomeBreakdownResponse value) =>
            value.writeToBuffer()));
    $addMethod($grpc.ServiceMethod<$24.GetTrackedExpenditureBreakdownRequest,
            $24.GetTrackedExpenditureBreakdownResponse>(
        'GetTrackedExpenditureBreakdown',
        getTrackedExpenditureBreakdown_Pre,
        false,
        false,
        ($core.List<$core.int> value) =>
            $24.GetTrackedExpenditureBreakdownRequest.fromBuffer(value),
        ($24.GetTrackedExpenditureBreakdownResponse value) =>
            value.writeToBuffer()));
    $addMethod($grpc.ServiceMethod<$24.GetTrackedIncomeTransactionsRequest,
            $24.GetTrackedIncomeTransactionsResponse>(
        'GetTrackedIncomeTransactions',
        getTrackedIncomeTransactions_Pre,
        false,
        false,
        ($core.List<$core.int> value) =>
            $24.GetTrackedIncomeTransactionsRequest.fromBuffer(value),
        ($24.GetTrackedIncomeTransactionsResponse value) =>
            value.writeToBuffer()));
    $addMethod($grpc.ServiceMethod<$24.GetTrackedExpenditureTransactionsRequest,
            $24.GetTrackedExpenditureTransactionsResponse>(
        'GetTrackedExpenditureTransactions',
        getTrackedExpenditureTransactions_Pre,
        false,
        false,
        ($core.List<$core.int> value) =>
            $24.GetTrackedExpenditureTransactionsRequest.fromBuffer(value),
        ($24.GetTrackedExpenditureTransactionsResponse value) =>
            value.writeToBuffer()));
    $addMethod($grpc.ServiceMethod<$24.GetComprehensiveFinancialSummaryRequest,
            $24.GetComprehensiveFinancialSummaryResponse>(
        'GetComprehensiveFinancialSummary',
        getComprehensiveFinancialSummary_Pre,
        false,
        false,
        ($core.List<$core.int> value) =>
            $24.GetComprehensiveFinancialSummaryRequest.fromBuffer(value),
        ($24.GetComprehensiveFinancialSummaryResponse value) =>
            value.writeToBuffer()));
  }

  $async.Future<$24.CreateExpenseResponse> createExpense_Pre(
      $grpc.ServiceCall call,
      $async.Future<$24.CreateExpenseRequest> request) async {
    return createExpense(call, await request);
  }

  $async.Future<$24.GetExpensesResponse> getExpenses_Pre($grpc.ServiceCall call,
      $async.Future<$24.GetExpensesRequest> request) async {
    return getExpenses(call, await request);
  }

  $async.Future<$24.GetExpenseByIdResponse> getExpenseById_Pre(
      $grpc.ServiceCall call,
      $async.Future<$24.GetExpenseByIdRequest> request) async {
    return getExpenseById(call, await request);
  }

  $async.Future<$24.UpdateExpenseResponse> updateExpense_Pre(
      $grpc.ServiceCall call,
      $async.Future<$24.UpdateExpenseRequest> request) async {
    return updateExpense(call, await request);
  }

  $async.Future<$24.DeleteExpenseResponse> deleteExpense_Pre(
      $grpc.ServiceCall call,
      $async.Future<$24.DeleteExpenseRequest> request) async {
    return deleteExpense(call, await request);
  }

  $async.Future<$24.CreateBudgetResponse> createBudget_Pre(
      $grpc.ServiceCall call,
      $async.Future<$24.CreateBudgetRequest> request) async {
    return createBudget(call, await request);
  }

  $async.Future<$24.GetBudgetsResponse> getBudgets_Pre($grpc.ServiceCall call,
      $async.Future<$24.GetBudgetsRequest> request) async {
    return getBudgets(call, await request);
  }

  $async.Future<$24.GetBudgetByIdResponse> getBudgetById_Pre(
      $grpc.ServiceCall call,
      $async.Future<$24.GetBudgetByIdRequest> request) async {
    return getBudgetById(call, await request);
  }

  $async.Future<$24.UpdateBudgetResponse> updateBudget_Pre(
      $grpc.ServiceCall call,
      $async.Future<$24.UpdateBudgetRequest> request) async {
    return updateBudget(call, await request);
  }

  $async.Future<$24.DeleteBudgetResponse> deleteBudget_Pre(
      $grpc.ServiceCall call,
      $async.Future<$24.DeleteBudgetRequest> request) async {
    return deleteBudget(call, await request);
  }

  $async.Future<$24.GetSpendingAnalyticsResponse> getSpendingAnalytics_Pre(
      $grpc.ServiceCall call,
      $async.Future<$24.GetSpendingAnalyticsRequest> request) async {
    return getSpendingAnalytics(call, await request);
  }

  $async.Future<$24.GetCategoryBreakdownResponse> getCategoryBreakdown_Pre(
      $grpc.ServiceCall call,
      $async.Future<$24.GetCategoryBreakdownRequest> request) async {
    return getCategoryBreakdown(call, await request);
  }

  $async.Future<$24.GetBudgetProgressResponse> getBudgetProgress_Pre(
      $grpc.ServiceCall call,
      $async.Future<$24.GetBudgetProgressRequest> request) async {
    return getBudgetProgress(call, await request);
  }

  $async.Future<$24.GetSpendingTrendsResponse> getSpendingTrends_Pre(
      $grpc.ServiceCall call,
      $async.Future<$24.GetSpendingTrendsRequest> request) async {
    return getSpendingTrends(call, await request);
  }

  $async.Future<$24.GetBudgetAlertsResponse> getBudgetAlerts_Pre(
      $grpc.ServiceCall call,
      $async.Future<$24.GetBudgetAlertsRequest> request) async {
    return getBudgetAlerts(call, await request);
  }

  $async.Future<$24.MarkAlertAsReadResponse> markAlertAsRead_Pre(
      $grpc.ServiceCall call,
      $async.Future<$24.MarkAlertAsReadRequest> request) async {
    return markAlertAsRead(call, await request);
  }

  $async.Future<$24.GetAISpendingInsightsResponse> getAISpendingInsights_Pre(
      $grpc.ServiceCall call,
      $async.Future<$24.GetAISpendingInsightsRequest> request) async {
    return getAISpendingInsights(call, await request);
  }

  $async.Future<$24.GetAIBudgetingRecommendationsResponse>
      getAIBudgetingRecommendations_Pre(
          $grpc.ServiceCall call,
          $async.Future<$24.GetAIBudgetingRecommendationsRequest>
              request) async {
    return getAIBudgetingRecommendations(call, await request);
  }

  $async.Future<$24.AutoCategorizeExpenseResponse> autoCategorizeExpense_Pre(
      $grpc.ServiceCall call,
      $async.Future<$24.AutoCategorizeExpenseRequest> request) async {
    return autoCategorizeExpense(call, await request);
  }

  $async.Future<$24.GetAIFinancialAdviceResponse> getAIFinancialAdvice_Pre(
      $grpc.ServiceCall call,
      $async.Future<$24.GetAIFinancialAdviceRequest> request) async {
    return getAIFinancialAdvice(call, await request);
  }

  $async.Future<$24.GetIncomeSourcesResponse> getIncomeSources_Pre(
      $grpc.ServiceCall call,
      $async.Future<$24.GetIncomeSourcesRequest> request) async {
    return getIncomeSources(call, await request);
  }

  $async.Future<$24.GetIncomeBreakdownResponse> getIncomeBreakdown_Pre(
      $grpc.ServiceCall call,
      $async.Future<$24.GetIncomeBreakdownRequest> request) async {
    return getIncomeBreakdown(call, await request);
  }

  $async.Future<$24.CreateIncomeSourceResponse> createIncomeSource_Pre(
      $grpc.ServiceCall call,
      $async.Future<$24.CreateIncomeSourceRequest> request) async {
    return createIncomeSource(call, await request);
  }

  $async.Future<$24.GetInvestmentPortfolioResponse> getInvestmentPortfolio_Pre(
      $grpc.ServiceCall call,
      $async.Future<$24.GetInvestmentPortfolioRequest> request) async {
    return getInvestmentPortfolio(call, await request);
  }

  $async.Future<$24.CreateInvestmentResponse> createInvestment_Pre(
      $grpc.ServiceCall call,
      $async.Future<$24.CreateInvestmentRequest> request) async {
    return createInvestment(call, await request);
  }

  $async.Future<$24.GetFinancialGoalsResponse> getFinancialGoals_Pre(
      $grpc.ServiceCall call,
      $async.Future<$24.GetFinancialGoalsRequest> request) async {
    return getFinancialGoals(call, await request);
  }

  $async.Future<$24.CreateFinancialGoalResponse> createFinancialGoal_Pre(
      $grpc.ServiceCall call,
      $async.Future<$24.CreateFinancialGoalRequest> request) async {
    return createFinancialGoal(call, await request);
  }

  $async.Future<$24.UpdateFinancialGoalProgressResponse>
      updateFinancialGoalProgress_Pre($grpc.ServiceCall call,
          $async.Future<$24.UpdateFinancialGoalProgressRequest> request) async {
    return updateFinancialGoalProgress(call, await request);
  }

  $async.Future<$24.GetSavingsGoalResponse> getSavingsGoal_Pre(
      $grpc.ServiceCall call,
      $async.Future<$24.GetSavingsGoalRequest> request) async {
    return getSavingsGoal(call, await request);
  }

  $async.Future<$24.CreateOrUpdateSavingsGoalResponse>
      createOrUpdateSavingsGoal_Pre($grpc.ServiceCall call,
          $async.Future<$24.CreateOrUpdateSavingsGoalRequest> request) async {
    return createOrUpdateSavingsGoal(call, await request);
  }

  $async.Future<$24.GetUpcomingBillsResponse> getUpcomingBills_Pre(
      $grpc.ServiceCall call,
      $async.Future<$24.GetUpcomingBillsRequest> request) async {
    return getUpcomingBills(call, await request);
  }

  $async.Future<$24.CreateRecurringBillResponse> createRecurringBill_Pre(
      $grpc.ServiceCall call,
      $async.Future<$24.CreateRecurringBillRequest> request) async {
    return createRecurringBill(call, await request);
  }

  $async.Future<$24.GetTrackedIncomeResponse> getTrackedIncome_Pre(
      $grpc.ServiceCall call,
      $async.Future<$24.GetTrackedIncomeRequest> request) async {
    return getTrackedIncome(call, await request);
  }

  $async.Future<$24.GetTrackedExpenditureResponse> getTrackedExpenditure_Pre(
      $grpc.ServiceCall call,
      $async.Future<$24.GetTrackedExpenditureRequest> request) async {
    return getTrackedExpenditure(call, await request);
  }

  $async.Future<$24.GetTrackedIncomeBreakdownResponse>
      getTrackedIncomeBreakdown_Pre($grpc.ServiceCall call,
          $async.Future<$24.GetTrackedIncomeBreakdownRequest> request) async {
    return getTrackedIncomeBreakdown(call, await request);
  }

  $async.Future<$24.GetTrackedExpenditureBreakdownResponse>
      getTrackedExpenditureBreakdown_Pre(
          $grpc.ServiceCall call,
          $async.Future<$24.GetTrackedExpenditureBreakdownRequest>
              request) async {
    return getTrackedExpenditureBreakdown(call, await request);
  }

  $async.Future<$24.GetTrackedIncomeTransactionsResponse>
      getTrackedIncomeTransactions_Pre(
          $grpc.ServiceCall call,
          $async.Future<$24.GetTrackedIncomeTransactionsRequest>
              request) async {
    return getTrackedIncomeTransactions(call, await request);
  }

  $async.Future<$24.GetTrackedExpenditureTransactionsResponse>
      getTrackedExpenditureTransactions_Pre(
          $grpc.ServiceCall call,
          $async.Future<$24.GetTrackedExpenditureTransactionsRequest>
              request) async {
    return getTrackedExpenditureTransactions(call, await request);
  }

  $async.Future<$24.GetComprehensiveFinancialSummaryResponse>
      getComprehensiveFinancialSummary_Pre(
          $grpc.ServiceCall call,
          $async.Future<$24.GetComprehensiveFinancialSummaryRequest>
              request) async {
    return getComprehensiveFinancialSummary(call, await request);
  }

  $async.Future<$24.CreateExpenseResponse> createExpense(
      $grpc.ServiceCall call, $24.CreateExpenseRequest request);
  $async.Future<$24.GetExpensesResponse> getExpenses(
      $grpc.ServiceCall call, $24.GetExpensesRequest request);
  $async.Future<$24.GetExpenseByIdResponse> getExpenseById(
      $grpc.ServiceCall call, $24.GetExpenseByIdRequest request);
  $async.Future<$24.UpdateExpenseResponse> updateExpense(
      $grpc.ServiceCall call, $24.UpdateExpenseRequest request);
  $async.Future<$24.DeleteExpenseResponse> deleteExpense(
      $grpc.ServiceCall call, $24.DeleteExpenseRequest request);
  $async.Future<$24.CreateBudgetResponse> createBudget(
      $grpc.ServiceCall call, $24.CreateBudgetRequest request);
  $async.Future<$24.GetBudgetsResponse> getBudgets(
      $grpc.ServiceCall call, $24.GetBudgetsRequest request);
  $async.Future<$24.GetBudgetByIdResponse> getBudgetById(
      $grpc.ServiceCall call, $24.GetBudgetByIdRequest request);
  $async.Future<$24.UpdateBudgetResponse> updateBudget(
      $grpc.ServiceCall call, $24.UpdateBudgetRequest request);
  $async.Future<$24.DeleteBudgetResponse> deleteBudget(
      $grpc.ServiceCall call, $24.DeleteBudgetRequest request);
  $async.Future<$24.GetSpendingAnalyticsResponse> getSpendingAnalytics(
      $grpc.ServiceCall call, $24.GetSpendingAnalyticsRequest request);
  $async.Future<$24.GetCategoryBreakdownResponse> getCategoryBreakdown(
      $grpc.ServiceCall call, $24.GetCategoryBreakdownRequest request);
  $async.Future<$24.GetBudgetProgressResponse> getBudgetProgress(
      $grpc.ServiceCall call, $24.GetBudgetProgressRequest request);
  $async.Future<$24.GetSpendingTrendsResponse> getSpendingTrends(
      $grpc.ServiceCall call, $24.GetSpendingTrendsRequest request);
  $async.Future<$24.GetBudgetAlertsResponse> getBudgetAlerts(
      $grpc.ServiceCall call, $24.GetBudgetAlertsRequest request);
  $async.Future<$24.MarkAlertAsReadResponse> markAlertAsRead(
      $grpc.ServiceCall call, $24.MarkAlertAsReadRequest request);
  $async.Future<$24.GetAISpendingInsightsResponse> getAISpendingInsights(
      $grpc.ServiceCall call, $24.GetAISpendingInsightsRequest request);
  $async.Future<$24.GetAIBudgetingRecommendationsResponse>
      getAIBudgetingRecommendations($grpc.ServiceCall call,
          $24.GetAIBudgetingRecommendationsRequest request);
  $async.Future<$24.AutoCategorizeExpenseResponse> autoCategorizeExpense(
      $grpc.ServiceCall call, $24.AutoCategorizeExpenseRequest request);
  $async.Future<$24.GetAIFinancialAdviceResponse> getAIFinancialAdvice(
      $grpc.ServiceCall call, $24.GetAIFinancialAdviceRequest request);
  $async.Future<$24.GetIncomeSourcesResponse> getIncomeSources(
      $grpc.ServiceCall call, $24.GetIncomeSourcesRequest request);
  $async.Future<$24.GetIncomeBreakdownResponse> getIncomeBreakdown(
      $grpc.ServiceCall call, $24.GetIncomeBreakdownRequest request);
  $async.Future<$24.CreateIncomeSourceResponse> createIncomeSource(
      $grpc.ServiceCall call, $24.CreateIncomeSourceRequest request);
  $async.Future<$24.GetInvestmentPortfolioResponse> getInvestmentPortfolio(
      $grpc.ServiceCall call, $24.GetInvestmentPortfolioRequest request);
  $async.Future<$24.CreateInvestmentResponse> createInvestment(
      $grpc.ServiceCall call, $24.CreateInvestmentRequest request);
  $async.Future<$24.GetFinancialGoalsResponse> getFinancialGoals(
      $grpc.ServiceCall call, $24.GetFinancialGoalsRequest request);
  $async.Future<$24.CreateFinancialGoalResponse> createFinancialGoal(
      $grpc.ServiceCall call, $24.CreateFinancialGoalRequest request);
  $async.Future<$24.UpdateFinancialGoalProgressResponse>
      updateFinancialGoalProgress($grpc.ServiceCall call,
          $24.UpdateFinancialGoalProgressRequest request);
  $async.Future<$24.GetSavingsGoalResponse> getSavingsGoal(
      $grpc.ServiceCall call, $24.GetSavingsGoalRequest request);
  $async.Future<$24.CreateOrUpdateSavingsGoalResponse>
      createOrUpdateSavingsGoal(
          $grpc.ServiceCall call, $24.CreateOrUpdateSavingsGoalRequest request);
  $async.Future<$24.GetUpcomingBillsResponse> getUpcomingBills(
      $grpc.ServiceCall call, $24.GetUpcomingBillsRequest request);
  $async.Future<$24.CreateRecurringBillResponse> createRecurringBill(
      $grpc.ServiceCall call, $24.CreateRecurringBillRequest request);
  $async.Future<$24.GetTrackedIncomeResponse> getTrackedIncome(
      $grpc.ServiceCall call, $24.GetTrackedIncomeRequest request);
  $async.Future<$24.GetTrackedExpenditureResponse> getTrackedExpenditure(
      $grpc.ServiceCall call, $24.GetTrackedExpenditureRequest request);
  $async.Future<$24.GetTrackedIncomeBreakdownResponse>
      getTrackedIncomeBreakdown(
          $grpc.ServiceCall call, $24.GetTrackedIncomeBreakdownRequest request);
  $async.Future<$24.GetTrackedExpenditureBreakdownResponse>
      getTrackedExpenditureBreakdown($grpc.ServiceCall call,
          $24.GetTrackedExpenditureBreakdownRequest request);
  $async.Future<$24.GetTrackedIncomeTransactionsResponse>
      getTrackedIncomeTransactions($grpc.ServiceCall call,
          $24.GetTrackedIncomeTransactionsRequest request);
  $async.Future<$24.GetTrackedExpenditureTransactionsResponse>
      getTrackedExpenditureTransactions($grpc.ServiceCall call,
          $24.GetTrackedExpenditureTransactionsRequest request);
  $async.Future<$24.GetComprehensiveFinancialSummaryResponse>
      getComprehensiveFinancialSummary($grpc.ServiceCall call,
          $24.GetComprehensiveFinancialSummaryRequest request);
}
