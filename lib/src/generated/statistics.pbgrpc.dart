///
//  Generated code. Do not modify.
//  source: statistics.proto
//
// @dart = 2.12
// ignore_for_file: annotate_overrides,camel_case_types,constant_identifier_names,directives_ordering,library_prefixes,non_constant_identifier_names,prefer_final_fields,return_of_invalid_type,unnecessary_const,unnecessary_import,unnecessary_this,unused_import,unused_shown_name

import 'dart:async' as $async;

import 'dart:core' as $core;

import 'package:grpc/service_api.dart' as $grpc;
import 'statistics.pb.dart' as $17;
export 'statistics.pb.dart';

class StatisticsServiceClient extends $grpc.Client {
  static final _$createExpense =
      $grpc.ClientMethod<$17.CreateExpenseRequest, $17.CreateExpenseResponse>(
          '/pb.StatisticsService/CreateExpense',
          ($17.CreateExpenseRequest value) => value.writeToBuffer(),
          ($core.List<$core.int> value) =>
              $17.CreateExpenseResponse.fromBuffer(value));
  static final _$getExpenses =
      $grpc.ClientMethod<$17.GetExpensesRequest, $17.GetExpensesResponse>(
          '/pb.StatisticsService/GetExpenses',
          ($17.GetExpensesRequest value) => value.writeToBuffer(),
          ($core.List<$core.int> value) =>
              $17.GetExpensesResponse.fromBuffer(value));
  static final _$getExpenseById =
      $grpc.ClientMethod<$17.GetExpenseByIdRequest, $17.GetExpenseByIdResponse>(
          '/pb.StatisticsService/GetExpenseById',
          ($17.GetExpenseByIdRequest value) => value.writeToBuffer(),
          ($core.List<$core.int> value) =>
              $17.GetExpenseByIdResponse.fromBuffer(value));
  static final _$updateExpense =
      $grpc.ClientMethod<$17.UpdateExpenseRequest, $17.UpdateExpenseResponse>(
          '/pb.StatisticsService/UpdateExpense',
          ($17.UpdateExpenseRequest value) => value.writeToBuffer(),
          ($core.List<$core.int> value) =>
              $17.UpdateExpenseResponse.fromBuffer(value));
  static final _$deleteExpense =
      $grpc.ClientMethod<$17.DeleteExpenseRequest, $17.DeleteExpenseResponse>(
          '/pb.StatisticsService/DeleteExpense',
          ($17.DeleteExpenseRequest value) => value.writeToBuffer(),
          ($core.List<$core.int> value) =>
              $17.DeleteExpenseResponse.fromBuffer(value));
  static final _$createBudget =
      $grpc.ClientMethod<$17.CreateBudgetRequest, $17.CreateBudgetResponse>(
          '/pb.StatisticsService/CreateBudget',
          ($17.CreateBudgetRequest value) => value.writeToBuffer(),
          ($core.List<$core.int> value) =>
              $17.CreateBudgetResponse.fromBuffer(value));
  static final _$getBudgets =
      $grpc.ClientMethod<$17.GetBudgetsRequest, $17.GetBudgetsResponse>(
          '/pb.StatisticsService/GetBudgets',
          ($17.GetBudgetsRequest value) => value.writeToBuffer(),
          ($core.List<$core.int> value) =>
              $17.GetBudgetsResponse.fromBuffer(value));
  static final _$getBudgetById =
      $grpc.ClientMethod<$17.GetBudgetByIdRequest, $17.GetBudgetByIdResponse>(
          '/pb.StatisticsService/GetBudgetById',
          ($17.GetBudgetByIdRequest value) => value.writeToBuffer(),
          ($core.List<$core.int> value) =>
              $17.GetBudgetByIdResponse.fromBuffer(value));
  static final _$updateBudget =
      $grpc.ClientMethod<$17.UpdateBudgetRequest, $17.UpdateBudgetResponse>(
          '/pb.StatisticsService/UpdateBudget',
          ($17.UpdateBudgetRequest value) => value.writeToBuffer(),
          ($core.List<$core.int> value) =>
              $17.UpdateBudgetResponse.fromBuffer(value));
  static final _$deleteBudget =
      $grpc.ClientMethod<$17.DeleteBudgetRequest, $17.DeleteBudgetResponse>(
          '/pb.StatisticsService/DeleteBudget',
          ($17.DeleteBudgetRequest value) => value.writeToBuffer(),
          ($core.List<$core.int> value) =>
              $17.DeleteBudgetResponse.fromBuffer(value));
  static final _$getSpendingAnalytics = $grpc.ClientMethod<
          $17.GetSpendingAnalyticsRequest, $17.GetSpendingAnalyticsResponse>(
      '/pb.StatisticsService/GetSpendingAnalytics',
      ($17.GetSpendingAnalyticsRequest value) => value.writeToBuffer(),
      ($core.List<$core.int> value) =>
          $17.GetSpendingAnalyticsResponse.fromBuffer(value));
  static final _$getCategoryBreakdown = $grpc.ClientMethod<
          $17.GetCategoryBreakdownRequest, $17.GetCategoryBreakdownResponse>(
      '/pb.StatisticsService/GetCategoryBreakdown',
      ($17.GetCategoryBreakdownRequest value) => value.writeToBuffer(),
      ($core.List<$core.int> value) =>
          $17.GetCategoryBreakdownResponse.fromBuffer(value));
  static final _$getBudgetProgress = $grpc.ClientMethod<
          $17.GetBudgetProgressRequest, $17.GetBudgetProgressResponse>(
      '/pb.StatisticsService/GetBudgetProgress',
      ($17.GetBudgetProgressRequest value) => value.writeToBuffer(),
      ($core.List<$core.int> value) =>
          $17.GetBudgetProgressResponse.fromBuffer(value));
  static final _$getSpendingTrends = $grpc.ClientMethod<
          $17.GetSpendingTrendsRequest, $17.GetSpendingTrendsResponse>(
      '/pb.StatisticsService/GetSpendingTrends',
      ($17.GetSpendingTrendsRequest value) => value.writeToBuffer(),
      ($core.List<$core.int> value) =>
          $17.GetSpendingTrendsResponse.fromBuffer(value));
  static final _$getBudgetAlerts = $grpc.ClientMethod<
          $17.GetBudgetAlertsRequest, $17.GetBudgetAlertsResponse>(
      '/pb.StatisticsService/GetBudgetAlerts',
      ($17.GetBudgetAlertsRequest value) => value.writeToBuffer(),
      ($core.List<$core.int> value) =>
          $17.GetBudgetAlertsResponse.fromBuffer(value));
  static final _$markAlertAsRead = $grpc.ClientMethod<
          $17.MarkAlertAsReadRequest, $17.MarkAlertAsReadResponse>(
      '/pb.StatisticsService/MarkAlertAsRead',
      ($17.MarkAlertAsReadRequest value) => value.writeToBuffer(),
      ($core.List<$core.int> value) =>
          $17.MarkAlertAsReadResponse.fromBuffer(value));
  static final _$getAISpendingInsights = $grpc.ClientMethod<
          $17.GetAISpendingInsightsRequest, $17.GetAISpendingInsightsResponse>(
      '/pb.StatisticsService/GetAISpendingInsights',
      ($17.GetAISpendingInsightsRequest value) => value.writeToBuffer(),
      ($core.List<$core.int> value) =>
          $17.GetAISpendingInsightsResponse.fromBuffer(value));
  static final _$getAIBudgetingRecommendations = $grpc.ClientMethod<
          $17.GetAIBudgetingRecommendationsRequest,
          $17.GetAIBudgetingRecommendationsResponse>(
      '/pb.StatisticsService/GetAIBudgetingRecommendations',
      ($17.GetAIBudgetingRecommendationsRequest value) => value.writeToBuffer(),
      ($core.List<$core.int> value) =>
          $17.GetAIBudgetingRecommendationsResponse.fromBuffer(value));
  static final _$autoCategorizeExpense = $grpc.ClientMethod<
          $17.AutoCategorizeExpenseRequest, $17.AutoCategorizeExpenseResponse>(
      '/pb.StatisticsService/AutoCategorizeExpense',
      ($17.AutoCategorizeExpenseRequest value) => value.writeToBuffer(),
      ($core.List<$core.int> value) =>
          $17.AutoCategorizeExpenseResponse.fromBuffer(value));
  static final _$getAIFinancialAdvice = $grpc.ClientMethod<
          $17.GetAIFinancialAdviceRequest, $17.GetAIFinancialAdviceResponse>(
      '/pb.StatisticsService/GetAIFinancialAdvice',
      ($17.GetAIFinancialAdviceRequest value) => value.writeToBuffer(),
      ($core.List<$core.int> value) =>
          $17.GetAIFinancialAdviceResponse.fromBuffer(value));
  static final _$getIncomeSources = $grpc.ClientMethod<
          $17.GetIncomeSourcesRequest, $17.GetIncomeSourcesResponse>(
      '/pb.StatisticsService/GetIncomeSources',
      ($17.GetIncomeSourcesRequest value) => value.writeToBuffer(),
      ($core.List<$core.int> value) =>
          $17.GetIncomeSourcesResponse.fromBuffer(value));
  static final _$getIncomeBreakdown = $grpc.ClientMethod<
          $17.GetIncomeBreakdownRequest, $17.GetIncomeBreakdownResponse>(
      '/pb.StatisticsService/GetIncomeBreakdown',
      ($17.GetIncomeBreakdownRequest value) => value.writeToBuffer(),
      ($core.List<$core.int> value) =>
          $17.GetIncomeBreakdownResponse.fromBuffer(value));
  static final _$createIncomeSource = $grpc.ClientMethod<
          $17.CreateIncomeSourceRequest, $17.CreateIncomeSourceResponse>(
      '/pb.StatisticsService/CreateIncomeSource',
      ($17.CreateIncomeSourceRequest value) => value.writeToBuffer(),
      ($core.List<$core.int> value) =>
          $17.CreateIncomeSourceResponse.fromBuffer(value));
  static final _$getInvestmentPortfolio = $grpc.ClientMethod<
          $17.GetInvestmentPortfolioRequest,
          $17.GetInvestmentPortfolioResponse>(
      '/pb.StatisticsService/GetInvestmentPortfolio',
      ($17.GetInvestmentPortfolioRequest value) => value.writeToBuffer(),
      ($core.List<$core.int> value) =>
          $17.GetInvestmentPortfolioResponse.fromBuffer(value));
  static final _$createInvestment = $grpc.ClientMethod<
          $17.CreateInvestmentRequest, $17.CreateInvestmentResponse>(
      '/pb.StatisticsService/CreateInvestment',
      ($17.CreateInvestmentRequest value) => value.writeToBuffer(),
      ($core.List<$core.int> value) =>
          $17.CreateInvestmentResponse.fromBuffer(value));
  static final _$getFinancialGoals = $grpc.ClientMethod<
          $17.GetFinancialGoalsRequest, $17.GetFinancialGoalsResponse>(
      '/pb.StatisticsService/GetFinancialGoals',
      ($17.GetFinancialGoalsRequest value) => value.writeToBuffer(),
      ($core.List<$core.int> value) =>
          $17.GetFinancialGoalsResponse.fromBuffer(value));
  static final _$createFinancialGoal = $grpc.ClientMethod<
          $17.CreateFinancialGoalRequest, $17.CreateFinancialGoalResponse>(
      '/pb.StatisticsService/CreateFinancialGoal',
      ($17.CreateFinancialGoalRequest value) => value.writeToBuffer(),
      ($core.List<$core.int> value) =>
          $17.CreateFinancialGoalResponse.fromBuffer(value));
  static final _$updateFinancialGoalProgress = $grpc.ClientMethod<
          $17.UpdateFinancialGoalProgressRequest,
          $17.UpdateFinancialGoalProgressResponse>(
      '/pb.StatisticsService/UpdateFinancialGoalProgress',
      ($17.UpdateFinancialGoalProgressRequest value) => value.writeToBuffer(),
      ($core.List<$core.int> value) =>
          $17.UpdateFinancialGoalProgressResponse.fromBuffer(value));
  static final _$getSavingsGoal =
      $grpc.ClientMethod<$17.GetSavingsGoalRequest, $17.GetSavingsGoalResponse>(
          '/pb.StatisticsService/GetSavingsGoal',
          ($17.GetSavingsGoalRequest value) => value.writeToBuffer(),
          ($core.List<$core.int> value) =>
              $17.GetSavingsGoalResponse.fromBuffer(value));
  static final _$createOrUpdateSavingsGoal = $grpc.ClientMethod<
          $17.CreateOrUpdateSavingsGoalRequest,
          $17.CreateOrUpdateSavingsGoalResponse>(
      '/pb.StatisticsService/CreateOrUpdateSavingsGoal',
      ($17.CreateOrUpdateSavingsGoalRequest value) => value.writeToBuffer(),
      ($core.List<$core.int> value) =>
          $17.CreateOrUpdateSavingsGoalResponse.fromBuffer(value));
  static final _$getUpcomingBills = $grpc.ClientMethod<
          $17.GetUpcomingBillsRequest, $17.GetUpcomingBillsResponse>(
      '/pb.StatisticsService/GetUpcomingBills',
      ($17.GetUpcomingBillsRequest value) => value.writeToBuffer(),
      ($core.List<$core.int> value) =>
          $17.GetUpcomingBillsResponse.fromBuffer(value));
  static final _$createRecurringBill = $grpc.ClientMethod<
          $17.CreateRecurringBillRequest, $17.CreateRecurringBillResponse>(
      '/pb.StatisticsService/CreateRecurringBill',
      ($17.CreateRecurringBillRequest value) => value.writeToBuffer(),
      ($core.List<$core.int> value) =>
          $17.CreateRecurringBillResponse.fromBuffer(value));

