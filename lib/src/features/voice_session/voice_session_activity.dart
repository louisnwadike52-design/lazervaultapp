import 'package:flutter/foundation.dart';

/// Process-global "a voice session is live" flag.
///
/// Set by [VoiceSessionCubit] when a session becomes live (credentials/connect)
/// and cleared on end / disconnect / terminal error. Read by the InactivityWatcher
/// so auto-logout is suppressed for the WHOLE voice session — including while the
/// sheet is minimized into the floating bubble, when the cubit may be outside the
/// watcher's `BuildContext` scope (so `context.read<VoiceSessionCubit>()` would
/// otherwise throw and the watcher would wrongly treat the session as inactive).
class VoiceSessionActivity {
  VoiceSessionActivity._();

  /// True while a voice session is engaged. Listenable so UI can react too.
  static final ValueNotifier<bool> active = ValueNotifier<bool>(false);

  static void setActive(bool value) {
    if (active.value != value) active.value = value;
  }

  static bool get isActive => active.value;
}
