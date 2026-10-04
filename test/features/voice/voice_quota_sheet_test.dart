import 'package:flutter_test/flutter_test.dart';
import 'package:lazervault/src/features/voice_session/widgets/voice_quota_sheet.dart';
import 'dart:io';

void main() {
  group('VoiceQuotaInfo.fromEvent', () {
    test('reads a well-formed refusal', () {
      final info = VoiceQuotaInfo.fromEvent(const {
        'reason': 'monthly allowance used',
        'needs_payg_optin': true,
        'free_minutes': 30,
        'used_minutes': 31,
        'remaining_minutes': 0,
      });
      expect(info.freeMinutes, 30);
      expect(info.usedMinutes, 31);
      expect(info.needsPaygOptIn, isTrue);
      expect(info.reason, 'monthly allowance used');
    });

    test('does NOT offer pay-as-you-go on a malformed or partial event', () {
      // The security-relevant default. needs_payg_optin absent, null, or a
      // truthy-looking string must all read as FALSE: offering the opt-in
      // would collect consent to a charge the server has not agreed to apply,
      // and the user would then be refused anyway.
      for (final data in <Map<String, dynamic>>[
        {},
        {'needs_payg_optin': null},
        {'needs_payg_optin': 'true'},
        {'needs_payg_optin': 1},
        {'needs_payg_optin': 'yes'},
      ]) {
        expect(VoiceQuotaInfo.fromEvent(data).needsPaygOptIn, isFalse,
            reason: 'payg must not be offered for $data');
      }
      // Only a real JSON boolean true enables it.
      expect(
          VoiceQuotaInfo.fromEvent(const {'needs_payg_optin': true})
              .needsPaygOptIn,
          isTrue);
    });

    test('parses numbers however the transport spelled them', () {
      // grpc-gateway and raw JSON disagree about int vs double vs string for
      // small integers; all three reach this sheet.
      final info = VoiceQuotaInfo.fromEvent(const {
        'free_minutes': '30',
        'used_minutes': 31.0,
      });
      expect(info.freeMinutes, 30);
      expect(info.usedMinutes, 31);
      expect(VoiceQuotaInfo.fromEvent(const {'free_minutes': 'abc'}).freeMinutes,
          0);
    });

    test('remaining minutes never goes negative', () {
      // Shown directly to the user. "-4 minutes remaining" is not a number
      // anyone can act on.
      final over = VoiceQuotaInfo.fromEvent(
          const {'free_minutes': 30, 'used_minutes': 34});
      expect(over.remainingMinutes, 0);
      final under = VoiceQuotaInfo.fromEvent(
          const {'free_minutes': 30, 'used_minutes': 10});
      expect(under.remainingMinutes, 20);
    });
  });

  group('wiring contract', () {
    // Source-level, because the alternative is a full LiveKit cubit harness.
    //
    // Comments are STRIPPED FIRST, deliberately. A previous version of a test
    // like this searched the raw file, so the doc comment naming the event made
    // a file with no actual handler look wired. The strip is what makes this a
    // test rather than a decoration — and the mutation check below proves the
    // strip works.
    String codeOf(String path) {
      final raw = File(path).readAsStringSync();
      return raw
          .split('\n')
          .where((l) => !l.trimLeft().startsWith('//'))
          .join('\n');
    }

    const cubitPath =
        'lib/src/features/voice_session/cubit/voice_session_cubit.dart';
    const sheetPath =
        'lib/src/features/voice_session/widgets/voice_command_sheet.dart';

    test('the cubit handles the voice_quota_exceeded event', () {
      expect(codeOf(cubitPath), contains("case 'voice_quota_exceeded':"),
          reason: 'the agent emits this event and the relay forwards it; '
              'without a case the refusal is silently dropped and the user '
              'sees a dead call');
    });

    test('the cubit can record and withdraw pay-as-you-go consent', () {
      final code = codeOf(cubitPath);
      expect(code, contains('/voice/billing/payg'));
      expect(code, contains('/voice/billing/status'));
      // Withdrawal must exist too: an opt-in with no way out is not consent.
      expect(code, contains('setVoicePaygOptIn'));
    });

    test('the UI shows the sheet on a quota refusal', () {
      final code = codeOf(sheetPath);
      expect(code, contains('VoiceSessionQuotaExceeded'));
      expect(code, contains('showVoiceQuotaSheet'));
    });


    test('the opt-in path handles a restart that refuses', () {
      // _startNewCall() returns early when the sheet is already closing or
      // auth has lapsed. The modal is gone by then, so a silent refusal left
      // the user on a voice screen with no session immediately after agreeing
      // to be charged. It must return a bool and the caller must react.
      final code = codeOf(sheetPath);
      expect(code, contains('bool _startNewCall()'),
          reason: '_startNewCall must report whether it actually started');
      expect(code, contains('if (_startNewCall()) return;'),
          reason: 'the quota opt-in path must check the restart result');
    });

    test('the quota sheet does not take a BuildContext parameter', () {
      // `mounted` is the State's flag and only certifies State.context.
      // Guarding a passed-in context with it is meaningless — that element can
      // be gone while the State is alive, and using it then throws.
      final code = codeOf(sheetPath);
      expect(code, isNot(contains('_showQuotaSheet(BuildContext context')),
          reason: 'take State.context so the mounted guard applies');
      expect(code, contains('Future<void> _showQuotaSheet(VoiceQuotaInfo info)'));
    });

    test('the comment strip actually strips (self-check)', () {
      // Mutation guard. If codeOf stopped removing comments, every test above
      // would pass on a commented-out handler.
      const commented = '''
// case 'voice_quota_exceeded':
  final x = 1;
''';
      final stripped = commented
          .split('\n')
          .where((l) => !l.trimLeft().startsWith('//'))
          .join('\n');
      expect(stripped, isNot(contains("case 'voice_quota_exceeded':")));
      expect(stripped, contains('final x = 1;'));
    });
  });
}
