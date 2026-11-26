import 'package:flutter/material.dart';
import 'package:flutter_test/flutter_test.dart';
import 'package:lazervault/core/services/app_update_service.dart';
import 'package:lazervault/src/features/app_update/widgets/forced_update_screen.dart';

/// A REQUIRED UPDATE MUST NOT BE DISMISSIBLE, AND MUST SAY SO.
///
/// The product has two levels and the user has to be able to feel which one
/// they are in: an OPTIONAL update is a sheet with "Not now" on it; a REQUIRED
/// update takes the whole screen, refuses to pop, and offers one action.
///
/// The gate is also the last screen some customers will see of an old build,
/// so the copy thanks them for being here — and that line is pinned, because
/// it sits outside the operator's release notes and a refactor that folded it
/// into the body would silently drop it whenever notes were set.
void main() {
  AppUpdateInfo infoWith({String notes = ''}) => AppUpdateInfo(
        type: AppUpdateType.forced,
        currentBuild: 500,
        latestBuild: 560,
        minBuild: 555,
        latestVersion: '1.2.0',
        notes: notes,
        storeUrl: 'https://play.google.com/store/apps/details?id=x',
        isIOS: false,
      );

  Future<void> pump(WidgetTester tester, AppUpdateInfo info) =>
      tester.pumpWidget(MaterialApp(
        home: ForcedUpdateScreen(info: info, onUpdate: () async {}),
      ));

  testWidgets('the gate refuses to pop', (tester) async {
    await pump(tester, infoWith());

    final popScope = tester.widget<PopScope>(find.byType(PopScope));
    expect(popScope.canPop, isFalse,
        reason: 'the OS back gesture must not return the user to a build we '
            'have decided is no longer safe to use');
  });

  testWidgets('it offers no way out but the store', (tester) async {
    await pump(tester, infoWith());

    // The button, not the body sentence that also says "Update now".
    expect(find.widgetWithText(ElevatedButton, 'Update now ⬆️'), findsOneWidget,
        reason: 'the single action is to open the store');
    for (final escape in const ['Not now', 'Later', 'Skip', 'Dismiss', 'Close']) {
      expect(find.text(escape), findsNothing,
          reason: '"$escape" belongs on the OPTIONAL update sheet, never here');
    }
  });

  testWidgets('it says the update is needed to keep using the app',
      (tester) async {
    await pump(tester, infoWith());

    expect(find.textContaining('Update required'), findsOneWidget);
    expect(find.textContaining('to continue'), findsOneWidget,
        reason: 'the user has to be told WHY they cannot go back, not just '
            'that they cannot');
  });

  testWidgets('the thank-you survives operator release notes', (tester) async {
    // The body is replaced wholesale when an operator sets notes. The
    // thank-you is a separate line precisely so it is not replaced with it.
    await pump(tester, infoWith(notes: 'Security fixes and a faster feed.'));

    expect(find.text('Security fixes and a faster feed.'), findsOneWidget);
    expect(find.textContaining('Thank you for choosing Lazervault'),
        findsOneWidget,
        reason: 'it is outside the notes on purpose');
  });

  testWidgets('the brand is written Lazervault, never LazerVault',
      (tester) async {
    await pump(tester, infoWith());

    final texts = tester
        .widgetList<Text>(find.byType(Text))
        .map((t) => t.data ?? '')
        .join(' ');
    expect(texts.contains('LazerVault'), isFalse,
        reason: 'user-visible copy uses normal capitalisation');
    expect(texts.contains('Lazervault'), isTrue);
  });

  testWidgets('no fault, no apology — it is the operator voice',
      (tester) async {
    await pump(tester, infoWith());

    final texts = tester
        .widgetList<Text>(find.byType(Text))
        .map((t) => (t.data ?? '').toLowerCase())
        .join(' ');
    for (final word in const ['sorry', 'apolog', 'unfortunately', 'error',
      'failed', 'problem']) {
      expect(texts.contains(word), isFalse,
          reason: 'an older build is not something the customer did wrong');
    }
  });
}
