///
//  Generated code. Do not modify.
//  source: statistics.proto
//
// @dart = 2.12
// ignore_for_file: annotate_overrides,camel_case_types,constant_identifier_names,directives_ordering,library_prefixes,non_constant_identifier_names,prefer_final_fields,return_of_invalid_type,unnecessary_const,unnecessary_import,unnecessary_this,unused_import,unused_shown_name

import 'dart:async' as $async;

import 'dart:core' as $core;

import 'package:grpc/service_api.dart' as $grpc;
import 'statistics.pb.dart' as $18;
export 'statistics.pb.dart';

class StatisticsServiceClient extends $grpc.Client {
  static final _$createExpense =
      $grpc.ClientMethod<$18.CreateExpenseRequest, $18.CreateExpenseResponse>(
          '/pb.StatisticsService/CreateExpense',
          ($18.CreateExpenseRequest value) => value.writeToBuffer(),
          ($core.List<$core.int> value) =>
              $18.CreateExpenseResponse.fromBuffer(value));
  static final _$getExpenses =
      $grpc.ClientMethod<$18.GetExpensesRequest, $18.GetExpensesResponse>(
          '/pb.StatisticsService/GetExpenses',
          ($18.GetExpensesRequest value) => value.writeToBuffer(),
          ($core.List<$core.int> value) =>
              $18.GetExpensesResponse.fromBuffer(value));
  static final _$getExpenseById =
      $grpc.ClientMethod<$18.GetExpenseByIdRequest, $18.GetExpenseByIdResponse>(
          '/pb.StatisticsService/GetExpenseById',
          ($18.GetExpenseByIdRequest value) => value.writeToBuffer(),
          ($core.List<$core.int> value) =>
              $18.GetExpenseByIdResponse.fromBuffer(value));
  static final _$updateExpense =
      $grpc.ClientMethod<$18.UpdateExpenseRequest, $18.UpdateExpenseResponse>(
          '/pb.StatisticsService/UpdateExpense',
          ($18.UpdateExpenseRequest value) => value.writeToBuffer(),
          ($core.List<$core.int> value) =>
              $18.UpdateExpenseResponse.fromBuffer(value));
  static final _$deleteExpense =
      $grpc.ClientMethod<$18.DeleteExpenseRequest, $18.DeleteExpenseResponse>(
          '/pb.StatisticsService/DeleteExpense',
          ($18.DeleteExpenseRequest value) => value.writeToBuffer(),
          ($core.List<$core.int> value) =>
              $18.DeleteExpenseResponse.fromBuffer(value));
  static final _$createBudget =
      $grpc.ClientMethod<$18.CreateBudgetRequest, $18.CreateBudgetResponse>(
          '/pb.StatisticsService/CreateBudget',
          ($18.CreateBudgetRequest value) => value.writeToBuffer(),
          ($core.List<$core.int> value) =>
              $18.CreateBudgetResponse.fromBuffer(value));
  static final _$getBudgets =
      $grpc.ClientMethod<$18.GetBudgetsRequest, $18.GetBudgetsResponse>(
          '/pb.StatisticsService/GetBudgets',
          ($18.GetBudgetsRequest value) => value.writeToBuffer(),
          ($core.List<$core.int> value) =>
              $18.GetBudgetsResponse.fromBuffer(value));
  static final _$getBudgetById =
      $grpc.ClientMethod<$18.GetBudgetByIdRequest, $18.GetBudgetByIdResponse>(
          '/pb.StatisticsService/GetBudgetById',
          ($18.GetBudgetByIdRequest value) => value.writeToBuffer(),
          ($core.List<$core.int> value) =>
              $18.GetBudgetByIdResponse.fromBuffer(value));
  static final _$updateBudget =
      $grpc.ClientMethod<$18.UpdateBudgetRequest, $18.UpdateBudgetResponse>(
          '/pb.StatisticsService/UpdateBudget',
          ($18.UpdateBudgetRequest value) => value.writeToBuffer(),
          ($core.List<$core.int> value) =>
              $18.UpdateBudgetResponse.fromBuffer(value));
  static final _$deleteBudget =
      $grpc.ClientMethod<$18.DeleteBudgetRequest, $18.DeleteBudgetResponse>(
          '/pb.StatisticsService/DeleteBudget',
          ($18.DeleteBudgetRequest value) => value.writeToBuffer(),
          ($core.List<$core.int> value) =>
              $18.DeleteBudgetResponse.fromBuffer(value));
  static final _$getSpendingAnalytics = $grpc.ClientMethod<
          $18.GetSpendingAnalyticsRequest, $18.GetSpendingAnalyticsResponse>(
      '/pb.StatisticsService/GetSpendingAnalytics',
      ($18.GetSpendingAnalyticsRequest value) => value.writeToBuffer(),
      ($core.List<$core.int> value) =>
          $18.GetSpendingAnalyticsResponse.fromBuffer(value));
  static final _$getCategoryBreakdown = $grpc.ClientMethod<
          $18.GetCategoryBreakdownRequest, $18.GetCategoryBreakdownResponse>(
      '/pb.StatisticsService/GetCategoryBreakdown',
      ($18.GetCategoryBreakdownRequest value) => value.writeToBuffer(),
      ($core.List<$core.int> value) =>
          $18.GetCategoryBreakdownResponse.fromBuffer(value));
  static final _$getBudgetProgress = $grpc.ClientMethod<
          $18.GetBudgetProgressRequest, $18.GetBudgetProgressResponse>(
      '/pb.StatisticsService/GetBudgetProgress',
      ($18.GetBudgetProgressRequest value) => value.writeToBuffer(),
      ($core.List<$core.int> value) =>
          $18.GetBudgetProgressResponse.fromBuffer(value));
  static final _$getSpendingTrends = $grpc.ClientMethod<
          $18.GetSpendingTrendsRequest, $18.GetSpendingTrendsResponse>(
      '/pb.StatisticsService/GetSpendingTrends',
      ($18.GetSpendingTrendsRequest value) => value.writeToBuffer(),
      ($core.List<$core.int> value) =>
          $18.GetSpendingTrendsResponse.fromBuffer(value));
  static final _$getBudgetAlerts = $grpc.ClientMethod<
          $18.GetBudgetAlertsRequest, $18.GetBudgetAlertsResponse>(
      '/pb.StatisticsService/GetBudgetAlerts',
      ($18.GetBudgetAlertsRequest value) => value.writeToBuffer(),
      ($core.List<$core.int> value) =>
          $18.GetBudgetAlertsResponse.fromBuffer(value));
  static final _$markAlertAsRead = $grpc.ClientMethod<
          $18.MarkAlertAsReadRequest, $18.MarkAlertAsReadResponse>(
      '/pb.StatisticsService/MarkAlertAsRead',
      ($18.MarkAlertAsReadRequest value) => value.writeToBuffer(),
      ($core.List<$core.int> value) =>
          $18.MarkAlertAsReadResponse.fromBuffer(value));
  static final _$getAISpendingInsights = $grpc.ClientMethod<
          $18.GetAISpendingInsightsRequest, $18.GetAISpendingInsightsResponse>(
      '/pb.StatisticsService/GetAISpendingInsights',
      ($18.GetAISpendingInsightsRequest value) => value.writeToBuffer(),
      ($core.List<$core.int> value) =>
          $18.GetAISpendingInsightsResponse.fromBuffer(value));
  static final _$getAIBudgetingRecommendations = $grpc.ClientMethod<
          $18.GetAIBudgetingRecommendationsRequest,
          $18.GetAIBudgetingRecommendationsResponse>(
      '/pb.StatisticsService/GetAIBudgetingRecommendations',
      ($18.GetAIBudgetingRecommendationsRequest value) => value.writeToBuffer(),
      ($core.List<$core.int> value) =>
          $18.GetAIBudgetingRecommendationsResponse.fromBuffer(value));
  static final _$autoCategorizeExpense = $grpc.ClientMethod<
          $18.AutoCategorizeExpenseRequest, $18.AutoCategorizeExpenseResponse>(
      '/pb.StatisticsService/AutoCategorizeExpense',
      ($18.AutoCategorizeExpenseRequest value) => value.writeToBuffer(),
      ($core.List<$core.int> value) =>
          $18.AutoCategorizeExpenseResponse.fromBuffer(value));
  static final _$getAIFinancialAdvice = $grpc.ClientMethod<
          $18.GetAIFinancialAdviceRequest, $18.GetAIFinancialAdviceResponse>(
      '/pb.StatisticsService/GetAIFinancialAdvice',
      ($18.GetAIFinancialAdviceRequest value) => value.writeToBuffer(),
      ($core.List<$core.int> value) =>
          $18.GetAIFinancialAdviceResponse.fromBuffer(value));
  static final _$getIncomeSources = $grpc.ClientMethod<
          $18.GetIncomeSourcesRequest, $18.GetIncomeSourcesResponse>(
      '/pb.StatisticsService/GetIncomeSources',
      ($18.GetIncomeSourcesRequest value) => value.writeToBuffer(),
      ($core.List<$core.int> value) =>
          $18.GetIncomeSourcesResponse.fromBuffer(value));
  static final _$getIncomeBreakdown = $grpc.ClientMethod<
          $18.GetIncomeBreakdownRequest, $18.GetIncomeBreakdownResponse>(
      '/pb.StatisticsService/GetIncomeBreakdown',
      ($18.GetIncomeBreakdownRequest value) => value.writeToBuffer(),
      ($core.List<$core.int> value) =>
          $18.GetIncomeBreakdownResponse.fromBuffer(value));
  static final _$createIncomeSource = $grpc.ClientMethod<
          $18.CreateIncomeSourceRequest, $18.CreateIncomeSourceResponse>(
      '/pb.StatisticsService/CreateIncomeSource',
      ($18.CreateIncomeSourceRequest value) => value.writeToBuffer(),
      ($core.List<$core.int> value) =>
          $18.CreateIncomeSourceResponse.fromBuffer(value));
  static final _$getInvestmentPortfolio = $grpc.ClientMethod<
          $18.GetInvestmentPortfolioRequest,
          $18.GetInvestmentPortfolioResponse>(
      '/pb.StatisticsService/GetInvestmentPortfolio',
      ($18.GetInvestmentPortfolioRequest value) => value.writeToBuffer(),
      ($core.List<$core.int> value) =>
          $18.GetInvestmentPortfolioResponse.fromBuffer(value));
  static final _$createInvestment = $grpc.ClientMethod<
          $18.CreateInvestmentRequest, $18.CreateInvestmentResponse>(
      '/pb.StatisticsService/CreateInvestment',
      ($18.CreateInvestmentRequest value) => value.writeToBuffer(),
      ($core.List<$core.int> value) =>
          $18.CreateInvestmentResponse.fromBuffer(value));
  static final _$getFinancialGoals = $grpc.ClientMethod<
          $18.GetFinancialGoalsRequest, $18.GetFinancialGoalsResponse>(
      '/pb.StatisticsService/GetFinancialGoals',
      ($18.GetFinancialGoalsRequest value) => value.writeToBuffer(),
      ($core.List<$core.int> value) =>
          $18.GetFinancialGoalsResponse.fromBuffer(value));
  static final _$createFinancialGoal = $grpc.ClientMethod<
          $18.CreateFinancialGoalRequest, $18.CreateFinancialGoalResponse>(
      '/pb.StatisticsService/CreateFinancialGoal',
      ($18.CreateFinancialGoalRequest value) => value.writeToBuffer(),
      ($core.List<$core.int> value) =>
          $18.CreateFinancialGoalResponse.fromBuffer(value));
  static final _$updateFinancialGoalProgress = $grpc.ClientMethod<
          $18.UpdateFinancialGoalProgressRequest,
          $18.UpdateFinancialGoalProgressResponse>(
      '/pb.StatisticsService/UpdateFinancialGoalProgress',
      ($18.UpdateFinancialGoalProgressRequest value) => value.writeToBuffer(),
      ($core.List<$core.int> value) =>
          $18.UpdateFinancialGoalProgressResponse.fromBuffer(value));
  static final _$getSavingsGoal =
      $grpc.ClientMethod<$18.GetSavingsGoalRequest, $18.GetSavingsGoalResponse>(
          '/pb.StatisticsService/GetSavingsGoal',
          ($18.GetSavingsGoalRequest value) => value.writeToBuffer(),
          ($core.List<$core.int> value) =>
              $18.GetSavingsGoalResponse.fromBuffer(value));
  static final _$createOrUpdateSavingsGoal = $grpc.ClientMethod<
          $18.CreateOrUpdateSavingsGoalRequest,
          $18.CreateOrUpdateSavingsGoalResponse>(
      '/pb.StatisticsService/CreateOrUpdateSavingsGoal',
      ($18.CreateOrUpdateSavingsGoalRequest value) => value.writeToBuffer(),
      ($core.List<$core.int> value) =>
          $18.CreateOrUpdateSavingsGoalResponse.fromBuffer(value));
  static final _$getUpcomingBills = $grpc.ClientMethod<
          $18.GetUpcomingBillsRequest, $18.GetUpcomingBillsResponse>(
      '/pb.StatisticsService/GetUpcomingBills',
      ($18.GetUpcomingBillsRequest value) => value.writeToBuffer(),
      ($core.List<$core.int> value) =>
          $18.GetUpcomingBillsResponse.fromBuffer(value));
  static final _$createRecurringBill = $grpc.ClientMethod<
          $18.CreateRecurringBillRequest, $18.CreateRecurringBillResponse>(
      '/pb.StatisticsService/CreateRecurringBill',
      ($18.CreateRecurringBillRequest value) => value.writeToBuffer(),
      ($core.List<$core.int> value) =>
          $18.CreateRecurringBillResponse.fromBuffer(value));

