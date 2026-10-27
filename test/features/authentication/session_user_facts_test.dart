// The biometric / voice unlock hands the post-login router a user built from
// the PROFILE proto, which has no passcode, PIN, verification or KYC fields.
// enrichSessionUser is what stops that user reading as "no passcode, no PIN"
// — which is what opened "Set Up Passcode" on every Face ID unlock.
import 'dart:async';

import 'package:dartz/dartz.dart';
import 'package:flutter_test/flutter_test.dart';
import 'package:lazervault/core/error/failure.dart';
import 'package:lazervault/core/services/login_facts_store.dart';
import 'package:lazervault/src/features/authentication/domain/entities/user.dart';
import 'package:lazervault/src/features/authentication/presentation/utils/session_user_facts.dart';

User _profileUser() => User(
      id: 'u1',
      firstName: 'Ada',
      lastName: 'Obi',
      email: 'ada@example.com',
      verified: false,
      isEmailVerified: false,
      createdAt: DateTime(2026),
      updatedAt: DateTime(2026),
    );

User _authUser() => _profileUser().copyWith(
      hasPasscode: true,
      hasPassword: false,
      verified: true,
      isEmailVerified: true,
      phoneNumber: '+2348012345678',
      signupStatus: 'complete',
      kycTier: 3,
      kycStatus: 'approved',
      preferredLoginMethod: 'phone_passcode',
    );

