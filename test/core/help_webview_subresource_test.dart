import 'dart:io';

import 'package:flutter_test/flutter_test.dart';

/// Help Center and Contact Us showed "Couldn't load this page" on pages that
/// had loaded.
///
/// Both URLs return 200 (verified against the live host). The sheet's
/// onWebResourceError fired anyway, because on Android it is called for EVERY
/// failed resource — a webfont, an analytics beacon, a favicon — not only the
/// document. One missing subresource therefore painted a full-screen failure
/// over a page that had rendered.
void main() {
  late String sheet;

  setUpAll(() {
    sheet = File(
            'lib/src/features/settings/presentation/widgets/webview_bottom_sheet.dart')
        .readAsStringSync();
  });

  test('a subresource failure does not fail the page', () {
    expect(
      sheet.contains('error.isForMainFrame == false'),
      isTrue,
      reason: 'every failed subresource marks the whole page as broken again, '
          'so Help Center and Contact Us show an error over content that '
          'loaded fine',
    );
  });

  test('the check is a definite false, not a falsy null', () {
    // isForMainFrame is nullable: the platform does not always say. Treating an
    // UNKNOWN as a subresource would swallow real failures and leave the user
    // on a blank sheet with no explanation — worse than a false alarm.
    expect(sheet.contains('error.isForMainFrame == false'), isTrue);
    expect(
      sheet.contains('!error.isForMainFrame') ||
          sheet.contains('error.isForMainFrame != true'),
      isFalse,
      reason: 'a null (unknown) must keep the old fail-loud behaviour',
    );
  });

  test('the main-frame guard returns before touching state', () {
    final at = sheet.indexOf('error.isForMainFrame == false');
    final cancel = sheet.indexOf('_loadTimer?.cancel()', at);
    expect(at, greaterThan(-1));
    expect(cancel, greaterThan(at),
        reason: 'the guard must short-circuit BEFORE cancelling the load timer '
            'and setting the error state, or it changes nothing');
  });

  test('the watchdog timer still exists for a silently dead host', () {
    // A page that neither finishes nor errors (captive portal, dropped
    // packets) must not spin for ever. Narrowing the error path makes this
    // fallback matter more, not less.
    expect(sheet.contains('_loadTimer = Timer('), isTrue,
        reason: 'with subresource errors ignored, this is now the only thing '
            'that catches a page which never loads and never reports an error');
  });
}
