import 'dart:io';

import 'package:flutter_test/flutter_test.dart';
import 'package:lazervault/src/features/lock_funds/domain/entities/lock_fund_entity.dart';

/// An EMPTY `maturity_action` means the user never chose.
///
/// The server then falls back to the plan's `auto_renew` flag, which may
/// start another term rather than return the money. So rendering empty as
/// "pay out" promises somebody their capital back when the server has agreed
/// to no such thing — it is a lie about money, not a cosmetic default.
/// `undecided` exists to carry that distinction all the way to the screen.
void main() {
  String code(String p) => File(p)
      .readAsStringSync()
      .split('\n')
      .where((l) =>
          !l.trimLeft().startsWith('//') && !l.trimLeft().startsWith('///'))
      .join('\n');

  group('the wire mapping', () {
    test('absent, blank and unknown all read as undecided', () {
      expect(MaturityAction.fromWire(null), MaturityAction.undecided);
      expect(MaturityAction.fromWire(''), MaturityAction.undecided);
      expect(MaturityAction.fromWire('   '), MaturityAction.undecided);
      expect(MaturityAction.fromWire('payout_everything'),
          MaturityAction.undecided,
          reason: 'an action added server-side after this build shipped must '
              'not be guessed at');
    });

    test('every offered choice round-trips through its slug', () {
      for (final a in MaturityAction.choices) {
        expect(a.wireValue, isNotEmpty, reason: '$a needs a slug to send');
        expect(MaturityAction.fromWire(a.wireValue), a);
        // Case and padding survive a sloppy backend.
        expect(MaturityAction.fromWire(' ${a.wireValue.toUpperCase()} '), a);
      }
    });

    test('undecided sends an empty slug, which is what CLEARS the choice', () {
      expect(MaturityAction.undecided.wireValue, '');
    });

    test('the slugs are exactly the four the proto documents', () {
      final proto = File('proto/lock_funds.proto').readAsStringSync();
      for (final a in MaturityAction.choices) {
        expect(proto, contains('"${a.wireValue}"'),
            reason: '${a.wireValue} is not a slug the service accepts');
      }
      expect(MaturityAction.choices.length, 4);
      expect(MaturityAction.choices, isNot(contains(MaturityAction.undecided)),
          reason: 'a user cannot CHOOSE indecision, only clear a choice');
      expect(MaturityAction.values.length, 5,
          reason: 'four choices plus undecided; a fifth needs a slug, copy '
              'and a server-side case added with it');
    });
  });

  group('undecided never reads as a payout', () {
    test('its copy claims nothing about where the money goes', () {
      final name = MaturityAction.undecided.displayName.toLowerCase();
      expect(name, 'not decided');
      expect(name, isNot(contains('pay')));
      expect(MaturityAction.undecided.description.toLowerCase(),
          contains('auto-renew'),
          reason: 'the user should know which setting actually decides');
    });

    test('it is not treated as a reinvestment either', () {
      expect(MaturityAction.undecided.isReinvestment, isFalse);
      expect(MaturityAction.payout.isReinvestment, isFalse);
      expect(MaturityAction.reinvestAll.isReinvestment, isTrue);
      expect(MaturityAction.reinvestPrincipal.isReinvestment, isTrue);
      expect(MaturityAction.reinvestInterest.isReinvestment, isTrue);
    });

    test('the detail row names the outcome auto-renew would produce', () {
      // Showing a bare "Not set" leaves the user to work out whether their
      // money comes back or rolls over — opposite outcomes.
      final s = code(
          'lib/src/features/lock_funds/presentation/screens/lock_fund_details_maturity.dart');
      expect(s, contains("'Not set — will renew'"));
      expect(s, contains("'Not set — will pay out'"));
      expect(s, contains('lock.autoRenew'));
    });
  });

  group('every label is sentence case', () {
    // Standing instruction: no Pascal/Title Case anywhere in PiggyVault.
    test('only the first word of a label is capitalised', () {
      bool startsUpper(String w) =>
          w.isNotEmpty && w[0].toUpperCase() == w[0] && w[0].toLowerCase() != w[0];
      for (final a in MaturityAction.values) {
        final words = a.displayName.split(' ');
        expect(startsUpper(words.first), isTrue,
            reason: '"${a.displayName}" should start with a capital');
        for (final w in words.skip(1)) {
          expect(startsUpper(w), isFalse,
              reason: '"${a.displayName}" is title-cased on "$w"');
        }
      }
    });
  });

  group('the wiring that carries it', () {
    test('the model parses the slug instead of storing it raw', () {
      final s =
          code('lib/src/features/lock_funds/data/models/lock_fund_model.dart');
      expect(s, contains('MaturityAction.fromWire(proto.maturityAction)'),
          reason: 'a raw string assignment would reintroduce the empty-means-'
              'payout ambiguity in the entity');
      expect(s, contains('proto.hasMaturitySettledAt()'),
          reason: 'a bare toDateTime() on an unset timestamp renders as 1970, '
              'which reads as a settlement that already happened');
      expect(s, contains('maturityNote: proto.maturityNote'));
      expect(s, contains('reinvestedIntoId: proto.reinvestedIntoId'));
    });

    test('the repository sends wireValue and substitutes nothing', () {
      final s = code(
          'lib/src/features/lock_funds/data/repositories/lock_funds_repository_impl.dart');
      final i = s.indexOf('Future<LockFund> setMaturityAction(');
      expect(i, greaterThan(-1), reason: 'the RPC is not called at all');
      final body = s.substring(i, (i + 900).clamp(0, s.length));
      expect(body, contains('..maturityAction = action.wireValue'));
      expect(body, isNot(contains("'payout'")),
          reason: 'defaulting an empty choice to payout here would make the '
              'clear-my-choice path impossible');
    });

    test('the tap is offered only on the two statuses the server accepts', () {
      // AccountsService.SetMaturityAction refuses anything that is not
      // `locked` or `pending_approval`. A tappable row elsewhere would open a
      // sheet whose every option comes back refused.
      final s = code(
          'lib/src/features/lock_funds/presentation/screens/lock_fund_details_screen.dart');
      final i = s.indexOf('_MaturitySection(');
      expect(i, greaterThan(-1), reason: 'the row is not on the screen');
      final block = s.substring(i, (i + 400).clamp(0, s.length));
      expect(block, contains('LockStatus.active'));
      expect(block, contains('LockStatus.pendingApproval'));
      expect(block, contains('_pickMaturityAction'));
      expect(block, contains(': null'),
          reason: 'every other status must get a read-only row');
    });

    test('a dismissed sheet changes nothing', () {
      final s = code(
          'lib/src/features/lock_funds/presentation/screens/lock_fund_details_screen.dart');
      final i = s.indexOf('Future<void> _pickMaturityAction()');
      expect(i, greaterThan(-1));
      final body = s.substring(i, (i + 1200).clamp(0, s.length));
      expect(body, contains('if (chosen == null) return;'),
          reason: 'null is a dismissal; undecided is a deliberate clear, and '
              'collapsing the two silently wipes a real choice');
      expect(body, contains('if (chosen == _lock.maturityAction) return;'),
          reason: 're-picking the current value should not round-trip');
    });

    test('the settled note is surfaced, not swallowed', () {
      final s = code(
          'lib/src/features/lock_funds/presentation/screens/lock_fund_details_maturity.dart');
      expect(s, contains('lock.maturityNote'),
          reason: 'reinvesting returns alone routinely lands under a plan '
              'minimum and is paid out instead — the user has to be told');
      expect(s, contains('lock.reinvestedIntoId.isNotEmpty'));
    });
  });
}
