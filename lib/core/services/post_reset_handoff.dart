import 'package:lazervault/core/config/country_config.dart'
    show CountryConfigs;
import 'package:lazervault/src/features/authentication/utils/login_identifier.dart';

/// Carries the identifier a user just proved control of, from a RESET flow to
/// the LOGIN screen that follows it.
///
/// ## Why this exists
///
/// Both reset flows ended by throwing the identifier away. Passcode reset did
/// `Get.offAllNamed(passcodeLogin)` with no arguments; the password screen was
/// handed `email`/`phone` by both of its callers and read only the token. So
/// someone who had just typed their number, received a code, and set a new
/// credential was asked who they were all over again — and on a device with no
/// cached profile, `PasscodeSignIn` bounces to the full login screen, so they
/// landed on a blank form seconds after proving their identity.
///
/// ## Why NOT auto-login instead
///
/// Signing the user in straight from a completed reset is the obvious
/// alternative and it is the wrong trade for a financial app:
///
/// * It mints a SESSION from possession of the reset channel alone. Someone
///   with brief access to an inbox or a SIM would get a live, funded session
///   rather than only a changed credential the real owner notices.
/// * It skips the path that establishes `login_method`, `has_passcode`, device
///   binding and 2FA. Those mirrored flags drifting is exactly what caused the
///   "app lock always opens the login screen" bug (see LoginFlowResolver).
/// * The user never types the new credential, so they can set a passcode they
///   immediately forget.
///
/// Carrying the identifier solves the actual complaint — "it forgot who I am" —
/// at no security cost, and one deliberate entry confirms they remember what
/// they just set.
///
/// ## What this is NOT
///
/// **A prefill, never a proof.** Nothing downstream may treat a value from here
/// as authentication, authorisation, or evidence the account exists. The login
/// screen still demands the passcode or password exactly as before.
///
/// Three properties keep it honest, and all three matter on a shared device:
///
/// * **In memory only.** Never written to storage. A reset is a moment, not a
///   state, and persisting whose account was last recovered is exposure with
///   no benefit.
/// * **Single use.** [consume] clears as it reads, so it cannot resurface on an
///   unrelated screen later in the session.
/// * **Short lived.** It expires on its own, so an abandoned reset cannot
///   prefill the next person to pick the phone up.
class PostResetHandoff {
  PostResetHandoff._();

  /// How long a handed-off identifier stays usable.
  ///
  /// Long enough to survive the success sheet, the navigation and a slow
  /// frame; far too short to still be around when the device changes hands.
  static const Duration ttl = Duration(minutes: 5);

  static String? _identifier;
  static LoginIdentifierType? _type;
  static DateTime? _setAt;

  /// Publish the identifier a reset flow just verified.
  ///
  /// [identifier] is the raw value the user typed (E.164 phone, or an email).
  /// Blank input clears rather than stores, so a flow that could not determine
  /// the identifier degrades to today's behaviour instead of carrying "".
  static void publish(String identifier, LoginIdentifierType type) {
    final v = identifier.trim();
    if (v.isEmpty) {
      clear();
      return;
    }
    _identifier = v;
    _type = type;
    _setAt = DateTime.now();
  }

  /// Take the pending identifier, clearing it.
  ///
  /// Returns null when nothing was published, when it has already been taken,
  /// or when it has expired. Callers treat null as "no prefill" — which is
  /// precisely the behaviour every one of these screens had before.
  static PostResetIdentity? consume() {
    final id = _identifier;
    final type = _type;
    final at = _setAt;
    clear();
    if (id == null || type == null || at == null) return null;
    if (DateTime.now().difference(at) > ttl) return null;
    return PostResetIdentity(identifier: id, type: type);
  }

  /// Read the pending identifier WITHOUT taking it.
  ///
  /// For the one caller that must compare it before deciding where to send the
  /// user: the passcode LOCK screen has to know whether the account that was
  /// just reset is the one it has cached, and consuming here would swallow the
  /// prefill the destination is about to use. Expiry still applies.
  ///
  /// Everything else uses [consume] — a peek that is never followed by a
  /// consume leaves a value to expire on its own, which is safe but wasteful.
  static PostResetIdentity? peek() {
    final id = _identifier;
    final type = _type;
    final at = _setAt;
    if (id == null || type == null || at == null) return null;
    if (DateTime.now().difference(at) > ttl) return null;
    return PostResetIdentity(identifier: id, type: type);
  }

  /// Whether a usable identifier is waiting, without taking it.
  ///
  /// For a caller that must decide WHERE to navigate before the destination
  /// consumes the value — read-only on purpose, so the decision does not
  /// swallow the prefill the destination is about to use.
  static bool get hasPending {
    final at = _setAt;
    if (_identifier == null || at == null) return false;
    return DateTime.now().difference(at) <= ttl;
  }

  /// Drop anything pending. Call on sign-out and on an abandoned flow.
  static void clear() {
    _identifier = null;
    _type = null;
    _setAt = null;
  }
}

/// An identifier carried out of a reset flow. A prefill value and its kind —
/// deliberately nothing else, so it cannot be mistaken for a credential.
class PostResetIdentity {
  const PostResetIdentity({required this.identifier, required this.type});

  final String identifier;
  final LoginIdentifierType type;

  bool get isPhone => type == LoginIdentifierType.phone;
  bool get isEmail => type == LoginIdentifierType.email;
}

/// A phone split into the country it belongs to and the national number.
class SplitPhone {
  const SplitPhone({required this.countryCode, required this.national});

  /// Country CODE (e.g. 'NG'), not the dialing prefix — this is what the
  /// country picker and SmartIdentifierInput both speak.
  final String countryCode;

  /// The number without its dialing prefix, which is what a phone field shows.
  final String national;
}

/// Split an E.164 number against the ACTIVE countries.
///
/// Extracted rather than copied: the passcode-reset screen already did this
/// loop inline to pre-fill its field, and the login screen now needs the same
/// answer to pre-fill its own. Two inline copies of "which country does this
/// number belong to" is how the two screens come to disagree about a number
/// that is the same on both.
///
/// Returns null when nothing matches — an unknown prefix, or a value that is
/// not a phone at all — and every caller treats that as "no prefill", which is
/// the behaviour they each had before.
SplitPhone? splitE164Phone(String e164) {
  final digits = e164.replaceAll(RegExp(r'[^\d]'), '');
  if (digits.isEmpty) return null;
  for (final c in CountryConfigs.activeCountries) {
    final dial = c.dialingCode.replaceAll('+', '');
    if (dial.isNotEmpty && digits.startsWith(dial)) {
      final national = digits.substring(dial.length);
      if (national.isEmpty) return null;
      return SplitPhone(countryCode: c.code, national: national);
    }
  }
  return null;
}
