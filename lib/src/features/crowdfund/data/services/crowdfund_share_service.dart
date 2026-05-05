import 'package:flutter_dotenv/flutter_dotenv.dart';

/// Builds the shareable URL for a crowdfund campaign.
///
/// The base URL is sourced from the `CROWDFUND_SHARE_BASE_URL` env var
/// (default `https://lazervault.app`). The same env value is mirrored on
/// the admin dashboard's crowdfund configuration tab so operators can
/// repoint shares without a mobile release. When the base URL changes
/// in production, update this env value in `.env.prod` and ship a new
/// build, or wire fetching from `system_settings` over a config RPC.
class CrowdfundShareService {
  static const String _defaultBase = 'https://lazervault.app';

  String get baseUrl {
    final raw = dotenv.env['CROWDFUND_SHARE_BASE_URL']?.trim();
    if (raw == null || raw.isEmpty) return _defaultBase;
    return raw.endsWith('/') ? raw.substring(0, raw.length - 1) : raw;
  }

  /// Returns the shareable URL for the given crowdfund id. The path
  /// segment `crowdfund` matches the planned web route at
  /// `https://lazervault.app/crowdfund/{id}` which renders the public
  /// donation page.
  String shareUrlFor(String crowdfundId) => '$baseUrl/crowdfund/$crowdfundId';
}
