/// Resolves a SCANNED or TYPED bank name against the active rail's bank list.
///
/// WHY THIS EXISTS
/// ---------------
/// The scan sheet had its own matcher whose last tier accepted ANY shared word
/// and returned a single answer with no notion of doubt. Two consequences, both
/// reported from the app:
///
///   * Wrong banks were chosen silently. "Guaranty Trust Bank" and "Trust
///     Microfinance Bank" share the word "trust", so one could resolve to the
///     other — a different institution, on a payment screen, with nothing to
///     tell the user.
///   * There were no suggestions. A partial read produced one guess or nothing,
///     so when the guess was wrong the desired bank was not among the options
///     and the user had to search 633 banks from scratch.
///
/// This returns RANKED candidates with a confidence tier, so the caller can
/// prefill a confident match and, when unsure, prefill the best guess AND open
/// the picker on the alternatives.
///
/// It mirrors the server-side resolver in
/// `chat_agents_shared/ocr/bank_resolution.py`. The two are kept in step by
/// testing both against the same real rail names.
library;

/// How sure we are, in decreasing order.
enum BankMatchTier {
  /// Names agree once reduced to their identity (including alias groups).
  /// Safe to use without asking.
  exact,

  /// One name is a substantial prefix of the other. Offer it FIRST, but the
  /// user confirms — paying the wrong bank is unrecoverable.
  strong,

  /// Meaningful token overlap only. A suggestion, never a selection.
  weak,
}

class BankMatch {
  const BankMatch({
    required this.name,
    required this.code,
    required this.tier,
    required this.score,
    this.logoUrl,
  });

  final String name;
  final String code;
  final BankMatchTier tier;
  final double score;
  final String? logoUrl;

  /// Whether this may be used WITHOUT the user confirming the bank.
  bool get isConfident => tier == BankMatchTier.exact;
}

class BankNameResolver {
  BankNameResolver._();

  /// Words that recur across dozens of real Nigerian bank names, so sharing one
  /// is not evidence of being the same bank. "trust" is here because Guaranty
  /// Trust, Trust Microfinance, Citizen Trust and Consistent Trust are four
  /// different institutions.
  static const _commonWords = <String>{
    'trust', 'digital', 'finance', 'financial', 'credit', 'savings', 'loans',
    'capital', 'union', 'national', 'federal', 'cooperative', 'community',
    'global', 'first', 'new', 'royal', 'prime', 'premier', 'standard',
    'united', 'general', 'peoples', 'money', 'pay', 'payment', 'payments',
  };

  /// Noise that appears or vanishes between a printed name, a rail's list and
  /// someone's handwriting. Multi-word forms first, or "microfinance bank"
  /// loses its "bank" and leaves a stray "microfinance".
  static const _noise = <String>[
    'microfinance bank', 'micro finance bank', 'digital services',
    'microfinance', 'micro finance', 'mfbank', 'mfb', 'mf',
    'plc', 'limited', 'ltd', 'llc', 'inc',
    'bank', 'banking', 'bancorp',
    'nigeria', 'nigerian', 'nig',
    'company', 'and', 'the',
    'services', 'service', 'holdings', 'group',
  ];

  /// Spellings of the same bank that do NOT reduce to each other. Grouped, not
  /// mapped one-way, because either side can carry either form: a slip may say
  /// "Guaranty Trust Bank" while the rail's list says "GTBank", and the reverse
  /// happens too.
  ///
  /// These are NAMES, never codes — so the table cannot go stale when a rail
  /// renumbers. The codes always come from the live list.
  static const _aliasGroups = <List<String>>[
    ['gtb', 'gtbank', 'gt bank', 'gtco', 'guaranty trust', 'guaranty trust bank'],
    ['uba', 'united bank for africa'],
    ['fbn', 'firstbank', 'first bank', 'first bank of nigeria'],
    ['fcmb', 'first city monument', 'first city monument bank'],
    ['stanbic', 'ibtc', 'stanbic ibtc', 'stanbic ibtc bank'],
    ['opay', 'o-pay', 'o pay', 'paycom', 'paycom opay',
      'opay digital services', 'opay digital services limited'],
    ['palmpay', 'palm pay'],
    ['alat', 'alat by wema', 'wema', 'wema bank'],
    ['9psb', '9 psb', '9mobile 9payment service bank'],
    ['moniepoint', 'moneypoint', 'monie', 'moniepoint mfb', 'moniepoint bank',
      'moniepoint microfinance bank'],
    ['kuda', 'kuda bank', 'kuda microfinance bank'],
  ];

