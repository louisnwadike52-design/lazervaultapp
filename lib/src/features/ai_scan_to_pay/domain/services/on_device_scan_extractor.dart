import 'package:lazervault/src/features/ai_scan_to_pay/domain/services/scan_text_normalizer.dart';
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
    // Same handwriting repair as the live detector (broken digit runs +
    // confusable glyphs) so a captured still of a wall sign parses on-device
    // instead of always burning a GPT-vision round-trip.
    final text = augmentDigitRuns(rawText.replaceAll('\n', ' '));
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

    var singleAccount = accounts.length == 1 ? accounts.first : null;
    final singlePhone = phones.length == 1 ? phones.first : null;
    var sloppyRun = false;

    final bank = _findBank(text, country);
    final bankName = bank?['name'];
    final bankCode = bank?['code'] ?? '';

    // SLOPPY-RUN RESCUE: a handwriting flourish or stroke tail reads as one
    // extra glyph, so a wall sign's 10-digit NUBAN frequently OCRs as a single
    // 11–12 digit run with no clean \d{10} inside (the strict lookarounds
    // exclude it). Recover: slide a 10-digit window over the run; when the
    // matched bank has a 3-digit NIP code, rank windows by the CBN NUBAN
    // checksum and take a UNIQUE valid one; otherwise prefer dropping the
    // TRAILING glyph (flourishes trail). Prefill-only + low confidence — the
    // Verify sheet's name-enquiry stays the authority and the field is
    // user-editable, so a wrong window costs an edit, never money.
    if (singleAccount == null && phones.isEmpty) {
      final long = RegExp(r'(?<!\d)\d{11,12}(?!\d)')
          .allMatches(text)
          .map((m) => m.group(0)!)
          .toSet();
      if (long.length == 1) {
        final run = long.first;
        final windows = <String>[
          for (var i = 0; i + 10 <= run.length; i++) run.substring(i, i + 10)
        ];
        String? pick;
        if (bankCode.length == 3) {
          final valid =
              windows.where((w) => _nubanChecksumOk(bankCode, w)).toList();
          if (valid.length == 1) pick = valid.first;
        }
        pick ??= windows.first; // drop trailing extras by default
        singleAccount = pick;
        sloppyRun = true;
      }
    }

    // 1) Bank account — the strongest routing target when present. A phone may
    //    also sit on the card as a contact line; the account + bank context wins
    //    (matches the backend's bank_details-over-phone classification).
    if (singleAccount != null) {
      return SmartScanResult(
        extractionType: 'bank_details',
        confidence: sloppyRun ? 0.6 : (bankName != null ? 0.9 : 0.75),
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
  /// CBN NUBAN check-digit validation for 3-digit NIP bank codes: weights
  /// 3,7,3 cycled over bankCode+9-digit serial; check = (10 − sum mod 10) mod
  /// 10. Used ONLY to rank candidate windows from a sloppy OCR run — never to
  /// reject a scan (MFB/fintech 5-digit codes skip this entirely).
  static bool _nubanChecksumOk(String bankCode, String account) {
    if (bankCode.length != 3 || account.length != 10) return false;
    const weights = [3, 7, 3, 3, 7, 3, 3, 7, 3, 3, 7, 3];
    final digits = '$bankCode${account.substring(0, 9)}';
    var sum = 0;
    for (var i = 0; i < 12; i++) {
      final d = int.tryParse(digits[i]);
      if (d == null) return false;
      sum += d * weights[i];
    }
    final check = (10 - (sum % 10)) % 10;
    return check == int.tryParse(account[9]);
  }

  Map<String, String>? _findBank(String text, String country) {
    List<Map<String, String>> banks;
    try {
      banks = serviceLocator<BankRepository>().cachedSync(country);
    } catch (_) {
      return null;
    }
    if (banks.isEmpty) return null;
    final hay = ' ${_canon(text)} ';
    // Handwritten signs split fintech names ("MONIE POINT", "PALM PAY") —
    // a space-collapsed haystack lets the whole-word check's fallback still
    // land on "moniepoint"/"palmpay". Min length 5 on this path so short
    // cores can't false-match inside unrelated collapsed words.
    final hayCollapsed = hay.replaceAll(' ', '');
    Map<String, String>? best;
    int bestLen = 0;
    for (final b in banks) {
      final core = _bankCore(_canon(b['name'] ?? ''));
      if (core.length < 3) continue;
      final coreCollapsed = core.replaceAll(' ', '');
      final hit = hay.contains(' $core ') ||
          (coreCollapsed.length >= 5 && hayCollapsed.contains(coreCollapsed));
      if (hit && core.length > bestLen) {
        best = b;
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
