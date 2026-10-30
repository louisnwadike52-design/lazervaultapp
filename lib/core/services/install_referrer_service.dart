import 'dart:async';
import 'dart:io' show Platform;

import 'package:flutter/foundation.dart';
import 'package:flutter/services.dart';
import 'package:shared_preferences/shared_preferences.dart';

import 'package:lazervault/core/utilities/invite_link.dart';
import 'package:lazervault/core/utilities/pending_referral.dart';

/// HOW A REFERRAL CODE SURVIVES A FRESH INSTALL.
///
/// A universal link only reaches the app if the app is ALREADY installed. The
/// user an invite is actually aimed at does not have it: they tap the link, land
/// on /download, and go to the Play Store. Everything in the URL is gone by the
/// time the app first opens, so the referrer earns nothing and the invitee is
/// asked to retype a code out of a chat thread — which is where most referrals
/// were being lost.
///
/// Play is the one platform that will carry something through an install. The
/// store link sets `referrer=ref=<CODE>` and Play hands that string back on
/// first launch, where it becomes a pending referral exactly as a deep link
/// would.
///
/// iOS HAS NO EQUIVALENT. Apple discards unknown App Store query parameters and
/// offers no install-referrer mechanism, so there the /download page's copy
/// button remains the fallback. This class answers null on iOS rather than
/// pretending otherwise.
///
/// IT NEVER BLOCKS AND NEVER THROWS. A signup must not wait on, or fail
/// because of, an attribution lookup: every failure path is "no referrer".
class InstallReferrerService {
  InstallReferrerService._();

  static final InstallReferrerService instance = InstallReferrerService._();

  @visibleForTesting
  static const MethodChannel channel =
      MethodChannel('com.lazervault.app/install_referrer');

  /// Marks the one-shot as done.
  ///
  /// Play keeps the referrer readable for the life of the install, so without
  /// this the app would re-read and re-apply it on every launch — overwriting a
  /// code the user later typed by hand with the one they arrived with.
  static const String _doneKey = 'install_referrer_checked';

  /// Reads the install referrer once and records any code it carries.
  ///
  /// Returns the code it stored, or null. Safe to call on every launch: after
  /// the first it is a single SharedPreferences read.
  Future<String?> captureOnce() async {
    if (!_isAndroid) return null;

    SharedPreferences prefs;
    try {
      prefs = await SharedPreferences.getInstance();
    } catch (e) {
      debugPrint('InstallReferrerService: prefs unavailable: $e');
      return null;
    }
    if (prefs.getBool(_doneKey) ?? false) return null;

    // Marked done BEFORE the platform call, not after.
    //
    // If the fetch hangs or the app is killed mid-call, a retry on the next
    // launch would be the same hang on a path that runs at startup. The
    // referrer is worth one attempt; it is not worth risking a slow open on
    // every subsequent launch.
    try {
      await prefs.setBool(_doneKey, true);
    } catch (_) {
      // Non-fatal: at worst this is read again next launch.
    }

    String? raw;
    try {
      // BOUNDED. The native side replies exactly once and never throws, but it
      // cannot guarantee that the Play Install Referrer service replies AT ALL:
      // if neither onInstallReferrerSetupFinished nor
      // onInstallReferrerServiceDisconnected fires, nothing completes this
      // future. captureOnce is `unawaited` at the call site, so a hang cannot
      // delay app open or a signup — but it would leak the bound service for
      // the life of the process. A deadline turns an indefinite wait into a
      // bounded one, and "no referrer" is already a first-class answer here.
      raw = await channel
          .invokeMethod<String>('fetch')
          .timeout(const Duration(seconds: 10));
    } on TimeoutException {
      debugPrint(
          'InstallReferrerService: fetch timed out — treating as no referrer');
      return null;
    } on MissingPluginException {
      // An older build of the host, or a platform without the channel.
      return null;
    } catch (e) {
      debugPrint('InstallReferrerService: fetch failed: $e');
      return null;
    }

    final code = referralCodeFromReferrer(raw);
    if (code == null) return null;

    // A code already captured WINS. A deep link that fired before this ran is
    // the more specific signal, and a user who typed one deliberately must not
    // be overwritten by where they happened to come from.
    final existing = await PendingReferral.instance.peek();
    if (existing != null && existing.isNotEmpty) return null;

    await PendingReferral.instance.remember(code);
    debugPrint('InstallReferrerService: captured referral from install');
    return code;
  }

  static bool get _isAndroid {
    try {
      return Platform.isAndroid;
    } catch (_) {
      // Platform is unavailable on web/tests; treat as not-Android.
      return false;
    }
  }
}

/// Extracts a referral code from a Play install-referrer string.
///
/// Play hands back whatever the store link's `referrer` parameter held. The
/// website sets `ref=<CODE>`, but the same field is the industry's dumping
/// ground for UTM tags, so the value is parsed as a query string and the `ref`
/// key is read out of it — tolerating the other parameters an analytics tool
/// may have added alongside.
///
/// A BARE code is also accepted. `referrer=NOBL0KEP` carries no `=`, which a
/// strict query parser reads as a key with no value; refusing it would lose a
/// perfectly good attribution over a formatting detail nobody controls.
///
/// Normalisation goes through [InviteLink.codeFrom] so the install-referrer
/// path, the deep-link path and the website all accept and reject exactly the
/// same strings.
@visibleForTesting
String? referralCodeFromReferrer(String? raw) {
  final s = raw?.trim() ?? '';
  if (s.isEmpty) return null;

  // TWO PASSES, and the order is the whole point.
  //
  // Play normally hands the value back decoded, but it passes through other
  // people's tooling and can arrive with its separators still encoded
  // (`ref%3DNOBL0KEP`). Every STRUCTURED reading is tried first, across the raw
  // string and a once-decoded copy, before anything is treated as a bare code.
  //
  // Getting that order wrong is not a near-miss, it is a wrong answer: the
  // encoded form has no literal `=`, so a bare-value reading of it yields
  // "REFNOBL0KEP" — a plausible-looking code belonging to nobody. The referral
  // is lost and the log says a code was found.
  final candidates = _referrerCandidates(s);

  for (final candidate in candidates) {
    try {
      final direct = InviteLink.codeFrom(Uri.parse('https://x/?$candidate'));
      if (direct != null) return direct;
    } catch (_) {
      // Try the next form.
    }
  }

  // Only now: a value with no separator at all is the code itself.
  for (final candidate in candidates) {
    if (candidate.contains('=') || candidate.contains('&')) continue;
    try {
      final bare = InviteLink.codeFrom(
          Uri.parse('https://x/?${InviteLink.refKey}=$candidate'));
      if (bare != null) return bare;
    } catch (_) {
      // Try the next form.
    }
  }
  return null;
}

/// The forms of a referrer string worth trying, most-likely first.
///
/// Only decodes when the string actually looks encoded, so an ordinary value is
/// never put through a transformation that could change it.
List<String> _referrerCandidates(String s) {
  final out = <String>[s];
  final lower = s.toLowerCase();
  if (lower.contains('%3d') || lower.contains('%26')) {
    try {
      final decoded = Uri.decodeComponent(s).trim();
      if (decoded.isNotEmpty && decoded != s) out.add(decoded);
    } catch (_) {
      // An undecodable string is simply not a candidate.
    }
  }
  return out;
}
