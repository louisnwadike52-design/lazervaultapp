import 'package:flutter_test/flutter_test.dart';
import 'package:lazervault/src/features/voice_session/voice_audio_route_policy.dart';

void main() {
  group('output-route override policy', () {
    test('iOS never overrides — the pinned configuration IS the route', () {
      // The override swaps LiveKit's videoChat mode for WebRTC's voiceChat
      // default, a quieter curve, and the next assertion swaps it back. Three
      // per agent turn is the "volume up and down" the user hears.
      expect(
        shouldOverrideOutputRoute(
            isIOS: true, androidMediaProfileApplied: false),
        isFalse,
      );
      expect(
        shouldOverrideOutputRoute(
            isIOS: true, androidMediaProfileApplied: true),
        isFalse,
      );
    });

    test('Android under the media profile never overrides', () {
      // setSpeakerphoneOn drags Android back into MODE_IN_COMMUNICATION, the
      // mode the media profile exists to escape.
      expect(
        shouldOverrideOutputRoute(
            isIOS: false, androidMediaProfileApplied: true),
        isFalse,
      );
    });

    test('Android WITHOUT the media profile still needs the override', () {
      // The one surviving case: communication mode really does default to the
      // earpiece, so the agent would be "held to your ear" quiet without it.
      expect(
        shouldOverrideOutputRoute(
            isIOS: false, androidMediaProfileApplied: false),
        isTrue,
      );
    });
  });
}
