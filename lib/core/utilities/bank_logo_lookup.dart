import 'package:flutter/foundation.dart';

/// Resolves a bank's backend-served logo URL from a bank NAME or CODE.
///
/// WHY A LOOKUP AND NOT A PARAMETER. [BankLogo] is rendered from ~35 places,
/// and most of them hold only a saved recipient or a scanned result — a bank
/// name and maybe a code, never the `Bank` object the bank-list RPC returned.
/// Threading a `logoUrl` through all of them would have meant 35 edits to get
/// logos onto the screens people actually use (saved recipients, transfer
/// history, confirm sheets), and any path that forgot it would silently fall
/// back to initials forever.
///
/// So the bank list, which DOES carry the URLs, publishes them here once, and
/// every renderer can ask.
///
/// INDEXED BY NAME FIRST. Bank codes are per-rail — Kuda is 50211 on
/// Flutterwave and 090267 on Nomba — so a code lookup is only safe as a second
/// attempt. The name is what the two rails agree on, and it is also the only
/// thing a saved recipient reliably stores.
class BankLogoLookup {
  BankLogoLookup._();

  static final Map<String, String> _byName = {};
  static final Map<String, String> _byCode = {};

  /// Bumped whenever the index changes, so a widget can rebuild once the bank
  /// list has loaded instead of being stuck on the initials it first painted.
  static final ValueNotifier<int> revision = ValueNotifier<int>(0);

  /// Feeds the index from a bank list. Safe to call repeatedly; later entries
  /// win, which is right because a later call is a fresher list.
  ///
  /// Entries with no `logo_url` are skipped rather than stored as empty — an
  /// empty value would be indistinguishable from "indexed, no logo" and would
  /// stop a later, better list from filling it.
  static void ingest(Iterable<Map<String, String>> banks) {
    var changed = false;
    for (final b in banks) {
      final url = (b['logo_url'] ?? '').trim();
      if (url.isEmpty) continue;
      final nameKey = normaliseName(b['name'] ?? '');
      if (nameKey.isNotEmpty && _byName[nameKey] != url) {
        _byName[nameKey] = url;
        changed = true;
      }
      final code = (b['code'] ?? '').trim();
      if (code.isNotEmpty && _byCode[code] != url) {
        _byCode[code] = url;
        changed = true;
      }
    }
    if (changed) revision.value++;
  }

  /// The URL for a bank, or null when we have none indexed.
  static String? urlFor({String? bankName, String? bankCode}) {
    final nameKey = normaliseName(bankName ?? '');
    if (nameKey.isNotEmpty) {
      final hit = _byName[nameKey];
      if (hit != null) return hit;
    }
    final code = (bankCode ?? '').trim();
    if (code.isNotEmpty) {
      final hit = _byCode[code];
      if (hit != null) return hit;
    }
    return null;
  }

  /// Mirrors the server's NormalizeBankNameKey closely enough to match the same
  /// banks, because the server built the index this widget is querying.
  ///
  /// It does NOT need to be byte-identical: both sides index the SAME bank
  /// list, so a name is matched against the spelling that list used. The noise
  /// words matter because a saved recipient may store "Zenith bank PLC" where
  /// the list said "Zenith Bank".
  static String normaliseName(String name) {
    var s = name.toLowerCase().trim();
    if (s.isEmpty) return '';
    s = s.replaceAll(RegExp(r'\([^)]*\)'), ' ');
    s = s.replaceAll(RegExp(r'[^a-z0-9 ]+'), ' ');
    s = ' ${s.replaceAll(RegExp(r'\s+'), ' ')} ';
    for (final w in _noise) {
      s = s.replaceAll(' $w ', ' ');
    }
    s = s.replaceAll(' ', '');
    // Same floor as the server: shorter than this matches far too much.
    return s.length < 3 ? '' : s;
  }

  // Order matters: multi-word forms before their parts, or "microfinance bank"
  // loses its "bank" first and leaves a stray "microfinance".
  static const _noise = <String>[
    'microfinance bank', 'micro finance bank', 'digital services',
    'microfinance', 'micro finance', 'mfbank', 'mfb', 'mf',
    'plc', 'limited', 'ltd', 'llc', 'inc',
    'bank', 'banking', 'bancorp',
    'nigeria', 'nigerian', 'nig',
    'company', 'and', 'the',
    'services', 'service', 'holdings', 'group',
  ];

  @visibleForTesting
  static void resetForTest() {
    _byName.clear();
    _byCode.clear();
    revision.value = 0;
  }
}