  static Map<String, String>? _aliasIndex;

  static Map<String, String> get _aliases {
    final built = _aliasIndex;
    if (built != null) return built;
    final index = <String, String>{};
    for (final group in _aliasGroups) {
      final canonical = 'alias:${group.first}';
      for (final spelling in group) {
        final key = _reduce(spelling);
        if (key.isNotEmpty) index[key] = canonical;
      }
    }
    _aliasIndex = index;
    return index;
  }

  /// The reduction, with no length floor. Used to build the alias index, where
  /// a floor would drop "gtb" and "uba".
  static String _reduce(String name) {
    var s = name.toLowerCase().trim();
    if (s.isEmpty) return '';
    s = s.replaceAll(RegExp(r'\([^)]*\)'), ' ');
    s = s.replaceAll(RegExp(r'[^a-z0-9 ]+'), ' ');
    s = ' ${s.replaceAll(RegExp(r'\s+'), ' ').trim()} ';
    for (final w in _noise) {
      s = s.replaceAll(' $w ', ' ');
    }
    return s.replaceAll(' ', '');
  }

  /// A bank name reduced to its identity, or '' when nothing identifying is
  /// left ("Bank PLC"). Callers must treat '' as "no match possible" rather
  /// than as a key, or every such name would collide.
  static String normalise(String name) {
    final s = _reduce(name);
    if (s.length >= 3) return s;
    // Short forms are only an identity when they are a known alias.
    return _aliases.containsKey(s) ? s : '';
  }

  /// Every key worth trying for one name. Applied to BOTH sides of a
  /// comparison: "Paycom (Opay)" reduces to "paycom" alone, so without the
  /// bank's own parenthetical a slip saying "Opay" could never match it.
  static List<String> candidateKeys(String name) {
    final out = <String>[];
    final seen = <String>{};
    void add(String k) {
      if (k.isNotEmpty && seen.add(k)) out.add(k);
    }

    final base = _reduce(name);
    add(normalise(name));
    final aliased = _aliases[base];
    if (aliased != null) add(aliased);

    final paren = RegExp(r'\(([^)]*)\)').firstMatch(name);
    if (paren != null) {
      final inner = paren.group(1) ?? '';
      add(normalise(inner));
      final a = _aliases[_reduce(inner)];
      if (a != null) add(a);
    }
    final open = name.indexOf('(');
    if (open > 0) {
      final head = name.substring(0, open);
      add(normalise(head));
      final a = _aliases[_reduce(head)];
      if (a != null) add(a);
    }
    return out;
  }

  static List<String> _tokens(String name) {
    final s = name.toLowerCase().replaceAll(RegExp(r'[^a-z0-9 ]+'), ' ');
    return s
        .split(RegExp(r'\s+'))
        .where((t) => t.length > 2 && !_noise.contains(t))
        .toList();
  }

  /// True when the text is a single word many banks share.
  ///
  /// Tested on the RAW text because reduction collapses "First Bank" and
  /// "First" to the same key, and only the raw form tells them apart: the
  /// first is a complete name, the second is very likely a truncated read.
  static bool _isSingleGenericWord(String name) {
    final words = name
        .toLowerCase()
        .replaceAll(RegExp(r'[^a-z0-9 ]+'), ' ')
        .split(RegExp(r'\s+'))
        .where((w) => w.isNotEmpty)
        .toList();
    return words.length == 1 && _commonWords.contains(words.first);
  }