void main() {
  test('a live GetMe lays every routing fact over the profile user', () async {
    final u = await enrichSessionUser(
      _profileUser(),
      fetchMe: () async => Right(_authUser()),
      fetchHasPin: () async => true,
      readPasscodeMirror: () async => null,
    );
    expect(u.hasPasscode, isTrue);
    expect(u.hasTransactionPin, isTrue);
    expect(u.verified, isTrue);
    expect(u.isEmailVerified, isTrue);
    expect(u.phoneNumber, '+2348012345678');
    expect(u.signupStatus, 'complete');
    expect(u.kycTier, 3);
    expect(u.kycStatus, 'approved');
    expect(u.preferredLoginMethod, 'phone_passcode');
    // Profile-only fields survive.
    expect(u.firstName, 'Ada');
  });

  test('a live GetMe that says NO passcode is believed', () async {
    final u = await enrichSessionUser(
      _profileUser(),
      fetchMe: () async => Right(_authUser().copyWith(hasPasscode: false)),
      fetchHasPin: () async => false,
      readPasscodeMirror: () async => 'true', // mirror must not override live
    );
    expect(u.hasPasscode, isFalse);
    expect(u.hasTransactionPin, isFalse);
  });

  test('GetMe unreachable → the stored mirror decides the passcode', () async {
    final u = await enrichSessionUser(
      _profileUser(),
      fetchMe: () async =>
          Left(ServerFailure(message: 'down', statusCode: 503)),
      fetchHasPin: () async => true,
      readPasscodeMirror: () async => 'true',
    );
    expect(u.hasPasscode, isTrue);
    expect(u.hasTransactionPin, isTrue);
  });

  test('GetMe unreachable and no mirror → fails toward NOT gating', () async {
    final u = await enrichSessionUser(
      _profileUser(),
      fetchMe: () async =>
          Left(ServerFailure(message: 'down', statusCode: 503)),
      fetchHasPin: () async => throw Exception('pin service down'),
      readPasscodeMirror: () async => null,
    );
    expect(u.hasPasscode, isTrue);
    expect(u.hasTransactionPin, isTrue);
  });

  test('a mirror that says false, with GetMe down, is respected', () async {
    final u = await enrichSessionUser(
      _profileUser(),
      fetchMe: () async => throw Exception('timeout'),
      fetchHasPin: () async => true,
      readPasscodeMirror: () async => 'false',
    );
    expect(u.hasPasscode, isFalse);
  });

  test('one lookup throwing does not take the others down', () async {
    final u = await enrichSessionUser(
      _profileUser(),
      fetchMe: () async => Right(_authUser()),
      fetchHasPin: () async => throw Exception('boom'),
      readPasscodeMirror: () async => throw Exception('boom'),
    );
    expect(u.hasPasscode, isTrue);
    expect(u.kycTier, 3);
    expect(u.hasTransactionPin, isTrue);
  });

  test('a slow lookup is bounded by the timeout', () async {
    final u = await enrichSessionUser(
      _profileUser(),
      timeout: const Duration(milliseconds: 20),
      fetchMe: () =>
          Future.delayed(const Duration(seconds: 5), () => Right(_authUser())),
      fetchHasPin: () async => true,
      readPasscodeMirror: () async => 'true',
    );
    expect(u.hasPasscode, isTrue);
    expect(u.kycTier, 0, reason: 'GetMe timed out; nothing was laid over');
  });

  group('cached facts first, backend in the background', () {
    LoginFacts facts() => LoginFacts.fromUser(_authUser());

    test('a record for this user is applied at once, before GetMe answers',
        () async {
      final never = Completer<Either<Failure, User>>();
      final writes = <User>[];
      final u = await enrichSessionUser(
        _profileUser(),
        fetchMe: () => never.future, // the backend has not answered
        fetchHasPin: () async => true,
        readPasscodeMirror: () async => null,
        readFacts: (_) async => facts(),
        writeFacts: (user, {hasTransactionPin}) async => writes.add(user),
      );
      expect(u.hasPasscode, isTrue);
      expect(u.kycTier, 3);
      expect(u.signupStatus, 'complete');
      expect(writes, isEmpty, reason: 'nothing live has arrived yet');
    });

    test('the background refresh replaces the record when GetMe answers',
        () async {
      final writes = <User>[];
      await enrichSessionUser(
        _profileUser(),
        fetchMe: () async => Right(_authUser().copyWith(kycTier: 2)),
        fetchHasPin: () async => false,
        readPasscodeMirror: () async => null,
        readFacts: (_) async => facts(),
        writeFacts: (user, {hasTransactionPin}) async => writes
            .add(user.copyWith(hasTransactionPin: hasTransactionPin ?? true)),
      );
      await Future<void>.delayed(const Duration(milliseconds: 20));
      expect(writes, hasLength(1));
      expect(writes.single.kycTier, 2);
      expect(writes.single.hasTransactionPin, isFalse);
    });

    test('a record for ANOTHER user is not applied (store returns null)',
        () async {
      final u = await enrichSessionUser(
        _profileUser(),
        fetchMe: () async => Right(_authUser()),
        fetchHasPin: () async => true,
        readPasscodeMirror: () async => null,
        readFacts: (_) async => null,
        writeFacts: (user, {hasTransactionPin}) async {},
      );
      expect(u.kycTier, 3, reason: 'came from the live GetMe, awaited');
    });

    test('no record → the live answer is recorded for next time', () async {
      final writes = <User>[];
      await enrichSessionUser(
        _profileUser(),
        fetchMe: () async => Right(_authUser()),
        fetchHasPin: () async => true,
        readPasscodeMirror: () async => null,
        readFacts: (_) async => null,
        writeFacts: (user, {hasTransactionPin}) async => writes.add(user),
      );
      expect(writes, hasLength(1));
    });

    test('a failed live lookup is never recorded', () async {
      final writes = <User>[];
      await enrichSessionUser(
        _profileUser(),
        fetchMe: () async =>
            Left(ServerFailure(message: 'down', statusCode: 503)),
        fetchHasPin: () async => true,
        readPasscodeMirror: () async => 'true',
        readFacts: (_) async => null,
        writeFacts: (user, {hasTransactionPin}) async => writes.add(user),
      );
      expect(writes, isEmpty);
    });

    test('refreshInBackground:false skips the backend entirely on a hit',
        () async {
      var calls = 0;
      await enrichSessionUser(
        _profileUser(),
        fetchMe: () async {
          calls++;
          return Right(_authUser());
        },
        fetchHasPin: () async => true,
        readPasscodeMirror: () async => null,
        readFacts: (_) async => facts(),
        writeFacts: (user, {hasTransactionPin}) async {},
        refreshInBackground: false,
      );
      await Future<void>.delayed(const Duration(milliseconds: 10));
      expect(calls, 0);
    });
  });
}