  StatisticsServiceClient($grpc.ClientChannel channel,
      {$grpc.CallOptions? options,
      $core.Iterable<$grpc.ClientInterceptor>? interceptors})
      : super(channel, options: options, interceptors: interceptors);

  $grpc.ResponseFuture<$17.CreateExpenseResponse> createExpense(
      $17.CreateExpenseRequest request,
      {$grpc.CallOptions? options}) {
    return $createUnaryCall(_$createExpense, request, options: options);
  }

  $grpc.ResponseFuture<$17.GetExpensesResponse> getExpenses(
      $17.GetExpensesRequest request,
      {$grpc.CallOptions? options}) {
    return $createUnaryCall(_$getExpenses, request, options: options);
  }

  $grpc.ResponseFuture<$17.GetExpenseByIdResponse> getExpenseById(
      $17.GetExpenseByIdRequest request,
      {$grpc.CallOptions? options}) {
    return $createUnaryCall(_$getExpenseById, request, options: options);
  }

  $grpc.ResponseFuture<$17.UpdateExpenseResponse> updateExpense(
      $17.UpdateExpenseRequest request,
      {$grpc.CallOptions? options}) {
    return $createUnaryCall(_$updateExpense, request, options: options);
  }

  $grpc.ResponseFuture<$17.DeleteExpenseResponse> deleteExpense(
      $17.DeleteExpenseRequest request,
      {$grpc.CallOptions? options}) {
    return $createUnaryCall(_$deleteExpense, request, options: options);
  }