  StatisticsServiceClient($grpc.ClientChannel channel,
      {$grpc.CallOptions? options,
      $core.Iterable<$grpc.ClientInterceptor>? interceptors})
      : super(channel, options: options, interceptors: interceptors);

  $grpc.ResponseFuture<$18.CreateExpenseResponse> createExpense(
      $18.CreateExpenseRequest request,
      {$grpc.CallOptions? options}) {
    return $createUnaryCall(_$createExpense, request, options: options);
  }

  $grpc.ResponseFuture<$18.GetExpensesResponse> getExpenses(
      $18.GetExpensesRequest request,
      {$grpc.CallOptions? options}) {
    return $createUnaryCall(_$getExpenses, request, options: options);
  }

  $grpc.ResponseFuture<$18.GetExpenseByIdResponse> getExpenseById(
      $18.GetExpenseByIdRequest request,
      {$grpc.CallOptions? options}) {
    return $createUnaryCall(_$getExpenseById, request, options: options);
  }

  $grpc.ResponseFuture<$18.UpdateExpenseResponse> updateExpense(
      $18.UpdateExpenseRequest request,
      {$grpc.CallOptions? options}) {
    return $createUnaryCall(_$updateExpense, request, options: options);
  }

  $grpc.ResponseFuture<$18.DeleteExpenseResponse> deleteExpense(
      $18.DeleteExpenseRequest request,
      {$grpc.CallOptions? options}) {
    return $createUnaryCall(_$deleteExpense, request, options: options);
  }

