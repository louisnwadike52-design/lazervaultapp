///
//  Generated code. Do not modify.
//  source: statistics.proto
//
// @dart = 2.12
// ignore_for_file: annotate_overrides,camel_case_types,constant_identifier_names,directives_ordering,library_prefixes,non_constant_identifier_names,prefer_final_fields,return_of_invalid_type,unnecessary_const,unnecessary_import,unnecessary_this,unused_import,unused_shown_name

import 'dart:async' as $async;

import 'dart:core' as $core;

import 'package:grpc/service_api.dart' as $grpc;
import 'statistics.pb.dart' as $19;
export 'statistics.pb.dart';

class StatisticsServiceClient extends $grpc.Client {
  static final _$createExpense =
      $grpc.ClientMethod<$19.CreateExpenseRequest, $19.CreateExpenseResponse>(
          '/pb.StatisticsService/CreateExpense',
          ($19.CreateExpenseRequest value) => value.writeToBuffer(),
          ($core.List<$core.int> value) =>
              $19.CreateExpenseResponse.fromBuffer(value));
  static final _$getExpenses =
      $grpc.ClientMethod<$19.GetExpensesRequest, $19.GetExpensesResponse>(
          '/pb.StatisticsService/GetExpenses',
          ($19.GetExpensesRequest value) => value.writeToBuffer(),
          ($core.List<$core.int> value) =>
              $19.GetExpensesResponse.fromBuffer(value));
  static final _$getExpenseById =
      $grpc.ClientMethod<$19.GetExpenseByIdRequest, $19.GetExpenseByIdResponse>(
          '/pb.StatisticsService/GetExpenseById',
          ($19.GetExpenseByIdRequest value) => value.writeToBuffer(),
          ($core.List<$core.int> value) =>
              $19.GetExpenseByIdResponse.fromBuffer(value));
  static final _$updateExpense =
      $grpc.ClientMethod<$19.UpdateExpenseRequest, $19.UpdateExpenseResponse>(
          '/pb.StatisticsService/UpdateExpense',
          ($19.UpdateExpenseRequest value) => value.writeToBuffer(),
          ($core.List<$core.int> value) =>
              $19.UpdateExpenseResponse.fromBuffer(value));
  static final _$deleteExpense =
      $grpc.ClientMethod<$19.DeleteExpenseRequest, $19.DeleteExpenseResponse>(
          '/pb.StatisticsService/DeleteExpense',
          ($19.DeleteExpenseRequest value) => value.writeToBuffer(),
          ($core.List<$core.int> value) =>
              $19.DeleteExpenseResponse.fromBuffer(value));
  static final _$createBudget =
      $grpc.ClientMethod<$19.CreateBudgetRequest, $19.CreateBudgetResponse>(
          '/pb.StatisticsService/CreateBudget',
          ($19.CreateBudgetRequest value) => value.writeToBuffer(),
          ($core.List<$core.int> value) =>
              $19.CreateBudgetResponse.fromBuffer(value));
  static final _$getBudgets =
      $grpc.ClientMethod<$19.GetBudgetsRequest, $19.GetBudgetsResponse>(
          '/pb.StatisticsService/GetBudgets',
          ($19.GetBudgetsRequest value) => value.writeToBuffer(),
          ($core.List<$core.int> value) =>
              $19.GetBudgetsResponse.fromBuffer(value));
  static final _$getBudgetById =
      $grpc.ClientMethod<$19.GetBudgetByIdRequest, $19.GetBudgetByIdResponse>(
          '/pb.StatisticsService/GetBudgetById',
          ($19.GetBudgetByIdRequest value) => value.writeToBuffer(),
          ($core.List<$core.int> value) =>
              $19.GetBudgetByIdResponse.fromBuffer(value));
  static final _$updateBudget =
      $grpc.ClientMethod<$19.UpdateBudgetRequest, $19.UpdateBudgetResponse>(
          '/pb.StatisticsService/UpdateBudget',
          ($19.UpdateBudgetRequest value) => value.writeToBuffer(),
          ($core.List<$core.int> value) =>
              $19.UpdateBudgetResponse.fromBuffer(value));
  static final _$deleteBudget =
      $grpc.ClientMethod<$19.DeleteBudgetRequest, $19.DeleteBudgetResponse>(
          '/pb.StatisticsService/DeleteBudget',
          ($19.DeleteBudgetRequest value) => value.writeToBuffer(),
          ($core.List<$core.int> value) =>
              $19.DeleteBudgetResponse.fromBuffer(value));
  static final _$getSpendingAnalytics = $grpc.ClientMethod<
          $19.GetSpendingAnalyticsRequest, $19.GetSpendingAnalyticsResponse>(
      '/pb.StatisticsService/GetSpendingAnalytics',
      ($19.GetSpendingAnalyticsRequest value) => value.writeToBuffer(),
      ($core.List<$core.int> value) =>
          $19.GetSpendingAnalyticsResponse.fromBuffer(value));
  static final _$getCategoryBreakdown = $grpc.ClientMethod<
          $19.GetCategoryBreakdownRequest, $19.GetCategoryBreakdownResponse>(
      '/pb.StatisticsService/GetCategoryBreakdown',
      ($19.GetCategoryBreakdownRequest value) => value.writeToBuffer(),
      ($core.List<$core.int> value) =>
          $19.GetCategoryBreakdownResponse.fromBuffer(value));
  static final _$getBudgetProgress = $grpc.ClientMethod<
          $19.GetBudgetProgressRequest, $19.GetBudgetProgressResponse>(
      '/pb.StatisticsService/GetBudgetProgress',
      ($19.GetBudgetProgressRequest value) => value.writeToBuffer(),
      ($core.List<$core.int> value) =>
          $19.GetBudgetProgressResponse.fromBuffer(value));
  static final _$getSpendingTrends = $grpc.ClientMethod<
          $19.GetSpendingTrendsRequest, $19.GetSpendingTrendsResponse>(
      '/pb.StatisticsService/GetSpendingTrends',
      ($19.GetSpendingTrendsRequest value) => value.writeToBuffer(),
      ($core.List<$core.int> value) =>
          $19.GetSpendingTrendsResponse.fromBuffer(value));
  static final _$getBudgetAlerts = $grpc.ClientMethod<
          $19.GetBudgetAlertsRequest, $19.GetBudgetAlertsResponse>(
      '/pb.StatisticsService/GetBudgetAlerts',
      ($19.GetBudgetAlertsRequest value) => value.writeToBuffer(),
      ($core.List<$core.int> value) =>
          $19.GetBudgetAlertsResponse.fromBuffer(value));
  static final _$markAlertAsRead = $grpc.ClientMethod<
          $19.MarkAlertAsReadRequest, $19.MarkAlertAsReadResponse>(
      '/pb.StatisticsService/MarkAlertAsRead',
      ($19.MarkAlertAsReadRequest value) => value.writeToBuffer(),
      ($core.List<$core.int> value) =>
          $19.MarkAlertAsReadResponse.fromBuffer(value));
  static final _$getAISpendingInsights = $grpc.ClientMethod<
          $19.GetAISpendingInsightsRequest, $19.GetAISpendingInsightsResponse>(
      '/pb.StatisticsService/GetAISpendingInsights',
      ($19.GetAISpendingInsightsRequest value) => value.writeToBuffer(),
      ($core.List<$core.int> value) =>
          $19.GetAISpendingInsightsResponse.fromBuffer(value));
  static final _$getAIBudgetingRecommendations = $grpc.ClientMethod<
          $19.GetAIBudgetingRecommendationsRequest,
          $19.GetAIBudgetingRecommendationsResponse>(
      '/pb.StatisticsService/GetAIBudgetingRecommendations',
      ($19.GetAIBudgetingRecommendationsRequest value) => value.writeToBuffer(),
      ($core.List<$core.int> value) =>
          $19.GetAIBudgetingRecommendationsResponse.fromBuffer(value));
  static final _$autoCategorizeExpense = $grpc.ClientMethod<
          $19.AutoCategorizeExpenseRequest, $19.AutoCategorizeExpenseResponse>(
      '/pb.StatisticsService/AutoCategorizeExpense',
      ($19.AutoCategorizeExpenseRequest value) => value.writeToBuffer(),
      ($core.List<$core.int> value) =>
          $19.AutoCategorizeExpenseResponse.fromBuffer(value));
  static final _$getAIFinancialAdvice = $grpc.ClientMethod<
          $19.GetAIFinancialAdviceRequest, $19.GetAIFinancialAdviceResponse>(
      '/pb.StatisticsService/GetAIFinancialAdvice',
      ($19.GetAIFinancialAdviceRequest value) => value.writeToBuffer(),
      ($core.List<$core.int> value) =>
          $19.GetAIFinancialAdviceResponse.fromBuffer(value));
  static final _$getIncomeSources = $grpc.ClientMethod<
          $19.GetIncomeSourcesRequest, $19.GetIncomeSourcesResponse>(
      '/pb.StatisticsService/GetIncomeSources',
      ($19.GetIncomeSourcesRequest value) => value.writeToBuffer(),
      ($core.List<$core.int> value) =>
          $19.GetIncomeSourcesResponse.fromBuffer(value));
  static final _$getIncomeBreakdown = $grpc.ClientMethod<
          $19.GetIncomeBreakdownRequest, $19.GetIncomeBreakdownResponse>(
      '/pb.StatisticsService/GetIncomeBreakdown',
      ($19.GetIncomeBreakdownRequest value) => value.writeToBuffer(),
      ($core.List<$core.int> value) =>
          $19.GetIncomeBreakdownResponse.fromBuffer(value));
  static final _$createIncomeSource = $grpc.ClientMethod<
          $19.CreateIncomeSourceRequest, $19.CreateIncomeSourceResponse>(
      '/pb.StatisticsService/CreateIncomeSource',
      ($19.CreateIncomeSourceRequest value) => value.writeToBuffer(),
      ($core.List<$core.int> value) =>
          $19.CreateIncomeSourceResponse.fromBuffer(value));
  static final _$getInvestmentPortfolio = $grpc.ClientMethod<
          $19.GetInvestmentPortfolioRequest,
          $19.GetInvestmentPortfolioResponse>(
      '/pb.StatisticsService/GetInvestmentPortfolio',
      ($19.GetInvestmentPortfolioRequest value) => value.writeToBuffer(),
      ($core.List<$core.int> value) =>
          $19.GetInvestmentPortfolioResponse.fromBuffer(value));
  static final _$createInvestment = $grpc.ClientMethod<
          $19.CreateInvestmentRequest, $19.CreateInvestmentResponse>(
      '/pb.StatisticsService/CreateInvestment',
      ($19.CreateInvestmentRequest value) => value.writeToBuffer(),
      ($core.List<$core.int> value) =>
          $19.CreateInvestmentResponse.fromBuffer(value));
  static final _$getFinancialGoals = $grpc.ClientMethod<
          $19.GetFinancialGoalsRequest, $19.GetFinancialGoalsResponse>(
      '/pb.StatisticsService/GetFinancialGoals',
      ($19.GetFinancialGoalsRequest value) => value.writeToBuffer(),
      ($core.List<$core.int> value) =>
          $19.GetFinancialGoalsResponse.fromBuffer(value));
  static final _$createFinancialGoal = $grpc.ClientMethod<
          $19.CreateFinancialGoalRequest, $19.CreateFinancialGoalResponse>(
      '/pb.StatisticsService/CreateFinancialGoal',
      ($19.CreateFinancialGoalRequest value) => value.writeToBuffer(),
      ($core.List<$core.int> value) =>
          $19.CreateFinancialGoalResponse.fromBuffer(value));
  static final _$updateFinancialGoalProgress = $grpc.ClientMethod<
          $19.UpdateFinancialGoalProgressRequest,
          $19.UpdateFinancialGoalProgressResponse>(
      '/pb.StatisticsService/UpdateFinancialGoalProgress',
      ($19.UpdateFinancialGoalProgressRequest value) => value.writeToBuffer(),
      ($core.List<$core.int> value) =>
          $19.UpdateFinancialGoalProgressResponse.fromBuffer(value));
  static final _$getSavingsGoal =
      $grpc.ClientMethod<$19.GetSavingsGoalRequest, $19.GetSavingsGoalResponse>(
          '/pb.StatisticsService/GetSavingsGoal',
          ($19.GetSavingsGoalRequest value) => value.writeToBuffer(),
          ($core.List<$core.int> value) =>
              $19.GetSavingsGoalResponse.fromBuffer(value));
  static final _$createOrUpdateSavingsGoal = $grpc.ClientMethod<
          $19.CreateOrUpdateSavingsGoalRequest,
          $19.CreateOrUpdateSavingsGoalResponse>(
      '/pb.StatisticsService/CreateOrUpdateSavingsGoal',
      ($19.CreateOrUpdateSavingsGoalRequest value) => value.writeToBuffer(),
      ($core.List<$core.int> value) =>
          $19.CreateOrUpdateSavingsGoalResponse.fromBuffer(value));
  static final _$getUpcomingBills = $grpc.ClientMethod<
          $19.GetUpcomingBillsRequest, $19.GetUpcomingBillsResponse>(
      '/pb.StatisticsService/GetUpcomingBills',
      ($19.GetUpcomingBillsRequest value) => value.writeToBuffer(),
      ($core.List<$core.int> value) =>
          $19.GetUpcomingBillsResponse.fromBuffer(value));
  static final _$createRecurringBill = $grpc.ClientMethod<
          $19.CreateRecurringBillRequest, $19.CreateRecurringBillResponse>(
      '/pb.StatisticsService/CreateRecurringBill',
      ($19.CreateRecurringBillRequest value) => value.writeToBuffer(),
      ($core.List<$core.int> value) =>
          $19.CreateRecurringBillResponse.fromBuffer(value));

