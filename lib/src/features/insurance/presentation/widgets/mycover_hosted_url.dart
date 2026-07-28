// Client-side composer for MyCover's UNIVERSAL hosted link (Buy / Manage).
//
// Buy and Manage have no policy yet, so — unlike Claim/Renew, whose URLs
// the backend composes from a purchase row — the app composes these from
// the admin-configured base link (FeatureFlags.insuranceHostedBaseLink)
// plus the logged-in user's identity. The email + client_reference=LV-<id>
// are what let the backend tie the resulting MyCover purchase back to this
// Lazervault user (see the webhook create-on-miss + hosted-import worker).
//
// This MIRRORS the Go `appendParamsToMyCoverURL`: MyCover's merchant pages
// are hash-routed SPAs (e.g. https://s.mycover.ai/#XIDgIDGGWV), so params
// must be appended INSIDE the hash fragment or the page never sees them.
class MyCoverHostedUrl {
  /// Compose the per-user hosted URL, or return null when [base] is empty
  /// (admin hasn't configured the link → caller renders an unavailable
  /// state rather than opening a blank webview).
  static String? compose({
    required String base,
    String email = '',
    String phone = '',
    String userId = '',
  }) {
    final trimmed = base.trim();
    if (trimmed.isEmpty) return null;

    final params = <String>[];
    if (email.trim().isNotEmpty) {
      params.add('email=${Uri.encodeQueryComponent(email.trim())}');
    }
    if (phone.trim().isNotEmpty) {
      params.add('phone=${Uri.encodeQueryComponent(phone.trim())}');
    }
    if (userId.trim().isNotEmpty) {
      params.add(
          'client_reference=${Uri.encodeQueryComponent('LV-${userId.trim()}')}');
    }
    if (params.isEmpty) return trimmed;

    final joined = params.join('&');
    final hashAt = trimmed.indexOf('#');
    if (hashAt >= 0) {
      final head = trimmed.substring(0, hashAt);
      final frag = trimmed.substring(hashAt);
      // Bare "#" with no merchant key → treat as no hash.
      if (frag.length <= 1) return _appendQuery(head, joined);
      final sep = frag.contains('?') ? '&' : '?';
      return '$head$frag$sep$joined';
    }
    return _appendQuery(trimmed, joined);
  }

  static String _appendQuery(String base, String joined) {
    final sep = base.contains('?') ? '&' : '?';
    return '$base$sep$joined';
  }
}
