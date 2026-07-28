import 'package:dio/dio.dart';
import 'package:flutter/widgets.dart';
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

      if (response.statusCode == 200 && response.data is Map<String, dynamic>) {
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
    final text = _buildShareText(report.sharingText.whatsapp, report, campaignUrl);
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
  Future<void> shareToFacebook(CrowdfundReport report, String? campaignUrl,
      {Rect? sharePositionOrigin}) async {
    if (campaignUrl != null) {
      final facebookUrl = Uri.parse(
        'https://www.facebook.com/sharer/sharer.php?u=${Uri.encodeComponent(campaignUrl)}&quote=${Uri.encodeComponent(report.sharingText.facebook)}',
      );
      await launchUrl(facebookUrl, mode: LaunchMode.externalApplication);
    } else {
      // Fallback to general share (carry the iOS anchor rect through).
      await shareGeneral(report, campaignUrl,
          sharePositionOrigin: sharePositionOrigin);
    }
  }

  /// Share report to Telegram
  Future<void> shareToTelegram(CrowdfundReport report, String? campaignUrl,
      {Rect? sharePositionOrigin}) async {
    final text = _buildShareText(report.sharingText.telegram, report, campaignUrl);
    final telegramUrl = Uri.parse(
      'https://t.me/share/url?url=${Uri.encodeComponent(campaignUrl ?? '')}&text=${Uri.encodeComponent(text)}',
    );

    if (await canLaunchUrl(telegramUrl)) {
      await launchUrl(telegramUrl, mode: LaunchMode.externalApplication);
    } else {
      await shareGeneral(report, campaignUrl,
          sharePositionOrigin: sharePositionOrigin);
    }
  }

  /// Share report to Twitter/X
  Future<void> shareToTwitter(CrowdfundReport report, String? campaignUrl) async {
    final text = _buildShareText(report.sharingText.twitter, report, campaignUrl);
    final hashtags = report.hashtags.join(',');
    final twitterUrl = Uri.parse(
      'https://twitter.com/intent/tweet?text=${Uri.encodeComponent(text)}&hashtags=$hashtags',
    );

    await launchUrl(twitterUrl, mode: LaunchMode.externalApplication);
  }

  /// General share using system share sheet.
  ///
  /// [sharePositionOrigin] is REQUIRED on iOS/iPad — share_plus throws
  /// `PlatformException("sharePositionOrigin: argument must be set …")` when the
  /// anchor rect is unset/zero (the "Failed to share" the user hit). Callers pass
  /// the tapped widget's global rect via [shareOriginFromContext]; a null/zero
  /// value falls back to a small valid rect so the sheet still opens.
  Future<void> shareGeneral(
    CrowdfundReport report,
    String? campaignUrl, {
    Rect? sharePositionOrigin,
  }) async {
    final text = _buildShareText(report.sharingText.general, report, campaignUrl);

    await SharePlus.instance.share(ShareParams(
      text: text,
      subject: report.title,
      sharePositionOrigin: resolveShareOrigin(sharePositionOrigin),
    ));
  }

  /// The full report text for copy-to-clipboard. Robust: never returns an empty
  /// string just because the AI left `sharingText.general` blank.
  String getShareableText(CrowdfundReport report, String? campaignUrl) {
    return _buildShareText(report.sharingText.general, report, campaignUrl);
  }

  /// Compose the shareable text. Prefers the platform-specific [baseText]; when
  /// it's blank, falls back to a composed message from the report body so share
  /// AND copy always produce meaningful content (not an empty clipboard).
  String _buildShareText(
      String baseText, CrowdfundReport report, String? campaignUrl) {
    var body = baseText.trim();
    if (body.isEmpty) {
      final parts = <String>[
        if (report.title.trim().isNotEmpty) report.title.trim(),
        if (report.summary.trim().isNotEmpty) report.summary.trim(),
        if (report.callToAction.trim().isNotEmpty) report.callToAction.trim(),
      ];
      body = parts.join('\n\n');
    }
    if (report.hashtags.isNotEmpty) {
      final tags = report.hashtags
          .map((t) => t.startsWith('#') ? t : '#$t')
          .join(' ');
      body = body.isEmpty ? tags : '$body\n\n$tags';
    }
    if (campaignUrl != null && campaignUrl.isNotEmpty) {
      body = body.isEmpty ? campaignUrl : '$body\n\n$campaignUrl';
    }
    return body;
  }

  // ── iOS share-sheet anchor ────────────────────────────────────────────
  // share_plus on iOS REQUIRES a non-zero `sharePositionOrigin` (the rect the
  // share popover anchors to). An unset/zero rect throws the "argument must be
  // set, {{0,0},{0,0}} must be non-zero" PlatformException.
  static Rect resolveShareOrigin(Rect? origin) {
    if (origin != null && origin.width > 0 && origin.height > 0) return origin;
    return const Rect.fromLTWH(0, 0, 1, 1);
  }

  /// Build a share-sheet anchor rect from a widget's [context] (its global
  /// bounds). Returns null when the render box isn't ready.
  static Rect? shareOriginFromContext(BuildContext context) {
    final obj = context.findRenderObject();
    if (obj is RenderBox && obj.hasSize) {
      return obj.localToGlobal(Offset.zero) & obj.size;
    }
    return null;
  }
}

/// Exception thrown when report generation fails
class ReportGenerationException implements Exception {
  final String message;

  ReportGenerationException(this.message);

  @override
  String toString() => message;
}