  $grpc.ResponseFuture<$18.CreateBudgetResponse> createBudget(
      $18.CreateBudgetRequest request,
      {$grpc.CallOptions? options}) {
    return $createUnaryCall(_$createBudget, request, options: options);
  }

  $grpc.ResponseFuture<$18.GetBudgetsResponse> getBudgets(
      $18.GetBudgetsRequest request,
      {$grpc.CallOptions? options}) {
    return $createUnaryCall(_$getBudgets, request, options: options);
  }

  $grpc.ResponseFuture<$18.GetBudgetByIdResponse> getBudgetById(
      $18.GetBudgetByIdRequest request,
      {$grpc.CallOptions? options}) {
    return $createUnaryCall(_$getBudgetById, request, options: options);
  }

  $grpc.ResponseFuture<$18.UpdateBudgetResponse> updateBudget(
      $18.UpdateBudgetRequest request,
      {$grpc.CallOptions? options}) {
    return $createUnaryCall(_$updateBudget, request, options: options);
  }

  $grpc.ResponseFuture<$18.DeleteBudgetResponse> deleteBudget(
      $18.DeleteBudgetRequest request,
      {$grpc.CallOptions? options}) {
    return $createUnaryCall(_$deleteBudget, request, options: options);
  }

  $grpc.ResponseFuture<$18.GetSpendingAnalyticsResponse> getSpendingAnalytics(
      $18.GetSpendingAnalyticsRequest request,
      {$grpc.CallOptions? options}) {
    return $createUnaryCall(_$getSpendingAnalytics, request, options: options);
  }

  $grpc.ResponseFuture<$18.GetCategoryBreakdownResponse> getCategoryBreakdown(
      $18.GetCategoryBreakdownRequest request,
      {$grpc.CallOptions? options}) {
    return $createUnaryCall(_$getCategoryBreakdown, request, options: options);
  }

  $grpc.ResponseFuture<$18.GetBudgetProgressResponse> getBudgetProgress(
      $18.GetBudgetProgressRequest request,
      {$grpc.CallOptions? options}) {
    return $createUnaryCall(_$getBudgetProgress, request, options: options);
  }

  $grpc.ResponseFuture<$18.GetSpendingTrendsResponse> getSpendingTrends(
      $18.GetSpendingTrendsRequest request,
      {$grpc.CallOptions? options}) {
    return $createUnaryCall(_$getSpendingTrends, request, options: options);
  }

  $grpc.ResponseFuture<$18.GetBudgetAlertsResponse> getBudgetAlerts(
      $18.GetBudgetAlertsRequest request,
      {$grpc.CallOptions? options}) {
    return $createUnaryCall(_$getBudgetAlerts, request, options: options);
  }

  $grpc.ResponseFuture<$18.MarkAlertAsReadResponse> markAlertAsRead(
      $18.MarkAlertAsReadRequest request,
      {$grpc.CallOptions? options}) {
    return $createUnaryCall(_$markAlertAsRead, request, options: options);
  }

  $grpc.ResponseFuture<$18.GetAISpendingInsightsResponse> getAISpendingInsights(
      $18.GetAISpendingInsightsRequest request,
      {$grpc.CallOptions? options}) {
    return $createUnaryCall(_$getAISpendingInsights, request, options: options);
  }

  $grpc.ResponseFuture<$18.GetAIBudgetingRecommendationsResponse>
      getAIBudgetingRecommendations(
          $18.GetAIBudgetingRecommendationsRequest request,
          {$grpc.CallOptions? options}) {
    return $createUnaryCall(_$getAIBudgetingRecommendations, request,
        options: options);
  }