  StatisticsServiceClient($grpc.ClientChannel channel,
      {$grpc.CallOptions? options,
      $core.Iterable<$grpc.ClientInterceptor>? interceptors})
      : super(channel, options: options, interceptors: interceptors);

  $grpc.ResponseFuture<$19.CreateExpenseResponse> createExpense(
      $19.CreateExpenseRequest request,
      {$grpc.CallOptions? options}) {
    return $createUnaryCall(_$createExpense, request, options: options);
  }

  $grpc.ResponseFuture<$19.GetExpensesResponse> getExpenses(
      $19.GetExpensesRequest request,
      {$grpc.CallOptions? options}) {
    return $createUnaryCall(_$getExpenses, request, options: options);
  }

  $grpc.ResponseFuture<$19.GetExpenseByIdResponse> getExpenseById(
      $19.GetExpenseByIdRequest request,
      {$grpc.CallOptions? options}) {
    return $createUnaryCall(_$getExpenseById, request, options: options);
  }

  $grpc.ResponseFuture<$19.UpdateExpenseResponse> updateExpense(
      $19.UpdateExpenseRequest request,
      {$grpc.CallOptions? options}) {
    return $createUnaryCall(_$updateExpense, request, options: options);
  }

  $grpc.ResponseFuture<$19.DeleteExpenseResponse> deleteExpense(
      $19.DeleteExpenseRequest request,
      {$grpc.CallOptions? options}) {
    return $createUnaryCall(_$deleteExpense, request, options: options);
  }