  $grpc.ResponseFuture<$17.CreateBudgetResponse> createBudget(
      $17.CreateBudgetRequest request,
      {$grpc.CallOptions? options}) {
    return $createUnaryCall(_$createBudget, request, options: options);
  }

  $grpc.ResponseFuture<$17.GetBudgetsResponse> getBudgets(
      $17.GetBudgetsRequest request,
      {$grpc.CallOptions? options}) {
    return $createUnaryCall(_$getBudgets, request, options: options);
  }

  $grpc.ResponseFuture<$17.GetBudgetByIdResponse> getBudgetById(
      $17.GetBudgetByIdRequest request,
      {$grpc.CallOptions? options}) {
    return $createUnaryCall(_$getBudgetById, request, options: options);
  }

  $grpc.ResponseFuture<$17.UpdateBudgetResponse> updateBudget(
      $17.UpdateBudgetRequest request,
      {$grpc.CallOptions? options}) {
    return $createUnaryCall(_$updateBudget, request, options: options);
  }

  $grpc.ResponseFuture<$17.DeleteBudgetResponse> deleteBudget(
      $17.DeleteBudgetRequest request,
      {$grpc.CallOptions? options}) {
    return $createUnaryCall(_$deleteBudget, request, options: options);
  }

  $grpc.ResponseFuture<$17.GetSpendingAnalyticsResponse> getSpendingAnalytics(
      $17.GetSpendingAnalyticsRequest request,
      {$grpc.CallOptions? options}) {
    return $createUnaryCall(_$getSpendingAnalytics, request, options: options);
  }

  $grpc.ResponseFuture<$17.GetCategoryBreakdownResponse> getCategoryBreakdown(
      $17.GetCategoryBreakdownRequest request,
      {$grpc.CallOptions? options}) {
    return $createUnaryCall(_$getCategoryBreakdown, request, options: options);
  }

  $grpc.ResponseFuture<$17.GetBudgetProgressResponse> getBudgetProgress(
      $17.GetBudgetProgressRequest request,
      {$grpc.CallOptions? options}) {
    return $createUnaryCall(_$getBudgetProgress, request, options: options);
  }

  $grpc.ResponseFuture<$17.GetSpendingTrendsResponse> getSpendingTrends(
      $17.GetSpendingTrendsRequest request,
      {$grpc.CallOptions? options}) {
    return $createUnaryCall(_$getSpendingTrends, request, options: options);
  }

  $grpc.ResponseFuture<$17.GetBudgetAlertsResponse> getBudgetAlerts(
      $17.GetBudgetAlertsRequest request,
      {$grpc.CallOptions? options}) {
    return $createUnaryCall(_$getBudgetAlerts, request, options: options);
  }

  $grpc.ResponseFuture<$17.MarkAlertAsReadResponse> markAlertAsRead(
      $17.MarkAlertAsReadRequest request,
      {$grpc.CallOptions? options}) {
    return $createUnaryCall(_$markAlertAsRead, request, options: options);
  }

  $grpc.ResponseFuture<$17.GetAISpendingInsightsResponse> getAISpendingInsights(
      $17.GetAISpendingInsightsRequest request,
      {$grpc.CallOptions? options}) {
    return $createUnaryCall(_$getAISpendingInsights, request, options: options);
  }

  $grpc.ResponseFuture<$17.GetAIBudgetingRecommendationsResponse>
      getAIBudgetingRecommendations(
          $17.GetAIBudgetingRecommendationsRequest request,
          {$grpc.CallOptions? options}) {
    return $createUnaryCall(_$getAIBudgetingRecommendations, request,
        options: options);
  }

