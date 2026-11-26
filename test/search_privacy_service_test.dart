import 'package:flutter_test/flutter_test.dart';
import 'package:shared_preferences/shared_preferences.dart';
import 'package:lazervault/core/services/search_privacy_service.dart';

/// The cached value exists only so the Settings switch paints its real
/// position on the first frame. These pin the direction it fails in, which is
/// the part that carries a privacy claim.
void main() {
  TestWidgetsFlutterBinding.ensureInitialized();

  test('an unset cache reads as DISCOVERABLE, not hidden', () async {
    SharedPreferences.setMockInitialValues({});
    final prefs = await SharedPreferences.getInstance();
    expect(SearchPrivacyService.cachedHidden(prefs), isFalse,
        reason: 'showing "you are hidden" when the app does not know would be '
            'a privacy claim it cannot keep; the opposite is a stale label the '
            'next fetch corrects');
  });

  test('a cached hidden position is painted back', () async {
    SharedPreferences.setMockInitialValues({'search_privacy_hidden': true});
    final prefs = await SharedPreferences.getInstance();
    expect(SearchPrivacyService.cachedHidden(prefs), isTrue);
  });

  test('sign-out clears it so a shared device does not leak the setting',
      () async {
    SharedPreferences.setMockInitialValues({'search_privacy_hidden': true});
    await SearchPrivacyService.clearCache();
    final prefs = await SharedPreferences.getInstance();
    expect(SearchPrivacyService.cachedHidden(prefs), isFalse,
        reason: 'the next holder on this device must not see the previous '
            "holder's privacy position");
  });
}
