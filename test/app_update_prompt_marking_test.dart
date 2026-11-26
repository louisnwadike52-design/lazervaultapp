import 'dart:io';
import 'package:flutter_test/flutter_test.dart';

/// THE ONE-TIME UPDATE PROMPT MUST BE MARKED SEEN WHEN IT IS PUSHED.
///
/// Reported 2026-11-10: "the app keeps telling me to update anytime I want to
/// open the app."
///
/// Two paths show the sheet and they share ONE SharedPreferences token, so they
/// must agree on when a prompt counts as seen:
///
///   * app_startup_gate  — pre-login, on the passcode screen
///   * dashboard_screen  — post-login
///
/// The gate awaited the sheet and marked it afterwards, so the prompt was only
/// spent when the sheet was DISMISSED. Anyone who met it on the passcode screen
/// and killed the app from the task switcher never reached the mark and was
/// prompted again on every single launch. The dashboard had the mirror-image
/// bug: it marked BEFORE showing, spending a prompt that might never render.
///
/// Both now push the sheet, keep the Future, mark, then await — so "rendered"
/// is the boundary, and a synchronous throw still leaves the prompt owed.
///
/// Source-level because the ordering is the whole behaviour: a widget test that
/// dismisses the sheet passes under BOTH orderings, which is precisely why this
/// survived so long.
void main() {
  String read(String path) {
    final f = File(path);
    expect(f.existsSync(), isTrue, reason: 'missing source file: $path');
    return f.readAsStringSync();
  }

  /// The index of the LAST line matching [needle] in [source].
  int lineOf(String source, String needle) {
    final lines = source.split('\n');
    for (var i = lines.length - 1; i >= 0; i--) {
      if (lines[i].contains(needle)) return i;
    }
    return -1;
  }

  group('the update prompt is marked seen when it is pushed', () {
    test('startup gate: showUpdateModal is NOT awaited before the mark', () {
      final src =
          read('lib/src/features/app_status/widgets/app_startup_gate.dart');

      // The exact regression: awaiting the sheet means the mark only runs on
      // dismissal, so a force-close re-offers it for ever.
      expect(src, isNot(contains('await showUpdateModal(')),
          reason: 'awaiting the sheet defers the mark until it is DISMISSED, '
              'so killing the app re-offers the same prompt every launch');

      final show = lineOf(src, 'showUpdateModal(');
      final mark = lineOf(src, 'markOptionalModalSeen(info)');
      expect(show, greaterThan(-1));
      expect(mark, greaterThan(-1));
      expect(mark, greaterThan(show),
          reason: 'the mark must come AFTER the sheet is pushed, so a '
              'synchronous throw leaves the prompt owed rather than spent');
    });

    test('dashboard: the mark also comes after the push', () {
      final src = read(
          'lib/src/features/presentation/views/dashboard/dashboard_screen.dart');

      expect(src, isNot(contains('await showUpdateModal(')),
          reason: 'same boundary as the startup gate');

      final show = lineOf(src, 'showUpdateModal(');
      final mark = lineOf(src, 'markOptionalModalSeen(info)');
      expect(show, greaterThan(-1));
      expect(mark, greaterThan(-1));
      expect(mark, greaterThan(show),
          reason: 'this path marked BEFORE showing, which spends a prompt '
              'that may never render');
    });

    test('both paths still mark at all', () {
      // A prompt that is never marked is the bug; a prompt that is never shown
      // is the opposite bug. Assert the call survives in both files.
      for (final path in const [
        'lib/src/features/app_status/widgets/app_startup_gate.dart',
        'lib/src/features/presentation/views/dashboard/dashboard_screen.dart',
      ]) {
        expect(read(path), contains('markOptionalModalSeen('),
            reason: '$path must still record that the prompt was shown');
      }
    });
  });
}