  $grpc.ResponseFuture<$17.AutoCategorizeExpenseResponse> autoCategorizeExpense(
      $17.AutoCategorizeExpenseRequest request,
      {$grpc.CallOptions? options}) {
    return $createUnaryCall(_$autoCategorizeExpense, request, options: options);
  }

  $grpc.ResponseFuture<$17.GetAIFinancialAdviceResponse> getAIFinancialAdvice(
      $17.GetAIFinancialAdviceRequest request,
      {$grpc.CallOptions? options}) {
    return $createUnaryCall(_$getAIFinancialAdvice, request, options: options);
  }

  $grpc.ResponseFuture<$17.GetIncomeSourcesResponse> getIncomeSources(
      $17.GetIncomeSourcesRequest request,
      {$grpc.CallOptions? options}) {
    return $createUnaryCall(_$getIncomeSources, request, options: options);
  }

  $grpc.ResponseFuture<$17.GetIncomeBreakdownResponse> getIncomeBreakdown(
      $17.GetIncomeBreakdownRequest request,
      {$grpc.CallOptions? options}) {
    return $createUnaryCall(_$getIncomeBreakdown, request, options: options);
  }

  $grpc.ResponseFuture<$17.CreateIncomeSourceResponse> createIncomeSource(
      $17.CreateIncomeSourceRequest request,
      {$grpc.CallOptions? options}) {
    return $createUnaryCall(_$createIncomeSource, request, options: options);
  }

  $grpc.ResponseFuture<$17.GetInvestmentPortfolioResponse>
      getInvestmentPortfolio($17.GetInvestmentPortfolioRequest request,
          {$grpc.CallOptions? options}) {
    return $createUnaryCall(_$getInvestmentPortfolio, request,
        options: options);
  }

  $grpc.ResponseFuture<$17.CreateInvestmentResponse> createInvestment(
      $17.CreateInvestmentRequest request,
      {$grpc.CallOptions? options}) {
    return $createUnaryCall(_$createInvestment, request, options: options);
  }

  $grpc.ResponseFuture<$17.GetFinancialGoalsResponse> getFinancialGoals(
      $17.GetFinancialGoalsRequest request,
      {$grpc.CallOptions? options}) {
    return $createUnaryCall(_$getFinancialGoals, request, options: options);
  }

  $grpc.ResponseFuture<$17.CreateFinancialGoalResponse> createFinancialGoal(
      $17.CreateFinancialGoalRequest request,
      {$grpc.CallOptions? options}) {
    return $createUnaryCall(_$createFinancialGoal, request, options: options);
  }

  $grpc.ResponseFuture<$17.UpdateFinancialGoalProgressResponse>
      updateFinancialGoalProgress(
          $17.UpdateFinancialGoalProgressRequest request,
          {$grpc.CallOptions? options}) {
    return $createUnaryCall(_$updateFinancialGoalProgress, request,
        options: options);
  }

  $grpc.ResponseFuture<$17.GetSavingsGoalResponse> getSavingsGoal(
      $17.GetSavingsGoalRequest request,
      {$grpc.CallOptions? options}) {
    return $createUnaryCall(_$getSavingsGoal, request, options: options);
  }

  $grpc.ResponseFuture<$17.CreateOrUpdateSavingsGoalResponse>
      createOrUpdateSavingsGoal($17.CreateOrUpdateSavingsGoalRequest request,
          {$grpc.CallOptions? options}) {
    return $createUnaryCall(_$createOrUpdateSavingsGoal, request,
        options: options);
  }

  $grpc.ResponseFuture<$17.GetUpcomingBillsResponse> getUpcomingBills(
      $17.GetUpcomingBillsRequest request,
      {$grpc.CallOptions? options}) {
    return $createUnaryCall(_$getUpcomingBills, request, options: options);
  }

  $grpc.ResponseFuture<$17.CreateRecurringBillResponse> createRecurringBill(
      $17.CreateRecurringBillRequest request,
      {$grpc.CallOptions? options}) {
    return $createUnaryCall(_$createRecurringBill, request, options: options);
  }
}

abstract class StatisticsServiceBase extends $grpc.Service {
  $core.String get $name => 'pb.StatisticsService';

