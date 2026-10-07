import 'dart:convert';
import 'dart:io';

import 'package:flutter_test/flutter_test.dart';
import 'package:lazervault/core/utilities/phone_account_banks.dart';

/// OPay / PalmPay accounts are phone numbers, and the rule lives in TWO
/// places: here, and in chat_agents_shared/ocr/phone_account_banks.py.
///
/// They have to agree. If the Python side normalises a number and the Dart
/// side does not, the server sends an 11-digit account and the screen shows
/// no pills for it — or worse, the two disagree about whether a ten-digit
/// string is a NUBAN or a phone number, and one of them pays the wrong thing.
/// The last group below runs the SAME cases through the real Python module.
void main() {
  group('normaliseMobile', () {
    test('a number without its leading zero is still a phone number', () {
      // THE BUG. Ten digits looks exactly like a NUBAN, so an OPay account
      // typed the way people type it went to the rail as an ordinary bank
      // account and came back rejected.
      expect(PhoneAccountBanks.normaliseMobile('7033609489'), '07033609489');
      expect(PhoneAccountBanks.normaliseMobile('8033609489'), '08033609489');
    });

    test('every way a number gets written down', () {
      for (final raw in [
        '08033609489',
        '8033609489',
        '+2348033609489',
        '2348033609489',
        '0803 360 9489',
        '0803-360-9489',
        '  08033609489  ',
      ]) {
        expect(PhoneAccountBanks.normaliseMobile(raw), '08033609489',
            reason: raw);
      }
    });

    test('a real NUBAN is never rewritten into a phone number', () {
      // The dangerous direction: rewriting a bank account into a number
      // nobody holds.
      for (final raw in ['1234567890', '0123456789', '2234567890']) {
        expect(PhoneAccountBanks.normaliseMobile(raw), isNull, reason: raw);
      }
    });

    test('rubbish is rejected rather than coerced', () {
      for (final raw in ['', 'abc', '0', '080', '080336094891234', null]) {
        expect(PhoneAccountBanks.normaliseMobile(raw), isNull,
            reason: '$raw');
      }
    });
  });

  group('bank identity', () {
    test('real-world spellings resolve', () {
      for (final raw in ['OPay', 'opay', 'O-Pay', 'OPay Digital Services']) {
        expect(PhoneAccountBanks.canonicalBank(raw), 'OPay', reason: raw);
      }
      for (final raw in ['PalmPay', 'palm pay', 'PalmPay Limited']) {
        expect(PhoneAccountBanks.canonicalBank(raw), 'PalmPay', reason: raw);
      }
      for (final raw in ['Access Bank', 'GTBank', '', null]) {
        expect(PhoneAccountBanks.canonicalBank(raw), isNull, reason: '$raw');
      }
    });

    test('an unnamed phone number offers BOTH banks', () {
      // A phone number cannot tell an OPay account from a PalmPay one, and
      // choosing on the customer's behalf is unrecoverable.
      expect(PhoneAccountBanks.candidatesFor('07033609489'),
          ['OPay', 'PalmPay']);
    });

    test('a named bank is not second-guessed', () {
      expect(
        PhoneAccountBanks.candidatesFor('07033609489', bankName: 'palm pay'),
        ['PalmPay'],
      );
    });

    test('a NUBAN offers nothing, so no misleading choice is rendered', () {
      expect(PhoneAccountBanks.candidatesFor('1234567890'), isEmpty);
      expect(PhoneAccountBanks.candidatesFor(''), isEmpty);
    });
  });

  group('the Dart and Python rules agree', () {
    // Skipped where python3 is unavailable rather than silently passing.
    const cases = [
      '08033609489', '8033609489', '+2348033609489', '2348033609489',
      '0803 360 9489', '7033609489', '1234567890', '0123456789',
      '2234567890', '', 'abc', '080', '09011111111', '07111111111',
      '06011111111', '05011111111', '080336094891234',
    ];

    test('normalisation matches case for case', () {
      final py = File('../chat_agents_shared/ocr/phone_account_banks.py');
      if (!py.existsSync()) {
        markTestSkipped('python module not reachable from here');
        return;
      }
      final script = '''
import json, sys
sys.path.insert(0, "${py.parent.absolute.path}")
from phone_account_banks import normalise_nigerian_mobile as n
print(json.dumps([n(c) for c in ${jsonEncode(cases)}]))
''';
      final r = Process.runSync('python3', ['-c', script]);
      if (r.exitCode != 0) {
        markTestSkipped('python3 unavailable: ${r.stderr}');
        return;
      }
      final pyOut = (jsonDecode(r.stdout.toString().trim()) as List)
          .map((e) => e as String?)
          .toList();
      final dartOut =
          cases.map((c) => PhoneAccountBanks.normaliseMobile(c)).toList();
      expect(dartOut, pyOut,
          reason: 'the client and the extractor disagree about what is a '
              'phone number — one of them will pay the wrong thing');
    });
  });
}
