import 'package:dio/dio.dart';
import 'package:share_plus/share_plus.dart';
import 'package:url_launcher/url_launcher.dart';
import '../domain/entities/group_entities.dart';

/// Service for generating and sharing AI-powered group account reports
/// Communicates with chat-agent-gateway which routes to the AI agent
class GroupAccountReportService {
  final Dio _dio;
  final String _baseUrl;
  final Future<String> Function() _getAccessToken;
  final String Function() _getUserId;

  GroupAccountReportService({
    required Dio dio,
    required String baseUrl,
    required Future<String> Function() getAccessToken,
    required String Function() getUserId,
  })  : _dio = dio,
        _baseUrl = baseUrl,
        _getAccessToken = getAccessToken,
        _getUserId = getUserId;

  /// Generate an AI-powered group report
  ///
  /// [group] - The group to generate a report for
  /// [contributions] - List of contributions in the group
  /// [reportType] - Type of report: 'creation', 'social_linked', 'contribution_created', 'payment_made'
  /// [payment] - Optional payment details for payment_made reports
  Future<GroupAccountReport> generateReport({
    required GroupAccount group,
    required List<Contribution> contributions,
    List<GroupMember>? members,
    String reportType = 'creation',
    ContributionPayment? payment,
  }) async {
    try {
      final userId = _getUserId();
      final accessToken = await _getAccessToken();

      // Build context for AI report generation
      final context = {
        'group_id': group.id,
        'group_name': group.name,
        'description': group.description,
        'admin_id': group.adminId,
        'status': group.status.toString(),
        'member_count': members?.length ?? group.members.length,
        'created_at': group.createdAt.toIso8601String(),
        'metadata': group.metadata,
        'contributions': contributions.map((c) => {
          'id': c.id,
          'title': c.title,
          'description': c.description,
          'target_amount': c.targetAmount,
          'current_amount': c.currentAmount,
          'currency': c.currency,
          'deadline': c.deadline.toIso8601String(),
          'type': c.type.toString(),
          'status': c.status.toString(),
          'created_by': c.createdBy,
          'member_count': c.members.length,
          'created_at': c.createdAt.toIso8601String(),
        }).toList(),
        'report_type': reportType,
      };

      // Add payment info if provided
      if (payment != null) {
        context['payment'] = {
          'amount': payment.amount,
          'currency': payment.currency,
          'payment_date': payment.paymentDate.toIso8601String(),
          'status': payment.status.toString(),
          'contributor_name': payment.userName,
        };
      }

      // Add social media links if present
      final externalLinks = <String, dynamic>{};
      if (group.metadata != null) {
        if (group.metadata!['whatsapp_group_link'] != null) {
          externalLinks['whatsapp'] = group.metadata!['whatsapp_group_link'];
        }
        if (group.metadata!['telegram_group_link'] != null) {
          externalLinks['telegram'] = group.metadata!['telegram_group_link'];
        }
      }
      if (externalLinks.isNotEmpty) {
        context['social_links'] = externalLinks;
      }

      final response = await _dio.post(
        '$_baseUrl/api/group-account/report',
        data: {
          'group_id': group.id,
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
        return GroupAccountReport.fromJson(response.data as Map<String, dynamic>);
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
  Future<void> shareToWhatsApp(GroupAccountReport report, {String? groupUrl}) async {
    final text = _buildShareText(report.sharingText['whatsapp'] ?? report.summary, groupUrl);
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

  /// Share report to Telegram
  Future<void> shareToTelegram(GroupAccountReport report, {String? groupUrl}) async {
    final text = _buildShareText(report.sharingText['telegram'] ?? report.summary, groupUrl);
    final telegramUrl = Uri.parse(
      'https://t.me/share/url?url=${Uri.encodeComponent(groupUrl ?? '')}&text=${Uri.encodeComponent(text)}',
    );

    if (await canLaunchUrl(telegramUrl)) {
      await launchUrl(telegramUrl, mode: LaunchMode.externalApplication);
    } else {
      await shareGeneral(report, groupUrl: groupUrl);
    }
  }

  /// Share report to Facebook
  Future<void> shareToFacebook(GroupAccountReport report, {String? groupUrl}) async {
    if (groupUrl != null) {
      final facebookUrl = Uri.parse(
        'https://www.facebook.com/sharer/sharer.php?u=${Uri.encodeComponent(groupUrl)}&quote=${Uri.encodeComponent(report.summary)}',
      );
      await launchUrl(facebookUrl, mode: LaunchMode.externalApplication);
    } else {
      await shareGeneral(report, groupUrl: groupUrl);
    }
  }

  /// Share report to Twitter/X
  Future<void> shareToTwitter(GroupAccountReport report, {String? groupUrl}) async {
    final text = _buildShareText(report.sharingText['twitter'] ?? report.summary, groupUrl);
    final hashtags = report.hashtags.join(',');
    final twitterUrl = Uri.parse(
      'https://twitter.com/intent/tweet?text=${Uri.encodeComponent(text)}&hashtags=$hashtags',
    );

    await launchUrl(twitterUrl, mode: LaunchMode.externalApplication);
  }

  /// General share using system share sheet
  Future<void> shareGeneral(GroupAccountReport report, {String? groupUrl}) async {
    final text = _buildShareText(report.sharingText['general'] ?? report.summary, groupUrl);

    await SharePlus.instance.share(ShareParams(
      text: text,
      subject: report.title,
    ));
  }

  /// Copy report text to clipboard
  String getShareableText(GroupAccountReport report, {String? groupUrl}) {
    return _buildShareText(report.sharingText['general'] ?? report.summary, groupUrl);
  }

  String _buildShareText(String baseText, String? groupUrl) {
    if (groupUrl != null && groupUrl.isNotEmpty) {
      return '$baseText\n\n$groupUrl';
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
