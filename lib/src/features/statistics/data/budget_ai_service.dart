import 'package:dio/dio.dart';
import 'package:lazervault/core/services/secure_storage_service.dart';
import 'package:lazervault/core/utils/api_headers.dart';

/// AI-powered budget insights response
class BudgetAIInsightsResponse {
  final String summary;
  final List<BudgetRecommendationItem> budgetRecommendations;
  final List<String> savingsOpportunities;
  final Map<String, dynamic> spendingPatterns;
  final double recommendedSavingsRate;
  final String riskLevel;
  final List<CategoryInsightItem> categoryInsights;

  BudgetAIInsightsResponse({
    required this.summary,
    required this.budgetRecommendations,
    required this.savingsOpportunities,
    required this.spendingPatterns,
    required this.recommendedSavingsRate,
    required this.riskLevel,
    required this.categoryInsights,
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
      spendingPatterns: (json['spending_patterns'] as Map<String, dynamic>?) ?? {},
      recommendedSavingsRate:
          (json['recommended_savings_rate'] as num?)?.toDouble() ?? 0.0,
      riskLevel: json['risk_level'] as String? ?? 'moderate',
      categoryInsights: (json['category_insights'] as List?)
              ?.map((item) => CategoryInsightItem.fromJson(item as Map<String, dynamic>))
              .toList() ??
          [],
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
      'risk_level': riskLevel,
      'category_insights':
          categoryInsights.map((c) => c.toJson()).toList(),
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

/// Sub-category insight item
class SubCategoryInsightItem {
  final String name;
  final double amount;
  final String insight;

  SubCategoryInsightItem({
    required this.name,
    required this.amount,
    required this.insight,
  });

  factory SubCategoryInsightItem.fromJson(Map<String, dynamic> json) {
    return SubCategoryInsightItem(
      name: json['name'] as String? ?? '',
      amount: (json['amount'] as num?)?.toDouble() ?? 0.0,
      insight: json['insight'] as String? ?? '',
    );
  }

  Map<String, dynamic> toJson() {
    return {'name': name, 'amount': amount, 'insight': insight};
  }
}

/// Per-category deep-dive insight with sub-category breakdowns
class CategoryInsightItem {
  final String categoryName;
  final String analysis;
  final List<SubCategoryInsightItem> subCategories;
  final List<String> actionItems;

  CategoryInsightItem({
    required this.categoryName,
    required this.analysis,
    required this.subCategories,
    required this.actionItems,
  });

  factory CategoryInsightItem.fromJson(Map<String, dynamic> json) {
    return CategoryInsightItem(
      categoryName: json['category_name'] as String? ?? '',
      analysis: json['analysis'] as String? ?? '',
      subCategories: (json['sub_categories'] as List?)
              ?.map((item) => SubCategoryInsightItem.fromJson(item as Map<String, dynamic>))
              .toList() ??
          [],
      actionItems: (json['action_items'] as List?)
              ?.map((e) => e.toString())
              .toList() ??
          [],
    );
  }

  Map<String, dynamic> toJson() {
    return {
      'category_name': categoryName,
      'analysis': analysis,
      'sub_categories': subCategories.map((s) => s.toJson()).toList(),
      'action_items': actionItems,
    };
  }
}

/// Service for generating AI-powered budget insights
/// Communicates with chat-agent-gateway POST /api/budget/ai-insights
class BudgetAIService {
  final Dio _dio;
  final String _baseUrl;
  final SecureStorageService _secureStorage;

  BudgetAIService({
    required Dio dio,
    required String baseUrl,
    required SecureStorageService secureStorage,
  })  : _dio = dio,
        _baseUrl = baseUrl,
        _secureStorage = secureStorage;

  /// Generate AI insights for budget planning
  Future<BudgetAIInsightsResponse> getAIInsights({
    required double monthlyIncome,
    required List<Map<String, dynamic>> spendingData,
    required List<Map<String, dynamic>> activeBudgets,
    required List<String> goals,
    required String riskTolerance,
    String currency = 'NGN',
    int monthsOfData = 3,
    List<Map<String, dynamic>> financialGoals = const [],
    List<Map<String, dynamic>> upcomingBills = const [],
    List<Map<String, dynamic>> budgetAlerts = const [],
    List<Map<String, dynamic>> failedTransactions = const [],
  }) async {
    try {
      final headers = await ApiHeaders.build(secureStorage: _secureStorage);

      final response = await _dio.post(
        '$_baseUrl/api/budget/ai-insights',
        data: {
          'monthly_income': monthlyIncome,
          'spending_data': spendingData,
          'active_budgets': activeBudgets,
          'goals': goals,
          'financial_goals': financialGoals,
          'upcoming_bills': upcomingBills,
          'budget_alerts': budgetAlerts,
          'failed_transactions': failedTransactions,
          'risk_tolerance': riskTolerance,
          'currency': currency,
          'months_of_data': monthsOfData,
        },
        options: Options(
          headers: headers,
          sendTimeout: const Duration(seconds: 60),
          receiveTimeout: const Duration(seconds: 60),
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
