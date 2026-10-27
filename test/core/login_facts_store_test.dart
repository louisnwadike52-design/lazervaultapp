// LoginFacts are what a biometric unlock routes on BEFORE the backend answers.
// They must be this user's, not too old, and applied over the profile user
// without losing what the profile knew.
import 'dart:convert';

import 'package:flutter_secure_storage/flutter_secure_storage.dart';
import 'package:flutter_test/flutter_test.dart';
import 'package:lazervault/core/services/login_facts_store.dart';
import 'package:lazervault/src/features/authentication/domain/entities/user.dart';

User _user({String id = 'u1'}) => User(
      id: id,
      firstName: 'Ada',
      lastName: 'Obi',
      email: 'ada@example.com',
      verified: true,
      isEmailVerified: true,
      createdAt: DateTime(2026),
      updatedAt: DateTime(2026),
      hasPasscode: true,
      hasTransactionPin: true,
      kycTier: 3,
      kycStatus: 'approved',
      signupStatus: 'complete',
      phoneNumber: '+2348012345678',
    );

void main() {
  TestWidgetsFlutterBinding.ensureInitialized();

  setUp(() {
    FlutterSecureStorage.setMockInitialValues({});
    LoginFactsStore.storage = const FlutterSecureStorage();
  });

  test('record then read returns the same facts for the same user', () async {
    await LoginFactsStore.record(_user());
    final f = await LoginFactsStore.read('u1');
    expect(f, isNotNull);
    expect(f!.hasPasscode, isTrue);
    expect(f.hasTransactionPin, isTrue);
    expect(f.kycTier, 3);
    expect(f.kycStatus, 'approved');
    expect(f.signupStatus, 'complete');
    expect(f.phoneVerified, isTrue);
  });

  test('a record never speaks for another user', () async {
    await LoginFactsStore.record(_user(id: 'u1'));
    expect(await LoginFactsStore.read('u2'), isNull);
  });

  test('the PIN answer from the PIN service overrides the user field',
      () async {
    await LoginFactsStore.record(_user(), hasTransactionPin: false);
    expect((await LoginFactsStore.read('u1'))!.hasTransactionPin, isFalse);
  });

  test('applyTo lays facts over a profile user and keeps profile fields', () {
    final facts = LoginFacts.fromUser(_user());
    final profileUser = User(
      id: 'u1',
      firstName: 'Ada',
      lastName: 'Obi',
      email: 'ada@example.com',
      verified: false,
      isEmailVerified: false,
      createdAt: DateTime(2026),
      updatedAt: DateTime(2026),
      profilePicture: 'https://x/y.png',
    );
    final u = facts.applyTo(profileUser);
    expect(u.hasPasscode, isTrue);
    expect(u.hasTransactionPin, isTrue);
    expect(u.verified, isTrue);
    expect(u.isEmailVerified, isTrue);
    expect(u.kycTier, 3);
    expect(u.phoneNumber, '+2348012345678');
    expect(u.profilePicture, 'https://x/y.png');
  });

  test('too old is not trusted', () async {
    final old = LoginFacts.fromUser(_user()).toJson()
      ..['recordedAt'] =
          DateTime.now().subtract(const Duration(days: 40)).toIso8601String();
    FlutterSecureStorage.setMockInitialValues({
      LoginFactsStore.storageKey: jsonEncode(old),
    });
    expect(await LoginFactsStore.read('u1'), isNull);
  });

  test('a record from another schema version is refused', () async {
    // Every bool in a record defaults to FALSE on an absent key, and false is
    // the gating answer ("no passcode, no PIN, not verified"). So a record
    // written by a different version of this code cannot be read field by
    // field — it must be refused, and the unlock asks the backend instead.
    final other = LoginFacts.fromUser(_user()).toJson()
      ..['v'] = LoginFacts.version + 1;
    FlutterSecureStorage.setMockInitialValues({
      LoginFactsStore.storageKey: jsonEncode(other),
    });
    expect(await LoginFactsStore.read('u1'), isNull);

    // Including a record with no version at all (written before the guard).
    final unversioned = LoginFacts.fromUser(_user()).toJson()..remove('v');
    FlutterSecureStorage.setMockInitialValues({
      LoginFactsStore.storageKey: jsonEncode(unversioned),
    });
    expect(await LoginFactsStore.read('u1'), isNull);
  });

  test('authType round-trips, and applyTo keeps a social stamp', () async {
    // The passcode gate turns on this field: a provider-linked account that
    // has declined a passcode must not be sent to a no-skip passcode screen
    // on the cached unlock path.
    await LoginFactsStore.record(_user().copyWith(authType: 'SOCIAL'));
    final f = await LoginFactsStore.read('u1');
    expect(f!.authType, 'SOCIAL');
    expect(f.applyTo(User.empty).isSocialAccount, isTrue);
  });

  test('garbage in storage reads as nothing, not a crash', () async {
    FlutterSecureStorage.setMockInitialValues({
      LoginFactsStore.storageKey: '{not json',
    });
    expect(await LoginFactsStore.read('u1'), isNull);
  });

  test('clear forgets', () async {
    await LoginFactsStore.record(_user());
    await LoginFactsStore.clear();
    expect(await LoginFactsStore.read('u1'), isNull);
  });

  test('an empty user id is never recorded', () async {
    await LoginFactsStore.record(_user(id: ''));
    expect(await LoginFactsStore.read(''), isNull);
  });
}