  $grpc.ResponseFuture<$18.AutoCategorizeExpenseResponse> autoCategorizeExpense(
      $18.AutoCategorizeExpenseRequest request,
      {$grpc.CallOptions? options}) {
    return $createUnaryCall(_$autoCategorizeExpense, request, options: options);
  }

  $grpc.ResponseFuture<$18.GetAIFinancialAdviceResponse> getAIFinancialAdvice(
      $18.GetAIFinancialAdviceRequest request,
      {$grpc.CallOptions? options}) {
    return $createUnaryCall(_$getAIFinancialAdvice, request, options: options);
  }

  $grpc.ResponseFuture<$18.GetIncomeSourcesResponse> getIncomeSources(
      $18.GetIncomeSourcesRequest request,
      {$grpc.CallOptions? options}) {
    return $createUnaryCall(_$getIncomeSources, request, options: options);
  }

  $grpc.ResponseFuture<$18.GetIncomeBreakdownResponse> getIncomeBreakdown(
      $18.GetIncomeBreakdownRequest request,
      {$grpc.CallOptions? options}) {
    return $createUnaryCall(_$getIncomeBreakdown, request, options: options);
  }

  $grpc.ResponseFuture<$18.CreateIncomeSourceResponse> createIncomeSource(
      $18.CreateIncomeSourceRequest request,
      {$grpc.CallOptions? options}) {
    return $createUnaryCall(_$createIncomeSource, request, options: options);
  }

  $grpc.ResponseFuture<$18.GetInvestmentPortfolioResponse>
      getInvestmentPortfolio($18.GetInvestmentPortfolioRequest request,
          {$grpc.CallOptions? options}) {
    return $createUnaryCall(_$getInvestmentPortfolio, request,
        options: options);
  }

  $grpc.ResponseFuture<$18.CreateInvestmentResponse> createInvestment(
      $18.CreateInvestmentRequest request,
      {$grpc.CallOptions? options}) {
    return $createUnaryCall(_$createInvestment, request, options: options);
  }

  $grpc.ResponseFuture<$18.GetFinancialGoalsResponse> getFinancialGoals(
      $18.GetFinancialGoalsRequest request,
      {$grpc.CallOptions? options}) {
    return $createUnaryCall(_$getFinancialGoals, request, options: options);
  }

  $grpc.ResponseFuture<$18.CreateFinancialGoalResponse> createFinancialGoal(
      $18.CreateFinancialGoalRequest request,
      {$grpc.CallOptions? options}) {
    return $createUnaryCall(_$createFinancialGoal, request, options: options);
  }

  $grpc.ResponseFuture<$18.UpdateFinancialGoalProgressResponse>
      updateFinancialGoalProgress(
          $18.UpdateFinancialGoalProgressRequest request,
          {$grpc.CallOptions? options}) {
    return $createUnaryCall(_$updateFinancialGoalProgress, request,
        options: options);
  }

  $grpc.ResponseFuture<$18.GetSavingsGoalResponse> getSavingsGoal(
      $18.GetSavingsGoalRequest request,
      {$grpc.CallOptions? options}) {
    return $createUnaryCall(_$getSavingsGoal, request, options: options);
  }

  $grpc.ResponseFuture<$18.CreateOrUpdateSavingsGoalResponse>
      createOrUpdateSavingsGoal($18.CreateOrUpdateSavingsGoalRequest request,
          {$grpc.CallOptions? options}) {
    return $createUnaryCall(_$createOrUpdateSavingsGoal, request,
        options: options);
  }

  $grpc.ResponseFuture<$18.GetUpcomingBillsResponse> getUpcomingBills(
      $18.GetUpcomingBillsRequest request,
      {$grpc.CallOptions? options}) {
    return $createUnaryCall(_$getUpcomingBills, request, options: options);
  }

  $grpc.ResponseFuture<$18.CreateRecurringBillResponse> createRecurringBill(
      $18.CreateRecurringBillRequest request,
      {$grpc.CallOptions? options}) {
    return $createUnaryCall(_$createRecurringBill, request, options: options);
  }
}

abstract class StatisticsServiceBase extends $grpc.Service {
  $core.String get $name => 'pb.StatisticsService';

