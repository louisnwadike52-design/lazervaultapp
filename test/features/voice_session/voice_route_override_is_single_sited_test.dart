import 'dart:io';

import 'package:flutter_test/flutter_test.dart';

/// The policy in voice_audio_route_policy.dart only helps if EVERY route
/// override goes through it. A second, ungated `setSpeakerphoneOn` anywhere in
/// the voice session would reintroduce the mid-turn level swing with the policy
/// test still green — so pin the call-site count at the source level.
void main() {
  test('the voice session touches the output route in exactly one place', () {
    final cubit = File(
        'lib/src/features/voice_session/cubit/voice_session_cubit.dart');
    expect(cubit.existsSync(), isTrue, reason: 'cubit moved — update this test');
    final src = cubit.readAsStringSync();

    final overrides =
        RegExp(r'setSpeakerphoneOn\s*\(').allMatches(src).length;
    expect(overrides, 1,
        reason: 'Expected the single policy-gated call inside '
            '_assertLoudspeaker. Found $overrides. A new call site must go '
            'through shouldOverrideOutputRoute(), or the agent\'s level will '
            'swing mid-turn again.');

    // And that one call must still be gated: the policy call has to appear
    // before it in the same method.
    final guardAt = src.indexOf('shouldOverrideOutputRoute(');
    final callAt = src.indexOf('setSpeakerphoneOn(');
    expect(guardAt, greaterThan(-1),
        reason: 'the policy guard was removed from the cubit');
    expect(guardAt, lessThan(callAt),
        reason: 'setSpeakerphoneOn is no longer behind the policy guard');
  });
}
