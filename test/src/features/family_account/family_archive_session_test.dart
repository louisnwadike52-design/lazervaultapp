import 'package:flutter_test/flutter_test.dart';
import 'package:lazervault/src/features/family_account/presentation/utils/family_archive_session.dart';

/// Closed Family & Friends accounts are shown for THIS SESSION only.
///
/// A creator who closes an account still needs to look back at how the money
/// moved, so the dashboard can show closed accounts on request. But the cap is
/// expressed in active accounts, and the dashboard a creator opens each day
/// should be the accounts they actually have — so the view mode must not
/// survive a logout, and must never be persisted.
void main() {
  setUp(() => FamilyArchiveSession.instance.clear());

  test('a fresh session shows only active accounts', () {
    expect(FamilyArchiveSession.instance.isShowing, isFalse);
  });

  test('showing and hiding is symmetric', () {
    final s = FamilyArchiveSession.instance;
    s.show();
    expect(s.isShowing, isTrue);
    s.hide();
    expect(s.isShowing, isFalse);
  });

  test('the CTA is repeatable, not one-shot', () {
    // The ask was explicitly "not a one-time CTA": a creator can come back to
    // closed accounts as often as they like within the session.
    final s = FamilyArchiveSession.instance;
    for (var i = 0; i < 3; i++) {
      s.toggle();
      expect(s.isShowing, isTrue);
      s.toggle();
      expect(s.isShowing, isFalse);
    }
  });

  test('logout puts the dashboard back to active accounts only', () {
    final s = FamilyArchiveSession.instance;
    s.show();
    s.clear(); // what the auth cubit's session teardown calls
    expect(s.isShowing, isFalse,
        reason: 'the next login — or the next person on a shared device — '
            'must not find closed accounts waiting on the dashboard');
  });

  test('listeners are notified so the carousel and CTA repaint together', () {
    final s = FamilyArchiveSession.instance;
    var fired = 0;
    void listener() => fired++;
    s.showClosed.addListener(listener);
    addTearDown(() => s.showClosed.removeListener(listener));

    s.show();
    expect(fired, 1);
    s.hide();
    expect(fired, 2);
    s.hide();
    expect(fired, 2, reason: 'no spurious repaint when nothing changed');
  });
}
