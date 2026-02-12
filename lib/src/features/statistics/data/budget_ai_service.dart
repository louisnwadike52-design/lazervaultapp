import 'package:dio/dio.dart';

/// AI-powered budget insights response
class BudgetAIInsightsResponse {
  final String summary;
  final List<BudgetRecommendationItem> budgetRecommendations;
  final List<String> savingsOpportunities;
  final List<String> spendingPatterns;
  final double recommendedSavingsRate;
  final String monthlyProjection;
  final String rationale;

  BudgetAIInsightsResponse({
    required this.summary,
    required this.budgetRecommendations,
    required this.savingsOpportunities,
    required this.spendingPatterns,
    required this.recommendedSavingsRate,
    required this.monthlyProjection,
    required this.rationale,
  });

  factory BudgetAIInsightsResponse.fromJson(Map<String, dynamic> json) {
    return BudgetAIInsightsResponse(
      summary: json['summary'] as String? ?? '',
      budgetRecommendations: (json['budget_recommendations'] as List?)
              ?.map((item) => BudgetRecommendationItem.fromJson(item as Map<String, dynamic>))
              .toList() ??
          [],
      savingsOpportunities: (json['savings_opportunities'] as List?)
              ?.map((e) => e.toString())
              .toList() ??
          [],
      spendingPatterns: (json['spending_patterns'] as List?)
              ?.map((e) => e.toString())
              .toList() ??
          [],
      recommendedSavingsRate:
          (json['recommended_savings_rate'] as num?)?.toDouble() ?? 0.0,
      monthlyProjection: json['monthly_projection'] as String? ?? '',
      rationale: json['rationale'] as String? ?? '',
    );
  }

  Map<String, dynamic> toJson() {
    return {
      'summary': summary,
      'budget_recommendations':
          budgetRecommendations.map((r) => r.toJson()).toList(),
      'savings_opportunities': savingsOpportunities,
      'spending_patterns': spendingPatterns,
      'recommended_savings_rate': recommendedSavingsRate,
      'monthly_projection': monthlyProjection,
      'rationale': rationale,
    };
  }
}

/// Individual budget recommendation
class BudgetRecommendationItem {
  final String category;
  final String categoryName;
  final double recommendedAmount;
  final double currentAmount;
  final double difference;
  final String reasoning;

  BudgetRecommendationItem({
    required this.category,
    required this.categoryName,
    required this.recommendedAmount,
    required this.currentAmount,
    required this.difference,
    required this.reasoning,
  });

  factory BudgetRecommendationItem.fromJson(Map<String, dynamic> json) {
    return BudgetRecommendationItem(
      category: json['category'] as String? ?? '',
      categoryName: json['category_name'] as String? ?? '',
      recommendedAmount:
          (json['recommended_amount'] as num?)?.toDouble() ?? 0.0,
      currentAmount: (json['current_amount'] as num?)?.toDouble() ?? 0.0,
      difference: (json['difference'] as num?)?.toDouble() ?? 0.0,
      reasoning: json['reasoning'] as String? ?? '',
    );
  }

  Map<String, dynamic> toJson() {
    return {
      'category': category,
      'category_name': categoryName,
      'recommended_amount': recommendedAmount,
      'current_amount': currentAmount,
      'difference': difference,
      'reasoning': reasoning,
    };
  }
}

/// Service for generating AI-powered budget insights
/// Communicates with chat-agent-gateway POST /api/budget/ai-insights
class BudgetAIService {
  final Dio _dio;
  final String _baseUrl;
  final Future<String> Function() _getAccessToken;

  BudgetAIService({
    required Dio dio,
    required String baseUrl,
    required Future<String> Function() getAccessToken,
  })  : _dio = dio,
        _baseUrl = baseUrl,
        _getAccessToken = getAccessToken;

  /// Generate AI insights for budget planning
  Future<BudgetAIInsightsResponse> getAIInsights({
    required double monthlyIncome,
    required List<Map<String, dynamic>> spendingData,
    required List<Map<String, dynamic>> activeBudgets,
    required List<String> goals,
    required String riskTolerance,
    String currency = 'NGN',
    int monthsOfData = 3,
  }) async {
    try {
      final accessToken = await _getAccessToken();

      final response = await _dio.post(
        '$_baseUrl/api/budget/ai-insights',
        data: {
          'monthly_income': monthlyIncome,
          'spending_data': spendingData,
          'active_budgets': activeBudgets,
          'financial_goals': goals,
          'risk_tolerance': riskTolerance,
          'currency': currency,
          'months_of_data': monthsOfData,
        },
        options: Options(
          headers: {
            'Authorization': 'Bearer $accessToken',
            'Content-Type': 'application/json',
          },
          sendTimeout: const Duration(seconds: 30),
          receiveTimeout: const Duration(seconds: 30),
        ),
      );

      if (response.statusCode == 200) {
        return BudgetAIInsightsResponse.fromJson(
            response.data as Map<String, dynamic>);
      }

      throw DioException(
        requestOptions: response.requestOptions,
        response: response,
        message: 'Failed to generate AI insights: ${response.statusCode}',
      );
    } on DioException catch (e) {
      if (e.type == DioExceptionType.connectionTimeout ||
          e.type == DioExceptionType.receiveTimeout) {
        throw Exception('AI insights request timed out. Please try again.');
      }
      rethrow;
    }
  }
}
