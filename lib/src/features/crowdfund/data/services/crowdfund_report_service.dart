import 'package:dio/dio.dart';
import 'package:share_plus/share_plus.dart';
import 'package:url_launcher/url_launcher.dart';
import '../../domain/entities/crowdfund_entities.dart';

/// Service for generating and sharing AI-powered crowdfund campaign reports
/// Communicates with chat-agent-gateway which routes to financial-products-chatagent
class CrowdfundReportService {
  final Dio _dio;
  final String _baseUrl;
  final Future<String> Function() _getAccessToken;
  final String Function() _getUserId;

  CrowdfundReportService({
    required Dio dio,
    required String baseUrl,
    required Future<String> Function() getAccessToken,
    required String Function() getUserId,
  })  : _dio = dio,
        _baseUrl = baseUrl,
        _getAccessToken = getAccessToken,
        _getUserId = getUserId;

  /// Generate an AI-powered campaign report
  ///
  /// [crowdfund] - The crowdfund campaign to generate a report for
  /// [statistics] - Campaign statistics for context
  /// [contributions] - Recent contributions for highlights
  /// [reportType] - Type of report: 'progress', 'milestone', or 'completion'
  Future<CrowdfundReport> generateReport({
    required Crowdfund crowdfund,
    required CrowdfundStatistics statistics,
    List<CrowdfundDonation>? contributions,
    String reportType = 'progress',
  }) async {
    try {
      final userId = _getUserId();
      final accessToken = await _getAccessToken();

      // Build context for AI report generation
      final context = {
        'title': crowdfund.title,
        'description': crowdfund.description,
        'story': crowdfund.story,
        'category': crowdfund.category,
        'currency': crowdfund.currency,
        'target_amount': crowdfund.targetAmount,
        'current_amount': crowdfund.currentAmount,
        'progress_percentage': statistics.progressPercentage,
        'donor_count': statistics.donorCount,
        'average_donation': statistics.averageDonation,
        'largest_donation': statistics.largestDonation,
        'days_remaining': statistics.daysRemaining,
        'is_completed': statistics.isCompleted,
        'creator_name': crowdfund.creator.fullName,
        'creator_verified': crowdfund.creator.verified,
        'contributions': contributions
                ?.take(10)
                .map((c) => {
                      'amount': c.amount,
                      'currency': c.currency,
                      'message': c.message,
                      'is_anonymous': c.isAnonymous,
                      'donor_name': c.isAnonymous ? 'Anonymous' : c.donor.displayName,
                      'date': c.donationDate.toIso8601String(),
                    })
                .toList() ??
            [],
      };

      final response = await _dio.post(
        '$_baseUrl/api/crowdfund/report',
        data: {
          'crowdfund_id': crowdfund.id,
          'user_id': userId,
          'context': context,
          'report_type': reportType,
          'model': 'gpt-4',
        },
        options: Options(
          headers: {
            'Content-Type': 'application/json',
            'Authorization': 'Bearer $accessToken',
          },
        ),
      );

      if (response.statusCode == 200) {
        return CrowdfundReport.fromJson(response.data as Map<String, dynamic>);
      } else {
        throw ReportGenerationException(
          'Failed to generate report: ${response.statusMessage}',
        );
      }
    } on DioException catch (e) {
      if (e.type == DioExceptionType.connectionTimeout ||
          e.type == DioExceptionType.receiveTimeout) {
        throw ReportGenerationException(
          'Report generation timed out. Please try again.',
        );
      }
      throw ReportGenerationException(
        'Network error: ${e.message}',
      );
    } catch (e) {
      if (e is ReportGenerationException) rethrow;
      throw ReportGenerationException('Error generating report: $e');
    }
  }

  /// Share report to WhatsApp
  Future<void> shareToWhatsApp(CrowdfundReport report, String? campaignUrl) async {
    final text = _buildShareText(report.sharingText.whatsapp, campaignUrl);
    final whatsappUrl = Uri.parse(
      'whatsapp://send?text=${Uri.encodeComponent(text)}',
    );

    if (await canLaunchUrl(whatsappUrl)) {
      await launchUrl(whatsappUrl);
    } else {
      // Fallback to web WhatsApp
      final webUrl = Uri.parse(
        'https://wa.me/?text=${Uri.encodeComponent(text)}',
      );
      await launchUrl(webUrl, mode: LaunchMode.externalApplication);
    }
  }

  /// Share report to Facebook
  Future<void> shareToFacebook(CrowdfundReport report, String? campaignUrl) async {
    if (campaignUrl != null) {
      final facebookUrl = Uri.parse(
        'https://www.facebook.com/sharer/sharer.php?u=${Uri.encodeComponent(campaignUrl)}&quote=${Uri.encodeComponent(report.sharingText.facebook)}',
      );
      await launchUrl(facebookUrl, mode: LaunchMode.externalApplication);
    } else {
      // Fallback to general share
      await shareGeneral(report, campaignUrl);
    }
  }

  /// Share report to Telegram
  Future<void> shareToTelegram(CrowdfundReport report, String? campaignUrl) async {
    final text = _buildShareText(report.sharingText.telegram, campaignUrl);
    final telegramUrl = Uri.parse(
      'https://t.me/share/url?url=${Uri.encodeComponent(campaignUrl ?? '')}&text=${Uri.encodeComponent(text)}',
    );

    if (await canLaunchUrl(telegramUrl)) {
      await launchUrl(telegramUrl, mode: LaunchMode.externalApplication);
    } else {
      await shareGeneral(report, campaignUrl);
    }
  }

  /// Share report to Twitter/X
  Future<void> shareToTwitter(CrowdfundReport report, String? campaignUrl) async {
    final text = _buildShareText(report.sharingText.twitter, campaignUrl);
    final hashtags = report.hashtags.join(',');
    final twitterUrl = Uri.parse(
      'https://twitter.com/intent/tweet?text=${Uri.encodeComponent(text)}&hashtags=$hashtags',
    );

    await launchUrl(twitterUrl, mode: LaunchMode.externalApplication);
  }

  /// General share using system share sheet
  Future<void> shareGeneral(CrowdfundReport report, String? campaignUrl) async {
    final text = _buildShareText(report.sharingText.general, campaignUrl);

    await SharePlus.instance.share(ShareParams(
      text: text,
      subject: report.title,
    ));
  }

  /// Copy report text to clipboard
  String getShareableText(CrowdfundReport report, String? campaignUrl) {
    return _buildShareText(report.sharingText.general, campaignUrl);
  }

  String _buildShareText(String baseText, String? campaignUrl) {
    if (campaignUrl != null && campaignUrl.isNotEmpty) {
      return '$baseText\n\n$campaignUrl';
    }
    return baseText;
  }
}

/// Exception thrown when report generation fails
class ReportGenerationException implements Exception {
  final String message;

  ReportGenerationException(this.message);

  @override
  String toString() => message;
}
