import 'dart:io';

import 'package:flutter_test/flutter_test.dart';

/// Invitations must not go out until the setup is submitted.
///
/// THE BUG THIS CATCHES, WHICH WAS LIVE
/// ------------------------------------
/// "Send Invitation" called _cubit.addMember() immediately. So tapping it
/// dispatched a REAL invitation before the wizard was finished, or even
/// committed to: the person was notified, showed as PENDING, and became a member
/// of an account whose setup the creator might then abandon — leaving live
/// invitations to a family account that was never configured.
///
/// People are now staged locally and sent once, from _activateAccount.
final _screen = File(
  'lib/src/features/family_account/presentation/views/family_activation_setup_screen.dart',
).readAsStringSync();

final _cubit = File(
  'lib/src/features/family_account/presentation/cubit/family_account_cubit.dart',
).readAsStringSync();

/// Source with `//` comment lines stripped — the fixes are documented in
/// comments that quote the very call being asserted absent.
String _strip(String s) => s
    .split('\n')
    .where((l) => !l.trimLeft().startsWith('//'))
    .join('\n');

String get _code => _strip(_screen);

/// The code of a named method, comments stripped.
String _method(String source, String signature) {
  final start = source.indexOf(signature);
  if (start == -1) throw StateError('method not found: $signature');
  final rest = source.substring(start);
  final end = rest.indexOf('\n  }\n');
  return _strip(rest.substring(0, end == -1 ? rest.length : end));
}

void main() {
  group('staging', () {
    test('picking a member stages locally and sends nothing', () {
      final body = _method(_screen, 'void _inviteMember()');
      expect(body, contains('_stagedInvites.add('));
      expect(
        body.contains('_cubit.addMember('),
        isFalse,
        reason: 'the invite button must not dispatch a real invitation — that '
            'notifies someone about an account whose setup may be abandoned',
      );
    });

    test('the button no longer claims to send', () {
      expect(_code.contains("'Send Invitation'"), isFalse);
      expect(_code, contains("'Add to invite list'"));
    });

    test('duplicates are caught across BOTH lists', () {
      // Staged twice = two invitations on submit; already-invited server-side
      // (a resumed setup) = a duplicate the server would reject.
      final body = _method(_screen, 'void _inviteMember()');
      expect(body, contains('_invitedMembers.any('));
      expect(body, contains('_stagedInvites.any('));
    });

    test('staged people can be removed before submit', () {
      expect(_code, contains('_stagedInvites.remove('));
    });
  });

  group('submit', () {
    test('invitations are sent BEFORE activation', () {
      final body = _method(_screen, 'Future<void> _activateAccount()');
      final sendIdx = body.indexOf('_sendStagedInvites()');
      final setupIdx = body.indexOf('_submitSetup()');
      expect(sendIdx, isNot(-1), reason: 'staged invites must actually be sent');
      expect(setupIdx, isNot(-1));
      expect(sendIdx < setupIdx, isTrue,
          reason: 'members must exist before the account goes active, so '
              'allocation and limits apply to a settled roster');
    });

    test('a double tap cannot re-send every invitation', () {
      // Activation is one-shot server-side, but a second tap would re-send the
      // whole staged batch before hitting that refusal.
      final body = _method(_screen, 'Future<void> _activateAccount()');
      expect(body, contains('_isSubmittingSetup'));
    });

    test('staged list is cleared after sending', () {
      final body = _method(_screen, 'Future<void> _activateAccount()');
      expect(body, contains('_stagedInvites.clear()'));
    });

    test('failures are named, not summarised', () {
      // "Some invitations failed" leaves the creator with no idea who to re-add.
      final body = _method(_screen, 'Future<void> _activateAccount()');
      expect(body, contains('failed.join('));
    });

    test('one failure does not abort the rest', () {
      final body = _method(_screen, 'Future<List<String>> _sendStagedInvites()');
      expect(body, contains('catch'));
      expect(body, contains('failed.add('));
    });
  });

  group('the batch send is state-silent', () {
    test('addMemberAwaitable exists and emits nothing', () {
      final body = _method(_cubit, 'Future<void> addMemberAwaitable(');
      expect(
        body.contains('emit('),
        isFalse,
        reason: 'emitting per invite would re-enter the wizard BlocConsumer '
            'once per staged member, mid-submit',
      );
      expect(body, contains('throw Exception('),
          reason: 'the caller needs to know WHICH invite failed');
    });
  });
}
