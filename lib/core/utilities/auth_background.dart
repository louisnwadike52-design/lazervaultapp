import 'dart:math';

/// Bundled auth-screen background photos.
///
/// All variants ship inside the app binary (declared under `assets/images/bg/`).
/// A single one is chosen at RANDOM once per app launch — [current] is a
/// `static final`, so its initializer runs the first time it's read and the same
/// image is then reused across every auth screen for that session (passcode
/// sign-in, passcode setup, transaction-PIN setup). Restarting the app reshuffles.
///
/// The images are not necessarily dark: each auth screen paints a dark overlay
/// on top so the foreground text/keypad stays readable regardless of the photo.
class AuthBackground {
  AuthBackground._();

  /// All bundled background variants — a contiguous 1–12 set, every entry
  /// backed by a real asset so the random pick / rotation can never land on a
  /// missing file (an "empty background"). Grouped: 1–4 forest, 5–8 ocean,
  /// 9–12 city glamour (Lagos, Cape Town, New York, Paris).
  ///
  /// The former galaxy and cow photos were removed from the download set and
  /// the files renumbered so this list stays gap-free — do NOT reintroduce a
  /// gap; add new photos at the end and keep the numbering contiguous.
  static const List<String> all = [
    'assets/images/bg/auth_background_1.webp', // Forest — lone tree at dusk
    'assets/images/bg/auth_background_2.webp', // Forest — misty woodland
    'assets/images/bg/auth_background_3.webp', // Forest — Yosemite valley
    'assets/images/bg/auth_background_4.webp', // Forest — alpine lake at sunset
    'assets/images/bg/auth_background_5.webp', // Ocean — aerial shoreline
    'assets/images/bg/auth_background_6.webp', // Ocean — calm sea at dawn
    'assets/images/bg/auth_background_7.webp', // Ocean — beach with gulls
    'assets/images/bg/auth_background_8.webp', // Ocean — sunset over water
    'assets/images/bg/auth_background_9.webp', // Lagos — Marina / Victoria Island
    'assets/images/bg/auth_background_10.webp', // Cape Town — cityscape
    'assets/images/bg/auth_background_11.webp', // New York — Hudson Yards at night
    'assets/images/bg/auth_background_12.webp', // Paris — city at night
  ];

  /// The variant chosen for THIS app launch (random, memoized once).
  static final String current = all[Random().nextInt(all.length)];
}