  $grpc.ResponseFuture<$19.CreateBudgetResponse> createBudget(
      $19.CreateBudgetRequest request,
      {$grpc.CallOptions? options}) {
    return $createUnaryCall(_$createBudget, request, options: options);
  }

  $grpc.ResponseFuture<$19.GetBudgetsResponse> getBudgets(
      $19.GetBudgetsRequest request,
      {$grpc.CallOptions? options}) {
    return $createUnaryCall(_$getBudgets, request, options: options);
  }

  $grpc.ResponseFuture<$19.GetBudgetByIdResponse> getBudgetById(
      $19.GetBudgetByIdRequest request,
      {$grpc.CallOptions? options}) {
    return $createUnaryCall(_$getBudgetById, request, options: options);
  }

  $grpc.ResponseFuture<$19.UpdateBudgetResponse> updateBudget(
      $19.UpdateBudgetRequest request,
      {$grpc.CallOptions? options}) {
    return $createUnaryCall(_$updateBudget, request, options: options);
  }

  $grpc.ResponseFuture<$19.DeleteBudgetResponse> deleteBudget(
      $19.DeleteBudgetRequest request,
      {$grpc.CallOptions? options}) {
    return $createUnaryCall(_$deleteBudget, request, options: options);
  }

  $grpc.ResponseFuture<$19.GetSpendingAnalyticsResponse> getSpendingAnalytics(
      $19.GetSpendingAnalyticsRequest request,
      {$grpc.CallOptions? options}) {
    return $createUnaryCall(_$getSpendingAnalytics, request, options: options);
  }

  $grpc.ResponseFuture<$19.GetCategoryBreakdownResponse> getCategoryBreakdown(
      $19.GetCategoryBreakdownRequest request,
      {$grpc.CallOptions? options}) {
    return $createUnaryCall(_$getCategoryBreakdown, request, options: options);
  }

  $grpc.ResponseFuture<$19.GetBudgetProgressResponse> getBudgetProgress(
      $19.GetBudgetProgressRequest request,
      {$grpc.CallOptions? options}) {
    return $createUnaryCall(_$getBudgetProgress, request, options: options);
  }

  $grpc.ResponseFuture<$19.GetSpendingTrendsResponse> getSpendingTrends(
      $19.GetSpendingTrendsRequest request,
      {$grpc.CallOptions? options}) {
    return $createUnaryCall(_$getSpendingTrends, request, options: options);
  }

  $grpc.ResponseFuture<$19.GetBudgetAlertsResponse> getBudgetAlerts(
      $19.GetBudgetAlertsRequest request,
      {$grpc.CallOptions? options}) {
    return $createUnaryCall(_$getBudgetAlerts, request, options: options);
  }

  $grpc.ResponseFuture<$19.MarkAlertAsReadResponse> markAlertAsRead(
      $19.MarkAlertAsReadRequest request,
      {$grpc.CallOptions? options}) {
    return $createUnaryCall(_$markAlertAsRead, request, options: options);
  }

  $grpc.ResponseFuture<$19.GetAISpendingInsightsResponse> getAISpendingInsights(
      $19.GetAISpendingInsightsRequest request,
      {$grpc.CallOptions? options}) {
    return $createUnaryCall(_$getAISpendingInsights, request, options: options);
  }

  $grpc.ResponseFuture<$19.GetAIBudgetingRecommendationsResponse>
      getAIBudgetingRecommendations(
          $19.GetAIBudgetingRecommendationsRequest request,
          {$grpc.CallOptions? options}) {
    return $createUnaryCall(_$getAIBudgetingRecommendations, request,
        options: options);
  }

