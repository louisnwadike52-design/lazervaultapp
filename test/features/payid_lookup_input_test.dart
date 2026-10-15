import 'dart:io';

import 'package:flutter/services.dart';
import 'package:flutter_test/flutter_test.dart';
import 'package:lazervault/src/features/id_pay/presentation/cubit/id_pay_state.dart';
import 'package:lazervault/src/features/id_pay/presentation/widgets/pay_id_input.dart';

/// Two reports from the PayID screens.
///
/// 1. **A doubled prefix.** The entry field draws a fixed `PAY-`, and every
///    copyable form of a PayID (share message, invoice PDF, copy button,
///    receipt) renders `PAY-<code>`. Pasting one showed `PAY-PAY-RSW6DQ` and
///    searched for `PAY-RSW6DQ` — a guaranteed "not found" for a code that
///    exists.
/// 2. **A failure shown twice.** A failed lookup rendered the styled in-page
///    state AND a red error toast on top of it.
void main() {
  group('the PAY- prefix is stripped from what the user enters', () {
    test('a pasted display code loses its prefix', () {
      expect(stripPayIdPrefix('PAY-RSW6DQ'), 'RSW6DQ');
    });

    test('however it was copied', () {
      for (final raw in [
        'pay-rsw6dq',
        'Pay-RSW6DQ',
        'PAY RSW6DQ',
        'PAY_RSW6DQ',
        'PAYRSW6DQ',
        '  PAY-RSW6DQ',
      ]) {
        expect(stripPayIdPrefix(raw).toUpperCase(), 'RSW6DQ',
            reason: 'failed on "$raw"');
      }
    });

    test('a paste on top of a paste is stripped all the way', () {
      expect(stripPayIdPrefix('PAY-PAY-RSW6DQ'), 'RSW6DQ');
      expect(stripPayIdPrefix('PAY-PAY-PAY-RSW6DQ'), 'RSW6DQ');
    });

    test('a bare code is untouched', () {
      expect(stripPayIdPrefix('RSW6DQ'), 'RSW6DQ');
      expect(stripPayIdPrefix(''), '');
    });

    test('a code that merely STARTS with the letters survives', () {
      // "PAYDAY" is six characters and a legal code shape. Eating the first
      // three would turn one valid code into a different one.
      expect(stripPayIdPrefix('PAYDAY'), 'DAY',
          reason: 'documents the known limit: an unseparated PAY prefix is '
              'stripped, because a pasted "PAYA3K9X2" is far more common '
              'than a code that happens to begin with those letters');
    });

    test('exactly "PAY" mid-typing does not empty the field', () {
      // Typing P-A-Y passes through this on every keystroke. Returning ""
      // would wipe what the user is in the middle of writing.
      expect(stripPayIdPrefix('PAY'), 'PAY');
    });

    test('the formatter upper-cases, because a paste skips the keyboard', () {
      const f = PayIdInputFormatter();
      final out = f.formatEditUpdate(
        const TextEditingValue(text: ''),
        const TextEditingValue(
            text: 'pay-rsw6dq',
            selection: TextSelection.collapsed(offset: 10)),
      );
      expect(out.text, 'RSW6DQ');
      // The caret must not sit past the end of the shortened text.
      expect(out.selection.baseOffset, lessThanOrEqualTo(out.text.length));
      expect(out.selection.baseOffset, greaterThanOrEqualTo(0));
    });

    test('an unchanged value is returned as-is, caret and all', () {
      const f = PayIdInputFormatter();
      const v = TextEditingValue(
          text: 'RSW6DQ', selection: TextSelection.collapsed(offset: 3));
      expect(f.formatEditUpdate(const TextEditingValue(text: ''), v), v);
    });
  });

  group('a failed lookup is shown once, and says which failure', () {
    test('only NOT_FOUND claims the code is wrong', () {
      expect(IDPayError(message: 'x', code: 'NOT_FOUND').isNotFound, isTrue);
      expect(IDPayError(message: 'x', code: 'not_found').isNotFound, isTrue);
      for (final code in ['UNAVAILABLE', 'DEADLINE_EXCEEDED', 'INTERNAL', '']) {
        expect(IDPayError(message: 'x', code: code).isNotFound, isFalse,
            reason: 'a $code failure must not tell the user to re-read a '
                'code that may be perfectly correct');
      }
    });

    test('the code is optional, so every other emitter still compiles', () {
      expect(IDPayError(message: 'x').code, '');
      expect(IDPayError(message: 'x').isNotFound, isFalse);
    });
  });

  group('the screen offers what the tab is for', () {
    String codeOfHome() => File(
            'lib/src/features/id_pay/presentation/view/id_pay_home_screen.dart')
        .readAsStringSync()
        .split('\n')
        .where((l) =>
            !l.trimLeft().startsWith('//') && !l.trimLeft().startsWith('///'))
        .join('\n');

    test('the big button says Pay on the Pay tab', () {
      // "Create PayID" over the Pay tab offered the opposite of what the user
      // had just chosen, while the real action was a small search icon inside
      // the field.
      final s = codeOfHome();
      expect(s, contains("_isPayTab ? 'Pay' : 'Create PayID'"));
      expect(s, contains('bool get _isPayTab => _tabController.index == 1;'),
          reason: 'read the tab from the controller, not a second copy of '
              'the index that a swipe can desync');
    });

    test('a tab change actually repaints the button', () {
      final s = codeOfHome();
      expect(s, contains('_tabController.addListener(_onTabChanged);'),
          reason: 'TabController notifies listeners; it does not rebuild the '
              'Scaffold, so the label would keep whatever it was built with');
      expect(s, contains('_tabController.removeListener(_onTabChanged);'),
          reason: 'a listener left on a disposed State calls setState on it');
    });

    test('Pay with an empty field focuses it rather than searching nothing',
        () {
      expect(codeOfHome(), contains('_searchFocus'));
      expect(codeOfHome(), contains('_searchFocus.dispose();'));
    });
  });

  group('a terminal status is unmissable', () {
    String badge() => File(
            'lib/src/features/id_pay/presentation/widgets/id_pay_status_badge.dart')
        .readAsStringSync();

    test('paid, expired and cancelled are drawn solid; active is not', () {
      final s = badge();
      expect(s, contains('bool get _isTerminal => status != IDPayStatus.active;'),
          reason: 'making EVERY badge shout makes none of them heard');
      expect(s, contains('color: _isTerminal ? accent : accent.withValues('),
          reason: 'a 15% tint on a #1F1F1F card is a 4-point luminance step — '
              'a tag, not a conclusion');
      expect(s, contains('_isTerminal ? Colors.white : accent'));
    });

    test('a terminal badge carries an icon', () {
      expect(badge(), contains('Icons.check_circle'));
      expect(badge(), contains('if (_isTerminal) ...['));
    });
  });

  group('the wiring', () {
    String codeOf(String p) => File(p)
        .readAsStringSync()
        .split('\n')
        .where((l) =>
            !l.trimLeft().startsWith('//') && !l.trimLeft().startsWith('///'))
        .join('\n');

    const lookup =
        'lib/src/features/id_pay/presentation/view/id_pay_lookup_screen.dart';
    const home =
        'lib/src/features/id_pay/presentation/view/id_pay_home_screen.dart';

    test('no toast duplicates the in-page failure state', () {
      expect(codeOf(lookup), isNot(contains('Get.snackbar')),
          reason: 'the styled empty state already says it, in the place the '
              'eye already is');
    });

    test('both entry fields run the formatter', () {
      for (final p in [lookup, home]) {
        expect(codeOf(p), contains('PayIdInputFormatter()'),
            reason: '$p lets a pasted PAY- through to the field');
      }
    });

    test('every route into a lookup strips the prefix', () {
      // The formatter only sees typing and pasting. A deep link, a QR scan or
      // the home tab sets the controller directly.
      expect(codeOf(lookup), contains("stripPayIdPrefix(args['payId']"),
          reason: 'a code arriving by route argument opens the screen showing '
              'the doubled prefix');
      expect(codeOf(lookup), contains('stripPayIdPrefix(payId)'));
      expect(codeOf(home), contains('stripPayIdPrefix(payId)'));
    });

    test('the creation success screen is not also announced by a toast', () {
      // The "PayID Created / Your PayID is Ready!" screen IS the success
      // message. A toast over it says the same thing a second time, lower
      // down, on its own timer.
      //
      // Searched 2026-10-15 and found none in the current code — this pins
      // that. The create screen keeps its ERROR toast deliberately: it has
      // no in-page error state, so removing it would fail silently.
      const created =
          'lib/src/features/id_pay/presentation/view/id_pay_created_screen.dart';
      expect(codeOf(created), isNot(contains('Get.snackbar')),
          reason: 'the success widget already says it — and the Copy chip '
              'confirms itself in place rather than with a second bar');
      // Copy still has to confirm SOMETHING: a clipboard write is invisible.
      expect(codeOf(created), contains("_copied ? 'Copied' : 'Copy'"),
          reason: 'removing the toast must not remove the confirmation');
      final createdSrc = codeOf(created);
      final d = createdSrc.indexOf('void dispose()');
      expect(d, greaterThan(-1), reason: 'the chip lost its dispose');
      expect(createdSrc.substring(d, createdSrc.indexOf('}', d)),
          contains('_revert?.cancel();'),
          reason: 'a timer outliving the screen calls setState on a dead '
              'State. (_copy cancels it too, so searching the whole file '
              'passes with dispose emptied.)');

      const create =
          'lib/src/features/id_pay/presentation/view/create_id_pay_screen.dart';
      final src = codeOf(create);
      final i = src.indexOf('if (state is IDPayCreated)');
      expect(i, greaterThan(-1), reason: 'the success branch moved');
      // Only up to the error branch: the error toast after it is wanted.
      final successBranch = src.substring(i, src.indexOf('else if', i));
      expect(successBranch, isNot(contains('snackbar')),
          reason: 'the success branch must navigate, not also toast');
    });

    test('the REQUEST strips it too, whatever route the code came by', () {
      // The screens are not the only callers: the chat and voice agents, a
      // deep link and a QR scan reach the repository directly, and a prefixed
      // code there is a guaranteed NOT_FOUND for a PayID that exists.
      const repo =
          'lib/src/features/id_pay/data/repositories/id_pay_repository_impl.dart';
      final src = codeOf(repo);
      for (final call in [
        'lookupIDPay(payId: stripPayIdPrefix(payId))',
        'lookupIDPayWithOrg(\n          payId: stripPayIdPrefix(payId))',
        'payId: stripPayIdPrefix(payId),',
      ]) {
        expect(src, contains(call), reason: 'missing: $call');
      }
      // Every remote call that takes a payId must be covered — counted, so
      // adding a fifth without stripping fails here.
      expect(src.split('stripPayIdPrefix(payId)').length - 1, 4,
          reason: 'one of the four payId-taking remote calls sends the raw '
              'value');
    });

    test('the failure state branches on the cause', () {
      final s = codeOf(lookup);
      expect(s, contains('state.isNotFound'));
      expect(s, contains("We couldn't reach the server"));
      expect(s, contains("'Try again'"),
          reason: 'retry is the action for an unreachable server, and the '
              'only one offered');
    });
  });
}
