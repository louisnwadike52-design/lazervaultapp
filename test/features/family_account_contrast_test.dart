import 'dart:io';

import 'package:flutter_test/flutter_test.dart';

/// Brand purple is a FILL colour, not a text colour on dark surfaces.
///
/// THE BUG THIS CATCHES, WHICH WAS LIVE
/// ------------------------------------
/// #4E03D0 on the family account's #1F1F1F cards fails contrast badly enough to
/// be unreadable in practice. It was being used for:
///   * @usernames under every member's name,
///   * the avatar initials, drawn INSIDE a circle tinted with the same purple,
///   * an "Invitation pending" line, and
///   * the pull-to-refresh spinner on a dark background.
///
/// #A78BFA is the established accessible tint for purple text on dark, already
/// used elsewhere in the app.
///
/// The TabBar indicator legitimately keeps the brand purple: it is a filled
/// shape with white text on top, which is what the colour is for.

final _src = File(
  'lib/src/features/family_account/presentation/views/family_account_detail_screen.dart',
).readAsStringSync();

/// Source with `//` comment lines removed — the fixes are documented in comments
/// that name the very colours being asserted against.
String get _code => _src
    .split('\n')
    .where((l) => !l.trimLeft().startsWith('//'))
    .join('\n');

void main() {
  test('brand purple is not used as a text colour', () {
    // Exactly one survivor is expected: the TabBar indicator FILL.
    final uses = RegExp(r'color: _kFamilyPurple,').allMatches(_code).length;
    expect(
      uses,
      1,
      reason: 'Only the TabBar indicator fill may use the brand purple. Every '
          'other use was text or a thin indicator on a dark surface, where it '
          'is unreadable — use _kFamilyPurpleText (#A78BFA) instead.',
    );
  });

  test('the accessible tint is defined and used', () {
    expect(_code, contains('_kFamilyPurpleText = Color(0xFFA78BFA)'));
    expect(
      RegExp(r'_kFamilyPurpleText').allMatches(_code).length,
      greaterThan(5),
      reason: 'usernames, avatar initials, currency prefix and the refresh '
          'spinners should all be on the accessible tint',
    );
  });

  test('raw brand-purple literals are not reintroduced for text', () {
    // The constant exists so the colour has one definition; a literal sneaking
    // back in is how the original drift happened.
    expect(
      _code.contains('color: const Color(0xFF4E03D0)'),
      isFalse,
      reason: 'use the named constants, not a raw literal',
    );
  });

  group('invitation state badges', () {
    test('each state has its own colour', () {
      // Every non-accepted state used to render in the same purple, so DECLINED
      // and EXPIRED looked identical to PENDING. A declined invite reading as
      // "still waiting" means an admin waits on someone who already said no.
      expect(_code, contains('Color _invitationStatusColor(InvitationStatus s)'));
      for (final s in [
        'InvitationStatus.pending',
        'InvitationStatus.declined',
        'InvitationStatus.expired',
        'InvitationStatus.removed',
        'InvitationStatus.accepted',
      ]) {
        expect(_code, contains('case $s:'),
            reason: '$s needs its own badge colour — a switch with a default '
                'would silently lump a new state in with an existing one');
      }
    });

    test('the badge is driven by the mapper, not a fixed colour', () {
      expect(
        _code,
        contains('_invitationStatusColor(member.invitationStatus)'),
      );
    });

    test('the duplicate "Invitation <status>" text line is gone', () {
      // The status is already a badge beside the role badge; the line beneath
      // repeated it in an unreadable colour.
      expect(
        _code.contains("'Invitation \${member.invitationStatus.name}'"),
        isFalse,
      );
    });
  });
}