  StatisticsServiceBase() {
    $addMethod($grpc.ServiceMethod<$17.CreateExpenseRequest,
            $17.CreateExpenseResponse>(
        'CreateExpense',
        createExpense_Pre,
        false,
        false,
        ($core.List<$core.int> value) =>
            $17.CreateExpenseRequest.fromBuffer(value),
        ($17.CreateExpenseResponse value) => value.writeToBuffer()));
    $addMethod(
        $grpc.ServiceMethod<$17.GetExpensesRequest, $17.GetExpensesResponse>(
            'GetExpenses',
            getExpenses_Pre,
            false,
            false,
            ($core.List<$core.int> value) =>
                $17.GetExpensesRequest.fromBuffer(value),
            ($17.GetExpensesResponse value) => value.writeToBuffer()));
    $addMethod($grpc.ServiceMethod<$17.GetExpenseByIdRequest,
            $17.GetExpenseByIdResponse>(
        'GetExpenseById',
        getExpenseById_Pre,
        false,
        false,
        ($core.List<$core.int> value) =>
            $17.GetExpenseByIdRequest.fromBuffer(value),
        ($17.GetExpenseByIdResponse value) => value.writeToBuffer()));
    $addMethod($grpc.ServiceMethod<$17.UpdateExpenseRequest,
            $17.UpdateExpenseResponse>(
        'UpdateExpense',
        updateExpense_Pre,
        false,
        false,
        ($core.List<$core.int> value) =>
            $17.UpdateExpenseRequest.fromBuffer(value),
        ($17.UpdateExpenseResponse value) => value.writeToBuffer()));
    $addMethod($grpc.ServiceMethod<$17.DeleteExpenseRequest,
            $17.DeleteExpenseResponse>(
        'DeleteExpense',
        deleteExpense_Pre,
        false,
        false,
        ($core.List<$core.int> value) =>
            $17.DeleteExpenseRequest.fromBuffer(value),
        ($17.DeleteExpenseResponse value) => value.writeToBuffer()));
    $addMethod(
        $grpc.ServiceMethod<$17.CreateBudgetRequest, $17.CreateBudgetResponse>(
            'CreateBudget',
            createBudget_Pre,
            false,
            false,
            ($core.List<$core.int> value) =>
                $17.CreateBudgetRequest.fromBuffer(value),
            ($17.CreateBudgetResponse value) => value.writeToBuffer()));
    $addMethod(
        $grpc.ServiceMethod<$17.GetBudgetsRequest, $17.GetBudgetsResponse>(
            'GetBudgets',
            getBudgets_Pre,
            false,
            false,
            ($core.List<$core.int> value) =>
                $17.GetBudgetsRequest.fromBuffer(value),
            ($17.GetBudgetsResponse value) => value.writeToBuffer()));
    $addMethod($grpc.ServiceMethod<$17.GetBudgetByIdRequest,
            $17.GetBudgetByIdResponse>(
        'GetBudgetById',
        getBudgetById_Pre,
        false,
        false,
        ($core.List<$core.int> value) =>
            $17.GetBudgetByIdRequest.fromBuffer(value),
        ($17.GetBudgetByIdResponse value) => value.writeToBuffer()));
    $addMethod(
        $grpc.ServiceMethod<$17.UpdateBudgetRequest, $17.UpdateBudgetResponse>(
            'UpdateBudget',
            updateBudget_Pre,
            false,
            false,
            ($core.List<$core.int> value) =>
                $17.UpdateBudgetRequest.fromBuffer(value),
            ($17.UpdateBudgetResponse value) => value.writeToBuffer()));
    $addMethod(
        $grpc.ServiceMethod<$17.DeleteBudgetRequest, $17.DeleteBudgetResponse>(
            'DeleteBudget',
            deleteBudget_Pre,
            false,
            false,
            ($core.List<$core.int> value) =>
                $17.DeleteBudgetRequest.fromBuffer(value),
            ($17.DeleteBudgetResponse value) => value.writeToBuffer()));
    $addMethod($grpc.ServiceMethod<$17.GetSpendingAnalyticsRequest,
            $17.GetSpendingAnalyticsResponse>(
        'GetSpendingAnalytics',
        getSpendingAnalytics_Pre,
        false,
        false,
        ($core.List<$core.int> value) =>
            $17.GetSpendingAnalyticsRequest.fromBuffer(value),
        ($17.GetSpendingAnalyticsResponse value) => value.writeToBuffer()));
    $addMethod($grpc.ServiceMethod<$17.GetCategoryBreakdownRequest,
            $17.GetCategoryBreakdownResponse>(
        'GetCategoryBreakdown',
        getCategoryBreakdown_Pre,
        false,
        false,
        ($core.List<$core.int> value) =>
            $17.GetCategoryBreakdownRequest.fromBuffer(value),
        ($17.GetCategoryBreakdownResponse value) => value.writeToBuffer()));
    $addMethod($grpc.ServiceMethod<$17.GetBudgetProgressRequest,
            $17.GetBudgetProgressResponse>(
        'GetBudgetProgress',
        getBudgetProgress_Pre,
        false,
        false,
        ($core.List<$core.int> value) =>
            $17.GetBudgetProgressRequest.fromBuffer(value),
        ($17.GetBudgetProgressResponse value) => value.writeToBuffer()));
    $addMethod($grpc.ServiceMethod<$17.GetSpendingTrendsRequest,
            $17.GetSpendingTrendsResponse>(
        'GetSpendingTrends',
        getSpendingTrends_Pre,
        false,
        false,
        ($core.List<$core.int> value) =>
            $17.GetSpendingTrendsRequest.fromBuffer(value),
        ($17.GetSpendingTrendsResponse value) => value.writeToBuffer()));
    $addMethod($grpc.ServiceMethod<$17.GetBudgetAlertsRequest,
            $17.GetBudgetAlertsResponse>(
        'GetBudgetAlerts',
        getBudgetAlerts_Pre,
        false,
        false,
        ($core.List<$core.int> value) =>
            $17.GetBudgetAlertsRequest.fromBuffer(value),
        ($17.GetBudgetAlertsResponse value) => value.writeToBuffer()));
    $addMethod($grpc.ServiceMethod<$17.MarkAlertAsReadRequest,
            $17.MarkAlertAsReadResponse>(
        'MarkAlertAsRead',
        markAlertAsRead_Pre,
        false,
        false,
        ($core.List<$core.int> value) =>
            $17.MarkAlertAsReadRequest.fromBuffer(value),
        ($17.MarkAlertAsReadResponse value) => value.writeToBuffer()));
    $addMethod($grpc.ServiceMethod<$17.GetAISpendingInsightsRequest,
            $17.GetAISpendingInsightsResponse>(
        'GetAISpendingInsights',
        getAISpendingInsights_Pre,
        false,
        false,
        ($core.List<$core.int> value) =>
            $17.GetAISpendingInsightsRequest.fromBuffer(value),
        ($17.GetAISpendingInsightsResponse value) => value.writeToBuffer()));
    $addMethod($grpc.ServiceMethod<$17.GetAIBudgetingRecommendationsRequest,
            $17.GetAIBudgetingRecommendationsResponse>(
        'GetAIBudgetingRecommendations',
        getAIBudgetingRecommendations_Pre,
        false,
        false,
        ($core.List<$core.int> value) =>
            $17.GetAIBudgetingRecommendationsRequest.fromBuffer(value),
        ($17.GetAIBudgetingRecommendationsResponse value) =>
            value.writeToBuffer()));
    $addMethod($grpc.ServiceMethod<$17.AutoCategorizeExpenseRequest,
            $17.AutoCategorizeExpenseResponse>(
        'AutoCategorizeExpense',
        autoCategorizeExpense_Pre,
        false,
        false,
        ($core.List<$core.int> value) =>
            $17.AutoCategorizeExpenseRequest.fromBuffer(value),
        ($17.AutoCategorizeExpenseResponse value) => value.writeToBuffer()));
    $addMethod($grpc.ServiceMethod<$17.GetAIFinancialAdviceRequest,
            $17.GetAIFinancialAdviceResponse>(
        'GetAIFinancialAdvice',
        getAIFinancialAdvice_Pre,
        false,
        false,
        ($core.List<$core.int> value) =>
            $17.GetAIFinancialAdviceRequest.fromBuffer(value),
        ($17.GetAIFinancialAdviceResponse value) => value.writeToBuffer()));
    $addMethod($grpc.ServiceMethod<$17.GetIncomeSourcesRequest,
            $17.GetIncomeSourcesResponse>(
        'GetIncomeSources',
        getIncomeSources_Pre,
        false,
        false,
        ($core.List<$core.int> value) =>
            $17.GetIncomeSourcesRequest.fromBuffer(value),
        ($17.GetIncomeSourcesResponse value) => value.writeToBuffer()));
    $addMethod($grpc.ServiceMethod<$17.GetIncomeBreakdownRequest,
            $17.GetIncomeBreakdownResponse>(
        'GetIncomeBreakdown',
        getIncomeBreakdown_Pre,
        false,
        false,
        ($core.List<$core.int> value) =>
            $17.GetIncomeBreakdownRequest.fromBuffer(value),
        ($17.GetIncomeBreakdownResponse value) => value.writeToBuffer()));
    $addMethod($grpc.ServiceMethod<$17.CreateIncomeSourceRequest,
            $17.CreateIncomeSourceResponse>(
        'CreateIncomeSource',
        createIncomeSource_Pre,
        false,
        false,
        ($core.List<$core.int> value) =>
            $17.CreateIncomeSourceRequest.fromBuffer(value),
        ($17.CreateIncomeSourceResponse value) => value.writeToBuffer()));
    $addMethod($grpc.ServiceMethod<$17.GetInvestmentPortfolioRequest,
            $17.GetInvestmentPortfolioResponse>(
        'GetInvestmentPortfolio',
        getInvestmentPortfolio_Pre,
        false,
        false,
        ($core.List<$core.int> value) =>
            $17.GetInvestmentPortfolioRequest.fromBuffer(value),
        ($17.GetInvestmentPortfolioResponse value) => value.writeToBuffer()));
    $addMethod($grpc.ServiceMethod<$17.CreateInvestmentRequest,
            $17.CreateInvestmentResponse>(
        'CreateInvestment',
        createInvestment_Pre,
        false,
        false,
        ($core.List<$core.int> value) =>
            $17.CreateInvestmentRequest.fromBuffer(value),
        ($17.CreateInvestmentResponse value) => value.writeToBuffer()));
    $addMethod($grpc.ServiceMethod<$17.GetFinancialGoalsRequest,
            $17.GetFinancialGoalsResponse>(
        'GetFinancialGoals',
        getFinancialGoals_Pre,
        false,
        false,
        ($core.List<$core.int> value) =>
            $17.GetFinancialGoalsRequest.fromBuffer(value),
        ($17.GetFinancialGoalsResponse value) => value.writeToBuffer()));
    $addMethod($grpc.ServiceMethod<$17.CreateFinancialGoalRequest,
            $17.CreateFinancialGoalResponse>(
        'CreateFinancialGoal',
        createFinancialGoal_Pre,
        false,
        false,
        ($core.List<$core.int> value) =>
            $17.CreateFinancialGoalRequest.fromBuffer(value),
        ($17.CreateFinancialGoalResponse value) => value.writeToBuffer()));
    $addMethod($grpc.ServiceMethod<$17.UpdateFinancialGoalProgressRequest,
            $17.UpdateFinancialGoalProgressResponse>(
        'UpdateFinancialGoalProgress',
        updateFinancialGoalProgress_Pre,
        false,
        false,
        ($core.List<$core.int> value) =>
            $17.UpdateFinancialGoalProgressRequest.fromBuffer(value),
        ($17.UpdateFinancialGoalProgressResponse value) =>
            value.writeToBuffer()));
    $addMethod($grpc.ServiceMethod<$17.GetSavingsGoalRequest,
            $17.GetSavingsGoalResponse>(
        'GetSavingsGoal',
        getSavingsGoal_Pre,
        false,
        false,
        ($core.List<$core.int> value) =>
            $17.GetSavingsGoalRequest.fromBuffer(value),
        ($17.GetSavingsGoalResponse value) => value.writeToBuffer()));
    $addMethod($grpc.ServiceMethod<$17.CreateOrUpdateSavingsGoalRequest,
            $17.CreateOrUpdateSavingsGoalResponse>(
        'CreateOrUpdateSavingsGoal',
        createOrUpdateSavingsGoal_Pre,
        false,
        false,
        ($core.List<$core.int> value) =>
            $17.CreateOrUpdateSavingsGoalRequest.fromBuffer(value),
        ($17.CreateOrUpdateSavingsGoalResponse value) =>
            value.writeToBuffer()));
    $addMethod($grpc.ServiceMethod<$17.GetUpcomingBillsRequest,
            $17.GetUpcomingBillsResponse>(
        'GetUpcomingBills',
        getUpcomingBills_Pre,
        false,
        false,
        ($core.List<$core.int> value) =>
            $17.GetUpcomingBillsRequest.fromBuffer(value),
        ($17.GetUpcomingBillsResponse value) => value.writeToBuffer()));
    $addMethod($grpc.ServiceMethod<$17.CreateRecurringBillRequest,
            $17.CreateRecurringBillResponse>(
        'CreateRecurringBill',
        createRecurringBill_Pre,
        false,
        false,
        ($core.List<$core.int> value) =>
            $17.CreateRecurringBillRequest.fromBuffer(value),
        ($17.CreateRecurringBillResponse value) => value.writeToBuffer()));
  }

