import 'package:flutter_dotenv/flutter_dotenv.dart';

/// Builds the shareable URL for an escrow OFFER.
///
/// The link points at the lazervault.app web landing
/// (`https://lazervault.app/escrow/offer/{token}`), which renders the listing
/// publicly-ish (title/price/seller — the web page itself calls the share-token
/// endpoint) and smart-hands-off to the app: opens the app via universal link
/// when installed, falls back to the store when not. The `{token}` is the
/// 32-byte random share token (the capability), NEVER the offer reference.
///
/// Base URL is env-overridable (`ESCROW_SHARE_BASE_URL`) so operators can
/// repoint without a mobile release — same pattern as CrowdfundShareService.
class EscrowShareService {
  static const String _defaultBase = 'https://lazervault.app';

  String get baseUrl {
    final raw = dotenv.env['ESCROW_SHARE_BASE_URL']?.trim();
    if (raw == null || raw.isEmpty) return _defaultBase;
    return raw.endsWith('/') ? raw.substring(0, raw.length - 1) : raw;
  }

  /// The shareable web URL for an offer's share token.
  String shareUrlForToken(String shareToken) =>
      '$baseUrl/escrow/offer/$shareToken';
}