  StatisticsServiceBase() {
    $addMethod($grpc.ServiceMethod<$18.CreateExpenseRequest,
            $18.CreateExpenseResponse>(
        'CreateExpense',
        createExpense_Pre,
        false,
        false,
        ($core.List<$core.int> value) =>
            $18.CreateExpenseRequest.fromBuffer(value),
        ($18.CreateExpenseResponse value) => value.writeToBuffer()));
    $addMethod(
        $grpc.ServiceMethod<$18.GetExpensesRequest, $18.GetExpensesResponse>(
            'GetExpenses',
            getExpenses_Pre,
            false,
            false,
            ($core.List<$core.int> value) =>
                $18.GetExpensesRequest.fromBuffer(value),
            ($18.GetExpensesResponse value) => value.writeToBuffer()));
    $addMethod($grpc.ServiceMethod<$18.GetExpenseByIdRequest,
            $18.GetExpenseByIdResponse>(
        'GetExpenseById',
        getExpenseById_Pre,
        false,
        false,
        ($core.List<$core.int> value) =>
            $18.GetExpenseByIdRequest.fromBuffer(value),
        ($18.GetExpenseByIdResponse value) => value.writeToBuffer()));
    $addMethod($grpc.ServiceMethod<$18.UpdateExpenseRequest,
            $18.UpdateExpenseResponse>(
        'UpdateExpense',
        updateExpense_Pre,
        false,
        false,
        ($core.List<$core.int> value) =>
            $18.UpdateExpenseRequest.fromBuffer(value),
        ($18.UpdateExpenseResponse value) => value.writeToBuffer()));
    $addMethod($grpc.ServiceMethod<$18.DeleteExpenseRequest,
            $18.DeleteExpenseResponse>(
        'DeleteExpense',
        deleteExpense_Pre,
        false,
        false,
        ($core.List<$core.int> value) =>
            $18.DeleteExpenseRequest.fromBuffer(value),
        ($18.DeleteExpenseResponse value) => value.writeToBuffer()));
    $addMethod(
        $grpc.ServiceMethod<$18.CreateBudgetRequest, $18.CreateBudgetResponse>(
            'CreateBudget',
            createBudget_Pre,
            false,
            false,
            ($core.List<$core.int> value) =>
                $18.CreateBudgetRequest.fromBuffer(value),
            ($18.CreateBudgetResponse value) => value.writeToBuffer()));
    $addMethod(
        $grpc.ServiceMethod<$18.GetBudgetsRequest, $18.GetBudgetsResponse>(
            'GetBudgets',
            getBudgets_Pre,
            false,
            false,
            ($core.List<$core.int> value) =>
                $18.GetBudgetsRequest.fromBuffer(value),
            ($18.GetBudgetsResponse value) => value.writeToBuffer()));
    $addMethod($grpc.ServiceMethod<$18.GetBudgetByIdRequest,
            $18.GetBudgetByIdResponse>(
        'GetBudgetById',
        getBudgetById_Pre,
        false,
        false,
        ($core.List<$core.int> value) =>
            $18.GetBudgetByIdRequest.fromBuffer(value),
        ($18.GetBudgetByIdResponse value) => value.writeToBuffer()));
    $addMethod(
        $grpc.ServiceMethod<$18.UpdateBudgetRequest, $18.UpdateBudgetResponse>(
            'UpdateBudget',
            updateBudget_Pre,
            false,
            false,
            ($core.List<$core.int> value) =>
                $18.UpdateBudgetRequest.fromBuffer(value),
            ($18.UpdateBudgetResponse value) => value.writeToBuffer()));
    $addMethod(
        $grpc.ServiceMethod<$18.DeleteBudgetRequest, $18.DeleteBudgetResponse>(
            'DeleteBudget',
            deleteBudget_Pre,
            false,
            false,
            ($core.List<$core.int> value) =>
                $18.DeleteBudgetRequest.fromBuffer(value),
            ($18.DeleteBudgetResponse value) => value.writeToBuffer()));
    $addMethod($grpc.ServiceMethod<$18.GetSpendingAnalyticsRequest,
            $18.GetSpendingAnalyticsResponse>(
        'GetSpendingAnalytics',
        getSpendingAnalytics_Pre,
        false,
        false,
        ($core.List<$core.int> value) =>
            $18.GetSpendingAnalyticsRequest.fromBuffer(value),
        ($18.GetSpendingAnalyticsResponse value) => value.writeToBuffer()));
    $addMethod($grpc.ServiceMethod<$18.GetCategoryBreakdownRequest,
            $18.GetCategoryBreakdownResponse>(
        'GetCategoryBreakdown',
        getCategoryBreakdown_Pre,
        false,
        false,
        ($core.List<$core.int> value) =>
            $18.GetCategoryBreakdownRequest.fromBuffer(value),
        ($18.GetCategoryBreakdownResponse value) => value.writeToBuffer()));
    $addMethod($grpc.ServiceMethod<$18.GetBudgetProgressRequest,
            $18.GetBudgetProgressResponse>(
        'GetBudgetProgress',
        getBudgetProgress_Pre,
        false,
        false,
        ($core.List<$core.int> value) =>
            $18.GetBudgetProgressRequest.fromBuffer(value),
        ($18.GetBudgetProgressResponse value) => value.writeToBuffer()));
    $addMethod($grpc.ServiceMethod<$18.GetSpendingTrendsRequest,
            $18.GetSpendingTrendsResponse>(
        'GetSpendingTrends',
        getSpendingTrends_Pre,
        false,
        false,
        ($core.List<$core.int> value) =>
            $18.GetSpendingTrendsRequest.fromBuffer(value),
        ($18.GetSpendingTrendsResponse value) => value.writeToBuffer()));
    $addMethod($grpc.ServiceMethod<$18.GetBudgetAlertsRequest,
            $18.GetBudgetAlertsResponse>(
        'GetBudgetAlerts',
        getBudgetAlerts_Pre,
        false,
        false,
        ($core.List<$core.int> value) =>
            $18.GetBudgetAlertsRequest.fromBuffer(value),
        ($18.GetBudgetAlertsResponse value) => value.writeToBuffer()));
    $addMethod($grpc.ServiceMethod<$18.MarkAlertAsReadRequest,
            $18.MarkAlertAsReadResponse>(
        'MarkAlertAsRead',
        markAlertAsRead_Pre,
        false,
        false,
        ($core.List<$core.int> value) =>
            $18.MarkAlertAsReadRequest.fromBuffer(value),
        ($18.MarkAlertAsReadResponse value) => value.writeToBuffer()));
    $addMethod($grpc.ServiceMethod<$18.GetAISpendingInsightsRequest,
            $18.GetAISpendingInsightsResponse>(
        'GetAISpendingInsights',
        getAISpendingInsights_Pre,
        false,
        false,
        ($core.List<$core.int> value) =>
            $18.GetAISpendingInsightsRequest.fromBuffer(value),
        ($18.GetAISpendingInsightsResponse value) => value.writeToBuffer()));
    $addMethod($grpc.ServiceMethod<$18.GetAIBudgetingRecommendationsRequest,
            $18.GetAIBudgetingRecommendationsResponse>(
        'GetAIBudgetingRecommendations',
        getAIBudgetingRecommendations_Pre,
        false,
        false,
        ($core.List<$core.int> value) =>
            $18.GetAIBudgetingRecommendationsRequest.fromBuffer(value),
        ($18.GetAIBudgetingRecommendationsResponse value) =>
            value.writeToBuffer()));
    $addMethod($grpc.ServiceMethod<$18.AutoCategorizeExpenseRequest,
            $18.AutoCategorizeExpenseResponse>(
        'AutoCategorizeExpense',
        autoCategorizeExpense_Pre,
        false,
        false,
        ($core.List<$core.int> value) =>
            $18.AutoCategorizeExpenseRequest.fromBuffer(value),
        ($18.AutoCategorizeExpenseResponse value) => value.writeToBuffer()));
    $addMethod($grpc.ServiceMethod<$18.GetAIFinancialAdviceRequest,
            $18.GetAIFinancialAdviceResponse>(
        'GetAIFinancialAdvice',
        getAIFinancialAdvice_Pre,
        false,
        false,
        ($core.List<$core.int> value) =>
            $18.GetAIFinancialAdviceRequest.fromBuffer(value),
        ($18.GetAIFinancialAdviceResponse value) => value.writeToBuffer()));
    $addMethod($grpc.ServiceMethod<$18.GetIncomeSourcesRequest,
            $18.GetIncomeSourcesResponse>(
        'GetIncomeSources',
        getIncomeSources_Pre,
        false,
        false,
        ($core.List<$core.int> value) =>
            $18.GetIncomeSourcesRequest.fromBuffer(value),
        ($18.GetIncomeSourcesResponse value) => value.writeToBuffer()));
    $addMethod($grpc.ServiceMethod<$18.GetIncomeBreakdownRequest,
            $18.GetIncomeBreakdownResponse>(
        'GetIncomeBreakdown',
        getIncomeBreakdown_Pre,
        false,
        false,
        ($core.List<$core.int> value) =>
            $18.GetIncomeBreakdownRequest.fromBuffer(value),
        ($18.GetIncomeBreakdownResponse value) => value.writeToBuffer()));
    $addMethod($grpc.ServiceMethod<$18.CreateIncomeSourceRequest,
            $18.CreateIncomeSourceResponse>(
        'CreateIncomeSource',
        createIncomeSource_Pre,
        false,
        false,
        ($core.List<$core.int> value) =>
            $18.CreateIncomeSourceRequest.fromBuffer(value),
        ($18.CreateIncomeSourceResponse value) => value.writeToBuffer()));
    $addMethod($grpc.ServiceMethod<$18.GetInvestmentPortfolioRequest,
            $18.GetInvestmentPortfolioResponse>(
        'GetInvestmentPortfolio',
        getInvestmentPortfolio_Pre,
        false,
        false,
        ($core.List<$core.int> value) =>
            $18.GetInvestmentPortfolioRequest.fromBuffer(value),
        ($18.GetInvestmentPortfolioResponse value) => value.writeToBuffer()));
    $addMethod($grpc.ServiceMethod<$18.CreateInvestmentRequest,
            $18.CreateInvestmentResponse>(
        'CreateInvestment',
        createInvestment_Pre,
        false,
        false,
        ($core.List<$core.int> value) =>
            $18.CreateInvestmentRequest.fromBuffer(value),
        ($18.CreateInvestmentResponse value) => value.writeToBuffer()));
    $addMethod($grpc.ServiceMethod<$18.GetFinancialGoalsRequest,
            $18.GetFinancialGoalsResponse>(
        'GetFinancialGoals',
        getFinancialGoals_Pre,
        false,
        false,
        ($core.List<$core.int> value) =>
            $18.GetFinancialGoalsRequest.fromBuffer(value),
        ($18.GetFinancialGoalsResponse value) => value.writeToBuffer()));
    $addMethod($grpc.ServiceMethod<$18.CreateFinancialGoalRequest,
            $18.CreateFinancialGoalResponse>(
        'CreateFinancialGoal',
        createFinancialGoal_Pre,
        false,
        false,
        ($core.List<$core.int> value) =>
            $18.CreateFinancialGoalRequest.fromBuffer(value),
        ($18.CreateFinancialGoalResponse value) => value.writeToBuffer()));
    $addMethod($grpc.ServiceMethod<$18.UpdateFinancialGoalProgressRequest,
            $18.UpdateFinancialGoalProgressResponse>(
        'UpdateFinancialGoalProgress',
        updateFinancialGoalProgress_Pre,
        false,
        false,
        ($core.List<$core.int> value) =>
            $18.UpdateFinancialGoalProgressRequest.fromBuffer(value),
        ($18.UpdateFinancialGoalProgressResponse value) =>
            value.writeToBuffer()));
    $addMethod($grpc.ServiceMethod<$18.GetSavingsGoalRequest,
            $18.GetSavingsGoalResponse>(
        'GetSavingsGoal',
        getSavingsGoal_Pre,
        false,
        false,
        ($core.List<$core.int> value) =>
            $18.GetSavingsGoalRequest.fromBuffer(value),
        ($18.GetSavingsGoalResponse value) => value.writeToBuffer()));
    $addMethod($grpc.ServiceMethod<$18.CreateOrUpdateSavingsGoalRequest,
            $18.CreateOrUpdateSavingsGoalResponse>(
        'CreateOrUpdateSavingsGoal',
        createOrUpdateSavingsGoal_Pre,
        false,
        false,
        ($core.List<$core.int> value) =>
            $18.CreateOrUpdateSavingsGoalRequest.fromBuffer(value),
        ($18.CreateOrUpdateSavingsGoalResponse value) =>
            value.writeToBuffer()));
    $addMethod($grpc.ServiceMethod<$18.GetUpcomingBillsRequest,
            $18.GetUpcomingBillsResponse>(
        'GetUpcomingBills',
        getUpcomingBills_Pre,
        false,
        false,
        ($core.List<$core.int> value) =>
            $18.GetUpcomingBillsRequest.fromBuffer(value),
        ($18.GetUpcomingBillsResponse value) => value.writeToBuffer()));
    $addMethod($grpc.ServiceMethod<$18.CreateRecurringBillRequest,
            $18.CreateRecurringBillResponse>(
        'CreateRecurringBill',
        createRecurringBill_Pre,
        false,
        false,
        ($core.List<$core.int> value) =>
            $18.CreateRecurringBillRequest.fromBuffer(value),
        ($18.CreateRecurringBillResponse value) => value.writeToBuffer()));
  }

