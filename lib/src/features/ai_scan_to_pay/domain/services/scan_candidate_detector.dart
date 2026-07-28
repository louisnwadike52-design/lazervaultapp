/// What kind of payable identifier the on-device OCR spotted in a camera frame.
enum ScanCandidateType { account, phone, amount, username, email }

/// A payable detail spotted on-device (via ML Kit text recognition) in a live
/// camera frame. This is only a *trigger*: it tells [LiveScanCameraView] that
/// there is something worth capturing on screen and gives a stable key to test
/// frame-to-frame steadiness. The authoritative parsing/classification always
/// happens server-side (chat-transfers-service OCR) once we capture a still —
/// so the patterns here are deliberately loose (detection, not validation).
class ScanCandidate {
  const ScanCandidate({
    required this.type,
    required this.value,
    required this.normalized,
  });

  final ScanCandidateType type;

  /// The raw matched text as it appeared on screen.
  final String value;

  /// A canonical form used for frame-to-frame stability comparison
  /// (digits-only for account/phone, lowercased for username/email).
  final String normalized;
}

/// Scans raw OCR text from a single frame and returns the strongest payable
/// candidate, or `null` when nothing actionable is visible.
///
/// Priority mirrors how the backend disambiguates: an @username or email is an
/// unambiguous internal-user identifier, a 10-digit NUBAN is a bank account, an
/// 11-digit `0…`/`+234…` is a phone. An amount alone never triggers a capture
/// (it can't route a payment on its own) — it only rides along as context.
class ScanCandidateDetector {
  const ScanCandidateDetector();

  // Exactly 10 digits, not part of a longer run (NUBAN account number).
  static final RegExp _account = RegExp(r'(?<!\d)\d{10}(?!\d)');
  // 11-digit local (leading 0) or +234 / 234 international NG phone.
  static final RegExp _phone = RegExp(r'(?<!\d)(?:\+?234|0)\d{10}(?!\d)');
  // @handle (min 3 chars).
  static final RegExp _username = RegExp(r'@([A-Za-z0-9_]{3,})');
  // Email — same shape as core FormValidators._emailRe.
  static final RegExp _email = RegExp(r'[\w.+-]+@[\w-]+\.[\w.-]+');
  // ₦ / NGN / N prefixed money value (context only, never triggers alone).
  static final RegExp _amount =
      RegExp(r'(?:₦|NGN|N)\s?[\d,]+(?:\.\d{1,2})?', caseSensitive: false);

  /// Returns the best payable candidate found in [rawText], or `null`.
  ScanCandidate? detect(String rawText) {
    final text = rawText.replaceAll('\n', ' ');
    if (text.trim().isEmpty) return null;

    // 1) Email — unambiguous internal user.
    final email = _email.firstMatch(text)?.group(0);
    if (email != null) {
      final v = email.trim().toLowerCase();
      return ScanCandidate(
        type: ScanCandidateType.email,
        value: email,
        normalized: v,
      );
    }

    // 2) @username — unambiguous internal user.
    final uname = _username.firstMatch(text)?.group(1);
    if (uname != null && uname.isNotEmpty) {
      return ScanCandidate(
        type: ScanCandidateType.username,
        value: '@$uname',
        normalized: uname.toLowerCase(),
      );
    }

    // 3) Phone (11-digit / +234) BEFORE account so an OPay/PalmPay number that
    //    is 11 digits isn't mis-keyed as a 10-digit account slice.
    final phone = _phone.firstMatch(text)?.group(0);
    if (phone != null) {
      return ScanCandidate(
        type: ScanCandidateType.phone,
        value: phone,
        normalized: phone.replaceAll(RegExp(r'\D'), ''),
      );
    }

    // 4) 10-digit NUBAN account.
    final account = _account.firstMatch(text)?.group(0);
    if (account != null) {
      return ScanCandidate(
        type: ScanCandidateType.account,
        value: account,
        normalized: account,
      );
    }

    return null;
  }

  /// Whether the frame carries a visible money amount (used only to enrich the
  /// overlay hint — not a capture trigger on its own).
  bool hasAmount(String rawText) => _amount.hasMatch(rawText);
}
