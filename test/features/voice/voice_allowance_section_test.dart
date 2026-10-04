import 'package:flutter_test/flutter_test.dart';
import 'dart:io';

// The pay-as-you-go sheet tells the user "you can turn this off any time in
// Voice settings" — and that setting did not exist. The server has always
// accepted a withdrawal (POST /voice/billing/payg with opted_in:false, which
// needs no terms version and is never refused); nothing in the app offered
// one. Consent you cannot withdraw where you were told you could is not
// consent.
//
// It also answers the question the refusal sheet could only answer too late:
// how many minutes are left. Before this, the only way to learn about the
// allowance was to be refused by it.
void main() {
  String codeOf(String path) => File(path)
      .readAsStringSync()
      .split('\n')
      .where((l) => !l.trimLeft().startsWith('//'))
      .join('\n');

  const sectionPath =
      'lib/src/features/voice/widgets/voice_allowance_section.dart';
  const screenPath =
      'lib/src/features/voice/screens/voice_settings_screen.dart';

  group('voice allowance section', () {
    test('voice settings renders it', () {
      final code = codeOf(screenPath);
      expect(code, contains('VoiceAllowanceSection('),
          reason: 'the opt-in sheet promises this setting exists');
      expect(code, contains('setVoicePaygOptIn'),
          reason: 'withdrawal must be reachable from the UI');
      expect(code, contains('fetchVoiceBillingStatus'),
          reason: 'the minutes must come from the server, not be guessed');
    });

    test('it can turn pay-as-you-go OFF, not just on', () {
      final code = codeOf(sectionPath);
      // A Switch, whose onChanged passes the new value through — not a
      // one-way opt-in button.
      expect(code, contains('onChanged: (v) => _toggle(v)'));
      expect(code, contains('widget.setOptIn(on)'));
    });

    test('it renders nothing when billing is off', () {
      // Billing off is the shipped default. Advertising a charge that cannot
      // happen would be worse than silence.
      final code = codeOf(sectionPath);
      expect(code, contains("s['billing_enabled'] != true"));
      expect(code, contains('SizedBox.shrink()'));
    });

    test('an unreadable status is never shown as "no minutes left"', () {
      // Null means UNKNOWN. Rendering it as zero remaining would tell someone
      // they are out of minutes when they may not be.
      final code = codeOf(sectionPath);
      expect(code, contains('if (s == null || '),
          reason: 'a null status must short-circuit before any figure is drawn');
      expect(code, isNot(contains('_status!')),
          reason: 'never force-unwrap a status that is allowed to be null');
    });

    test('server errors are not surfaced raw on a money surface', () {
      final code = codeOf(sectionPath);
      expect(code, contains('Server not reachable'));
      // No interpolation of a caught error into user-visible text.
      expect(code, isNot(contains(r'$e')));
      expect(code, isNot(contains('e.toString()')));
    });

    test('consent state is re-read from the server, not assumed', () {
      // The server is the authority on whether consent was recorded and on
      // the terms it was recorded against.
      final code = codeOf(sectionPath);
      final toggle = code.substring(code.indexOf('Future<void> _toggle('));
      expect(toggle.substring(0, 900), contains('await _load()'));
    });

    test('the comment strip actually strips (self-check)', () {
      const commented = '// VoiceAllowanceSection(\n  final x = 1;\n';
      final stripped = commented
          .split('\n')
          .where((l) => !l.trimLeft().startsWith('//'))
          .join('\n');
      expect(stripped, isNot(contains('VoiceAllowanceSection')));
      expect(stripped, contains('final x = 1;'));
    });
  });
}