  $grpc.ResponseFuture<$19.AutoCategorizeExpenseResponse> autoCategorizeExpense(
      $19.AutoCategorizeExpenseRequest request,
      {$grpc.CallOptions? options}) {
    return $createUnaryCall(_$autoCategorizeExpense, request, options: options);
  }

  $grpc.ResponseFuture<$19.GetAIFinancialAdviceResponse> getAIFinancialAdvice(
      $19.GetAIFinancialAdviceRequest request,
      {$grpc.CallOptions? options}) {
    return $createUnaryCall(_$getAIFinancialAdvice, request, options: options);
  }

  $grpc.ResponseFuture<$19.GetIncomeSourcesResponse> getIncomeSources(
      $19.GetIncomeSourcesRequest request,
      {$grpc.CallOptions? options}) {
    return $createUnaryCall(_$getIncomeSources, request, options: options);
  }

  $grpc.ResponseFuture<$19.GetIncomeBreakdownResponse> getIncomeBreakdown(
      $19.GetIncomeBreakdownRequest request,
      {$grpc.CallOptions? options}) {
    return $createUnaryCall(_$getIncomeBreakdown, request, options: options);
  }

  $grpc.ResponseFuture<$19.CreateIncomeSourceResponse> createIncomeSource(
      $19.CreateIncomeSourceRequest request,
      {$grpc.CallOptions? options}) {
    return $createUnaryCall(_$createIncomeSource, request, options: options);
  }

  $grpc.ResponseFuture<$19.GetInvestmentPortfolioResponse>
      getInvestmentPortfolio($19.GetInvestmentPortfolioRequest request,
          {$grpc.CallOptions? options}) {
    return $createUnaryCall(_$getInvestmentPortfolio, request,
        options: options);
  }

  $grpc.ResponseFuture<$19.CreateInvestmentResponse> createInvestment(
      $19.CreateInvestmentRequest request,
      {$grpc.CallOptions? options}) {
    return $createUnaryCall(_$createInvestment, request, options: options);
  }

  $grpc.ResponseFuture<$19.GetFinancialGoalsResponse> getFinancialGoals(
      $19.GetFinancialGoalsRequest request,
      {$grpc.CallOptions? options}) {
    return $createUnaryCall(_$getFinancialGoals, request, options: options);
  }

  $grpc.ResponseFuture<$19.CreateFinancialGoalResponse> createFinancialGoal(
      $19.CreateFinancialGoalRequest request,
      {$grpc.CallOptions? options}) {
    return $createUnaryCall(_$createFinancialGoal, request, options: options);
  }

  $grpc.ResponseFuture<$19.UpdateFinancialGoalProgressResponse>
      updateFinancialGoalProgress(
          $19.UpdateFinancialGoalProgressRequest request,
          {$grpc.CallOptions? options}) {
    return $createUnaryCall(_$updateFinancialGoalProgress, request,
        options: options);
  }

  $grpc.ResponseFuture<$19.GetSavingsGoalResponse> getSavingsGoal(
      $19.GetSavingsGoalRequest request,
      {$grpc.CallOptions? options}) {
    return $createUnaryCall(_$getSavingsGoal, request, options: options);
  }

  $grpc.ResponseFuture<$19.CreateOrUpdateSavingsGoalResponse>
      createOrUpdateSavingsGoal($19.CreateOrUpdateSavingsGoalRequest request,
          {$grpc.CallOptions? options}) {
    return $createUnaryCall(_$createOrUpdateSavingsGoal, request,
        options: options);
  }

  $grpc.ResponseFuture<$19.GetUpcomingBillsResponse> getUpcomingBills(
      $19.GetUpcomingBillsRequest request,
      {$grpc.CallOptions? options}) {
    return $createUnaryCall(_$getUpcomingBills, request, options: options);
  }

  $grpc.ResponseFuture<$19.CreateRecurringBillResponse> createRecurringBill(
      $19.CreateRecurringBillRequest request,
      {$grpc.CallOptions? options}) {
    return $createUnaryCall(_$createRecurringBill, request, options: options);
  }
}

abstract class StatisticsServiceBase extends $grpc.Service {
  $core.String get $name => 'pb.StatisticsService';

