import 'package:lazervault/core/services/injection_container.dart';
import 'package:lazervault/src/features/recipients/data/datasources/bank_scan_datasource.dart';
import 'package:lazervault/src/features/recipients/data/repositories/bank_repository.dart';

/// On-device (ML Kit text → deterministic parse) extractor that builds a
/// [SmartScanResult] WITHOUT the backend GPT-vision round-trip, for the common,
/// unambiguous payment identifiers: a 10-digit NUBAN account (+ best-effort bank
/// name), an 11-digit / +234 phone, an @username, or an email.
///
/// It returns **null** — deferring to the GPT backend — for exactly the cases
/// GPT is actually needed for and on-device parsing can't safely resolve:
/// invoices / multiple account numbers / account-vs-phone ambiguity / nothing
/// readable. This is the Kuda-style fast path: on-device OCR + deterministic
/// NUBAN+bank parse for 90% of scans, cloud vision only for the hard 10%.
///
/// Money-safety is unchanged: the authoritative account holder name still comes
/// from the NIP name-enquiry in the Verify sheet, the bank is user-confirmed,
/// and the transaction PIN is still required. This only changes the SOURCE of
/// the sheet's prefilled account/bank — a wrong prefill is caught at Verify and
/// can never move money on its own.
class OnDeviceScanExtractor {
  const OnDeviceScanExtractor();

  // Exactly 10 digits, not part of a longer run (NUBAN account number).
  static final RegExp _account = RegExp(r'(?<!\d)\d{10}(?!\d)');
  // 11-digit local (leading 0) or +234 / 234 international NG phone.
  static final RegExp _phone = RegExp(r'(?<!\d)(?:\+?234|0)\d{10}(?!\d)');
  // @handle (min 3 chars).
  static final RegExp _username = RegExp(r'@([A-Za-z0-9_]{3,})');
  // Email.
  static final RegExp _email = RegExp(r'[\w.+-]+@[\w-]+\.[\w.-]+');

  /// Bank-name noise words stripped before matching a scanned name to the list.
  static const _bankNoise = <String>{
    'bank', 'plc', 'mfb', 'microfinance', 'limited', 'ltd', 'nigeria', 'ng',
  };

  /// Parse [rawText] (ML Kit OCR of the captured still) into a routable
  /// [SmartScanResult], or null to fall back to the GPT backend.
  ///
  /// On-device parsing is deliberately **Nigeria-tuned** (10-digit NUBAN,
  /// 11-digit/+234 phone). For any other market it returns null so the scan
  /// falls back to the country-agnostic GPT-vision path — a US/UK account that
  /// happens to be 10 digits must never be mis-read as an NG NUBAN + NG bank.
  SmartScanResult? extract(String rawText, {String country = 'NG'}) {
    if (country.toUpperCase() != 'NG') return null;
    final text = rawText.replaceAll('\n', ' ');
    if (text.trim().isEmpty) return null;

    final email = _email.firstMatch(text)?.group(0)?.trim().toLowerCase();
    final uname = _username.firstMatch(text)?.group(1);
    final phones = _phone.allMatches(text).map((m) => m.group(0)!).toSet();
    // 10-digit runs that aren't the tail of an 11-digit phone we already found.
    final accounts = _account
        .allMatches(text)
        .map((m) => m.group(0)!)
        .where((a) => !phones.any((p) => p.contains(a)))
        .toSet();

    // Ambiguity / invoice → defer to GPT (it disambiguates + reads amount/memo).
    // More than one distinct account number, or several phones with no account,
    // is exactly the multi-number layout on-device parsing can't safely pick.
    if (accounts.length > 1) return null;
    if (accounts.isEmpty && phones.length > 1) return null;

    final singleAccount = accounts.length == 1 ? accounts.first : null;
    final singlePhone = phones.length == 1 ? phones.first : null;

    // 1) Bank account — the strongest routing target when present. A phone may
    //    also sit on the card as a contact line; the account + bank context wins
    //    (matches the backend's bank_details-over-phone classification).
    if (singleAccount != null) {
      final bankName = _findBankName(text, country);
      return SmartScanResult(
        extractionType: 'bank_details',
        confidence: bankName != null ? 0.9 : 0.75,
        accountNumber: singleAccount,
        bankName: bankName,
      );
    }

    // 2) Phone (OPay/PalmPay-style account) — only when no account is present.
    if (singlePhone != null) {
      final digits = singlePhone.replaceAll(RegExp(r'\D'), '');
      final withCc = digits.startsWith('234')
          ? digits
          : digits.startsWith('0')
              ? '234${digits.substring(1)}'
              : digits;
      return SmartScanResult(
        extractionType: 'phone_number',
        confidence: 0.8,
        phoneNumber: withCc,
      );
    }

    // 3) @username — unambiguous internal user (resolved client-side downstream).
    if (uname != null && uname.isNotEmpty) {
      return SmartScanResult(
        extractionType: 'internal_user',
        confidence: 0.85,
        username: uname,
      );
    }

    // 4) Email — unambiguous internal user.
    if (email != null && email.isNotEmpty) {
      return SmartScanResult(
        extractionType: 'email',
        confidence: 0.85,
        email: email,
      );
    }

    // Nothing clean → GPT fallback.
    return null;
  }

  /// Best-effort spot of a bank name in free OCR [text] against the on-device
  /// bank list. Returns the canonical list name when a bank's distinctive core
  /// (name minus "bank/plc/mfb/…") appears as a whole-word run in the text, else
  /// null — the Verify sheet then lets the user pick the bank. Never blocks the
  /// fast path: a missing bank just costs one extra tap; a wrong guess is
  /// user-correctable and NIP-validated before any money moves.
  String? _findBankName(String text, String country) {
    List<Map<String, String>> banks;
    try {
      banks = serviceLocator<BankRepository>().cachedSync(country);
    } catch (_) {
      return null;
    }
    if (banks.isEmpty) return null;
    final hay = ' ${_canon(text)} ';
    String? best;
    int bestLen = 0;
    for (final b in banks) {
      final core = _bankCore(_canon(b['name'] ?? ''));
      if (core.length < 3) continue;
      if (hay.contains(' $core ') && core.length > bestLen) {
        best = b['name'];
        bestLen = core.length;
      }
    }
    return best;
  }

  String _canon(String s) => s
      .toLowerCase()
      .replaceAll(RegExp(r'[^a-z0-9 ]'), ' ')
      .replaceAll(RegExp(r'\s+'), ' ')
      .trim();

  String _bankCore(String canon) => canon
      .split(' ')
      .where((w) => w.isNotEmpty && !_bankNoise.contains(w))
      .join(' ')
      .trim();
}
