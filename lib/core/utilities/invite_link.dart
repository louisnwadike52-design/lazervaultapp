/// Where an invite sends somebody, and how the referral code travels with it.
///
/// WHY THIS IS ONE PLACE
///
/// Invites are shared from more than one screen, and they used to point at
/// `https://lazervault.app` — the marketing homepage. The referral code was in
/// the message text beside the link, so the recipient landed on a page that
/// knew nothing about it, had to find the store themselves, and then retype a
/// code out of a chat thread. Most did neither, and the referrer's commission
/// was lost with nothing anywhere to show why.
///
/// The link now goes to /download and CARRIES the code, which does two things
/// the homepage could not: an installed app gets the code handed to it by the
/// OS (that path is a verified universal link / app link, so signup prefills
/// with no typing), and a browser gets a page that shows the code with a copy
/// button.
///
/// Keeping the URL shape in one file matters because the WEBSITE parses the
/// other end of it. `ref` is the agreed key — see lib/appStore.ts in the
/// website repo — and a second spelling anywhere is an invite that silently
/// drops the code.
library;

class InviteLink {
  const InviteLink._();

  /// The public download page. A verified app link on both platforms, so an
  /// installed app intercepts it before the browser ever loads.
  static const String downloadUrl = 'https://lazervault.app/download';

  /// Query key the code rides on. Must match REFERRAL_QUERY_KEY on the site.
  static const String refKey = 'ref';

  /// Build the URL to share.
  ///
  /// Falls back to the bare download page when there is no code — an invite
  /// without a referral is still a perfectly good invite, and a trailing
  /// `?ref=` would be a worse link than none.
  static String forCode(String? code) {
    final c = (code ?? '').trim();
    if (c.isEmpty) return downloadUrl;
    return '$downloadUrl?$refKey=${Uri.encodeQueryComponent(c)}';
  }

  /// Read a referral code out of an incoming link.
  ///
  /// Accepts the code from the query string on any of our hosts/paths rather
  /// than insisting on /download, because a link gets forwarded, shortened and
  /// re-shared, and the code is worth honouring wherever it survived.
  ///
  /// Normalised to the issued shape (uppercase alphanumeric) and length-
  /// checked, so a mangled value is dropped rather than sent to the backend to
  /// be rejected as unknown — which would lose the attribution silently.
  static String? codeFrom(Uri uri) {
    final raw = uri.queryParameters[refKey];
    if (raw == null) return null;
    final code = raw.trim().toUpperCase().replaceAll(RegExp(r'[^A-Z0-9]'), '');
    if (code.length < 4 || code.length > 16) return null;
    return code;
  }
}