  /// Ranks the rail's banks against [scannedName], best first.
  ///
  /// [banks] entries need `name` and `code` — the shape BankRepository already
  /// produces, so the ACTIVE rail's codes are used and nothing here changes
  /// when the payout provider switches.
  ///
  /// Returns an empty list when nothing plausibly matches. That is a real
  /// answer: prefill the account number and let the user pick the bank.
  static List<BankMatch> rank(
    String scannedName,
    List<Map<String, String>> banks, {
    int limit = 6,
  }) {
    if (scannedName.trim().isEmpty || banks.isEmpty) return const [];
    final queryKeys = candidateKeys(scannedName);
    if (queryKeys.isEmpty) return const [];
    final querySet = queryKeys.toSet();
    final queryTokens = _tokens(scannedName).toSet();
    final demote = _isSingleGenericWord(scannedName);

    final results = <BankMatch>[];
    final seenCodes = <String>{};
    void push(Map<String, String> b, BankMatchTier tier, double score) {
      final code = b['code'] ?? '';
      if (code.isEmpty || !seenCodes.add(code)) return;
      results.add(BankMatch(
        name: b['name'] ?? '',
        code: code,
        tier: tier,
        score: score,
        logoUrl: b['logo_url'],
      ));
    }

    final withKeys = banks
        .where((b) => (b['name'] ?? '').isNotEmpty && (b['code'] ?? '').isNotEmpty)
        .map((b) => (bank: b, keys: candidateKeys(b['name'] ?? '')))
        .toList();

    // 1. Exact on any shared key.
    for (final e in withKeys) {
      if (e.keys.any(querySet.contains)) {
        push(e.bank, demote ? BankMatchTier.strong : BankMatchTier.exact, 1.0);
      }
    }

    // 2. Strong partial: one key is a prefix of the other and the shorter is
    //    substantial. "parallex"/"parallexmf" qualifies; "first"/
    //    "firstcitymonument" does not — a generic word several banks share is
    //    not evidence.
    for (final e in withKeys) {
      var best = 0.0;
      for (final k in queryKeys) {
        if (k.length < 5 || k.startsWith('alias:')) continue;
        for (final nb in e.keys) {
          if (nb.isEmpty || nb == k || nb.startsWith('alias:')) continue;
          if (nb.startsWith(k) || k.startsWith(nb)) {
            final shorter = k.length < nb.length ? k.length : nb.length;
            final longer = k.length < nb.length ? nb.length : k.length;
            final s = shorter / longer;
            if (s > best) best = s;
          }
        }
      }
      if (best > 0) push(e.bank, BankMatchTier.strong, best);
    }

    // 3. Weak: meaningful token overlap, and only then. One shared token has
    //    to be both long AND not a word banks commonly share — the bar that
    //    stops "Guaranty Trust" resolving to "Trust Microfinance".
    if (queryTokens.isNotEmpty) {
      for (final e in withKeys) {
        final bt = _tokens(e.bank['name'] ?? '').toSet();
        if (bt.isEmpty) continue;
        final shared = queryTokens.intersection(bt);
        if (shared.isEmpty) continue;
        final strongSingle =
            shared.any((t) => t.length >= 6 && !_commonWords.contains(t));
        if (shared.length >= 2 || strongSingle) {
          push(e.bank, BankMatchTier.weak,
              shared.length / queryTokens.union(bt).length);
        }
      }
    }

    results.sort((a, b) {
      final t = a.tier.index.compareTo(b.tier.index);
      if (t != 0) return t;
      final s = b.score.compareTo(a.score);
      if (s != 0) return s;
      return a.name.toLowerCase().compareTo(b.name.toLowerCase());
    });
    return results.length <= limit ? results : results.sublist(0, limit);
  }

  /// The best match, or null. [alternatives] carries the ranked list to offer.
  static ({BankMatch? best, List<BankMatch> alternatives}) resolve(
    String scannedName,
    List<Map<String, String>> banks,
  ) {
    final ranked = rank(scannedName, banks);
    return (best: ranked.isEmpty ? null : ranked.first, alternatives: ranked);
  }
}
