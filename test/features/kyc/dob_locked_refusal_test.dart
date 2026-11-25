import 'dart:io';

import 'package:flutter_test/flutter_test.dart';

/// THE REFUSAL THAT HAD NOWHERE TO GO.
///
/// auth-service refuses a date-of-birth change once `identity_verified` is
/// true. A gate was added in front of the picker so the customer would be
/// routed to support instead of being walked through choosing a date they
/// could not save — and the refusals kept coming: TEN on 25 Nov alone,
/// measured in auth-microservice's own logs, after the gate existed.
///
/// The gate was reading the SESSION copy of the flag, and that copy is loaded
/// at login. Verification sets `identity_verified` server-side, adopts the
/// registry name and raises the tier, and tells the app nothing — so the gate
/// saw `false`, opened the picker, and the customer confirmed a date, waited
/// on the write, and got "locked". A snackbar is not a destination, so that is
/// where they stopped.
///
/// Two defences now, because the first one can be wrong:
///   1. ask the server before the gate decides (refreshProfileQuietly);
///   2. if the refusal lands anyway, route it where the gate would have.
void main() {
  final src = File(
    'lib/src/features/kyc/presentation/widgets/kyc_profile_fix.dart',
  ).readAsStringSync();
  final cubit = File(
    'lib/src/features/authentication/cubit/authentication_cubit.dart',
  ).readAsStringSync();

  test('defence 1: the gate asks the server before it decides', () {
    final refresh = src.indexOf('refreshProfileQuietly');
    final gate = src.indexOf('if (_dobLockedByVerification(ctx))');
    expect(refresh, greaterThan(-1),
        reason: 'the gate reads a copy loaded at login; without a refresh it '
            'cannot see a flag the server set during verification');
    expect(gate, greaterThan(refresh),
        reason: 'the refresh must happen BEFORE the gate decides, or it '
            'changes nothing');
    expect(src.contains('.timeout('), isTrue,
        reason: 'a profile read on a congested cell must not hold the editor '
            'shut indefinitely — the cached value still decides');
  });

  test('defence 2: a locked refusal routes to support, not a snackbar', () {
    expect(src.contains('_isDobLockedFailure'), isTrue);
    final locked = src.indexOf('if (_isDobLockedFailure(failure.message))');
    expect(locked, greaterThan(-1),
        reason: 'the refusal the gate exists to pre-empt must end somewhere');
    // Scoped to the FOLD's failure branch. There is a second "Could not save"
    // earlier in the function for a thrown error, which is a different path —
    // comparing against that one tests nothing about this ordering.
    final generic = src.indexOf("Get.snackbar('Could not save', failure.message)");
    expect(generic, greaterThan(-1),
        reason: 'the non-locked refusals must still reach the customer');
    expect(locked, lessThan(generic),
        reason: 'the locked branch must be taken BEFORE the generic snackbar, '
            'or it is unreachable and the dead end survives');
    expect(src.contains('_openDobSupportTicket'), isTrue);
  });

  test('a refused write teaches the session copy, so attempt two takes the gate',
      () {
    expect(src.contains('applyIdentityVerified'), isTrue,
        reason: 'without recording what the server just told us, every later '
            'attempt pays for another refused write');
    expect(cubit.contains('void applyIdentityVerified'), isTrue);
  });

  test('the flag is only ever set, never cleared', () {
    final i = cubit.indexOf('void applyIdentityVerified');
    final body = cubit.substring(i, i + 420);
    expect(body.contains('identityVerified: true'), isTrue);
    expect(body.contains('identityVerified: false'), isFalse,
        reason: 'clearing it would let a stale read re-open an edit the '
            'server will refuse');
    expect(body.contains('emit('), isFalse,
        reason: 'emitting AuthenticationSuccess mid-KYC makes every login '
            'surface run goAfterLogin and replace the stack');
  });

  test('the matcher reads the server sentence, loosely', () {
    // The real sentence, verbatim from auth-service.
    const real = 'date of birth is locked because your identity has been '
        'verified — contact support to correct it';
    final m = RegExp(r"bool _isDobLockedFailure\(String message\) \{([\s\S]*?)\n\}")
        .firstMatch(src);
    expect(m, isNotNull, reason: 'the matcher has moved');
    final body = m!.group(1)!;
    expect(body.contains("contains('lock')"), isTrue);
    expect(real.toLowerCase().contains('lock'), isTrue,
        reason: "the server's actual wording must satisfy the matcher");
    expect(
      body.contains("contains('identity')") && body.contains("contains('verified')"),
      isTrue,
      reason: 'matching "lock" alone would capture an account lockout, which '
          'is a different problem with a different destination',
    );
  });

  test('the context is re-checked across every await', () {
    expect(RegExp(r'if \(!ctx\.mounted\) return false;').allMatches(src).length,
        greaterThanOrEqualTo(2),
        reason: 'the picker is a route the customer sits inside; mounting the '
            'confirm dialog on a defunct context throws where they can only '
            'see a frozen screen');
  });
}
