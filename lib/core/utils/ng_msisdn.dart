/// Nigerian mobile numbers, accepted the way people actually type them.
///
/// Every bill flow that takes a phone number — airtime, data, cable TV,
/// electricity, education, betting, ePINs — gated its Buy button on
/// `^0\d{10}$`: eleven digits with a leading zero, and nothing else.
///
/// The field that number is typed into shows a `+234` prefix. A customer who
/// reads that prefix and types the ten-digit national number (9035137654 —
/// which is what the prefix is asking for) got a disabled button with nothing
/// on screen explaining why. The same customer typing 09035137654 succeeded.
/// Reported as "even airtime purchase is currently failing": the request never
/// reached the service at all, because the button never enabled.
///
/// Providers want one shape — the eleven-digit 0-prefixed form — so the fix is
/// to accept every spelling and normalise once, here, rather than ask the
/// customer to guess which one the field wants.
///
/// Accepted (all resolve to 09035137654):
///   09035137654     11 digits, the canonical form
///   9035137654      10 digits, what the +234 prefix asks for
///   2349035137654   dialling code, as a contact-book entry often holds it
///   +2349035137654  dialling code with the plus
///   002349035137654 international access code
///   0903 513 7654 / 0903-513-7654 / (0903) 513 7654
///
/// Rejected: anything whose ten-digit national number does not begin 7, 8 or 9
/// — Nigerian mobile prefixes are 070/071/080/081/090/091 — and anything with
/// the wrong number of digits. Rejecting a landline here is deliberate: these
/// flows top up a SIM.
library;

/// The ten-digit national number, or null when [raw] is not a Nigerian mobile.
String? ngNationalNumber(String raw) {
  var d = raw.replaceAll(RegExp(r'[^0-9+]'), '');
  // A leading + is only meaningful before the country code; strip it and let
  // the 234 branch below do the work.
  if (d.startsWith('+')) d = d.substring(1);
  d = d.replaceAll('+', '');

  // 00 is the international access prefix in much of the world; a contact
  // saved while roaming often carries it.
  if (d.startsWith('00234')) {
    d = d.substring(5);
  } else if (d.startsWith('234')) {
    d = d.substring(3);
  } else if (d.length == 11 && d.startsWith('0')) {
    d = d.substring(1);
  }

  // After stripping any prefix we must be left with exactly the national
  // number. A stray leading zero can survive the 234 branch (+2340903…),
  // which some contact books write.
  if (d.length == 11 && d.startsWith('0')) d = d.substring(1);

  if (d.length != 10) return null;
  if (!RegExp(r'^[789]\d{9}$').hasMatch(d)) return null;
  return d;
}

/// The form providers are sent: eleven digits, leading zero. Null when [raw]
/// is not a Nigerian mobile number.
///
/// Always send THIS, never the raw field text — a customer who typed the
/// ten-digit form would otherwise have ten digits forwarded to a provider that
/// requires eleven.
String? normaliseNgMsisdn(String raw) {
  final nsn = ngNationalNumber(raw);
  return nsn == null ? null : '0$nsn';
}

/// Whether [raw] is a Nigerian mobile number in any accepted spelling. This is
/// the predicate a Buy button should gate on.
bool isValidNgMsisdn(String raw) => ngNationalNumber(raw) != null;

/// What to tell someone whose number is not accepted yet, or null while the
/// field is empty or still being typed.
///
/// Deliberately quiet until there is enough to judge: shouting "invalid" at
/// the third keystroke is noise, and the button being disabled already says
/// "not yet".
String? ngMsisdnHint(String raw) {
  final digits = raw.replaceAll(RegExp(r'[^0-9]'), '');
  if (digits.isEmpty) return null;
  if (isValidNgMsisdn(raw)) return null;
  if (digits.length < 10) return null; // still typing
  if (digits.length > 14) return 'That number is too long';
  final nsn = digits.length >= 10 ? digits.substring(digits.length - 10) : '';
  if (nsn.isNotEmpty && !RegExp(r'^[789]').hasMatch(nsn)) {
    return "That doesn't look like a Nigerian mobile number";
  }
  return 'Check the number — it should be 11 digits, or 10 after +234';
}
