import 'package:get/get.dart';
import 'package:lazervault/core/config/country_config.dart';

/// Helpers for the email-OR-phone login identifier used by the email+password
/// login flow. The same text field accepts either an email address or a phone
/// number; these utilities detect which and split it into the (email, phone)
/// pair the backend `Login` RPC expects (it matches by whichever is non-empty).

/// The three kinds of login/recovery identifier a single smart field accepts.
enum LoginIdentifierType { phone, email, username }

/// Detect the identifier TYPE from what the user has typed SO FAR, using a
/// deterministic precedence so the field can adapt live as they type:
///  1. starts with '@'    → username (an explicit @handle)
///  2. contains an '@'    → email (a `name@domain` address is being entered —
///                          the moment an '@' appears mid-string it's an email,
///                          not a username)
///  3. has a letter / '_' → username (a plain alphabetic handle)
///  4. otherwise (digits, '+', separators) → phone
/// Empty defaults to [LoginIdentifierType.phone] (the field's resting mode).
LoginIdentifierType detectLoginIdentifierType(String raw) {
  final v = raw.trim();
  if (v.isEmpty) return LoginIdentifierType.phone;
  if (v.startsWith('@')) return LoginIdentifierType.username;
  if (v.contains('@')) return LoginIdentifierType.email;
  if (RegExp(r'[a-zA-Z_]').hasMatch(v)) return LoginIdentifierType.username;
  return LoginIdentifierType.phone;
}

/// True when [raw] looks like an email address (contains "@" and validates).
bool isEmailIdentifier(String raw) {
  final value = raw.trim();
  return value.contains('@') && GetUtils.isEmail(value);
}

/// True when [raw] looks like a phone number (digits, optionally a leading "+",
/// with common separators) of a plausible length.
bool isPhoneIdentifier(String raw) {
  final value = raw.trim();
  if (value.isEmpty || value.contains('@')) return false;
  final cleaned = value.replaceAll(RegExp(r'[\s\-()]'), '');
  if (!RegExp(r'^\+?[0-9]+$').hasMatch(cleaned)) return false;
  final digits = cleaned.replaceAll('+', '');
  return digits.length >= 7 && digits.length <= 15;
}

/// Backend username rules (auth-service resolveUsername): 3–30 chars,
/// letters/digits/underscore, with an optional leading "@" handle prefix. We
/// additionally require at least one non-digit so an all-digit string is
/// treated as a phone (the common case) rather than a numeric username.
final RegExp _usernameRe = RegExp(r'^[a-zA-Z0-9_]{3,30}$');

/// True when [raw] looks like a username (not an email, not a phone).
bool isUsernameIdentifier(String raw) {
  var value = raw.trim();
  if (value.startsWith('@')) {
    value = value.substring(1); // handle prefix is allowed
  } else if (value.contains('@')) {
    return false; // an embedded "@" means email, not username
  }
  if (!_usernameRe.hasMatch(value)) return false;
  if (RegExp(r'^[0-9]+$').hasMatch(value)) return false; // pure digits → phone
  return true;
}

/// Normalize a username identifier: strip a leading "@" and lowercase (usernames
/// are stored + looked up lowercase on the backend).
String normalizeUsernameIdentifier(String raw) {
  final value = raw.trim();
  final u = value.startsWith('@') ? value.substring(1) : value;
  return u.toLowerCase();
}

/// Whether [raw] is a usable login identifier (a valid email, phone or username).
bool isValidLoginIdentifier(String raw) =>
    isEmailIdentifier(raw) || isPhoneIdentifier(raw) || isUsernameIdentifier(raw);

/// Normalize a phone identifier to E.164. A leading "+" is respected as an
/// explicit international number; otherwise the dialing code for [countryIso]
/// (default Nigeria) is applied after dropping a national trunk "0". Returns the
/// original string when it can't be normalized.
String normalizePhoneIdentifier(String raw, {String countryIso = 'NG'}) {
  final cleaned = raw.trim().replaceAll(RegExp(r'[\s\-()]'), '');
  if (cleaned.startsWith('+')) {
    return '+${cleaned.substring(1).replaceAll('+', '')}';
  }
  final national = cleaned.replaceFirst(RegExp(r'^0+'), '');
  final dialing = CountryConfigs.getDialingCode(countryIso) ??
      CountryConfigs.getDialingCode('NG') ??
      '+234';
  return '$dialing$national';
}

/// Split a login identifier into the (email, phone) pair for the Login RPC.
/// Exactly one is non-empty. Phone is normalized to E.164 using [countryIso]
/// (the country selected in the login UI; default Nigeria).
/// A username, when detected, rides in the `email` field — the backend
/// `resolveLoginUser` detects an email/phone/username by shape, so no separate
/// proto field is needed.
({String email, String phone}) splitLoginIdentifier(String raw,
    {String countryIso = 'NG'}) {
  final value = raw.trim();
  if (isPhoneIdentifier(value) && !isEmailIdentifier(value)) {
    return (email: '', phone: normalizePhoneIdentifier(value, countryIso: countryIso));
  }
  if (!isEmailIdentifier(value) && isUsernameIdentifier(value)) {
    return (email: normalizeUsernameIdentifier(value), phone: '');
  }
  return (email: value, phone: '');
}

/// True when a login failure means NO ACCOUNT MATCHED THE IDENTIFIER, as
/// opposed to the passcode being wrong.
///
/// auth-service separates these deliberately: a user lookup that finds nothing
/// returns exactly "invalid credentials", while a genuinely wrong passcode
/// returns "Incorrect passcode. N attempt(s) remaining before your account is
/// temporarily locked". Treating the two the same is what made a typo'd email
/// surface as "your correct passcode was rejected", with the real mistake two
/// screens back and never named.
///
/// Shared by the login screen (which sends the user back to the identifier
/// field) and the returning-user lock screen (where a stale CACHED identifier
/// means no passcode can ever work). One predicate so the two cannot drift.
///
/// This distinction is already visible in the API's responses, so acting on it
/// in the UI reveals nothing to an attacker that probing did not already.
bool isUnknownIdentifierFailure(String message) {
  return message.toLowerCase().contains('invalid credentials');
}
