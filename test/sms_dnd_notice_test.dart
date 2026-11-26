import 'package:flutter/material.dart';
import 'package:flutter_test/flutter_test.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:shared_preferences/shared_preferences.dart';
import 'package:lazervault/core/config/feature_flags.dart';
import 'package:lazervault/src/features/widgets/sms_dnd_notice.dart';

/// The DND notice tells a customer to unblock SMS on their handset. That advice
/// is only ever correct while the platform is actually SENDING SMS, so these
/// pin the gating rather than the wording.
Future<void> _pump(WidgetTester tester,
    {Duration? revealAfter, int cooldownsElapsed = 1}) async {
  await tester.pumpWidget(
    ScreenUtilInit(
      designSize: const Size(390, 844),
      builder: (_, __) => MaterialApp(
        home: Scaffold(
          body: SmsDndNotice(
            revealAfter: revealAfter,
            cooldownsElapsed: cooldownsElapsed,
          ),
        ),
      ),
    ),
  );
  await tester.pump();
}

void main() {
  TestWidgetsFlutterBinding.ensureInitialized();

  setUp(() async {
    SharedPreferences.setMockInitialValues({});
    await FeatureFlags.init();
    await FeatureFlags.debugResetForTest();
  });

  testWidgets('hidden when the operator turns SMS off — no release needed',
      (tester) async {
    await FeatureFlags.applyRemoteSnapshot({'sms_provider_active': 'false'});
    await _pump(tester);
    expect(find.byType(SmsDndNotice), findsOneWidget);
    expect(find.text('Still no code?'), findsNothing,
        reason:
            'with SMS off no SMS is attempted, so telling the customer to '
            'unblock SMS is misleading');
  });

  testWidgets('shown once SMS is active', (tester) async {
    await FeatureFlags.applyRemoteSnapshot({'sms_provider_active': 'true'});
    await _pump(tester);
    expect(find.text('Still no code?'), findsOneWidget);
  });

  testWidgets('operator can suppress just the notice, leaving SMS on',
      (tester) async {
    await FeatureFlags.applyRemoteSnapshot({
      'sms_provider_active': 'true',
      'sms_dnd_help_enabled': 'false',
    });
    await _pump(tester);
    expect(find.text('Still no code?'), findsNothing);
  });

  testWidgets('self-timed reveal stays hidden until the delay elapses',
      (tester) async {
    await FeatureFlags.applyRemoteSnapshot({'sms_provider_active': 'true'});
    await _pump(tester, revealAfter: const Duration(seconds: 60));
    expect(find.text('Still no code?'), findsNothing,
        reason: 'advice must not pre-empt a code that is still in flight');

    await tester.pump(const Duration(seconds: 61));
    expect(find.text('Still no code?'), findsOneWidget);
  });

  test('the short code and keyword are operator-tunable, not compiled in',
      () async {
    await FeatureFlags.applyRemoteSnapshot({
      'sms_dnd_help_code': '1234',
      'sms_dnd_help_keyword': 'OPEN',
    });
    expect(FeatureFlags.smsDndHelpCode, '1234');
    expect(FeatureFlags.smsDndHelpKeyword, 'OPEN');
  });

  test('falls back to the published NCC values when unset', () async {
    // 2442 is the NCC short code, shared by MTN, Airtel, Glo and 9mobile.
    // The keyword is "1" (allow banking/insurance/financial), NOT "ALLOW"
    // (deactivate DND entirely) — see the 2442 table in
    // admin-gateway/internal/handlers/sms_dnd_defaults.go.
    expect(FeatureFlags.smsDndHelpCode, '2442');
    expect(FeatureFlags.smsDndHelpKeyword, '1');
  });

  testWidgets('does not show until the operator-set number of waits', (tester) async {
    await FeatureFlags.applyRemoteSnapshot({
      'sms_provider_active': 'true',
      'sms_dnd_help_after_attempts': '3',
    });
    await _pump(tester, cooldownsElapsed: 2);
    expect(find.text('Still no code?'), findsNothing,
        reason: 'two waits is below the threshold of three');

    await _pump(tester, cooldownsElapsed: 3);
    expect(find.text('Still no code?'), findsOneWidget);
  });

  testWidgets('a threshold of 0 never shows it', (tester) async {
    await FeatureFlags.applyRemoteSnapshot({
      'sms_provider_active': 'true',
      'sms_dnd_help_after_attempts': '0',
    });
    await _pump(tester, cooldownsElapsed: 5);
    expect(find.text('Still no code?'), findsNothing);
  });

  testWidgets('every visible string comes from settings, not the binary',
      (tester) async {
    await FeatureFlags.applyRemoteSnapshot({
      'sms_provider_active': 'true',
      'sms_dnd_help_title': 'Code not arriving?',
      'sms_dnd_help_message': 'Custom body copy.',
      'sms_dnd_help_distinction': 'Set by the network.',
      'sms_dnd_help_action': 'Send {keyword} to {code}.',
      'sms_dnd_help_cta': 'Open {code}',
      'sms_dnd_help_keyword': 'OPEN',
      'sms_dnd_help_code': '1234',
    });
    await _pump(tester);
    expect(find.text('Code not arriving?'), findsOneWidget);
    expect(find.text('Custom body copy.'), findsOneWidget);
    expect(find.text('Set by the network.'), findsOneWidget);
    expect(find.text('Send OPEN to 1234.'), findsOneWidget,
        reason: 'placeholders must substitute');
    expect(find.text('Open 1234'), findsOneWidget);
    expect(find.text('Still no code?'), findsNothing,
        reason: 'no compiled default should survive an operator value');
  });

  testWidgets('clearing the carrier-vs-phone line removes it', (tester) async {
    await FeatureFlags.applyRemoteSnapshot({
      'sms_provider_active': 'true',
      'sms_dnd_help_distinction': '',
    });
    await _pump(tester);
    expect(find.text('Still no code?'), findsOneWidget,
        reason: 'the rest of the notice stays');
    expect(find.textContaining('not on your phone'), findsNothing);
  });

  testWidgets('by default it says the block is the CARRIER, not the handset',
      (tester) async {
    await FeatureFlags.applyRemoteSnapshot({'sms_provider_active': 'true'});
    await _pump(tester);
    // The sentence that stops customers hunting in device settings.
    expect(find.textContaining('not on your phone'), findsOneWidget);
  });

  testWidgets('approval retires the notice everywhere', (tester) async {
    await FeatureFlags.applyRemoteSnapshot({
      'sms_provider_active': 'true',
      'sms_otp_route_approved': 'true',
    });
    await _pump(tester);
    expect(find.text('Still no code?'), findsNothing,
        reason: 'the corporate/OTP route is DND-exempt, so the advice is wrong '
            'once our sender is approved for it');
  });

  testWidgets('defaults to NOT approved, so help still shows', (tester) async {
    await FeatureFlags.applyRemoteSnapshot({'sms_provider_active': 'true'});
    await _pump(tester);
    expect(find.text('Still no code?'), findsOneWidget,
        reason: 'failing closed here shows help nobody needed; failing open '
            'would strand a DND customer with no code and no explanation');
  });

  test('the lighter category unblock is the default, not a full DND lift', () async {
    await FeatureFlags.applyRemoteSnapshot({});
    expect(FeatureFlags.smsDndHelpKeyword, '1',
        reason: '"1" allows only financial messages; "ALLOW" would switch off '
            'all of the customer\'s spam protection');
    expect(FeatureFlags.smsDndHelpAction, contains('STATUS'),
        reason: 'customers should be able to CHECK their DND state');
  });
}