  StatisticsServiceBase() {
    $addMethod($grpc.ServiceMethod<$19.CreateExpenseRequest,
            $19.CreateExpenseResponse>(
        'CreateExpense',
        createExpense_Pre,
        false,
        false,
        ($core.List<$core.int> value) =>
            $19.CreateExpenseRequest.fromBuffer(value),
        ($19.CreateExpenseResponse value) => value.writeToBuffer()));
    $addMethod(
        $grpc.ServiceMethod<$19.GetExpensesRequest, $19.GetExpensesResponse>(
            'GetExpenses',
            getExpenses_Pre,
            false,
            false,
            ($core.List<$core.int> value) =>
                $19.GetExpensesRequest.fromBuffer(value),
            ($19.GetExpensesResponse value) => value.writeToBuffer()));
    $addMethod($grpc.ServiceMethod<$19.GetExpenseByIdRequest,
            $19.GetExpenseByIdResponse>(
        'GetExpenseById',
        getExpenseById_Pre,
        false,
        false,
        ($core.List<$core.int> value) =>
            $19.GetExpenseByIdRequest.fromBuffer(value),
        ($19.GetExpenseByIdResponse value) => value.writeToBuffer()));
    $addMethod($grpc.ServiceMethod<$19.UpdateExpenseRequest,
            $19.UpdateExpenseResponse>(
        'UpdateExpense',
        updateExpense_Pre,
        false,
        false,
        ($core.List<$core.int> value) =>
            $19.UpdateExpenseRequest.fromBuffer(value),
        ($19.UpdateExpenseResponse value) => value.writeToBuffer()));
    $addMethod($grpc.ServiceMethod<$19.DeleteExpenseRequest,
            $19.DeleteExpenseResponse>(
        'DeleteExpense',
        deleteExpense_Pre,
        false,
        false,
        ($core.List<$core.int> value) =>
            $19.DeleteExpenseRequest.fromBuffer(value),
        ($19.DeleteExpenseResponse value) => value.writeToBuffer()));
    $addMethod(
        $grpc.ServiceMethod<$19.CreateBudgetRequest, $19.CreateBudgetResponse>(
            'CreateBudget',
            createBudget_Pre,
            false,
            false,
            ($core.List<$core.int> value) =>
                $19.CreateBudgetRequest.fromBuffer(value),
            ($19.CreateBudgetResponse value) => value.writeToBuffer()));
    $addMethod(
        $grpc.ServiceMethod<$19.GetBudgetsRequest, $19.GetBudgetsResponse>(
            'GetBudgets',
            getBudgets_Pre,
            false,
            false,
            ($core.List<$core.int> value) =>
                $19.GetBudgetsRequest.fromBuffer(value),
            ($19.GetBudgetsResponse value) => value.writeToBuffer()));
    $addMethod($grpc.ServiceMethod<$19.GetBudgetByIdRequest,
            $19.GetBudgetByIdResponse>(
        'GetBudgetById',
        getBudgetById_Pre,
        false,
        false,
        ($core.List<$core.int> value) =>
            $19.GetBudgetByIdRequest.fromBuffer(value),
        ($19.GetBudgetByIdResponse value) => value.writeToBuffer()));
    $addMethod(
        $grpc.ServiceMethod<$19.UpdateBudgetRequest, $19.UpdateBudgetResponse>(
            'UpdateBudget',
            updateBudget_Pre,
            false,
            false,
            ($core.List<$core.int> value) =>
                $19.UpdateBudgetRequest.fromBuffer(value),
            ($19.UpdateBudgetResponse value) => value.writeToBuffer()));
    $addMethod(
        $grpc.ServiceMethod<$19.DeleteBudgetRequest, $19.DeleteBudgetResponse>(
            'DeleteBudget',
            deleteBudget_Pre,
            false,
            false,
            ($core.List<$core.int> value) =>
                $19.DeleteBudgetRequest.fromBuffer(value),
            ($19.DeleteBudgetResponse value) => value.writeToBuffer()));
    $addMethod($grpc.ServiceMethod<$19.GetSpendingAnalyticsRequest,
            $19.GetSpendingAnalyticsResponse>(
        'GetSpendingAnalytics',
        getSpendingAnalytics_Pre,
        false,
        false,
        ($core.List<$core.int> value) =>
            $19.GetSpendingAnalyticsRequest.fromBuffer(value),
        ($19.GetSpendingAnalyticsResponse value) => value.writeToBuffer()));
    $addMethod($grpc.ServiceMethod<$19.GetCategoryBreakdownRequest,
            $19.GetCategoryBreakdownResponse>(
        'GetCategoryBreakdown',
        getCategoryBreakdown_Pre,
        false,
        false,
        ($core.List<$core.int> value) =>
            $19.GetCategoryBreakdownRequest.fromBuffer(value),
        ($19.GetCategoryBreakdownResponse value) => value.writeToBuffer()));
    $addMethod($grpc.ServiceMethod<$19.GetBudgetProgressRequest,
            $19.GetBudgetProgressResponse>(
        'GetBudgetProgress',
        getBudgetProgress_Pre,
        false,
        false,
        ($core.List<$core.int> value) =>
            $19.GetBudgetProgressRequest.fromBuffer(value),
        ($19.GetBudgetProgressResponse value) => value.writeToBuffer()));
    $addMethod($grpc.ServiceMethod<$19.GetSpendingTrendsRequest,
            $19.GetSpendingTrendsResponse>(
        'GetSpendingTrends',
        getSpendingTrends_Pre,
        false,
        false,
        ($core.List<$core.int> value) =>
            $19.GetSpendingTrendsRequest.fromBuffer(value),
        ($19.GetSpendingTrendsResponse value) => value.writeToBuffer()));
    $addMethod($grpc.ServiceMethod<$19.GetBudgetAlertsRequest,
            $19.GetBudgetAlertsResponse>(
        'GetBudgetAlerts',
        getBudgetAlerts_Pre,
        false,
        false,
        ($core.List<$core.int> value) =>
            $19.GetBudgetAlertsRequest.fromBuffer(value),
        ($19.GetBudgetAlertsResponse value) => value.writeToBuffer()));
    $addMethod($grpc.ServiceMethod<$19.MarkAlertAsReadRequest,
            $19.MarkAlertAsReadResponse>(
        'MarkAlertAsRead',
        markAlertAsRead_Pre,
        false,
        false,
        ($core.List<$core.int> value) =>
            $19.MarkAlertAsReadRequest.fromBuffer(value),
        ($19.MarkAlertAsReadResponse value) => value.writeToBuffer()));
    $addMethod($grpc.ServiceMethod<$19.GetAISpendingInsightsRequest,
            $19.GetAISpendingInsightsResponse>(
        'GetAISpendingInsights',
        getAISpendingInsights_Pre,
        false,
        false,
        ($core.List<$core.int> value) =>
            $19.GetAISpendingInsightsRequest.fromBuffer(value),
        ($19.GetAISpendingInsightsResponse value) => value.writeToBuffer()));
    $addMethod($grpc.ServiceMethod<$19.GetAIBudgetingRecommendationsRequest,
            $19.GetAIBudgetingRecommendationsResponse>(
        'GetAIBudgetingRecommendations',
        getAIBudgetingRecommendations_Pre,
        false,
        false,
        ($core.List<$core.int> value) =>
            $19.GetAIBudgetingRecommendationsRequest.fromBuffer(value),
        ($19.GetAIBudgetingRecommendationsResponse value) =>
            value.writeToBuffer()));
    $addMethod($grpc.ServiceMethod<$19.AutoCategorizeExpenseRequest,
            $19.AutoCategorizeExpenseResponse>(
        'AutoCategorizeExpense',
        autoCategorizeExpense_Pre,
        false,
        false,
        ($core.List<$core.int> value) =>
            $19.AutoCategorizeExpenseRequest.fromBuffer(value),
        ($19.AutoCategorizeExpenseResponse value) => value.writeToBuffer()));
    $addMethod($grpc.ServiceMethod<$19.GetAIFinancialAdviceRequest,
            $19.GetAIFinancialAdviceResponse>(
        'GetAIFinancialAdvice',
        getAIFinancialAdvice_Pre,
        false,
        false,
        ($core.List<$core.int> value) =>
            $19.GetAIFinancialAdviceRequest.fromBuffer(value),
        ($19.GetAIFinancialAdviceResponse value) => value.writeToBuffer()));
    $addMethod($grpc.ServiceMethod<$19.GetIncomeSourcesRequest,
            $19.GetIncomeSourcesResponse>(
        'GetIncomeSources',
        getIncomeSources_Pre,
        false,
        false,
        ($core.List<$core.int> value) =>
            $19.GetIncomeSourcesRequest.fromBuffer(value),
        ($19.GetIncomeSourcesResponse value) => value.writeToBuffer()));
    $addMethod($grpc.ServiceMethod<$19.GetIncomeBreakdownRequest,
            $19.GetIncomeBreakdownResponse>(
        'GetIncomeBreakdown',
        getIncomeBreakdown_Pre,
        false,
        false,
        ($core.List<$core.int> value) =>
            $19.GetIncomeBreakdownRequest.fromBuffer(value),
        ($19.GetIncomeBreakdownResponse value) => value.writeToBuffer()));
    $addMethod($grpc.ServiceMethod<$19.CreateIncomeSourceRequest,
            $19.CreateIncomeSourceResponse>(
        'CreateIncomeSource',
        createIncomeSource_Pre,
        false,
        false,
        ($core.List<$core.int> value) =>
            $19.CreateIncomeSourceRequest.fromBuffer(value),
        ($19.CreateIncomeSourceResponse value) => value.writeToBuffer()));
    $addMethod($grpc.ServiceMethod<$19.GetInvestmentPortfolioRequest,
            $19.GetInvestmentPortfolioResponse>(
        'GetInvestmentPortfolio',
        getInvestmentPortfolio_Pre,
        false,
        false,
        ($core.List<$core.int> value) =>
            $19.GetInvestmentPortfolioRequest.fromBuffer(value),
        ($19.GetInvestmentPortfolioResponse value) => value.writeToBuffer()));
    $addMethod($grpc.ServiceMethod<$19.CreateInvestmentRequest,
            $19.CreateInvestmentResponse>(
        'CreateInvestment',
        createInvestment_Pre,
        false,
        false,
        ($core.List<$core.int> value) =>
            $19.CreateInvestmentRequest.fromBuffer(value),
        ($19.CreateInvestmentResponse value) => value.writeToBuffer()));
    $addMethod($grpc.ServiceMethod<$19.GetFinancialGoalsRequest,
            $19.GetFinancialGoalsResponse>(
        'GetFinancialGoals',
        getFinancialGoals_Pre,
        false,
        false,
        ($core.List<$core.int> value) =>
            $19.GetFinancialGoalsRequest.fromBuffer(value),
        ($19.GetFinancialGoalsResponse value) => value.writeToBuffer()));
    $addMethod($grpc.ServiceMethod<$19.CreateFinancialGoalRequest,
            $19.CreateFinancialGoalResponse>(
        'CreateFinancialGoal',
        createFinancialGoal_Pre,
        false,
        false,
        ($core.List<$core.int> value) =>
            $19.CreateFinancialGoalRequest.fromBuffer(value),
        ($19.CreateFinancialGoalResponse value) => value.writeToBuffer()));
    $addMethod($grpc.ServiceMethod<$19.UpdateFinancialGoalProgressRequest,
            $19.UpdateFinancialGoalProgressResponse>(
        'UpdateFinancialGoalProgress',
        updateFinancialGoalProgress_Pre,
        false,
        false,
        ($core.List<$core.int> value) =>
            $19.UpdateFinancialGoalProgressRequest.fromBuffer(value),
        ($19.UpdateFinancialGoalProgressResponse value) =>
            value.writeToBuffer()));
    $addMethod($grpc.ServiceMethod<$19.GetSavingsGoalRequest,
            $19.GetSavingsGoalResponse>(
        'GetSavingsGoal',
        getSavingsGoal_Pre,
        false,
        false,
        ($core.List<$core.int> value) =>
            $19.GetSavingsGoalRequest.fromBuffer(value),
        ($19.GetSavingsGoalResponse value) => value.writeToBuffer()));
    $addMethod($grpc.ServiceMethod<$19.CreateOrUpdateSavingsGoalRequest,
            $19.CreateOrUpdateSavingsGoalResponse>(
        'CreateOrUpdateSavingsGoal',
        createOrUpdateSavingsGoal_Pre,
        false,
        false,
        ($core.List<$core.int> value) =>
            $19.CreateOrUpdateSavingsGoalRequest.fromBuffer(value),
        ($19.CreateOrUpdateSavingsGoalResponse value) =>
            value.writeToBuffer()));
    $addMethod($grpc.ServiceMethod<$19.GetUpcomingBillsRequest,
            $19.GetUpcomingBillsResponse>(
        'GetUpcomingBills',
        getUpcomingBills_Pre,
        false,
        false,
        ($core.List<$core.int> value) =>
            $19.GetUpcomingBillsRequest.fromBuffer(value),
        ($19.GetUpcomingBillsResponse value) => value.writeToBuffer()));
    $addMethod($grpc.ServiceMethod<$19.CreateRecurringBillRequest,
            $19.CreateRecurringBillResponse>(
        'CreateRecurringBill',
        createRecurringBill_Pre,
        false,
        false,
        ($core.List<$core.int> value) =>
            $19.CreateRecurringBillRequest.fromBuffer(value),
        ($19.CreateRecurringBillResponse value) => value.writeToBuffer()));
  }

