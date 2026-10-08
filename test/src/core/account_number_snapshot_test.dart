import 'package:flutter_test/flutter_test.dart';
import 'package:lazervault/core/services/account_number_change_watcher.dart';

/// "Your account details have changed" kept reappearing with identical details.
///
/// THE MECHANISM
///
/// The baseline is one tab-separated string of (number, bank, holder), and the
/// parser draws a deliberate distinction: a MISSING field is null — "this
/// device never recorded it", never reported as a change — while a
/// present-but-empty field is '' — "recorded as absent", which IS comparable.
///
/// `_snapshot` then always joined three parts. So a pass that had the account
/// number but whose bank had not arrived yet stored `"1234\t\t"`, which parses
/// as bank = '' rather than null. On the NEXT load the bank WAS there, the
/// watcher compared '' against 'Nombank MFB', and announced a change that had
/// never happened. Nothing about the account moved; the snapshot flapped
/// between partial and complete.
///
/// Two fixes, both pinned here: unknown trailing fields are omitted rather than
/// written as empty, and a known value is never overwritten by an unloaded one.
void main() {
  ({String number, String? bank, String? holder}) roundTrip(
      String number, String bank, String holder) {
    return AccountNumberChangeWatcher.parseSnapshot(
      AccountNumberChangeWatcher.snapshotFor(number, bank, holder),
    );
  }

  group('an unloaded field is recorded as UNKNOWN, not as absent', () {
    test('number only', () {
      final r = roundTrip('1234567890', '', '');
      expect(r.number, '1234567890');
      expect(r.bank, isNull,
          reason: "'' would be compared against the real bank next load and "
              'reported as a change');
      expect(r.holder, isNull);
    });

    test('number and bank, holder not loaded yet', () {
      final r = roundTrip('1234567890', 'Nombank MFB', '');
      expect(r.number, '1234567890');
      expect(r.bank, 'Nombank MFB');
      expect(r.holder, isNull);
    });

    test('all three present', () {
      final r = roundTrip('1234567890', 'Nombank MFB', 'PRAIZ ONAH');
      expect(r.number, '1234567890');
      expect(r.bank, 'Nombank MFB');
      expect(r.holder, 'PRAIZ ONAH');
    });
  });

  group('the reported repeat cannot happen', () {
    test('a partial first pass does not forge a bank change', () {
      // Pass 1: the summary arrived with the number but no bank yet.
      final first = AccountNumberChangeWatcher.snapshotFor('1234567890', '', '');
      final prev = AccountNumberChangeWatcher.parseSnapshot(first);

      // Pass 2: the bank is now populated. This is the exact comparison the
      // watcher makes.
      const currentBank = 'Nombank MFB';
      final bankMoved =
          prev.bank != null && currentBank.isNotEmpty && prev.bank != currentBank;

      expect(bankMoved, isFalse,
          reason: 'the bank was never recorded, so it cannot have "changed"');
    });

    test('a partial first pass does not forge a holder change', () {
      final first = AccountNumberChangeWatcher.snapshotFor(
          '1234567890', 'Nombank MFB', '');
      final prev = AccountNumberChangeWatcher.parseSnapshot(first);

      const currentHolder = 'PRAIZ ONAH';
      final holderMoved = prev.holder != null &&
          currentHolder.isNotEmpty &&
          prev.holder != currentHolder;

      expect(holderMoved, isFalse);
    });

    test('carrying a known value forward survives an empty pass', () {
      // Pass 1 knows everything.
      var stored = AccountNumberChangeWatcher.snapshotFor(
          '1234567890', 'Nombank MFB', 'PRAIZ ONAH');

      // Pass 2 arrives with the bank momentarily blank. The watcher carries the
      // previous value forward instead of storing the blank.
      var prev = AccountNumberChangeWatcher.parseSnapshot(stored);
      const currentBank = '';
      const currentHolder = 'PRAIZ ONAH';
      final nextBank = currentBank.isNotEmpty ? currentBank : (prev.bank ?? '');
      final nextHolder =
          currentHolder.isNotEmpty ? currentHolder : (prev.holder ?? '');
      stored = AccountNumberChangeWatcher.snapshotFor(
          '1234567890', nextBank, nextHolder);

      // Pass 3 has the bank back. Nothing should look changed.
      prev = AccountNumberChangeWatcher.parseSnapshot(stored);
      expect(prev.bank, 'Nombank MFB',
          reason: 'the blank pass must not have erased a known bank');
      final bankMoved = prev.bank != null && prev.bank != 'Nombank MFB';
      expect(bankMoved, isFalse);
    });
  });

  group('a REAL change is still reported', () {
    test('the provider migration this modal exists for', () {
      final stored = AccountNumberChangeWatcher.snapshotFor(
          '9800138852', 'Flutterwave MFB', 'Praiz Onah FLW');
      final prev = AccountNumberChangeWatcher.parseSnapshot(stored);

      const number = '1234567890';
      const bank = 'Nombank MFB';
      const holder = 'PRAIZ ONAH';

      expect(prev.number != number, isTrue);
      expect(prev.bank != null && prev.bank != bank, isTrue);
      expect(prev.holder != null && prev.holder != holder, isTrue);
    });
  });

  group('the legacy bare-number baseline still parses', () {
    test('an existing install holding just a number', () {
      // Written before the snapshot carried bank/holder. Must read as "never
      // recorded" for those two, or every existing user would be told their
      // bank changed the first time this ran.
      final r = AccountNumberChangeWatcher.parseSnapshot('9800138852');
      expect(r.number, '9800138852');
      expect(r.bank, isNull);
      expect(r.holder, isNull);
    });
  });

  group('a middle field that was never loaded is still unknown', () {
    test('holder known before bank — the hole the first fix left open', () {
      // Omitting TRAILING unknowns cannot express "bank unknown, holder
      // known": the bank sits in the middle slot and had to be written empty.
      // Reading that as "recorded as absent" would re-create the phantom
      // change through a narrower door.
      final stored =
          AccountNumberChangeWatcher.snapshotFor('1234567890', '', 'PRAIZ ONAH');
      final prev = AccountNumberChangeWatcher.parseSnapshot(stored);

      expect(prev.holder, 'PRAIZ ONAH');
      expect(prev.bank, isNull,
          reason: 'the bank was never loaded, so it cannot have changed');

      const currentBank = 'Nombank MFB';
      final bankMoved =
          prev.bank != null && currentBank.isNotEmpty && prev.bank != currentBank;
      expect(bankMoved, isFalse);
    });
  });
}
