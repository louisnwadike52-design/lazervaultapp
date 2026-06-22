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

  /// All bundled background variants (1–4 forest, 5–8 ocean).
  static const List<String> all = [
    'assets/images/bg/auth_background_1.webp',
    'assets/images/bg/auth_background_2.webp',
    'assets/images/bg/auth_background_3.webp',
    'assets/images/bg/auth_background_4.webp',
    'assets/images/bg/auth_background_5.webp',
    'assets/images/bg/auth_background_6.webp',
    'assets/images/bg/auth_background_7.webp',
    'assets/images/bg/auth_background_8.webp',
  ];

  /// The variant chosen for THIS app launch (random, memoized once).
  static final String current = all[Random().nextInt(all.length)];
}
