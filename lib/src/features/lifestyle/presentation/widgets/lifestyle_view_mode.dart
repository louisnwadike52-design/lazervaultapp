import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:shared_preferences/shared_preferences.dart';

import 'package:lazervault/core/config/feature_flags.dart';

/// How the Lifestyle hub lays its entries out.
///
/// The hub shipped with one layout — full-bleed banners — which reads well with
/// two entries and progressively worse as more are added: a screen of stacked
/// billboards where each one shouts. Rather than pick a different single
/// layout, the choice belongs to the person looking at it, and it persists,
/// because a view preference that resets every visit is not a preference.
enum LifestyleViewMode {
  /// Full-width gradient banners. Best for a short, promotional list.
  banner,

  /// Two-up tiles. Twice the density, still showing each entry's colour.
  grid,

  /// Compact single-line rows. Densest; for someone who knows what they want.
  list,
}

extension LifestyleViewModeX on LifestyleViewMode {
  String get label => switch (this) {
        LifestyleViewMode.banner => 'Banners',
        LifestyleViewMode.grid => 'Grid',
        LifestyleViewMode.list => 'List',
      };

  IconData get icon => switch (this) {
        LifestyleViewMode.banner => Icons.view_agenda_outlined,
        LifestyleViewMode.grid => Icons.grid_view_rounded,
        LifestyleViewMode.list => Icons.view_list_rounded,
      };
}

/// Persistence for the layout choice. Best-effort on both sides: a storage
/// failure falls back to the default layout rather than blocking the screen,
/// because the hub must render whether or not preferences are readable.
class LifestyleViewModePrefs {
  LifestyleViewModePrefs._();

  static const _key = 'lifestyle_view_mode';

  /// The layout someone sees before they have chosen one: GRID.
  ///
  /// Banners were the original default and they do not survive the hub
  /// growing. One entry per screenful means the later entries are below the
  /// fold on arrival — present, but not discoverable by anyone who does not
  /// think to scroll a screen that looks finished. Grid shows roughly three
  /// times as many in the same space while keeping each entry's colour, so the
  /// hub reads as a set of choices rather than a single promotion.
  ///
  /// Only the DEFAULT moved. A stored preference still wins, including a
  /// stored `banner` — someone who picked banners keeps them, because the
  /// whole point of persisting the choice is that it is theirs.
  static const LifestyleViewMode _appDefault = LifestyleViewMode.grid;

  /// The default in force: the admin-set platform default when there is one,
  /// otherwise [_appDefault].
  ///
  /// ADMIN-TUNABLE so the hub's opening layout can change without an app
  /// release — the same arrangement the chat accent uses
  /// ([FeatureFlags.chatDefaultAccentKey]). The setting names a mode; a value
  /// this build does not recognise falls back rather than rendering nothing,
  /// because a deployment can be ahead of a store release.
  ///
  /// This only answers "what does someone who has never chosen see". A stored
  /// user preference still wins over it, so flipping the platform default
  /// never overrides a choice somebody made.
  static LifestyleViewMode get platformDefault {
    final name = FeatureFlags.lifestyleDefaultView.trim().toLowerCase();
    if (name.isEmpty) return _appDefault;
    for (final m in LifestyleViewMode.values) {
      if (m.name == name) return m;
    }
    return _appDefault;
  }

  static Future<LifestyleViewMode> load() async {
    try {
      final prefs = await SharedPreferences.getInstance();
      final stored = prefs.getString(_key);
      if (stored == null) return platformDefault;
      return LifestyleViewMode.values.firstWhere(
        (m) => m.name == stored,
        orElse: () => platformDefault,
      );
    } catch (_) {
      return platformDefault;
    }
  }

  static Future<void> save(LifestyleViewMode mode) async {
    try {
      final prefs = await SharedPreferences.getInstance();
      await prefs.setString(_key, mode.name);
    } catch (_) {
      // A layout preference is never worth surfacing an error for.
    }
  }
}

/// Header control for switching layout.
///
/// A popup menu rather than a cycling button: cycling hides what the other
/// options are and forces you to tap through layouts you did not want, which
/// is the wrong trade for a control used rarely and deliberately. The menu
/// names every option and check-marks the active one.
class LifestyleViewModeButton extends StatelessWidget {
  const LifestyleViewModeButton({
    super.key,
    required this.mode,
    required this.onChanged,
    this.color,
  });

  final LifestyleViewMode mode;
  final ValueChanged<LifestyleViewMode> onChanged;
  final Color? color;

  @override
  Widget build(BuildContext context) {
    final tint = color ?? const Color(0xFF9CA3AF);
    return PopupMenuButton<LifestyleViewMode>(
      tooltip: 'Change layout',
      initialValue: mode,
      color: const Color(0xFF1F1F1F),
      shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(12.r)),
      onSelected: (m) {
        HapticFeedback.selectionClick();
        onChanged(m);
      },
      itemBuilder: (_) => [
        for (final m in LifestyleViewMode.values)
          PopupMenuItem<LifestyleViewMode>(
            value: m,
            child: Row(
              children: [
                Icon(m.icon,
                    size: 18.sp,
                    color: m == mode ? Colors.white : const Color(0xFF9CA3AF)),
                SizedBox(width: 10.w),
                Expanded(
                  child: Text(
                    m.label,
                    style: TextStyle(
                      color: m == mode ? Colors.white : const Color(0xFF9CA3AF),
                      fontSize: 14.sp,
                      fontWeight: m == mode ? FontWeight.w600 : FontWeight.w400,
                    ),
                  ),
                ),
                if (m == mode)
                  Icon(Icons.check_rounded, size: 16.sp, color: Colors.white),
              ],
            ),
          ),
      ],
      icon: Icon(mode.icon, color: tint, size: 24.sp),
    );
  }
}
