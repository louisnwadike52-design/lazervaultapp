import 'dart:io';

import 'package:sms_autofill/sms_autofill.dart';

import 'package:lazervault/core/config/country_config.dart';

/// A device phone number resolved from the platform hint picker, split into the
/// parts the phone input needs.
class DevicePhone {
  final String e164; // +2348012345678
  final String countryCode; // NG
  final String national; // 8012345678 (dial code stripped)

  const DevicePhone({
    required this.e164,
    required this.countryCode,
    required this.national,
  });
}

/// Wraps the platform "phone number hint" picker (Android Smart Lock / Google
/// Phone Number Hint via sms_autofill). Shows the OS bottom sheet listing the
/// SIM numbers on the device; the user taps one and we get it back — no runtime
/// permission needed. iOS has no such API, so it's Android-only and degrades to
/// a no-op (callers hide the CTA when [isSupported] is false).
class DevicePhoneHint {
  DevicePhoneHint._();

  static bool get isSupported => Platform.isAndroid;

  /// Shows the picker and returns the chosen number parsed into
  /// (e164, countryCode, national), or null when unsupported / cancelled /
  /// the picker returned nothing.
  ///
  /// [preferredCountry] is the ISO code currently selected on the screen. It's
  /// used as the fallback when the device returns a LOCAL-format number (e.g. a
  /// Nigerian SIM handing back `0803…`/`803…` with no `+234`) — without it those
  /// perfectly-valid numbers used to fail the dial-code match and get dropped as
  /// "couldn't read a number". Defaults to the first active country when null.
  static Future<DevicePhone?> request({String? preferredCountry}) async {
    if (!isSupported) return null;
    String? raw;
    try {
      raw = await SmsAutoFill().hint;
    } catch (_) {
      return null;
    }
    if (raw == null || raw.trim().isEmpty) return null;
    return _parse(raw.trim(), preferredCountry: preferredCountry);
  }

  static DevicePhone? _parse(String raw, {String? preferredCountry}) {
    final digits = raw.replaceAll(RegExp(r'[^\d+]'), '');
    final hadPlus = digits.startsWith('+');
    final bare = hadPlus ? digits.substring(1) : digits;
    if (bare.isEmpty) return null;

    // 1) International: longest dial-code prefix match against the active
    // countries so e.g. +234… resolves to NG and +1… to the right NANP entry.
    CountryConfig? best;
    var bestLen = 0;
    for (final c in CountryConfigs.activeCountries) {
      final dial = c.dialingCode.replaceAll('+', '');
      if (dial.isNotEmpty && bare.startsWith(dial) && dial.length > bestLen) {
        best = c;
        bestLen = dial.length;
      }
    }
    if (best != null) {
      final national = _stripTrunk(bare.substring(bestLen));
      if (national.isEmpty) return null;
      final dial = best.dialingCode.replaceAll('+', '');
      return DevicePhone(
        e164: '+$dial$national',
        countryCode: best.code,
        national: national,
      );
    }

    // 2) No dial-code match. The picker returned a LOCAL/national-format number
    // (no usable country code) — resolve it against the country selected on the
    // screen (or the first active country) and treat the digits as a national
    // number. This is the common case the old code wrongly dropped as null.
    final fallback = _countryFor(preferredCountry);
    if (fallback == null) return null;
    final national = _stripTrunk(bare);
    if (national.isEmpty) return null;
    final dial = fallback.dialingCode.replaceAll('+', '');
    return DevicePhone(
      e164: '+$dial$national',
      countryCode: fallback.code,
      national: national,
    );
  }

  /// Drop a single leading national trunk '0' (NG/UK/… local prefix) so the
  /// national part matches what the phone field expects in E.164 terms.
  static String _stripTrunk(String national) =>
      national.length > 1 && national.startsWith('0')
          ? national.substring(1)
          : national;

  /// Resolve an ISO country code to its config, falling back to the first
  /// active country. Returns null only when there are no active countries.
  static CountryConfig? _countryFor(String? code) {
    final list = CountryConfigs.activeCountries;
    if (list.isEmpty) return null;
    if (code != null && code.trim().isNotEmpty) {
      for (final c in list) {
        if (c.code.toUpperCase() == code.trim().toUpperCase()) return c;
      }
    }
    return list.first;
  }
}
