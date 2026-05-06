import 'package:dio/dio.dart';

import '../../utils/donor_rating_calculator.dart';

/// Calls the chat-agent-gateway's `/api/crowdfund/donor-rating` endpoint
/// to produce an AI-driven donor rating. Lazy: only invoked when the
/// donor detail modal opens, never during the donations list paint.
///
/// On any failure (no LLM configured, network error, JSON parse error)
/// the gateway already returns a deterministic rule-based response with
/// `success=true` and `error=<reason>`. We map that into the same
/// [DonorRating] entity the rest of the UI consumes.
class CrowdfundDonorRatingService {
  final Dio _dio;
  final String _baseUrl;
  final Future<String> Function() _getAccessToken;

  CrowdfundDonorRatingService({
    required Dio dio,
    required String baseUrl,
    required Future<String> Function() getAccessToken,
  })  : _dio = dio,
        _baseUrl = baseUrl,
        _getAccessToken = getAccessToken;

  Future<DonorRating> fetchRating({
    required String crowdfundId,
    required String donorUserId,
    required String displayName,
    required String currency,
    required DonorRatingMetrics metrics,
  }) async {
    try {
      final accessToken = await _getAccessToken();
      final response = await _dio.post(
        '$_baseUrl/api/crowdfund/donor-rating',
        data: {
          'crowdfund_id': crowdfundId,
          'donor_user_id': donorUserId,
          'display_name': displayName,
          'currency': currency,
          'metrics': metrics.toJson(),
        },
        options: Options(
          headers: {
            'Content-Type': 'application/json',
            if (accessToken.isNotEmpty) 'Authorization': 'Bearer $accessToken',
          },
        ),
      );

      if (response.statusCode == 200 && response.data is Map<String, dynamic>) {
        return _ratingFromJson(response.data as Map<String, dynamic>);
      }
      throw DonorRatingException('Unexpected ${response.statusCode}');
    } on DioException catch (e) {
      if (e.type == DioExceptionType.connectionTimeout ||
          e.type == DioExceptionType.receiveTimeout) {
        throw DonorRatingException('Donor rating timed out. Tap to retry.');
      }
      throw DonorRatingException('Network error: ${e.message ?? 'unknown'}');
    } catch (e) {
      if (e is DonorRatingException) rethrow;
      throw DonorRatingException('Donor rating failed: $e');
    }
  }

  DonorRating _ratingFromJson(Map<String, dynamic> json) {
    final overall = (json['overall_score'] as num?)?.toDouble() ?? 1.0;
    final star = (json['star_count'] as num?)?.toInt() ?? overall.round();
    return DonorRating(
      overallScore: overall.clamp(1.0, 5.0),
      starCount: star.clamp(1, 5),
      generosityScore:
          ((json['generosity_score'] as num?)?.toDouble() ?? 0.0).clamp(0.0, 1.0),
      repeatSupportScore: ((json['repeat_support_score'] as num?)?.toDouble() ?? 0.0)
          .clamp(0.0, 1.0),
      engagementScore:
          ((json['engagement_score'] as num?)?.toDouble() ?? 0.0).clamp(0.0, 1.0),
      earlySupportScore: ((json['early_support_score'] as num?)?.toDouble() ?? 0.0)
          .clamp(0.0, 1.0),
      label: (json['label'] as String?)?.trim().isNotEmpty == true
          ? json['label'] as String
          : 'Supporter',
      summary: (json['summary'] as String?) ?? '',
      traits: (json['traits'] as List<dynamic>?)
              ?.map((e) => e.toString())
              .where((e) => e.isNotEmpty)
              .toList(growable: false) ??
          const <String>[],
    );
  }
}

/// Donor metrics computed client-side from the donations already loaded
/// for the campaign. These match the DonorMetrics shape on the backend
/// (snake_case) and cap at the field boundaries so a malformed campaign
/// can't poison the prompt.
class DonorRatingMetrics {
  final double totalDonated;
  final int contributionCount;
  final bool hasMessage;
  final bool isAnonymous;
  final bool isCreator;
  final int daysSinceFirstDonation;
  final int daysSinceLastDonation;
  final int firstDonationOffsetDays;
  final double campaignAverageDonation;
  final double campaignLargestDonation;
  final int campaignTotalDonors;
  final int campaignAgeDays;

  const DonorRatingMetrics({
    required this.totalDonated,
    required this.contributionCount,
    required this.hasMessage,
    required this.isAnonymous,
    required this.isCreator,
    required this.daysSinceFirstDonation,
    required this.daysSinceLastDonation,
    required this.firstDonationOffsetDays,
    required this.campaignAverageDonation,
    required this.campaignLargestDonation,
    required this.campaignTotalDonors,
    required this.campaignAgeDays,
  });

  Map<String, dynamic> toJson() => {
        'total_donated': totalDonated,
        'contribution_count': contributionCount,
        'has_message': hasMessage,
        'is_anonymous': isAnonymous,
        'is_creator': isCreator,
        'days_since_first_donation': daysSinceFirstDonation,
        'days_since_last_donation': daysSinceLastDonation,
        'first_donation_offset_days': firstDonationOffsetDays,
        'campaign_average_donation': campaignAverageDonation,
        'campaign_largest_donation': campaignLargestDonation,
        'campaign_total_donors': campaignTotalDonors,
        'campaign_age_days': campaignAgeDays,
      };
}

class DonorRatingException implements Exception {
  final String message;
  DonorRatingException(this.message);
  @override
  String toString() => message;
}
