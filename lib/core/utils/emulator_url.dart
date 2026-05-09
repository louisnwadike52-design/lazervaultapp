// Tiny helper for the Android-emulator dev workflow: image URLs the
// backend mints in local-dev (e.g. http://localhost:8083/uploads/...
// or http://127.0.0.1:8083/uploads/...) are unreachable from inside
// the emulator, which sees the host machine on 10.0.2.2 instead.
//
// We do this rewrite at the LAST possible moment (when the image is
// rendered) rather than at ingest, so:
//   1. Receipts, share links, etc. that other surfaces persist or
//      send out-of-app aren't accidentally rewritten to a host-only
//      address.
//   2. iOS / web / release builds (where the emulator hack does not
//      apply) keep the original URL untouched.
//
// Release builds and non-Android targets are no-ops, so the helper
// is safe to sprinkle freely on any image source.

import 'dart:io' show Platform;

import 'package:flutter/foundation.dart';

const _emulatorHostHosts = <String>[
  'localhost',
  '127.0.0.1',
];
const _emulatorHostReplacement = '10.0.2.2';

/// Rewrites [url] so an Android emulator can reach the host machine.
/// Returns the input unchanged on iOS / web / desktop / release builds,
/// or when the URL doesn't reference a localhost host.
String rewriteHostForEmulator(String? url) {
  if (url == null || url.isEmpty) return '';
  if (kReleaseMode) return url;
  // The 10.0.2.2 trick is Android-emulator specific. The web target
  // resolves localhost to the dev machine just fine, and iOS uses
  // localhost natively when the simulator and the backend share the
  // host. Guarding by Platform.isAndroid keeps the rewrite scoped.
  if (kIsWeb) return url;
  try {
    if (!Platform.isAndroid) return url;
  } catch (_) {
    // Platform.isAndroid throws on web; the kIsWeb guard above
    // already handles that, but the catch keeps any other host
    // (e.g. fuchsia) on the original URL.
    return url;
  }
  Uri parsed;
  try {
    parsed = Uri.parse(url);
  } catch (_) {
    return url;
  }
  if (!parsed.hasScheme) return url;
  if (!_emulatorHostHosts.contains(parsed.host)) return url;
  return parsed.replace(host: _emulatorHostReplacement).toString();
}