  $async.Future<$17.CreateExpenseResponse> createExpense_Pre(
      $grpc.ServiceCall call,
      $async.Future<$17.CreateExpenseRequest> request) async {
    return createExpense(call, await request);
  }

  $async.Future<$17.GetExpensesResponse> getExpenses_Pre($grpc.ServiceCall call,
      $async.Future<$17.GetExpensesRequest> request) async {
    return getExpenses(call, await request);
  }

  $async.Future<$17.GetExpenseByIdResponse> getExpenseById_Pre(
      $grpc.ServiceCall call,
      $async.Future<$17.GetExpenseByIdRequest> request) async {
    return getExpenseById(call, await request);
  }

  $async.Future<$17.UpdateExpenseResponse> updateExpense_Pre(
      $grpc.ServiceCall call,
      $async.Future<$17.UpdateExpenseRequest> request) async {
    return updateExpense(call, await request);
  }

  $async.Future<$17.DeleteExpenseResponse> deleteExpense_Pre(
      $grpc.ServiceCall call,
      $async.Future<$17.DeleteExpenseRequest> request) async {
    return deleteExpense(call, await request);
  }

  $async.Future<$17.CreateBudgetResponse> createBudget_Pre(
      $grpc.ServiceCall call,
      $async.Future<$17.CreateBudgetRequest> request) async {
    return createBudget(call, await request);
  }

