import 'dart:async';
import 'dart:convert';

import 'package:http/http.dart' as http;

/// AI-generated coverage summary returned by chat-agent-gateway.
///
/// The gateway's `/api/insurance/coverage-summary` endpoint takes the
/// raw HTML coverage description MyCover.ai provides and returns a
/// 2-3 sentence plain-text summary + 3-5 short benefit bullets — so
/// the quote-review screen never has to render HTML.
class CoverageSummary {
  final String summary;
  final List<String> bullets;

  /// `'llm'` when the model generated this, `'fallback'` when the
  /// gateway used the extractive fallback (LLM unavailable). Both are
  /// safe to render; this field is informational so we can subtly
  /// flag fallback summaries in tests / debugging.
  final String source;

  const CoverageSummary({
    required this.summary,
    required this.bullets,
    required this.source,
  });

  factory CoverageSummary.fromJson(Map<String, dynamic> json) {
    return CoverageSummary(
      summary: (json['summary'] as String?) ?? '',
      bullets: (json['bullets'] as List?)?.cast<String>() ?? const [],
      source: (json['source'] as String?) ?? 'unknown',
    );
  }
}

/// Thin client over the chat-agent-gateway coverage-summary endpoint.
/// Stateless; safe to instantiate per call.
class CoverageSummaryService {
  /// Defaults match the chat-agent-gateway URL used elsewhere (see
  /// crowdfund donor-rating client at
  /// `CrowdfundCampaignDetail.tsx:512` for the admin counterpart).
  /// Override at construction for tests.
  final String baseUrl;
  final Duration timeout;

  CoverageSummaryService({
    String? baseUrl,
    this.timeout = const Duration(seconds: 15),
  }) : baseUrl = baseUrl ?? _defaultBaseUrl();

  /// Android emulator can't reach `localhost`; it routes host loopback
  /// to `10.0.2.2`. Use that for dev; production should override via
  /// `--dart-define=CHAT_GATEWAY_URL=…`.
  static String _defaultBaseUrl() {
    const fromEnv = String.fromEnvironment('CHAT_GATEWAY_URL', defaultValue: '');
    if (fromEnv.isNotEmpty) return fromEnv;
    return 'http://10.0.2.2:3011';
  }

  Future<CoverageSummary> summarize({
    required String productId,
    required String productName,
    required String providerName,
    required String category,
    required String coverageSummary,
    required List<String> coverageItems,
    required String currency,
  }) async {
    final uri = Uri.parse('$baseUrl/api/insurance/coverage-summary');
    final res = await http
        .post(
          uri,
          headers: const {'Content-Type': 'application/json'},
          body: jsonEncode({
            'product_id': productId,
            'product_name': productName,
            'provider_name': providerName,
            'category': category,
            'coverage_summary': coverageSummary,
            'coverage_items': coverageItems,
            'currency': currency,
          }),
        )
        .timeout(timeout);
    if (res.statusCode != 200) {
      throw Exception(
        'coverage-summary failed: HTTP ${res.statusCode} — ${res.body}',
      );
    }
    final body = jsonDecode(res.body) as Map<String, dynamic>;
    return CoverageSummary.fromJson(body);
  }
}