  $async.Future<$18.CreateExpenseResponse> createExpense_Pre(
      $grpc.ServiceCall call,
      $async.Future<$18.CreateExpenseRequest> request) async {
    return createExpense(call, await request);
  }

  $async.Future<$18.GetExpensesResponse> getExpenses_Pre($grpc.ServiceCall call,
      $async.Future<$18.GetExpensesRequest> request) async {
    return getExpenses(call, await request);
  }

  $async.Future<$18.GetExpenseByIdResponse> getExpenseById_Pre(
      $grpc.ServiceCall call,
      $async.Future<$18.GetExpenseByIdRequest> request) async {
    return getExpenseById(call, await request);
  }

  $async.Future<$18.UpdateExpenseResponse> updateExpense_Pre(
      $grpc.ServiceCall call,
      $async.Future<$18.UpdateExpenseRequest> request) async {
    return updateExpense(call, await request);
  }

  $async.Future<$18.DeleteExpenseResponse> deleteExpense_Pre(
      $grpc.ServiceCall call,
      $async.Future<$18.DeleteExpenseRequest> request) async {
    return deleteExpense(call, await request);
  }

  $async.Future<$18.CreateBudgetResponse> createBudget_Pre(
      $grpc.ServiceCall call,
      $async.Future<$18.CreateBudgetRequest> request) async {
    return createBudget(call, await request);
  }