  $async.Future<$19.CreateExpenseResponse> createExpense_Pre(
      $grpc.ServiceCall call,
      $async.Future<$19.CreateExpenseRequest> request) async {
    return createExpense(call, await request);
  }

  $async.Future<$19.GetExpensesResponse> getExpenses_Pre($grpc.ServiceCall call,
      $async.Future<$19.GetExpensesRequest> request) async {
    return getExpenses(call, await request);
  }

  $async.Future<$19.GetExpenseByIdResponse> getExpenseById_Pre(
      $grpc.ServiceCall call,
      $async.Future<$19.GetExpenseByIdRequest> request) async {
    return getExpenseById(call, await request);
  }

  $async.Future<$19.UpdateExpenseResponse> updateExpense_Pre(
      $grpc.ServiceCall call,
      $async.Future<$19.UpdateExpenseRequest> request) async {
    return updateExpense(call, await request);
  }

  $async.Future<$19.DeleteExpenseResponse> deleteExpense_Pre(
      $grpc.ServiceCall call,
      $async.Future<$19.DeleteExpenseRequest> request) async {
    return deleteExpense(call, await request);
  }

  $async.Future<$19.CreateBudgetResponse> createBudget_Pre(
      $grpc.ServiceCall call,
      $async.Future<$19.CreateBudgetRequest> request) async {
    return createBudget(call, await request);
  }

