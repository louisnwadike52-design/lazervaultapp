import 'dart:convert';

import 'package:http/http.dart' as http;
import 'package:lazervault/core/services/endpoint_registry.dart';

/// A support material (e.g. a how-to video or PDF) shown under Help & Support.
class HelpMaterial {
  final String title;
  final String url;
  const HelpMaterial({required this.title, required this.url});
}

/// The admin-configured Help & Support content. Every field is sourced from the
/// admin dashboard (system_settings, `help_*` keys) so Contact Us / Terms /
/// Privacy / About / support materials are never hardcoded. Built-in defaults
/// are only a fallback used when the backend is unreachable, so the screen
/// always renders something usable.
class HelpConfig {
  final String contactEmail;
  final String contactPhone;
  final String contactWhatsapp;
  final String contactAddress;
  final String contactUrl; // empty → no "contact page" webview row
  final String supportHours; // label for the contact card (e.g. "24/7 support")
  final String termsUrl;
  final String privacyUrl;
  final String aboutUrl; // always opens in the webview sheet (never empty)
  final String faqUrl; // empty → fall back to support materials list
  final List<HelpMaterial> materials;

  const HelpConfig({
    required this.contactEmail,
    required this.contactPhone,
    required this.contactWhatsapp,
    required this.contactAddress,
    required this.contactUrl,
    required this.supportHours,
    required this.termsUrl,
    required this.privacyUrl,
    required this.aboutUrl,
    required this.faqUrl,
    required this.materials,
  });

  /// True when there's at least one contact channel to show. The account-sheet
  /// help tab hides its whole contact card when this is false.
  bool get hasAnyContact =>
      contactPhone.isNotEmpty ||
      contactEmail.isNotEmpty ||
      contactWhatsapp.isNotEmpty;

  static const HelpConfig fallback = HelpConfig(
    contactEmail: 'support@lazervault.app',
    contactPhone: '',
    contactWhatsapp: '',
    contactAddress: '',
    contactUrl: '',
    supportHours: '24/7 support',
    termsUrl: 'https://lazervault.app/legal/terms',
    privacyUrl: 'https://lazervault.app/legal/privacy',
    aboutUrl: 'https://lazervault.app/about',
    faqUrl: 'https://lazervault.app/help',
    materials: <HelpMaterial>[],
  );
}

/// Fetches + caches the Help & Support config from the admin settings endpoint
/// (`/api/v1/internal/voice-agents/settings`, the same no-auth poll the URL
/// registry uses). Never throws — falls back to [HelpConfig.fallback].
class HelpConfigService {
  HelpConfigService._();
  static final HelpConfigService instance = HelpConfigService._();

  HelpConfig _config = HelpConfig.fallback;
  DateTime? _fetchedAt;
  static const _ttl = Duration(minutes: 30);

  HelpConfig get config => _config;

  Future<HelpConfig> ensure() async {
    if (_fetchedAt != null && DateTime.now().difference(_fetchedAt!) < _ttl) {
      return _config;
    }
    try {
      final res = await http
          .get(Uri.parse(endpointRegistry.adminSettingsEndpoint))
          .timeout(const Duration(seconds: 6));
      if (res.statusCode == 200) {
        final body = jsonDecode(res.body);
        final list = body is Map<String, dynamic> ? body['settings'] : null;
        if (list is List) {
          final m = <String, String>{};
          for (final raw in list) {
            if (raw is Map && raw['key'] is String && raw['value'] is String) {
              m[raw['key'] as String] = raw['value'] as String;
            }
          }
          _config = _parse(m);
          _fetchedAt = DateTime.now();
        }
      }
    } catch (_) {
      // Keep last good / fallback — Help & Support must always render.
    }
    return _config;
  }

  HelpConfig _parse(Map<String, String> m) {
    String pick(String key, String fallback) {
      final v = m[key];
      return (v != null && v.trim().isNotEmpty) ? v.trim() : fallback;
    }

    // help_support_materials is a JSON array of {title,url}.
    final materials = <HelpMaterial>[];
    final rawMaterials = m['help_support_materials'];
    if (rawMaterials != null && rawMaterials.trim().isNotEmpty) {
      try {
        final decoded = jsonDecode(rawMaterials);
        if (decoded is List) {
          for (final item in decoded) {
            if (item is Map &&
                item['title'] is String &&
                item['url'] is String &&
                (item['url'] as String).trim().isNotEmpty) {
              materials.add(HelpMaterial(
                title: (item['title'] as String).trim(),
                url: (item['url'] as String).trim(),
              ));
            }
          }
        }
      } catch (_) {
        // Malformed admin value — ignore, leave materials empty.
      }
    }

    return HelpConfig(
      contactEmail: pick('help_contact_email', HelpConfig.fallback.contactEmail),
      contactPhone: pick('help_contact_phone', ''),
      contactWhatsapp: pick('help_contact_whatsapp', ''),
      contactAddress: pick('help_contact_address', ''),
      contactUrl: pick('help_contact_url', ''),
      supportHours: pick('help_support_hours', HelpConfig.fallback.supportHours),
      termsUrl: pick('help_terms_url', HelpConfig.fallback.termsUrl),
      privacyUrl: pick('help_privacy_url', HelpConfig.fallback.privacyUrl),
      // Default to the fallback About page so the webview always has a URL to
      // load even when an admin hasn't set help_about_url — the app never shows
      // a dead/empty About sheet.
      aboutUrl: pick('help_about_url', HelpConfig.fallback.aboutUrl),
      faqUrl: pick('help_faq_url', HelpConfig.fallback.faqUrl),
      materials: materials,
    );
  }
}
