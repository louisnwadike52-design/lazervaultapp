import 'dart:io';

import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:flutter_test/flutter_test.dart';
import 'package:lazervault/src/features/support/presentation/support_sla_notice.dart';

/// The reply-time notice, and the rule that its words never live in the app.
///
/// "24–48 hours" is a promise the support team has to keep. Hardcoding it in
/// a Flutter widget puts that promise behind an app-store review: the team
/// could not widen it over a holiday, or narrow it when they staffed up,
/// without shipping a release. So the copy is served by support-service from
/// the same row the admin console writes, and these tests pin both halves —
/// that the widget renders what it is given, and that it never carries words
/// of its own.
Widget _host(Widget child) => ScreenUtilInit(
      designSize: const Size(390, 844),
      builder: (_, __) => MaterialApp(home: Scaffold(body: child)),
    );

void main() {
  group('SupportSlaNotice', () {
    testWidgets('renders the server-supplied copy verbatim', (tester) async {
      const copy = 'We reply within 24–48 hours.';
      await tester.pumpWidget(_host(const SupportSlaNotice(text: copy)));
      await tester.pumpAndSettle();
      expect(find.text(copy), findsOneWidget);
    });

    testWidgets('renders nothing at all when the copy is missing',
        (tester) async {
      // Null is the normal state while the fetch is in flight, and the
      // permanent state if it fails. A banner that appears a beat late reads
      // as an error that just appeared, and one that renders empty leaves a
      // bordered box saying nothing.
      await tester.pumpWidget(_host(const SupportSlaNotice(text: null)));
      await tester.pumpAndSettle();
      expect(find.byType(Container), findsNothing);
    });

    testWidgets('treats whitespace-only copy as missing', (tester) async {
      await tester.pumpWidget(_host(const SupportSlaNotice(text: '   ')));
      await tester.pumpAndSettle();
      expect(find.byType(Container), findsNothing);
    });

    testWidgets('long copy wraps instead of overflowing', (tester) async {
      // The admin console caps this at 240 characters; the widget must cope
      // with the whole budget on the narrowest phone we support.
      final long = 'A' * 240;
      await tester.pumpWidget(_host(SupportSlaNotice(text: long)));
      await tester.pumpAndSettle();
      expect(tester.takeException(), isNull);
      expect(find.text(long), findsOneWidget);
    });
  });

  test('no support surface hardcodes a reply-time promise', () {
    // The failure this guards is subtle: someone adds "within 24-48 hours"
    // to a screen as a quick fix, the admin console later changes the real
    // promise, and the app keeps showing the old one — with no way to tell
    // which the customer saw.
    final offenders = <String>[];
    final dir = Directory('lib/src/features/support');
    for (final f in dir.listSync(recursive: true).whereType<File>()) {
      if (!f.path.endsWith('.dart')) continue;
      final body = f.readAsStringSync();
      // Strip comments: this file's siblings explain the rule in prose.
      final code = body
          .split('\n')
          .where((l) => !l.trimLeft().startsWith('//'))
          .join('\n');
      if (RegExp(r'24\s*[-–]\s*48').hasMatch(code)) {
        offenders.add(f.path);
      }
    }
    expect(
      offenders,
      isEmpty,
      reason: 'these files state a reply window in app code: $offenders. '
          'The promise is operator-tunable (support_settings key '
          'support_response_sla_text) precisely so it is not shipped in a '
          'build — read it from SupportApi.responseSlaText() instead.',
    );
  });
}
