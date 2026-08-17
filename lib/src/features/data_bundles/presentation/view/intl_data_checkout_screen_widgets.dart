part of 'intl_data_checkout_screen.dart';

/// Per-country phone number spec: dial code, national-significant-number
/// length (or min/max range), and whether a leading `0` is conventionally
/// typed. Reused by [IntlDataCheckoutScreen] for phone validation.
class IntlDataCountry {
  final String code;
  final String name;
  final String dial;
  final String flag;
  final int nsnMin;
  final int nsnMax;
  final bool leadingZeroAllowed;
  const IntlDataCountry(
    this.code,
    this.name,
    this.dial,
    this.flag, {
    required this.nsnMin,
    required this.nsnMax,
    required this.leadingZeroAllowed,
  });

  /// Master list of Reloadly-supported markets for data bundles with
  /// accurate per-country NSN (national significant number) lengths and
  /// trunk-zero conventions. Validation is handled locally before we
  /// ever call the backend / Reloadly /topups API — any phone outside
  /// [nsnMin, nsnMax] would be rejected upstream anyway, so we catch it
  /// client-side to give users an instant error instead of a round-trip.
  ///
  /// Lengths sourced from ITU E.164 national-number specs and Reloadly's
  /// published supported-country catalogue (mobile MSISDN ranges).
  /// `leadingZeroAllowed` mirrors each country's domestic dialling
  /// convention — when true, users can type `0xxx…` and validation
  /// strips the trunk zero before length-checking (see
  /// [_IntlDataCheckoutScreenState._normalisedNsn]).
  static const List<IntlDataCountry> all = [
    // West Africa
    IntlDataCountry('NG', 'Nigeria', '+234', '\u{1F1F3}\u{1F1EC}', nsnMin: 10, nsnMax: 10, leadingZeroAllowed: true),
    IntlDataCountry('GH', 'Ghana', '+233', '\u{1F1EC}\u{1F1ED}', nsnMin: 9, nsnMax: 9, leadingZeroAllowed: true),
    IntlDataCountry('CI', 'Cote d\'Ivoire', '+225', '\u{1F1E8}\u{1F1EE}', nsnMin: 8, nsnMax: 10, leadingZeroAllowed: false),
    IntlDataCountry('SN', 'Senegal', '+221', '\u{1F1F8}\u{1F1F3}', nsnMin: 9, nsnMax: 9, leadingZeroAllowed: false),
    IntlDataCountry('CM', 'Cameroon', '+237', '\u{1F1E8}\u{1F1F2}', nsnMin: 9, nsnMax: 9, leadingZeroAllowed: false),
    // East Africa
    IntlDataCountry('KE', 'Kenya', '+254', '\u{1F1F0}\u{1F1EA}', nsnMin: 9, nsnMax: 9, leadingZeroAllowed: true),
    IntlDataCountry('TZ', 'Tanzania', '+255', '\u{1F1F9}\u{1F1FF}', nsnMin: 9, nsnMax: 9, leadingZeroAllowed: true),
    IntlDataCountry('UG', 'Uganda', '+256', '\u{1F1FA}\u{1F1EC}', nsnMin: 9, nsnMax: 9, leadingZeroAllowed: true),
    IntlDataCountry('RW', 'Rwanda', '+250', '\u{1F1F7}\u{1F1FC}', nsnMin: 9, nsnMax: 9, leadingZeroAllowed: false),
    IntlDataCountry('ET', 'Ethiopia', '+251', '\u{1F1EA}\u{1F1F9}', nsnMin: 9, nsnMax: 9, leadingZeroAllowed: true),
    // North & Southern Africa
    IntlDataCountry('EG', 'Egypt', '+20', '\u{1F1EA}\u{1F1EC}', nsnMin: 10, nsnMax: 10, leadingZeroAllowed: true),
    IntlDataCountry('MA', 'Morocco', '+212', '\u{1F1F2}\u{1F1E6}', nsnMin: 9, nsnMax: 9, leadingZeroAllowed: true),
    IntlDataCountry('ZA', 'South Africa', '+27', '\u{1F1FF}\u{1F1E6}', nsnMin: 9, nsnMax: 9, leadingZeroAllowed: true),
    // Americas
    IntlDataCountry('US', 'United States', '+1', '\u{1F1FA}\u{1F1F8}', nsnMin: 10, nsnMax: 10, leadingZeroAllowed: false),
    IntlDataCountry('CA', 'Canada', '+1', '\u{1F1E8}\u{1F1E6}', nsnMin: 10, nsnMax: 10, leadingZeroAllowed: false),
    IntlDataCountry('MX', 'Mexico', '+52', '\u{1F1F2}\u{1F1FD}', nsnMin: 10, nsnMax: 10, leadingZeroAllowed: false),
    IntlDataCountry('BR', 'Brazil', '+55', '\u{1F1E7}\u{1F1F7}', nsnMin: 10, nsnMax: 11, leadingZeroAllowed: false),
    IntlDataCountry('AR', 'Argentina', '+54', '\u{1F1E6}\u{1F1F7}', nsnMin: 10, nsnMax: 10, leadingZeroAllowed: false),
    // Europe
    IntlDataCountry('GB', 'United Kingdom', '+44', '\u{1F1EC}\u{1F1E7}', nsnMin: 10, nsnMax: 10, leadingZeroAllowed: true),
    IntlDataCountry('DE', 'Germany', '+49', '\u{1F1E9}\u{1F1EA}', nsnMin: 10, nsnMax: 11, leadingZeroAllowed: true),
    IntlDataCountry('FR', 'France', '+33', '\u{1F1EB}\u{1F1F7}', nsnMin: 9, nsnMax: 9, leadingZeroAllowed: true),
    IntlDataCountry('ES', 'Spain', '+34', '\u{1F1EA}\u{1F1F8}', nsnMin: 9, nsnMax: 9, leadingZeroAllowed: false),
    IntlDataCountry('IT', 'Italy', '+39', '\u{1F1EE}\u{1F1F9}', nsnMin: 9, nsnMax: 10, leadingZeroAllowed: false),
    IntlDataCountry('NL', 'Netherlands', '+31', '\u{1F1F3}\u{1F1F1}', nsnMin: 9, nsnMax: 9, leadingZeroAllowed: true),
    IntlDataCountry('PL', 'Poland', '+48', '\u{1F1F5}\u{1F1F1}', nsnMin: 9, nsnMax: 9, leadingZeroAllowed: false),
    IntlDataCountry('PT', 'Portugal', '+351', '\u{1F1F5}\u{1F1F9}', nsnMin: 9, nsnMax: 9, leadingZeroAllowed: false),
    IntlDataCountry('TR', 'Turkey', '+90', '\u{1F1F9}\u{1F1F7}', nsnMin: 10, nsnMax: 10, leadingZeroAllowed: true),
    // Middle East
    IntlDataCountry('AE', 'United Arab Emirates', '+971', '\u{1F1E6}\u{1F1EA}', nsnMin: 9, nsnMax: 9, leadingZeroAllowed: true),
    IntlDataCountry('SA', 'Saudi Arabia', '+966', '\u{1F1F8}\u{1F1E6}', nsnMin: 9, nsnMax: 9, leadingZeroAllowed: true),
    // Asia
    IntlDataCountry('IN', 'India', '+91', '\u{1F1EE}\u{1F1F3}', nsnMin: 10, nsnMax: 10, leadingZeroAllowed: false),
    IntlDataCountry('PK', 'Pakistan', '+92', '\u{1F1F5}\u{1F1F0}', nsnMin: 10, nsnMax: 10, leadingZeroAllowed: true),
    IntlDataCountry('BD', 'Bangladesh', '+880', '\u{1F1E7}\u{1F1E9}', nsnMin: 10, nsnMax: 10, leadingZeroAllowed: true),
    IntlDataCountry('PH', 'Philippines', '+63', '\u{1F1F5}\u{1F1ED}', nsnMin: 10, nsnMax: 10, leadingZeroAllowed: true),
    IntlDataCountry('ID', 'Indonesia', '+62', '\u{1F1EE}\u{1F1E9}', nsnMin: 9, nsnMax: 12, leadingZeroAllowed: true),
    IntlDataCountry('MY', 'Malaysia', '+60', '\u{1F1F2}\u{1F1FE}', nsnMin: 9, nsnMax: 10, leadingZeroAllowed: true),
    IntlDataCountry('TH', 'Thailand', '+66', '\u{1F1F9}\u{1F1ED}', nsnMin: 9, nsnMax: 9, leadingZeroAllowed: true),
    IntlDataCountry('VN', 'Vietnam', '+84', '\u{1F1FB}\u{1F1F3}', nsnMin: 9, nsnMax: 10, leadingZeroAllowed: true),
    IntlDataCountry('CN', 'China', '+86', '\u{1F1E8}\u{1F1F3}', nsnMin: 11, nsnMax: 11, leadingZeroAllowed: false),
    // Oceania
    IntlDataCountry('AU', 'Australia', '+61', '\u{1F1E6}\u{1F1FA}', nsnMin: 9, nsnMax: 9, leadingZeroAllowed: true),
    IntlDataCountry('NZ', 'New Zealand', '+64', '\u{1F1F3}\u{1F1FF}', nsnMin: 8, nsnMax: 10, leadingZeroAllowed: true),
  ];

  /// Lookup by ISO-2 code.
  static IntlDataCountry? byCode(String code) {
    for (final c in all) {
      if (c.code == code) return c;
    }
    return null;
  }
}
