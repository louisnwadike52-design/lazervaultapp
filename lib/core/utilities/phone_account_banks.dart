library;

/// OPay / PalmPay accounts are PHONE NUMBERS.
///
/// A MIRROR of chat_agents_shared/ocr/phone_account_banks.py, kept in step by
/// test/core/phone_account_banks_test.dart, which runs the SAME cases both
/// sides use. Two definitions of "is this a phone number" that disagree would
/// show the pills on one screen and not the other for the same scan.
///
/// WHY THE CLIENT NEEDS IT AT ALL
/// ------------------------------
/// The server normalises the number and works out which banks it could belong
/// to, but `BankDetails` is a proto message with no field to carry a candidate
/// list — adding one means regenerating protos across three repos. The client
/// does not need the list: given the account number, the answer is the same
/// two banks every time. So it asks the question itself and offers the choice.
class PhoneAccountBanks {
  const PhoneAccountBanks._();

  /// Banks whose account number IS the customer's phone number.
  ///
  /// No codes here on purpose: OPay is 999992 on Flutterwave and 305 on
  /// Nomba, so a code is only ever read from the active rail's own list. One
  /// from the wrong rail pays the wrong bank.
  static const List<String> names = ['OPay', 'PalmPay'];

  /// Nigerian mobile prefixes, without the leading zero.
  static const List<String> _mobilePrefixes = [
    '70', '71', '78', '80', '81', '90', '91',
  ];

  static const Map<String, String> _aliases = {
    'opay': 'OPay',
    'o-pay': 'OPay',
    'o pay': 'OPay',
    'opay digital services': 'OPay',
    'paycom': 'OPay',
    'palmpay': 'PalmPay',
    'palm pay': 'PalmPay',
  };

  /// `0XXXXXXXXXX`, or null when the input is not a Nigerian mobile number.
  ///
  /// The leading zero is the whole point. Without it a number is ten digits
  /// and looks exactly like a NUBAN, which is how an OPay account typed the
  /// way people actually type it was sent to the rail as an ordinary bank
  /// account and came back rejected.
  static String? normaliseMobile(String? raw) {
    if (raw == null) return null;
    var digits = raw.replaceAll(RegExp(r'\D'), '');
    if (digits.isEmpty) return null;

    if (digits.startsWith('234')) {
      digits = '0${digits.substring(3)}';
    } else if (digits.length == 10) {
      // The ambiguous case: ten digits is a mobile number missing its zero
      // ONLY if what follows is a real mobile prefix. A NUBAN beginning "80"
      // would otherwise be silently rewritten into a phone number.
      if (!_mobilePrefixes.contains(digits.substring(0, 2))) return null;
      digits = '0$digits';
    }

    if (digits.length != 11 || !digits.startsWith('0')) return null;
    if (!_mobilePrefixes.contains(digits.substring(1, 3))) return null;
    return digits;
  }

  /// "OPay" / "PalmPay" for any real-world spelling, else null.
  static String? canonicalBank(String? name) {
    if (name == null) return null;
    final key = name.trim().toLowerCase().replaceAll(RegExp(r'\s+'), ' ');
    if (key.isEmpty) return null;
    final exact = _aliases[key];
    if (exact != null) return exact;
    // Longest alias first so "palm pay" cannot be shadowed by a shorter one.
    final keys = _aliases.keys.toList()
      ..sort((a, b) => b.length.compareTo(a.length));
    for (final alias in keys) {
      if (key.contains(alias)) return _aliases[alias];
    }
    return null;
  }

  static bool isPhoneAccountBank(String? name) => canonicalBank(name) != null;

  /// Whether this account number should be paid as a phone-number account,
  /// and therefore whether to offer the OPay / PalmPay choice.
  static bool looksLikePhoneAccount(String? accountNumber) =>
      normaliseMobile(accountNumber) != null;

  /// The banks to offer for [accountNumber].
  ///
  /// Both, unless the scan already named one — a phone number cannot tell an
  /// OPay account from a PalmPay one, plenty of people have both, and paying
  /// the wrong one is unrecoverable. Empty when the number is not a phone
  /// number at all, so the caller renders nothing rather than a misleading
  /// choice.
  static List<String> candidatesFor(String? accountNumber, {String? bankName}) {
    if (!looksLikePhoneAccount(accountNumber)) return const [];
    final named = canonicalBank(bankName);
    return named != null ? [named] : names;
  }
}