  $async.Future<$17.GetBudgetsResponse> getBudgets_Pre($grpc.ServiceCall call,
      $async.Future<$17.GetBudgetsRequest> request) async {
    return getBudgets(call, await request);
  }

  $async.Future<$17.GetBudgetByIdResponse> getBudgetById_Pre(
      $grpc.ServiceCall call,
      $async.Future<$17.GetBudgetByIdRequest> request) async {
    return getBudgetById(call, await request);
  }

  $async.Future<$17.UpdateBudgetResponse> updateBudget_Pre(
      $grpc.ServiceCall call,
      $async.Future<$17.UpdateBudgetRequest> request) async {
    return updateBudget(call, await request);
  }

  $async.Future<$17.DeleteBudgetResponse> deleteBudget_Pre(
      $grpc.ServiceCall call,
      $async.Future<$17.DeleteBudgetRequest> request) async {
    return deleteBudget(call, await request);
  }

  $async.Future<$17.GetSpendingAnalyticsResponse> getSpendingAnalytics_Pre(
      $grpc.ServiceCall call,
      $async.Future<$17.GetSpendingAnalyticsRequest> request) async {
    return getSpendingAnalytics(call, await request);
  }

  $async.Future<$17.GetCategoryBreakdownResponse> getCategoryBreakdown_Pre(
      $grpc.ServiceCall call,
      $async.Future<$17.GetCategoryBreakdownRequest> request) async {
    return getCategoryBreakdown(call, await request);
  }

  $async.Future<$17.GetBudgetProgressResponse> getBudgetProgress_Pre(
      $grpc.ServiceCall call,
      $async.Future<$17.GetBudgetProgressRequest> request) async {
    return getBudgetProgress(call, await request);
  }

  $async.Future<$17.GetSpendingTrendsResponse> getSpendingTrends_Pre(
      $grpc.ServiceCall call,
      $async.Future<$17.GetSpendingTrendsRequest> request) async {
    return getSpendingTrends(call, await request);
  }

  $async.Future<$17.GetBudgetAlertsResponse> getBudgetAlerts_Pre(
      $grpc.ServiceCall call,
      $async.Future<$17.GetBudgetAlertsRequest> request) async {
    return getBudgetAlerts(call, await request);
  }

  $async.Future<$17.MarkAlertAsReadResponse> markAlertAsRead_Pre(
      $grpc.ServiceCall call,
      $async.Future<$17.MarkAlertAsReadRequest> request) async {
    return markAlertAsRead(call, await request);
  }

  $async.Future<$17.GetAISpendingInsightsResponse> getAISpendingInsights_Pre(
      $grpc.ServiceCall call,
      $async.Future<$17.GetAISpendingInsightsRequest> request) async {
    return getAISpendingInsights(call, await request);
  }

  $async.Future<$17.GetAIBudgetingRecommendationsResponse>
      getAIBudgetingRecommendations_Pre(
          $grpc.ServiceCall call,
          $async.Future<$17.GetAIBudgetingRecommendationsRequest>
              request) async {
    return getAIBudgetingRecommendations(call, await request);
  }

  $async.Future<$17.AutoCategorizeExpenseResponse> autoCategorizeExpense_Pre(
      $grpc.ServiceCall call,
      $async.Future<$17.AutoCategorizeExpenseRequest> request) async {
    return autoCategorizeExpense(call, await request);
  }

  $async.Future<$17.GetAIFinancialAdviceResponse> getAIFinancialAdvice_Pre(
      $grpc.ServiceCall call,
      $async.Future<$17.GetAIFinancialAdviceRequest> request) async {
    return getAIFinancialAdvice(call, await request);
  }

  $async.Future<$17.GetIncomeSourcesResponse> getIncomeSources_Pre(
      $grpc.ServiceCall call,
      $async.Future<$17.GetIncomeSourcesRequest> request) async {
    return getIncomeSources(call, await request);
  }

  $async.Future<$17.GetIncomeBreakdownResponse> getIncomeBreakdown_Pre(
      $grpc.ServiceCall call,
      $async.Future<$17.GetIncomeBreakdownRequest> request) async {
    return getIncomeBreakdown(call, await request);
  }

  $async.Future<$17.CreateIncomeSourceResponse> createIncomeSource_Pre(
      $grpc.ServiceCall call,
      $async.Future<$17.CreateIncomeSourceRequest> request) async {
    return createIncomeSource(call, await request);
  }

  $async.Future<$17.GetInvestmentPortfolioResponse> getInvestmentPortfolio_Pre(
      $grpc.ServiceCall call,
      $async.Future<$17.GetInvestmentPortfolioRequest> request) async {
    return getInvestmentPortfolio(call, await request);
  }

  $async.Future<$17.CreateInvestmentResponse> createInvestment_Pre(
      $grpc.ServiceCall call,
      $async.Future<$17.CreateInvestmentRequest> request) async {
    return createInvestment(call, await request);
  }

  $async.Future<$17.GetFinancialGoalsResponse> getFinancialGoals_Pre(
      $grpc.ServiceCall call,
      $async.Future<$17.GetFinancialGoalsRequest> request) async {
    return getFinancialGoals(call, await request);
  }

  $async.Future<$17.CreateFinancialGoalResponse> createFinancialGoal_Pre(
      $grpc.ServiceCall call,
      $async.Future<$17.CreateFinancialGoalRequest> request) async {
    return createFinancialGoal(call, await request);
  }

  $async.Future<$17.UpdateFinancialGoalProgressResponse>
      updateFinancialGoalProgress_Pre($grpc.ServiceCall call,
          $async.Future<$17.UpdateFinancialGoalProgressRequest> request) async {
    return updateFinancialGoalProgress(call, await request);
  }

