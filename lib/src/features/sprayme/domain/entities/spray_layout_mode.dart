import 'package:flutter/material.dart';

/// How a Lazerspray live arranges its participants.
///
/// The three arrangements every video product converges on — TikTok LIVE,
/// Zoom and Google Meet all offer the same set under different names:
///
/// * [grid]      — everyone the same size. Best for co-hosts, where no single
///                 person is "the" speaker.
/// * [sidebar]   — one large view with the others stacked down the side.
/// * [spotlight] — one person full-bleed, the rest in a strip along the bottom.
///
/// [grid] is the product default (see [kSprayDefaultLayoutMode]); an admin can
/// change the platform default without a redeploy, and a viewer can always
/// override it for themselves inside a room.
enum SprayLayoutMode {
  grid,
  sidebar,
  spotlight;

  /// Label shown in the layout picker. Sentence case, like every other control.
  String get label => switch (this) {
        SprayLayoutMode.grid => 'Grid',
        SprayLayoutMode.sidebar => 'Sidebar',
        SprayLayoutMode.spotlight => 'Spotlight',
      };

  /// One line explaining what the viewer will get.
  String get description => switch (this) {
        SprayLayoutMode.grid => 'Everyone the same size',
        SprayLayoutMode.sidebar => 'Main view with others beside it',
        SprayLayoutMode.spotlight => 'One person full screen',
      };

  IconData get icon => switch (this) {
        SprayLayoutMode.grid => Icons.grid_view_rounded,
        SprayLayoutMode.sidebar => Icons.view_sidebar_rounded,
        SprayLayoutMode.spotlight => Icons.person_rounded,
      };

  /// The value an admin stores in system settings for this mode.
  String get settingValue => name;
}

/// The built-in default, used until the admin value is known.
///
/// Grid, deliberately: a spray live is a party with co-hosts rather than a
/// single presenter, so equal tiles are right more often than a spotlight. It
/// is also the safest first paint — a grid of one participant looks identical
/// to a spotlight of one, so opening in grid and later adopting a different
/// admin default cannot produce a jarring re-layout for the common case.
const SprayLayoutMode kSprayDefaultLayoutMode = SprayLayoutMode.grid;

/// The system-settings key an admin flips to change the platform default.
const String kSprayLayoutModeSettingKey = 'sprayme_default_layout_mode';

/// Parses an admin-configured value into a mode.
///
/// Anything unrecognised — a typo in the dashboard, a value from a newer build,
/// an empty string — falls back to [kSprayDefaultLayoutMode] rather than
/// throwing. A bad settings row must never stop a live from rendering.
SprayLayoutMode sprayLayoutModeFromSetting(String? raw) {
  final value = raw?.trim().toLowerCase();
  if (value == null || value.isEmpty) return kSprayDefaultLayoutMode;
  for (final mode in SprayLayoutMode.values) {
    if (mode.name == value) return mode;
  }
  // Accept the names other products use for the same arrangements, so an
  // admin who types what they know gets what they meant.
  return switch (value) {
    'gallery' || 'tiles' || 'equal' => SprayLayoutMode.grid,
    'side' || 'filmstrip' || 'strip' => SprayLayoutMode.sidebar,
    'speaker' || 'active_speaker' || 'focus' || 'stage' =>
      SprayLayoutMode.spotlight,
    _ => kSprayDefaultLayoutMode,
  };
}