  $async.Future<$18.GetBudgetsResponse> getBudgets_Pre($grpc.ServiceCall call,
      $async.Future<$18.GetBudgetsRequest> request) async {
    return getBudgets(call, await request);
  }

  $async.Future<$18.GetBudgetByIdResponse> getBudgetById_Pre(
      $grpc.ServiceCall call,
      $async.Future<$18.GetBudgetByIdRequest> request) async {
    return getBudgetById(call, await request);
  }

  $async.Future<$18.UpdateBudgetResponse> updateBudget_Pre(
      $grpc.ServiceCall call,
      $async.Future<$18.UpdateBudgetRequest> request) async {
    return updateBudget(call, await request);
  }

  $async.Future<$18.DeleteBudgetResponse> deleteBudget_Pre(
      $grpc.ServiceCall call,
      $async.Future<$18.DeleteBudgetRequest> request) async {
    return deleteBudget(call, await request);
  }

  $async.Future<$18.GetSpendingAnalyticsResponse> getSpendingAnalytics_Pre(
      $grpc.ServiceCall call,
      $async.Future<$18.GetSpendingAnalyticsRequest> request) async {
    return getSpendingAnalytics(call, await request);
  }

  $async.Future<$18.GetCategoryBreakdownResponse> getCategoryBreakdown_Pre(
      $grpc.ServiceCall call,
      $async.Future<$18.GetCategoryBreakdownRequest> request) async {
    return getCategoryBreakdown(call, await request);
  }

  $async.Future<$18.GetBudgetProgressResponse> getBudgetProgress_Pre(
      $grpc.ServiceCall call,
      $async.Future<$18.GetBudgetProgressRequest> request) async {
    return getBudgetProgress(call, await request);
  }

  $async.Future<$18.GetSpendingTrendsResponse> getSpendingTrends_Pre(
      $grpc.ServiceCall call,
      $async.Future<$18.GetSpendingTrendsRequest> request) async {
    return getSpendingTrends(call, await request);
  }

  $async.Future<$18.GetBudgetAlertsResponse> getBudgetAlerts_Pre(
      $grpc.ServiceCall call,
      $async.Future<$18.GetBudgetAlertsRequest> request) async {
    return getBudgetAlerts(call, await request);
  }

  $async.Future<$18.MarkAlertAsReadResponse> markAlertAsRead_Pre(
      $grpc.ServiceCall call,
      $async.Future<$18.MarkAlertAsReadRequest> request) async {
    return markAlertAsRead(call, await request);
  }

  $async.Future<$18.GetAISpendingInsightsResponse> getAISpendingInsights_Pre(
      $grpc.ServiceCall call,
      $async.Future<$18.GetAISpendingInsightsRequest> request) async {
    return getAISpendingInsights(call, await request);
  }

  $async.Future<$18.GetAIBudgetingRecommendationsResponse>
      getAIBudgetingRecommendations_Pre(
          $grpc.ServiceCall call,
          $async.Future<$18.GetAIBudgetingRecommendationsRequest>
              request) async {
    return getAIBudgetingRecommendations(call, await request);
  }

  $async.Future<$18.AutoCategorizeExpenseResponse> autoCategorizeExpense_Pre(
      $grpc.ServiceCall call,
      $async.Future<$18.AutoCategorizeExpenseRequest> request) async {
    return autoCategorizeExpense(call, await request);
  }

  $async.Future<$18.GetAIFinancialAdviceResponse> getAIFinancialAdvice_Pre(
      $grpc.ServiceCall call,
      $async.Future<$18.GetAIFinancialAdviceRequest> request) async {
    return getAIFinancialAdvice(call, await request);
  }

  $async.Future<$18.GetIncomeSourcesResponse> getIncomeSources_Pre(
      $grpc.ServiceCall call,
      $async.Future<$18.GetIncomeSourcesRequest> request) async {
    return getIncomeSources(call, await request);
  }

  $async.Future<$18.GetIncomeBreakdownResponse> getIncomeBreakdown_Pre(
      $grpc.ServiceCall call,
      $async.Future<$18.GetIncomeBreakdownRequest> request) async {
    return getIncomeBreakdown(call, await request);
  }

  $async.Future<$18.CreateIncomeSourceResponse> createIncomeSource_Pre(
      $grpc.ServiceCall call,
      $async.Future<$18.CreateIncomeSourceRequest> request) async {
    return createIncomeSource(call, await request);
  }

  $async.Future<$18.GetInvestmentPortfolioResponse> getInvestmentPortfolio_Pre(
      $grpc.ServiceCall call,
      $async.Future<$18.GetInvestmentPortfolioRequest> request) async {
    return getInvestmentPortfolio(call, await request);
  }

  $async.Future<$18.CreateInvestmentResponse> createInvestment_Pre(
      $grpc.ServiceCall call,
      $async.Future<$18.CreateInvestmentRequest> request) async {
    return createInvestment(call, await request);
  }

  $async.Future<$18.GetFinancialGoalsResponse> getFinancialGoals_Pre(
      $grpc.ServiceCall call,
      $async.Future<$18.GetFinancialGoalsRequest> request) async {
    return getFinancialGoals(call, await request);
  }

  $async.Future<$18.CreateFinancialGoalResponse> createFinancialGoal_Pre(
      $grpc.ServiceCall call,
      $async.Future<$18.CreateFinancialGoalRequest> request) async {
    return createFinancialGoal(call, await request);
  }

  $async.Future<$18.UpdateFinancialGoalProgressResponse>
      updateFinancialGoalProgress_Pre($grpc.ServiceCall call,
          $async.Future<$18.UpdateFinancialGoalProgressRequest> request) async {
    return updateFinancialGoalProgress(call, await request);
  }

