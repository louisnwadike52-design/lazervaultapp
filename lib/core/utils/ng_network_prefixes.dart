/// Canonical NCC prefix allocation for Nigerian GSM networks — the SINGLE
/// SOURCE OF TRUTH for client-side network auto-detection. The airtime and
/// data quick-buys plus the legacy airtime provider catalogue all read from
/// here, so an allocation added once (NCC releases new blocks every few
/// years) applies to every flow at the same moment. Airtime previously kept
/// its own stale copy (missing 0703/0706/0707, 0701/0708, 0705) while data
/// kept a near-complete inline map that mis-filed 0801 under MTN.
///
/// Keys are the backend network tickers ("mtn"/"airtel"/"glo"/"etisalat" —
/// etisalat is the backend's ticker for 9mobile). Values are the 3 digits
/// after the leading 0 ("703" for 0703).
class NgNetworkPrefixes {
  NgNetworkPrefixes._();

  static const Map<String, Set<String>> byNetwork = {
    'mtn': {
      '703', '704', '706', '707', '803', '806', '810',
      '813', '814', '816', '903', '906', '913', '916',
    },
    // 0801 is an Airtel block (it was mis-filed under MTN in the old
    // data-quick-buy map); 0911 is Airtel's 2021 release, absent from both
    // old copies.
    'airtel': {
      '701', '708', '801', '802', '808', '812',
      '901', '902', '904', '907', '911', '912',
    },
    'glo': {'705', '805', '807', '811', '815', '905', '915'},
    'etisalat': {'809', '817', '818', '908', '909'},
  };

  /// 0-prefixed local dialling forms ("0703") for callers that match against
  /// the 11-digit local number.
  static List<String> localForm(String network) => [
        for (final p in byNetwork[network] ?? const <String>{}) '0$p',
      ];

  /// Detects the network ticker from any NG phone form (+234…, 234…, 0…,
  /// bare 10 digits). Returns null when the prefix isn't allocated.
  static String? detect(String phone) {
    var d = phone.replaceAll(RegExp(r'[^\d]'), '');
    if (d.startsWith('234')) d = d.substring(3);
    if (d.startsWith('0')) d = d.substring(1);
    if (d.length < 3) return null;
    final p3 = d.substring(0, 3);
    for (final e in byNetwork.entries) {
      if (e.value.contains(p3)) return e.key;
    }
    return null;
  }
}
