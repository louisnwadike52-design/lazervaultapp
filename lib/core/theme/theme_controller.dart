import 'package:flutter/material.dart';
import 'package:get/get.dart';

import 'package:lazervault/core/services/secure_storage_service.dart';

/// Owns the app's [ThemeMode] for the light/dark toggle.
///
/// - Startup reads the locally-cached `dark_mode` flag (instant, offline) so the
///   app opens in the right theme.
/// - [setDark] flips the theme instantly via `Get.changeThemeMode` and persists
///   the choice locally (server persistence is done by the Settings flow via
///   `ProfileCubit.updatePreferences`).
/// - [syncFromServer] reconciles with the server preference after profile load
///   (server wins; updates the cache + live theme).
class ThemeController {
  final SecureStorageService _store;
  ThemeMode mode;

  ThemeController(this._store, this.mode);

  static Future<ThemeController> create(SecureStorageService store) async {
    bool dark = false;
    try {
      dark = await store.getDarkMode();
    } catch (_) {}
    return ThemeController(store, dark ? ThemeMode.dark : ThemeMode.light);
  }

  bool get isDark => mode == ThemeMode.dark;

  /// Flip the theme now + persist locally.
  Future<void> setDark(bool dark) async {
    mode = dark ? ThemeMode.dark : ThemeMode.light;
    Get.changeThemeMode(mode);
    try {
      await _store.setDarkMode(dark);
    } catch (_) {}
  }

  /// Reconcile with the server-stored preference (called after profile load).
  Future<void> syncFromServer(bool darkFromServer) async {
    if (isDark == darkFromServer) return;
    await setDark(darkFromServer);
  }
}
