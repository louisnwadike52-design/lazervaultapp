import 'package:flutter_test/flutter_test.dart';
import 'package:lazervault/src/features/voice_session/voice_audio_route_policy.dart';

void main() {
  group('output-route re-assertion policy', () {
    test('iOS re-asserts — it restores the PINNED configuration', () {
      // Hardware.setSpeakerphoneOn's iOS branch re-invokes
      // onConfigureNativeAudio and applies the result through
      // Native.configureAudio. That hook is pinned to playAndRecordSpeaker, so
      // this re-applies our own configuration idempotently and restores the
      // route after another component (the transaction-PIN sheet, a platform
      // interruption) reconfigures the session.
      //
      // This deliberately does NOT suppress the call on iOS. A previous version
      // did, blaming it for the agent's level swinging between turns. The swing
      // was LiveKit's DEFAULT configuration function alternating between
      // `playback` (spokenAudio, loud) while remote-only and
      // `playAndRecordSpeaker` (videoChat, quieter) once the AEC mic published.
      // The onConfigureNativeAudio pin fixed that; suppressing this fixed
      // nothing and cost the only restore path iOS had.
      expect(
        shouldOverrideOutputRoute(
            isIOS: true, androidMediaProfileApplied: false),
        isTrue,
      );
    });

    test('Android under the media profile does NOT re-assert', () {
      // Here setSpeakerphoneOn really does take the flutter_webrtc path, whose
      // AudioUtils.m sets category and mode from WebRTC's own configuration —
      // dragging the session back into MODE_IN_COMMUNICATION, the mode the
      // media profile exists to escape. Media playback is already on the
      // loudspeaker, so there is nothing to win.
      expect(
        shouldOverrideOutputRoute(
            isIOS: false, androidMediaProfileApplied: true),
        isFalse,
      );
    });

    test('Android without the media profile still re-asserts', () {
      // The legacy communication-mode session really does default to the
      // earpiece — the "held to your ear" quiet the override was added for.
      expect(
        shouldOverrideOutputRoute(
            isIOS: false, androidMediaProfileApplied: false),
        isTrue,
      );
    });
  });
}