  $async.Future<$17.GetSavingsGoalResponse> getSavingsGoal_Pre(
      $grpc.ServiceCall call,
      $async.Future<$17.GetSavingsGoalRequest> request) async {
    return getSavingsGoal(call, await request);
  }

  $async.Future<$17.CreateOrUpdateSavingsGoalResponse>
      createOrUpdateSavingsGoal_Pre($grpc.ServiceCall call,
          $async.Future<$17.CreateOrUpdateSavingsGoalRequest> request) async {
    return createOrUpdateSavingsGoal(call, await request);
  }

  $async.Future<$17.GetUpcomingBillsResponse> getUpcomingBills_Pre(
      $grpc.ServiceCall call,
      $async.Future<$17.GetUpcomingBillsRequest> request) async {
    return getUpcomingBills(call, await request);
  }

  $async.Future<$17.CreateRecurringBillResponse> createRecurringBill_Pre(
      $grpc.ServiceCall call,
      $async.Future<$17.CreateRecurringBillRequest> request) async {
    return createRecurringBill(call, await request);
  }

  $async.Future<$17.CreateExpenseResponse> createExpense(
      $grpc.ServiceCall call, $17.CreateExpenseRequest request);
  $async.Future<$17.GetExpensesResponse> getExpenses(
      $grpc.ServiceCall call, $17.GetExpensesRequest request);
  $async.Future<$17.GetExpenseByIdResponse> getExpenseById(
      $grpc.ServiceCall call, $17.GetExpenseByIdRequest request);
  $async.Future<$17.UpdateExpenseResponse> updateExpense(
      $grpc.ServiceCall call, $17.UpdateExpenseRequest request);
  $async.Future<$17.DeleteExpenseResponse> deleteExpense(
      $grpc.ServiceCall call, $17.DeleteExpenseRequest request);
  $async.Future<$17.CreateBudgetResponse> createBudget(
      $grpc.ServiceCall call, $17.CreateBudgetRequest request);
  $async.Future<$17.GetBudgetsResponse> getBudgets(
      $grpc.ServiceCall call, $17.GetBudgetsRequest request);
  $async.Future<$17.GetBudgetByIdResponse> getBudgetById(
      $grpc.ServiceCall call, $17.GetBudgetByIdRequest request);
  $async.Future<$17.UpdateBudgetResponse> updateBudget(
      $grpc.ServiceCall call, $17.UpdateBudgetRequest request);
  $async.Future<$17.DeleteBudgetResponse> deleteBudget(
      $grpc.ServiceCall call, $17.DeleteBudgetRequest request);
  $async.Future<$17.GetSpendingAnalyticsResponse> getSpendingAnalytics(
      $grpc.ServiceCall call, $17.GetSpendingAnalyticsRequest request);
  $async.Future<$17.GetCategoryBreakdownResponse> getCategoryBreakdown(
      $grpc.ServiceCall call, $17.GetCategoryBreakdownRequest request);
  $async.Future<$17.GetBudgetProgressResponse> getBudgetProgress(
      $grpc.ServiceCall call, $17.GetBudgetProgressRequest request);
  $async.Future<$17.GetSpendingTrendsResponse> getSpendingTrends(
      $grpc.ServiceCall call, $17.GetSpendingTrendsRequest request);
  $async.Future<$17.GetBudgetAlertsResponse> getBudgetAlerts(
      $grpc.ServiceCall call, $17.GetBudgetAlertsRequest request);
  $async.Future<$17.MarkAlertAsReadResponse> markAlertAsRead(
      $grpc.ServiceCall call, $17.MarkAlertAsReadRequest request);
  $async.Future<$17.GetAISpendingInsightsResponse> getAISpendingInsights(
      $grpc.ServiceCall call, $17.GetAISpendingInsightsRequest request);
  $async.Future<$17.GetAIBudgetingRecommendationsResponse>
      getAIBudgetingRecommendations($grpc.ServiceCall call,
          $17.GetAIBudgetingRecommendationsRequest request);
  $async.Future<$17.AutoCategorizeExpenseResponse> autoCategorizeExpense(
      $grpc.ServiceCall call, $17.AutoCategorizeExpenseRequest request);
  $async.Future<$17.GetAIFinancialAdviceResponse> getAIFinancialAdvice(
      $grpc.ServiceCall call, $17.GetAIFinancialAdviceRequest request);
  $async.Future<$17.GetIncomeSourcesResponse> getIncomeSources(
      $grpc.ServiceCall call, $17.GetIncomeSourcesRequest request);
  $async.Future<$17.GetIncomeBreakdownResponse> getIncomeBreakdown(
      $grpc.ServiceCall call, $17.GetIncomeBreakdownRequest request);
  $async.Future<$17.CreateIncomeSourceResponse> createIncomeSource(
      $grpc.ServiceCall call, $17.CreateIncomeSourceRequest request);
  $async.Future<$17.GetInvestmentPortfolioResponse> getInvestmentPortfolio(
      $grpc.ServiceCall call, $17.GetInvestmentPortfolioRequest request);
  $async.Future<$17.CreateInvestmentResponse> createInvestment(
      $grpc.ServiceCall call, $17.CreateInvestmentRequest request);
  $async.Future<$17.GetFinancialGoalsResponse> getFinancialGoals(
      $grpc.ServiceCall call, $17.GetFinancialGoalsRequest request);
  $async.Future<$17.CreateFinancialGoalResponse> createFinancialGoal(
      $grpc.ServiceCall call, $17.CreateFinancialGoalRequest request);
  $async.Future<$17.UpdateFinancialGoalProgressResponse>
      updateFinancialGoalProgress($grpc.ServiceCall call,
          $17.UpdateFinancialGoalProgressRequest request);
  $async.Future<$17.GetSavingsGoalResponse> getSavingsGoal(
      $grpc.ServiceCall call, $17.GetSavingsGoalRequest request);
  $async.Future<$17.CreateOrUpdateSavingsGoalResponse>
      createOrUpdateSavingsGoal(
          $grpc.ServiceCall call, $17.CreateOrUpdateSavingsGoalRequest request);
  $async.Future<$17.GetUpcomingBillsResponse> getUpcomingBills(
      $grpc.ServiceCall call, $17.GetUpcomingBillsRequest request);
  $async.Future<$17.CreateRecurringBillResponse> createRecurringBill(
      $grpc.ServiceCall call, $17.CreateRecurringBillRequest request);
}