  $async.Future<$19.GetBudgetsResponse> getBudgets_Pre($grpc.ServiceCall call,
      $async.Future<$19.GetBudgetsRequest> request) async {
    return getBudgets(call, await request);
  }

  $async.Future<$19.GetBudgetByIdResponse> getBudgetById_Pre(
      $grpc.ServiceCall call,
      $async.Future<$19.GetBudgetByIdRequest> request) async {
    return getBudgetById(call, await request);
  }

  $async.Future<$19.UpdateBudgetResponse> updateBudget_Pre(
      $grpc.ServiceCall call,
      $async.Future<$19.UpdateBudgetRequest> request) async {
    return updateBudget(call, await request);
  }

  $async.Future<$19.DeleteBudgetResponse> deleteBudget_Pre(
      $grpc.ServiceCall call,
      $async.Future<$19.DeleteBudgetRequest> request) async {
    return deleteBudget(call, await request);
  }

  $async.Future<$19.GetSpendingAnalyticsResponse> getSpendingAnalytics_Pre(
      $grpc.ServiceCall call,
      $async.Future<$19.GetSpendingAnalyticsRequest> request) async {
    return getSpendingAnalytics(call, await request);
  }

  $async.Future<$19.GetCategoryBreakdownResponse> getCategoryBreakdown_Pre(
      $grpc.ServiceCall call,
      $async.Future<$19.GetCategoryBreakdownRequest> request) async {
    return getCategoryBreakdown(call, await request);
  }

  $async.Future<$19.GetBudgetProgressResponse> getBudgetProgress_Pre(
      $grpc.ServiceCall call,
      $async.Future<$19.GetBudgetProgressRequest> request) async {
    return getBudgetProgress(call, await request);
  }

  $async.Future<$19.GetSpendingTrendsResponse> getSpendingTrends_Pre(
      $grpc.ServiceCall call,
      $async.Future<$19.GetSpendingTrendsRequest> request) async {
    return getSpendingTrends(call, await request);
  }

  $async.Future<$19.GetBudgetAlertsResponse> getBudgetAlerts_Pre(
      $grpc.ServiceCall call,
      $async.Future<$19.GetBudgetAlertsRequest> request) async {
    return getBudgetAlerts(call, await request);
  }

  $async.Future<$19.MarkAlertAsReadResponse> markAlertAsRead_Pre(
      $grpc.ServiceCall call,
      $async.Future<$19.MarkAlertAsReadRequest> request) async {
    return markAlertAsRead(call, await request);
  }

  $async.Future<$19.GetAISpendingInsightsResponse> getAISpendingInsights_Pre(
      $grpc.ServiceCall call,
      $async.Future<$19.GetAISpendingInsightsRequest> request) async {
    return getAISpendingInsights(call, await request);
  }

  $async.Future<$19.GetAIBudgetingRecommendationsResponse>
      getAIBudgetingRecommendations_Pre(
          $grpc.ServiceCall call,
          $async.Future<$19.GetAIBudgetingRecommendationsRequest>
              request) async {
    return getAIBudgetingRecommendations(call, await request);
  }

  $async.Future<$19.AutoCategorizeExpenseResponse> autoCategorizeExpense_Pre(
      $grpc.ServiceCall call,
      $async.Future<$19.AutoCategorizeExpenseRequest> request) async {
    return autoCategorizeExpense(call, await request);
  }

  $async.Future<$19.GetAIFinancialAdviceResponse> getAIFinancialAdvice_Pre(
      $grpc.ServiceCall call,
      $async.Future<$19.GetAIFinancialAdviceRequest> request) async {
    return getAIFinancialAdvice(call, await request);
  }

  $async.Future<$19.GetIncomeSourcesResponse> getIncomeSources_Pre(
      $grpc.ServiceCall call,
      $async.Future<$19.GetIncomeSourcesRequest> request) async {
    return getIncomeSources(call, await request);
  }

  $async.Future<$19.GetIncomeBreakdownResponse> getIncomeBreakdown_Pre(
      $grpc.ServiceCall call,
      $async.Future<$19.GetIncomeBreakdownRequest> request) async {
    return getIncomeBreakdown(call, await request);
  }

  $async.Future<$19.CreateIncomeSourceResponse> createIncomeSource_Pre(
      $grpc.ServiceCall call,
      $async.Future<$19.CreateIncomeSourceRequest> request) async {
    return createIncomeSource(call, await request);
  }

  $async.Future<$19.GetInvestmentPortfolioResponse> getInvestmentPortfolio_Pre(
      $grpc.ServiceCall call,
      $async.Future<$19.GetInvestmentPortfolioRequest> request) async {
    return getInvestmentPortfolio(call, await request);
  }

  $async.Future<$19.CreateInvestmentResponse> createInvestment_Pre(
      $grpc.ServiceCall call,
      $async.Future<$19.CreateInvestmentRequest> request) async {
    return createInvestment(call, await request);
  }

  $async.Future<$19.GetFinancialGoalsResponse> getFinancialGoals_Pre(
      $grpc.ServiceCall call,
      $async.Future<$19.GetFinancialGoalsRequest> request) async {
    return getFinancialGoals(call, await request);
  }

  $async.Future<$19.CreateFinancialGoalResponse> createFinancialGoal_Pre(
      $grpc.ServiceCall call,
      $async.Future<$19.CreateFinancialGoalRequest> request) async {
    return createFinancialGoal(call, await request);
  }

  $async.Future<$19.UpdateFinancialGoalProgressResponse>
      updateFinancialGoalProgress_Pre($grpc.ServiceCall call,
          $async.Future<$19.UpdateFinancialGoalProgressRequest> request) async {
    return updateFinancialGoalProgress(call, await request);
  }

