import 'package:dio/dio.dart';
import '../../domain/entities/credit_score.dart';
import '../../domain/entities/credit_score_ai_insights.dart';

/// Service for generating AI-powered credit score insights
/// Communicates with chat-agent-gateway POST /api/credit-score/ai-insights
class CreditScoreAIService {
  final Dio _dio;
  final String _baseUrl;
  final Future<String> Function() _getAccessToken;

  CreditScoreAIService({
    required Dio dio,
    required String baseUrl,
    required Future<String> Function() getAccessToken,
  })  : _dio = dio,
        _baseUrl = baseUrl,
        _getAccessToken = getAccessToken;

  /// Generate AI insights for a credit score
  Future<CreditScoreAIInsights> getAIInsights(CreditScoreEntity score) async {
    try {
      final accessToken = await _getAccessToken();

      final factors = <Map<String, dynamic>>[
        {'name': 'Payment History', 'score': score.paymentHistoryScore, 'weight': 35},
        {'name': 'Income Stability', 'score': score.incomeStabilityScore, 'weight': 25},
        {'name': 'Spending Discipline', 'score': score.spendingDisciplineScore, 'weight': 20},
        {'name': 'Account Age', 'score': score.accountAgeScore, 'weight': 10},
        {'name': 'Balance Consistency', 'score': score.balanceConsistencyScore, 'weight': 10},
      ];

      final tips = score.tips.map((t) => t.title).toList();

      final response = await _dio.post(
        '$_baseUrl/api/credit-score/ai-insights',
        data: {
          'score': score.score,
          'rating': score.rating,
          'factors': factors,
          'tips': tips,
          'transactions_analyzed': score.transactionsAnalyzed,
          'months_of_data': score.monthsOfData,
          'bank_name': score.bankName,
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
        return CreditScoreAIInsights.fromJson(response.data as Map<String, dynamic>);
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
