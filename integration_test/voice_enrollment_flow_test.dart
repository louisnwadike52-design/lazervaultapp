// ignore_for_file: avoid_print

import 'package:flutter_test/flutter_test.dart';
import 'package:integration_test/integration_test.dart';
import 'package:flutter/material.dart';

/// Voice enrollment flow integration test scaffold.
///
/// Status: SKELETON — the previous version of this file declared 9
/// `testWidgets` blocks each with `expect(true, isTrue)` as the only
/// assertion. That was dishonest test coverage; this rewrite marks the
/// non-runnable cases with explicit `skip:` reasons and keeps the
/// EnrollmentTestHelpers as a reference for whoever wires the real
/// flow.
///
/// Why these tests can't run today:
///   • Voice biometric enrollment requires the microphone to publish
///     real audio samples. Integration tests cannot synthesise audio
///     for the audio_streamer / record packages used by the enrollment
///     screen — the platform channel returns empty buffers.
///   • The voice-biometrics-service (gRPC 50053) must be running. The
///     test does not start it.
///   • Permission dialogs interrupt automation; on iOS they cannot be
///     dismissed programmatically.
///
/// What the real test should look like (deferred to Phase 11 of the
/// chat + voice production-readiness arc):
///
///   integration_test/general_voice_e2e_test.dart  (NEW, to be authored)
///       • Provisions a fresh test user via auth-service (no UI flow)
///       • Skips biometric enrollment for the test user via the
///         admin's `voice_biometrics_enabled=false` system_setting
///         override or a per-user override on the test fixture
///       • Drives a `/voice/session/start` call against
///         voice-agent-gateway and asserts the LiveKit room mints
///       • Validates one full voice round-trip (Whisper STT →
///         chat-agent-gateway → tool → TTS → caption)
///
/// The biometric enrollment path itself is best covered by a Go-level
/// integration test against voice-biometrics-service with pre-recorded
/// WAV fixtures. That lives outside the Flutter integration_test
/// runner.

void main() {
  IntegrationTestWidgetsFlutterBinding.ensureInitialized();

  group('Voice Enrollment Flow - Integration Tests', () {
    testWidgets(
      'Complete enrollment flow',
      (WidgetTester tester) async {
        // Real flow tested by Phase 11's general_voice_e2e_test.dart
        // against the biometrics-service-disabled path. This file's
        // microphone-dependent walk has no automation hook on Flutter
        // integration_test today.
      },
      // Skip reason: Requires real microphone audio + voice-biometrics-service —
          // covered by Phase 11 general_voice_e2e_test.dart (TODO).
      skip: true,
    );

    testWidgets(
      'Enrollment with permission denial',
      (WidgetTester tester) async {},
      // Skip reason: Permission dialogs cannot be dismissed
      // programmatically on iOS; requires platform-channel mock.
      skip: true,
    );

    testWidgets(
      'Cancel enrollment mid-flow',
      (WidgetTester tester) async {},
      // Skip reason: See "Complete enrollment flow" — same root cause.
      skip: true,
    );

    testWidgets(
      'Error handling during enrollment',
      (WidgetTester tester) async {},
      // Skip reason: Requires mocked biometrics-service failures;
      // see Phase 11.
      skip: true,
    );

    testWidgets(
      'Voice command after enrollment',
      (WidgetTester tester) async {},
      // Skip reason: Voice command path covered by Phase 11 voice E2E.
      skip: true,
    );

    testWidgets(
      'Re-enrollment flow',
      (WidgetTester tester) async {},
      // Skip reason: Requires real audio; see Phase 11.
      skip: true,
    );

    testWidgets(
      'Enrollment completion time',
      (WidgetTester tester) async {},
      // Skip reason: Performance metric belongs in voice-biometrics-
      // service Go integration test with WAV fixtures, not Flutter
      // integration_test.
      skip: true,
    );

    testWidgets(
      'Memory usage during enrollment',
      (WidgetTester tester) async {},
      // Skip reason: Memory profiling belongs in flutter driver /
      // devtools, not integration_test assertions.
      skip: true,
    );
  });
}

/// Reference helpers retained for whoever wires the real flow (Phase 11
/// of the chat + voice arc). NOT used by any active test today.
class EnrollmentTestHelpers {
  /// Navigate to voice enrollment screen.
  static Future<void> navigateToEnrollment(WidgetTester tester) async {
    final micButton = find.byIcon(Icons.mic);
    if (micButton.evaluate().isEmpty) {
      throw StateError('No mic button found on dashboard');
    }
    await tester.tap(micButton);
    await tester.pumpAndSettle();
    final setupButton = find.text('Set Up Voice');
    if (tester.widgetList(setupButton).isNotEmpty) {
      await tester.tap(setupButton);
      await tester.pumpAndSettle();
    }
  }

  /// Complete a single recording sample. Real audio is supplied by the
  /// hardware microphone; cannot be faked from integration_test today.
  static Future<void> recordSample(WidgetTester tester, int sampleNumber) async {
    expect(find.text('Sample $sampleNumber of 3'), findsOneWidget);
    final startButton = find.text('Start Recording');
    await tester.tap(startButton);
    await tester.pumpAndSettle();
    await Future<void>.delayed(const Duration(seconds: 6));
    await tester.pumpAndSettle();
    expect(find.byType(CircularProgressIndicator), findsOneWidget);
  }

  /// Wait for enrollment completion.
  static Future<void> waitForEnrollment(WidgetTester tester) async {
    await tester.pumpAndSettle();
    expect(find.text('Voice Enrolled!'), findsOneWidget);
    final doneButton = find.text('Done');
    await tester.tap(doneButton);
    await tester.pumpAndSettle();
  }
}

/// Reference data for whoever wires the real flow.
class EnrollmentTestData {
  static const List<String> enrollmentPhrases = [
    'My voice is my password',
    'I authorize LazerVault transactions',
    'Banking by voice is secure and convenient',
  ];
}
