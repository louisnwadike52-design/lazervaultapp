import 'dart:io';

import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:flutter_test/flutter_test.dart';
import 'package:lazervault/core/shared_widgets/otp_field_behaviour.dart';

/// AUTOFILL, PASTE AND TYPING MUST ALL WORK, ON EVERY CODE SCREEN.
///
/// Reported as "paste or autofill from SMS is not effective". Neither worked,
/// for reasons that differed per screen — there were six code-entry screens
/// and six answers. The three mechanisms are independent and each had its own
/// way of being absent:
///
///   * AUTOFILL needs `autofillHints` AND an `AutofillGroup` ancestor.
///     Flutter forwards the hint to the platform only inside a group, so a
///     tagged field without one is inert — which is how Pinput, whose hint is
///     correct by default, still produced no suggestion.
///   * PASTE needs `enableInteractiveSelection` AND a context menu. Both pin
///     packages default selection to false, and `pin_input_text_field`
///     forwards a null `contextMenuBuilder` verbatim, so there was no menu
///     even once selection was on.
///   * TYPING must keep working, which is why none of this may introduce a
///     controlled component. In November a controlled pin widget reconciled
///     its own state against a prop on every rebuild and a customer on
///     Android could not enter the code he had been sent.
void main() {
  /// Source with comment lines removed.
  ///
  /// Every file here explains these bugs in prose that names the identifiers
  /// being searched for, so a raw search matches the explanation.
  String code(String s) => s
      .split('\n')
      .where((l) => !l.trimLeft().startsWith('//'))
      .where((l) => !l.trimLeft().startsWith('///'))
      .join('\n');

  group('the shared definition', () {
    test('tags a one-time code', () {
      expect(otpAutofillHints, contains(AutofillHints.oneTimeCode));
    });

    test('extracts the code from a pasted SENTENCE', () {
      // What people actually paste. Without the digits filter the pin fields
      // accept the whole string and maxLength then cuts it to its first six
      // CHARACTERS — "Your c" — so paste looked broken rather than filtered.
      expect(otpDigitsOf('Your Lazervault code is 123456'), '123456');
      expect(otpDigitsOf('123456 is your code'), '123456');
      expect(otpDigitsOf('12-34-56'), '123456');
    });

    test('clips a long paste and refuses an empty one', () {
      expect(otpDigitsOf('1234567890'), '123456');
      // '' rather than a throw: the caller leaves the field alone instead of
      // clearing what the customer had typed.
      expect(otpDigitsOf('no digits here'), '');
      expect(otpDigitsOf(''), '');
    });

    test('the formatters filter BEFORE they limit', () {
      // Order is the whole point: digits out of the sentence first, length cap
      // second. Reversed, the cap would take six characters of prose.
      final fmt = otpInputFormatters(6);
      expect(fmt.first, isA<FilteringTextInputFormatter>());
      expect(fmt.last, isA<LengthLimitingTextInputFormatter>());
    });

    group('spreading a paste across boxes', () {
      List<TextEditingController> boxes() =>
          List.generate(6, (_) => TextEditingController());

      test('fills every box from one pasted value', () {
        // THE MULTI-BOX BUG. Those screens capped each box at one character,
        // so a six-digit paste became a single digit wherever it landed.
        final c = boxes();
        expect(applyOtpPaste(c, '123456'), '123456');
        expect(c.map((e) => e.text).join(), '123456');
      });

      test('sets each selection explicitly', () {
        // Assigning `.text` alone leaves selection at the invalid default
        // (-1). On Android that is a caret the input connection cannot place,
        // so the next keypress goes nowhere — the "field went dead" report
        // this app has already had once.
        final c = boxes();
        applyOtpPaste(c, '123456');
        for (final e in c) {
          expect(e.selection.baseOffset, e.text.length,
              reason: 'offset -1 is what kills the next keypress');
        }
      });

      test('clears the boxes a shorter paste does not reach', () {
        // Otherwise digits of the previous paste stay behind and the screen
        // submits a code that is part one attempt and part another.
        final c = boxes();
        applyOtpPaste(c, '123456');
        applyOtpPaste(c, '99');
        expect(c.map((e) => e.text).join(), '99');
      });

      test('leaves the boxes untouched when there is nothing usable', () {
        final c = boxes();
        applyOtpPaste(c, '123456');
        expect(applyOtpPaste(c, 'no digits'), '');
        expect(c.map((e) => e.text).join(), '123456',
            reason: 'a junk paste must not wipe a code already entered');
      });
    });
  });

  group('every code screen', () {
    /// DERIVED, NOT LISTED. The screens are found by searching for the
    /// controllers and widgets that take a code, so a SEVENTH code screen
    /// fails here without anybody remembering to extend a list — which is
    /// exactly how these six came to disagree with each other.
    final screens = Directory('lib/src/features')
        .listSync(recursive: true)
        .whereType<File>()
        .where((f) => f.path.endsWith('.dart'))
        .where((f) {
      final body = code(f.readAsStringSync());
      final takesACode = body.contains('PinInputTextField(') ||
          body.contains('Pinput(') ||
          body.contains('_otpController') ||
          body.contains('_otpControllers');
      // The transaction PIN is not a one-time code: it is a secret the
      // customer chose and remembers, it never arrives by SMS, and tagging it
      // oneTimeCode would invite the OS to fill it from a message.
      final isTransactionPin = body.contains('PinCodeTextField(');
      return takesACode && !isTransactionPin;
    }).toList();

    test('there are screens to check at all', () {
      expect(screens.length, greaterThanOrEqualTo(4),
          reason: 'the search no longer locates the code screens, so every '
              'assertion below is passing over an empty list');
    });

    test('each one sits inside an AutofillGroup', () {
      for (final f in screens) {
        final body = code(f.readAsStringSync());
        expect(body.contains('AutofillGroup('), isTrue,
            reason: '${f.path} takes a one-time code but has no '
                'AutofillGroup. Flutter forwards autofillHints to the '
                'platform only inside a group, so the field gets no iOS '
                '"From Messages" suggestion and is never offered to '
                "Android's autofill framework — the hint, if any, is inert.");
      }
    });

    test('each one is TAGGED as a one-time code', () {
      // The hint is what the AutofillGroup forwards. Three shapes are valid
      // and all three are in use, so this accepts any of them rather than
      // forcing a single spelling:
      //
      //   * `otpAutofillHints` — the shared constant, used directly;
      //   * the same constant behind a `index == 0 ?` conditional, which is
      //     how the multi-box screens tag only the autofocused box (tagging
      //     all six would invite the OS to fill each with the whole code);
      //   * no declaration at all on a `Pinput`, which already DEFAULTS
      //     autofillHints to [AutofillHints.oneTimeCode] — verified in the
      //     package. That default is precisely why its screen looked correct
      //     while producing nothing: the hint was there and the
      //     AutofillGroup was not.
      for (final f in screens) {
        final body = code(f.readAsStringSync());
        final tagged = body.contains('otpAutofillHints') ||
            body.contains('AutofillHints.oneTimeCode') ||
            body.contains('Pinput(');
        expect(tagged, isTrue,
            reason: '${f.path} takes a one-time code but never tags the field '
                'as one, so the AutofillGroup around it has nothing to '
                'forward: no iOS "From Messages" suggestion and no offer to '
                "Android's autofill framework.");
      }
    });

    test('each one allows a paste to be made at all', () {
      for (final f in screens) {
        final body = code(f.readAsStringSync());
        expect(body.contains('enableInteractiveSelection: true'), isTrue,
            reason: '${f.path} leaves interactive selection at the packages\' '
                'default of false, so a long press gives no handles and no '
                'menu: there is no way to paste a code the customer copied.');
      }
    });
  });

  group('raising maxLength must not break typing', () {
    /// THE REGRESSION THIS PAIR OF FIXES CREATED AND THEN CLOSED.
    ///
    /// The multi-box screens capped every box at one character, so a pasted
    /// code was truncated to a single digit wherever it landed. Raising the
    /// cap to the full code length fixed paste and broke correction: a box
    /// holding "3" that the customer taps and types "9" into then reports
    /// "39" — two characters — which the paste path reads as a pasted code
    /// and spreads across the boxes, WIPING the rest of what they entered.
    ///
    /// Selecting the box on focus removes it at the source: whatever arrives
    /// next replaces what was there, so typing yields one character and a
    /// paste yields exactly the pasted code. Heuristics on the value's length
    /// were the alternative and they cannot tell a two-digit paste from a
    /// correction.
    final multiBox = <String>[
      'lib/src/features/authentication/presentation/views/login_otp_screen.dart',
      'lib/src/features/transaction_pin/presentation/views/forgot_pin_screen.dart',
    ];

    test('every box accepts a full-length paste', () {
      for (final path in multiBox) {
        final body = code(File(path).readAsStringSync());
        expect(body.contains('maxLength: 1,'), isFalse,
            reason: '$path caps a code box at one character, so a pasted code '
                'is truncated to its first digit wherever it lands and the '
                'distribution never runs.');
      }
    });

    test('and every box therefore selects itself on focus', () {
      // These two go together. Raising the cap WITHOUT this is worse than
      // leaving it at one, because correcting a digit then destroys the code.
      for (final path in multiBox) {
        final body = code(File(path).readAsStringSync());
        expect(body.contains('selectAllOnFocus('), isTrue,
            reason: '$path accepts a full-length paste in every box but does '
                'not select a box on focus. Typing into an already-filled box '
                'then reports two characters, which is read as a paste and '
                'wipes the remaining digits.');
        expect(body.contains('removeListener('), isTrue,
            reason: '$path adds a focus listener without removing it — one '
                'leaked listener per visit to the screen.');
      }
    });
  });

  group('typing cannot be broken again', () {
    test('no code screen uses the controlled pin widget', () {
      // PinFieldAutoFill keeps its own `code` and reconciles it against a
      // prop in didUpdateWidget. Every OTP screen here reports each keystroke
      // to a cubit, which emits, which rebuilds — so that reconciliation ran
      // on every digit, and in November a customer on Android could not type
      // the code he had received: four attempts over forty minutes with no
      // verify call ever reaching the server.
      final offenders = Directory('lib')
          .listSync(recursive: true)
          .whereType<File>()
          .where((f) => f.path.endsWith('.dart'))
          .where((f) => code(f.readAsStringSync()).contains('PinFieldAutoFill'))
          .map((f) => f.path)
          .toList();
      expect(offenders, isEmpty,
          reason: 'a controlled pin component is back in the input path');
    });

    test('the shared behaviour holds no state', () {
      // It is configuration, not a widget. Nothing here can sit between a
      // keypress and the text, which is what makes it safe where the previous
      // two attempts were not.
      final src = File('lib/core/shared_widgets/otp_field_behaviour.dart')
          .readAsStringSync();
      final body = code(src);
      expect(body.contains('StatefulWidget'), isFalse);
      expect(body.contains('setState'), isFalse);
      expect(body.contains('didUpdateWidget'), isFalse,
          reason: 'reconciling against a prop on rebuild is the exact '
              'mechanism that broke typing before');
    });
  });
}