  $async.Future<$18.GetSavingsGoalResponse> getSavingsGoal_Pre(
      $grpc.ServiceCall call,
      $async.Future<$18.GetSavingsGoalRequest> request) async {
    return getSavingsGoal(call, await request);
  }

  $async.Future<$18.CreateOrUpdateSavingsGoalResponse>
      createOrUpdateSavingsGoal_Pre($grpc.ServiceCall call,
          $async.Future<$18.CreateOrUpdateSavingsGoalRequest> request) async {
    return createOrUpdateSavingsGoal(call, await request);
  }

  $async.Future<$18.GetUpcomingBillsResponse> getUpcomingBills_Pre(
      $grpc.ServiceCall call,
      $async.Future<$18.GetUpcomingBillsRequest> request) async {
    return getUpcomingBills(call, await request);
  }

  $async.Future<$18.CreateRecurringBillResponse> createRecurringBill_Pre(
      $grpc.ServiceCall call,
      $async.Future<$18.CreateRecurringBillRequest> request) async {
    return createRecurringBill(call, await request);
  }

  $async.Future<$18.CreateExpenseResponse> createExpense(
      $grpc.ServiceCall call, $18.CreateExpenseRequest request);
  $async.Future<$18.GetExpensesResponse> getExpenses(
      $grpc.ServiceCall call, $18.GetExpensesRequest request);
  $async.Future<$18.GetExpenseByIdResponse> getExpenseById(
      $grpc.ServiceCall call, $18.GetExpenseByIdRequest request);
  $async.Future<$18.UpdateExpenseResponse> updateExpense(
      $grpc.ServiceCall call, $18.UpdateExpenseRequest request);
  $async.Future<$18.DeleteExpenseResponse> deleteExpense(
      $grpc.ServiceCall call, $18.DeleteExpenseRequest request);
  $async.Future<$18.CreateBudgetResponse> createBudget(
      $grpc.ServiceCall call, $18.CreateBudgetRequest request);
  $async.Future<$18.GetBudgetsResponse> getBudgets(
      $grpc.ServiceCall call, $18.GetBudgetsRequest request);
  $async.Future<$18.GetBudgetByIdResponse> getBudgetById(
      $grpc.ServiceCall call, $18.GetBudgetByIdRequest request);
  $async.Future<$18.UpdateBudgetResponse> updateBudget(
      $grpc.ServiceCall call, $18.UpdateBudgetRequest request);
  $async.Future<$18.DeleteBudgetResponse> deleteBudget(
      $grpc.ServiceCall call, $18.DeleteBudgetRequest request);
  $async.Future<$18.GetSpendingAnalyticsResponse> getSpendingAnalytics(
      $grpc.ServiceCall call, $18.GetSpendingAnalyticsRequest request);
  $async.Future<$18.GetCategoryBreakdownResponse> getCategoryBreakdown(
      $grpc.ServiceCall call, $18.GetCategoryBreakdownRequest request);
  $async.Future<$18.GetBudgetProgressResponse> getBudgetProgress(
      $grpc.ServiceCall call, $18.GetBudgetProgressRequest request);
  $async.Future<$18.GetSpendingTrendsResponse> getSpendingTrends(
      $grpc.ServiceCall call, $18.GetSpendingTrendsRequest request);
  $async.Future<$18.GetBudgetAlertsResponse> getBudgetAlerts(
      $grpc.ServiceCall call, $18.GetBudgetAlertsRequest request);
  $async.Future<$18.MarkAlertAsReadResponse> markAlertAsRead(
      $grpc.ServiceCall call, $18.MarkAlertAsReadRequest request);
  $async.Future<$18.GetAISpendingInsightsResponse> getAISpendingInsights(
      $grpc.ServiceCall call, $18.GetAISpendingInsightsRequest request);
  $async.Future<$18.GetAIBudgetingRecommendationsResponse>
      getAIBudgetingRecommendations($grpc.ServiceCall call,
          $18.GetAIBudgetingRecommendationsRequest request);
  $async.Future<$18.AutoCategorizeExpenseResponse> autoCategorizeExpense(
      $grpc.ServiceCall call, $18.AutoCategorizeExpenseRequest request);
  $async.Future<$18.GetAIFinancialAdviceResponse> getAIFinancialAdvice(
      $grpc.ServiceCall call, $18.GetAIFinancialAdviceRequest request);
  $async.Future<$18.GetIncomeSourcesResponse> getIncomeSources(
      $grpc.ServiceCall call, $18.GetIncomeSourcesRequest request);
  $async.Future<$18.GetIncomeBreakdownResponse> getIncomeBreakdown(
      $grpc.ServiceCall call, $18.GetIncomeBreakdownRequest request);
  $async.Future<$18.CreateIncomeSourceResponse> createIncomeSource(
      $grpc.ServiceCall call, $18.CreateIncomeSourceRequest request);
  $async.Future<$18.GetInvestmentPortfolioResponse> getInvestmentPortfolio(
      $grpc.ServiceCall call, $18.GetInvestmentPortfolioRequest request);
  $async.Future<$18.CreateInvestmentResponse> createInvestment(
      $grpc.ServiceCall call, $18.CreateInvestmentRequest request);
  $async.Future<$18.GetFinancialGoalsResponse> getFinancialGoals(
      $grpc.ServiceCall call, $18.GetFinancialGoalsRequest request);
  $async.Future<$18.CreateFinancialGoalResponse> createFinancialGoal(
      $grpc.ServiceCall call, $18.CreateFinancialGoalRequest request);
  $async.Future<$18.UpdateFinancialGoalProgressResponse>
      updateFinancialGoalProgress($grpc.ServiceCall call,
          $18.UpdateFinancialGoalProgressRequest request);
  $async.Future<$18.GetSavingsGoalResponse> getSavingsGoal(
      $grpc.ServiceCall call, $18.GetSavingsGoalRequest request);
  $async.Future<$18.CreateOrUpdateSavingsGoalResponse>
      createOrUpdateSavingsGoal(
          $grpc.ServiceCall call, $18.CreateOrUpdateSavingsGoalRequest request);
  $async.Future<$18.GetUpcomingBillsResponse> getUpcomingBills(
      $grpc.ServiceCall call, $18.GetUpcomingBillsRequest request);
  $async.Future<$18.CreateRecurringBillResponse> createRecurringBill(
      $grpc.ServiceCall call, $18.CreateRecurringBillRequest request);
}
