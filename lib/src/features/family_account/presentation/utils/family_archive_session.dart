library;

import 'package:flutter/foundation.dart';

/// Whether CLOSED Family & Friends accounts are currently being shown.
///
/// Closing a family account archives it: the pool balance returns to the
/// creator, the slot is freed against the per-creator cap, and the row is kept
/// so its history survives. The archive screen can already LIST those rows,
/// but a creator looking back at how the money actually moved needs the real
/// thing — the dashboard card and the detail screen, with the activity feed,
/// the members and the receipts exactly as they were.
///
/// So this is a VIEW MODE, not a setting:
///
///   * It lives in memory only. Nothing is written to SharedPreferences, so it
///     cannot survive a restart by accident.
///   * It is cleared on logout with the rest of the session state, so every
///     login starts with only the active accounts on the dashboard — which is
///     the rule the per-creator cap is expressed in, and what a creator
///     expects to see.
///   * It is a ValueNotifier so the carousel and the CTA repaint together the
///     moment it flips, rather than waiting for whatever rebuilds next.
///
/// Deliberately NOT a toggle that re-opens anything: an archived account stays
/// read-only and keeps its freed slot. This only decides whether it is on
/// screen.
class FamilyArchiveSession {
  FamilyArchiveSession._();

  static final FamilyArchiveSession instance = FamilyArchiveSession._();

  /// True while closed accounts are being shown on the dashboard.
  final ValueNotifier<bool> showClosed = ValueNotifier<bool>(false);

  bool get isShowing => showClosed.value;

  void show() => showClosed.value = true;
  void hide() => showClosed.value = false;
  void toggle() => showClosed.value = !showClosed.value;

  /// Called from the auth cubit's session teardown. Logging out must put the
  /// dashboard back to "active accounts only" — a creator who closed an
  /// account and then signed out should not find it waiting for them.
  void clear() => showClosed.value = false;
}