  $async.Future<$19.GetSavingsGoalResponse> getSavingsGoal_Pre(
      $grpc.ServiceCall call,
      $async.Future<$19.GetSavingsGoalRequest> request) async {
    return getSavingsGoal(call, await request);
  }

  $async.Future<$19.CreateOrUpdateSavingsGoalResponse>
      createOrUpdateSavingsGoal_Pre($grpc.ServiceCall call,
          $async.Future<$19.CreateOrUpdateSavingsGoalRequest> request) async {
    return createOrUpdateSavingsGoal(call, await request);
  }

  $async.Future<$19.GetUpcomingBillsResponse> getUpcomingBills_Pre(
      $grpc.ServiceCall call,
      $async.Future<$19.GetUpcomingBillsRequest> request) async {
    return getUpcomingBills(call, await request);
  }

  $async.Future<$19.CreateRecurringBillResponse> createRecurringBill_Pre(
      $grpc.ServiceCall call,
      $async.Future<$19.CreateRecurringBillRequest> request) async {
    return createRecurringBill(call, await request);
  }

  $async.Future<$19.CreateExpenseResponse> createExpense(
      $grpc.ServiceCall call, $19.CreateExpenseRequest request);
  $async.Future<$19.GetExpensesResponse> getExpenses(
      $grpc.ServiceCall call, $19.GetExpensesRequest request);
  $async.Future<$19.GetExpenseByIdResponse> getExpenseById(
      $grpc.ServiceCall call, $19.GetExpenseByIdRequest request);
  $async.Future<$19.UpdateExpenseResponse> updateExpense(
      $grpc.ServiceCall call, $19.UpdateExpenseRequest request);
  $async.Future<$19.DeleteExpenseResponse> deleteExpense(
      $grpc.ServiceCall call, $19.DeleteExpenseRequest request);
  $async.Future<$19.CreateBudgetResponse> createBudget(
      $grpc.ServiceCall call, $19.CreateBudgetRequest request);
  $async.Future<$19.GetBudgetsResponse> getBudgets(
      $grpc.ServiceCall call, $19.GetBudgetsRequest request);
  $async.Future<$19.GetBudgetByIdResponse> getBudgetById(
      $grpc.ServiceCall call, $19.GetBudgetByIdRequest request);
  $async.Future<$19.UpdateBudgetResponse> updateBudget(
      $grpc.ServiceCall call, $19.UpdateBudgetRequest request);
  $async.Future<$19.DeleteBudgetResponse> deleteBudget(
      $grpc.ServiceCall call, $19.DeleteBudgetRequest request);
  $async.Future<$19.GetSpendingAnalyticsResponse> getSpendingAnalytics(
      $grpc.ServiceCall call, $19.GetSpendingAnalyticsRequest request);
  $async.Future<$19.GetCategoryBreakdownResponse> getCategoryBreakdown(
      $grpc.ServiceCall call, $19.GetCategoryBreakdownRequest request);
  $async.Future<$19.GetBudgetProgressResponse> getBudgetProgress(
      $grpc.ServiceCall call, $19.GetBudgetProgressRequest request);
  $async.Future<$19.GetSpendingTrendsResponse> getSpendingTrends(
      $grpc.ServiceCall call, $19.GetSpendingTrendsRequest request);
  $async.Future<$19.GetBudgetAlertsResponse> getBudgetAlerts(
      $grpc.ServiceCall call, $19.GetBudgetAlertsRequest request);
  $async.Future<$19.MarkAlertAsReadResponse> markAlertAsRead(
      $grpc.ServiceCall call, $19.MarkAlertAsReadRequest request);
  $async.Future<$19.GetAISpendingInsightsResponse> getAISpendingInsights(
      $grpc.ServiceCall call, $19.GetAISpendingInsightsRequest request);
  $async.Future<$19.GetAIBudgetingRecommendationsResponse>
      getAIBudgetingRecommendations($grpc.ServiceCall call,
          $19.GetAIBudgetingRecommendationsRequest request);
  $async.Future<$19.AutoCategorizeExpenseResponse> autoCategorizeExpense(
      $grpc.ServiceCall call, $19.AutoCategorizeExpenseRequest request);
  $async.Future<$19.GetAIFinancialAdviceResponse> getAIFinancialAdvice(
      $grpc.ServiceCall call, $19.GetAIFinancialAdviceRequest request);
  $async.Future<$19.GetIncomeSourcesResponse> getIncomeSources(
      $grpc.ServiceCall call, $19.GetIncomeSourcesRequest request);
  $async.Future<$19.GetIncomeBreakdownResponse> getIncomeBreakdown(
      $grpc.ServiceCall call, $19.GetIncomeBreakdownRequest request);
  $async.Future<$19.CreateIncomeSourceResponse> createIncomeSource(
      $grpc.ServiceCall call, $19.CreateIncomeSourceRequest request);
  $async.Future<$19.GetInvestmentPortfolioResponse> getInvestmentPortfolio(
      $grpc.ServiceCall call, $19.GetInvestmentPortfolioRequest request);
  $async.Future<$19.CreateInvestmentResponse> createInvestment(
      $grpc.ServiceCall call, $19.CreateInvestmentRequest request);
  $async.Future<$19.GetFinancialGoalsResponse> getFinancialGoals(
      $grpc.ServiceCall call, $19.GetFinancialGoalsRequest request);
  $async.Future<$19.CreateFinancialGoalResponse> createFinancialGoal(
      $grpc.ServiceCall call, $19.CreateFinancialGoalRequest request);
  $async.Future<$19.UpdateFinancialGoalProgressResponse>
      updateFinancialGoalProgress($grpc.ServiceCall call,
          $19.UpdateFinancialGoalProgressRequest request);
  $async.Future<$19.GetSavingsGoalResponse> getSavingsGoal(
      $grpc.ServiceCall call, $19.GetSavingsGoalRequest request);
  $async.Future<$19.CreateOrUpdateSavingsGoalResponse>
      createOrUpdateSavingsGoal(
          $grpc.ServiceCall call, $19.CreateOrUpdateSavingsGoalRequest request);
  $async.Future<$19.GetUpcomingBillsResponse> getUpcomingBills(
      $grpc.ServiceCall call, $19.GetUpcomingBillsRequest request);
  $async.Future<$19.CreateRecurringBillResponse> createRecurringBill(
      $grpc.ServiceCall call, $19.CreateRecurringBillRequest request);
}
