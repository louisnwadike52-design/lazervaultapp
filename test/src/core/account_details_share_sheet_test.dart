import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:flutter_test/flutter_test.dart';
import 'package:get/get.dart';
import 'package:lazervault/core/shared_widgets/account_details_share_sheet.dart';

Future<void> _pump(
  WidgetTester tester, {
  required String accountNumber,
  String accountName = 'Acme Trading Ltd',
  String bankName = 'Wema Bank',
  String accountNameLabel = 'Business name',
}) async {
  await tester.pumpWidget(
    ScreenUtilInit(
      designSize: const Size(390, 844),
      builder: (_, __) => GetMaterialApp(
        home: Scaffold(
          body: Builder(
            builder: (context) => TextButton(
              onPressed: () => AccountDetailsShareSheet.show(
                context,
                title: 'Business account details',
                accountName: accountName,
                accountNameLabel: accountNameLabel,
                bankName: bankName,
                accountNumber: accountNumber,
              ),
              child: const Text('open'),
            ),
          ),
        ),
      ),
    ),
  );
  await tester.tap(find.text('open'));
  await tester.pumpAndSettle();
}

void main() {
  TestWidgetsFlutterBinding.ensureInitialized();

  group('account details are copyable per item', () {
    late List<MethodCall> clipboard;

    setUp(() {
      clipboard = [];
      TestDefaultBinaryMessengerBinding.instance.defaultBinaryMessenger
          .setMockMethodCallHandler(SystemChannels.platform, (call) async {
        if (call.method == 'Clipboard.setData') clipboard.add(call);
        return null;
      });
    });

    tearDown(() {
      TestDefaultBinaryMessengerBinding.instance.defaultBinaryMessenger
          .setMockMethodCallHandler(SystemChannels.platform, null);
    });

    testWidgets('shows every fact a payer needs, each with its own copy',
        (tester) async {
      await _pump(tester, accountNumber: '9836436110');

      expect(find.text('Acme Trading Ltd'), findsOneWidget);
      expect(find.text('Wema Bank'), findsOneWidget);
      expect(find.text('9836436110'), findsOneWidget);
      // The label is per type: "Account name" on a family pool would read as
      // the creator's personal name.
      expect(find.text('Business name'), findsOneWidget);

      // One copy control per fact, so a bank form that wants only the digits
      // does not force the user to edit a pasted block.
      expect(find.byIcon(Icons.copy_rounded), findsNWidgets(3));
    });

    testWidgets('copying the number yields DIGITS ONLY', (tester) async {
      // A NUBAN pasted with a space or dash is rejected by the receiving
      // bank's form, and the user cannot see which character is wrong.
      await _pump(tester, accountNumber: '983 643-6110');

      await tester.tap(find.byIcon(Icons.copy_rounded).last);
      await tester.pump();

      expect(clipboard, isNotEmpty);
      expect(clipboard.last.arguments['text'], '9836436110');

      // Let the confirmation snackbar run out, or its ticker outlives the test
      // tree and the teardown reports a disposed-with-active-Ticker failure.
      await tester.pumpAndSettle(const Duration(seconds: 3));
    });

    testWidgets('an unprovisioned account offers nothing to copy or share',
        (tester) async {
      await _pump(tester, accountNumber: '');

      // No blank row beside a real bank name — that invites someone to pay
      // into nothing.
      expect(find.textContaining('no number yet'), findsOneWidget);
      expect(find.byIcon(Icons.copy_rounded), findsNothing);

      final share = tester.widget<ElevatedButton>(find.byType(ElevatedButton));
      expect(share.onPressed, isNull,
          reason: 'Share must be disabled with nothing to share');
      final copyAll = tester.widget<OutlinedButton>(find.byType(OutlinedButton));
      expect(copyAll.onPressed, isNull);
    });

    testWidgets('copy-all produces the same message shape as personal accounts',
        (tester) async {
      await _pump(tester, accountNumber: '9836436110');

      final copyAll = find.widgetWithText(OutlinedButton, 'Copy all');
      await tester.ensureVisible(copyAll);
      await tester.pumpAndSettle();
      await tester.tap(copyAll, warnIfMissed: false);
      await tester.pump();

      final text = clipboard.last.arguments['text'] as String;
      await tester.pumpAndSettle(const Duration(seconds: 3));
      // Parity with account_preview_card's _shareMessage: whoever receives a
      // business and then a personal set must not get two different formats.
      expect(text, contains('Account name:    Acme Trading Ltd'));
      expect(text, contains('Bank:            Wema Bank'));
      expect(text, contains('Account number:  9836436110'));
      expect(text, startsWith('Hello,'));
      expect(text, endsWith('Thank you.'));
    });
  });
}
