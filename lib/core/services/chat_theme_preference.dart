library;

import 'package:flutter/material.dart';
import 'package:shared_preferences/shared_preferences.dart';

import 'package:lazervault/core/config/feature_flags.dart';

/// THE ACCENT THE AI CHAT IS PAINTED IN.
///
/// The chat was a fixed purple with no way to change it — the three-dot menu
/// offered Clear, Export and AI Settings, and nothing about how it looks.
///
/// Sits alongside [ChatLanguagePreference]: the same shape, the same storage,
/// read wherever the chat paints itself. A plain static holder rather than a
/// provider because the chat already rebuilds on its own state changes, and a
/// notifier lets a change land without reopening the screen.
///
/// ## The default is the platform's, not this file's
///
/// [FeatureFlags.chatDefaultAccentKey] carries an admin-set default, so a
/// deployment can brand the assistant without an app release. A user's own
/// choice always wins over it — the admin default only answers "what does
/// someone who has never chosen see".
class ChatAccent {
  const ChatAccent({
    required this.id,
    required this.label,
    required this.primary,
    required this.secondary,
  });

  /// Stable storage id. Never a colour value: a palette tweak would otherwise
  /// orphan everyone's saved choice.
  final String id;
  final String label;

  /// The strong colour — user bubbles, the send button, the header.
  final Color primary;

  /// The lighter companion used for gradients and glows.
  final Color secondary;
}

class ChatThemePreference {
  ChatThemePreference._();

  static const String _accentKey = 'chat_accent';
  static const String _bubbleKey = 'chat_bubble_shape';

  /// Six, deliberately. Enough to feel like a choice, few enough that every
  /// one has been checked for contrast against the chat's dark surface —
  /// an accent nobody can read their own message on is not a theme.
  static const List<ChatAccent> accents = [
    ChatAccent(
      id: 'purple',
      label: 'Purple',
      primary: Color(0xFF8B5CF6),
      secondary: Color(0xFFA78BFA),
    ),
    ChatAccent(
      id: 'indigo',
      label: 'Indigo',
      primary: Color(0xFF4834D4),
      secondary: Color(0xFF6C5CE7),
    ),
    ChatAccent(
      id: 'teal',
      label: 'Teal',
      primary: Color(0xFF14B8A6),
      secondary: Color(0xFF2DD4BF),
    ),
    ChatAccent(
      id: 'emerald',
      label: 'Emerald',
      primary: Color(0xFF10B981),
      secondary: Color(0xFF34D399),
    ),
    ChatAccent(
      id: 'amber',
      label: 'Amber',
      primary: Color(0xFFF59E0B),
      secondary: Color(0xFFFBBF24),
    ),
    ChatAccent(
      id: 'rose',
      label: 'Rose',
      primary: Color(0xFFF43F5E),
      secondary: Color(0xFFFB7185),
    ),
  ];

  /// Bumped on every change so an open chat repaints without being reopened.
  static final ValueNotifier<int> revision = ValueNotifier<int>(0);

  static SharedPreferences? _prefs;

  /// Call once at startup, next to the other preference warm-ups. Safe to call
  /// again; a second call just refreshes the handle.
  static Future<void> init() async {
    _prefs = await SharedPreferences.getInstance();
    revision.value++;
  }

  static ChatAccent byId(String? id) {
    for (final a in accents) {
      if (a.id == id) return a;
    }
    return accents.first;
  }

  /// What the platform shows someone who has never chosen.
  ///
  /// Falls back to the first accent when the admin value names an accent this
  /// build does not have — a deployment can be ahead of a store release, and
  /// an unknown name must not paint the chat in nothing.
  static ChatAccent get platformDefault =>
      byId(FeatureFlags.chatDefaultAccent);

  /// The accent in force: the user's choice, else the platform default.
  static ChatAccent get accent {
    final saved = _prefs?.getString(_accentKey);
    if (saved == null || saved.isEmpty) return platformDefault;
    return byId(saved);
  }

  static bool get hasUserChoice {
    final saved = _prefs?.getString(_accentKey);
    return saved != null && saved.isNotEmpty;
  }

  static Future<void> setAccent(String id) async {
    _prefs ??= await SharedPreferences.getInstance();
    await _prefs!.setString(_accentKey, id);
    revision.value++;
  }

  /// Back to whatever the platform sets, rather than to this file's first
  /// entry — "reset" should mean the same thing as "never chose".
  static Future<void> clearAccent() async {
    _prefs ??= await SharedPreferences.getInstance();
    await _prefs!.remove(_accentKey);
    revision.value++;
  }

  /// Square-ish or fully rounded bubbles. Stored as a bool because there are
  /// two, and a third would be a new setting rather than a third value here.
  static bool get roundedBubbles => _prefs?.getBool(_bubbleKey) ?? true;

  static Future<void> setRoundedBubbles(bool rounded) async {
    _prefs ??= await SharedPreferences.getInstance();
    await _prefs!.setBool(_bubbleKey, rounded);
    revision.value++;
  }

  static double get bubbleRadius => roundedBubbles ? 18 : 8;
}
