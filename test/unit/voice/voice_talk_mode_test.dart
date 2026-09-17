import 'package:flutter_test/flutter_test.dart';
import 'package:lazervault/src/features/voice_session/widgets/voice_talk_affordance.dart';

/// The gesture copy used to live in four places — the call sheet, the floating
/// bubble, the settings chips and the settings helper line — and they had
/// already drifted: the sheet said "Double-tap" for the mode the bubble called
/// "Double-tap to talk". Nothing catches that, because each string is correct
/// on its own; only together are they wrong.
///
/// These tests pin the properties that matter for someone who cannot tell how
/// to start talking.
void main() {
  group('VoiceTalkMode', () {
    test('every mode names its gesture', () {
      for (final mode in VoiceTalkMode.all) {
        expect(VoiceTalkMode.label(mode), isNotEmpty);
        expect(VoiceTalkMode.explanation(mode), isNotEmpty);
      }
    });

    // The half people never discover: how to STOP. Each push-to-talk mode must
    // give a different instruction while capturing, or the control says "Tap to
    // talk" at someone who is already talking.
    test('capturing tells you how to send, per mode', () {
      expect(VoiceTalkMode.action(VoiceTalkMode.hold, capturing: true),
          'Release to send');
      expect(VoiceTalkMode.action(VoiceTalkMode.tap, capturing: true),
          'Tap to send');
      expect(VoiceTalkMode.action(VoiceTalkMode.doubleTap, capturing: true),
          'Double-tap to send');
    });

    test('idle tells you how to start, per mode', () {
      expect(VoiceTalkMode.action(VoiceTalkMode.hold, capturing: false),
          'Hold to talk');
      expect(VoiceTalkMode.action(VoiceTalkMode.tap, capturing: false),
          'Tap to talk');
      expect(VoiceTalkMode.action(VoiceTalkMode.doubleTap, capturing: false),
          'Double-tap to talk');
    });

    // Three push-to-talk modes that read identically would put us straight back
    // where we started, so assert they are actually distinguishable.
    test('the three push-to-talk modes are distinguishable from each other', () {
      final idle = {
        for (final m in [VoiceTalkMode.hold, VoiceTalkMode.tap, VoiceTalkMode.doubleTap])
          VoiceTalkMode.action(m, capturing: false)
      };
      expect(idle.length, 3, reason: 'each gesture needs its own wording');

      final busy = {
        for (final m in [VoiceTalkMode.hold, VoiceTalkMode.tap, VoiceTalkMode.doubleTap])
          VoiceTalkMode.action(m, capturing: true)
      };
      expect(busy.length, 3);
    });

    test('continuous has no gesture to perform', () {
      expect(VoiceTalkMode.isPushToTalk(VoiceTalkMode.continuous), isFalse);
      for (final m in [VoiceTalkMode.hold, VoiceTalkMode.tap, VoiceTalkMode.doubleTap]) {
        expect(VoiceTalkMode.isPushToTalk(m), isTrue);
      }
      // It must not instruct a tap on a mode where tapping does nothing.
      expect(VoiceTalkMode.action(VoiceTalkMode.continuous, capturing: false),
          isNot(contains('Tap')));
    });

    // An unknown value from the server must not render a blank control.
    test('an unrecognised mode falls back to continuous copy', () {
      expect(VoiceTalkMode.label('something_new'), isNotEmpty);
      expect(VoiceTalkMode.action('something_new', capturing: false), isNotEmpty);
      expect(VoiceTalkMode.explanation('something_new'), isNotEmpty);
    });
  });
}
