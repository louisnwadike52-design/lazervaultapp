import 'package:flutter_test/flutter_test.dart';
import 'package:lazervault/src/features/group_account/data/services/group_funds_terms_prefs.dart';
import 'package:shared_preferences/shared_preferences.dart';

/// The terms open ONCE on the landing page, then stay shut until the user
/// asks for them again from Settings.
///
/// Scoped per user on purpose: the dismissal is a statement by the person who
/// read it, not by the handset. Two people sharing a device each get their own
/// first read.
void main() {
  setUp(() async {
    SharedPreferences.setMockInitialValues({});
  });

  test('shown on a first visit', () async {
    expect(await GroupFundsTermsPrefs.shouldShow('user-1'), isTrue);
  });

  test('stays shut once dismissed', () async {
    await GroupFundsTermsPrefs.dismiss('user-1');
    expect(await GroupFundsTermsPrefs.shouldShow('user-1'), isFalse);
  });

  test('Settings brings it back', () async {
    await GroupFundsTermsPrefs.dismiss('user-1');
    await GroupFundsTermsPrefs.reset('user-1');
    expect(await GroupFundsTermsPrefs.shouldShow('user-1'), isTrue);
  });

  test("one user's dismissal is not another's", () async {
    await GroupFundsTermsPrefs.dismiss('user-1');
    expect(await GroupFundsTermsPrefs.shouldShow('user-2'), isTrue,
        reason: 'the second person has never read them');
    expect(await GroupFundsTermsPrefs.shouldShow('user-1'), isFalse);
  });

  test('a signed-out reader is tracked separately, not as everyone', () async {
    await GroupFundsTermsPrefs.dismiss('');
    expect(await GroupFundsTermsPrefs.shouldShow(''), isFalse);
    expect(await GroupFundsTermsPrefs.shouldShow('user-1'), isTrue);
  });

  test('dismissing twice is harmless', () async {
    await GroupFundsTermsPrefs.dismiss('user-1');
    await GroupFundsTermsPrefs.dismiss('user-1');
    expect(await GroupFundsTermsPrefs.shouldShow('user-1'), isFalse);
  });
}
