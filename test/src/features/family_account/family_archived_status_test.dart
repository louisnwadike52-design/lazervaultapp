import 'dart:io';

import 'package:flutter_test/flutter_test.dart';
import 'package:lazervault/src/features/family_account/domain/entities/family_account_entities.dart';

/// Closing a Family & Friends account archives it: funds return, the slot frees
/// up, and the row and its history are kept.
///
/// THE BUG THIS CATCHES: `archived` had no value in FamilyAccountStatus, and the
/// status mapper's `default` fell through to `active`. So a retired account came
/// back to the app claiming to be LIVE — it would have been labelled "Active" on
/// the archive screen, and any `status == active` branch would have treated a
/// closed account as spendable. The enum value is the fix; these tests are what
/// stop the fall-through from being reintroduced.
void main() {
  group('archived is a real status, distinct from every other one', () {
    test('the enum carries it', () {
      expect(
          FamilyAccountStatus.values, contains(FamilyAccountStatus.archived));
    });

    test('it is not active', () {
      // The whole bug in one assertion.
      expect(FamilyAccountStatus.archived, isNot(FamilyAccountStatus.active));
    });

    test('it reads as "Closed" to the user, not "Archived"', () {
      // "Archived" is our storage word. The button the creator pressed said
      // Close account, so the state has to say Closed back.
      expect(FamilyAccountStatus.archived.displayName, 'Closed');
    });

    test('every status still has a display name', () {
      // A new enum value with no displayName would throw at render time rather
      // than fail here.
      for (final s in FamilyAccountStatus.values) {
        expect(s.displayName, isNotEmpty, reason: '$s has no display name');
      }
    });
  });

  group('the status mapper', () {
    late String source;

    setUpAll(() {
      final file = File(
        'lib/src/features/family_account/data/models/family_account_models.dart',
      );
      expect(file.existsSync(), isTrue,
          reason: 'family_account_models.dart moved — update this test');
      source = file.readAsStringSync();
    });

    test("maps 'archived' explicitly rather than falling through to active",
        () {
      expect(source, contains("case 'archived':"),
          reason: 'without this case the default returned active, so a closed '
              'account reported itself as live');
      expect(source, contains('FamilyAccountStatus.archived'));
    });

    test('serialises it back to the wire value the server filters on', () {
      // The archive screen asks the RPC for status=archived; if serialisation
      // drifted, the screen would silently return nothing.
      expect(source, contains("return 'archived';"));
    });
  });

  group('the archive screen', () {
    late String source;

    setUpAll(() {
      final file = File(
        'lib/src/features/family_account/presentation/views/'
        'family_archived_accounts_screen.dart',
      );
      expect(file.existsSync(), isTrue,
          reason: 'family_archived_accounts_screen.dart moved');
      source = file.readAsStringSync();
    });

    test('asks the SERVER for archived accounts', () {
      // An unfiltered read already excludes archived rows, so a client-side
      // filter for them could only ever return an empty list. The filter has to
      // reach the RPC.
      expect(source, contains('loadFamilyAccounts(statusFilter:'),
          reason: 'the status must be sent through to the server');
      expect(source, contains("'archived'"));
    });

    test('shows only archived rows even if the server sends others', () {
      expect(source, contains('FamilyAccountStatus.archived'),
          reason: 'a live account on a screen titled "Previous accounts" is '
              'worse than an empty list');
    });

    test('has a real empty state rather than a blank screen', () {
      expect(source, contains('No closed accounts'));
    });

    test('has a retry path when the read fails', () {
      expect(source, contains('Try again'));
    });
  });

  group('the close dialog tells the truth about what happens', () {
    late String source;

    setUpAll(() {
      final file = File(
        'lib/src/features/family_account/presentation/views/'
        'family_account_detail_screen.dart',
      );
      expect(file.existsSync(), isTrue);
      source = file.readAsStringSync();
    });

    test('no longer claims the action cannot be undone', () {
      // It stopped being true when delete became an archive: the row and its
      // history are kept and stay readable.
      expect(
        source.contains('This action cannot be undone'),
        isFalse,
        reason: 'the account is archived, not destroyed — and the copy scared '
            'people off while hiding the part they care about, that the slot '
            'comes back',
      );
    });

    test('says the slot frees up', () {
      expect(source, contains('frees up a'));
    });

    test('the confirm button is disabled until the name matches', () {
      // It used to accept the tap and return early on a mismatch, with no
      // message — so a typo read as "the Delete button is broken", on a
      // destructive action.
      expect(source, contains('ValueListenableBuilder<TextEditingValue>'),
          reason: 'the button must reflect whether the typed name matches');
      expect(source, contains('disabledBackgroundColor'));
    });
  });
}
