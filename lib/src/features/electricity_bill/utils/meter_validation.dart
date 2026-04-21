/// Nigerian DisCo meter-number validation — shared across every
/// electricity-bill screen that accepts a meter number.
///
/// Meter numbers in Nigeria are always digits-only and in the range
/// **10–13 characters**. Source: NERC's prepaid metering standards +
/// the meter-number formats each of the 12 DisCos issue (EKEDC /
/// IKEDC / AEDC / PHED / KEDCO / JED / IBEDC / BEDC / KAEDCO / YEDC /
/// EEDC / APLE). Most prepaid meters are 11 digits; some postpaid /
/// older meters are 10 or 12; a few smart meters go up to 13. Anything
/// outside that band is a typo — not a live meter — so we reject it
/// up-front rather than round-tripping to VTpass only to get back an
/// invalid-meter error.
library;

const int kMeterNumberMinLen = 10;
const int kMeterNumberMaxLen = 13;

/// Returns `null` when [raw] is a valid NG meter number, or a human
/// error message otherwise.
String? validateMeterNumber(String raw) {
  final v = raw.trim();
  if (v.isEmpty) return 'Meter number is required';
  if (!RegExp(r'^\d+$').hasMatch(v)) {
    return 'Meter number must be digits only';
  }
  if (v.length < kMeterNumberMinLen) {
    return 'Meter number must be at least $kMeterNumberMinLen digits';
  }
  if (v.length > kMeterNumberMaxLen) {
    return 'Meter number can\'t be more than $kMeterNumberMaxLen digits';
  }
  return null;
}
