import 'dart:io';

import 'package:flutter_test/flutter_test.dart';
import 'package:lazervault/src/features/airtime/presentation/widgets/airtime_prefill.dart';

/// "In repeat purchase of data and airtime it should prefill the phone number
/// and plans from the previous purchase" — and "repeat purchase seems like a
/// new screen showing".
///
/// Those are ONE bug on the airtime side. Repeat carried the phone, amount
/// and network as route arguments, and those are read in `initState`, so they
/// only land when a new widget is constructed. The sheet is most often opened
/// from the recent-transactions card ON the airtime screen, so the only way
/// to deliver a prefill was `preventDuplicates: false` — pushing a SECOND
/// airtime screen over the one already on screen.
///
/// On the data side the carrier was carried but the BUNDLE was not, so a
/// "repeat" dropped the user on the full plan list with the one thing they
/// were repeating left to find again.
void main() {
  String read(String p) {
    final f = File(p);
    expect(f.existsSync(), isTrue, reason: '$p moved — repoint this test');
    return f.readAsStringSync();
  }

  String code(String src) => src
      .split('\n')
      .where((l) => !l.trimLeft().startsWith('//') && !l.trimLeft().startsWith('///'))
      .join('\n');

  group('the prefill signal', () {
    tearDown(AirtimePrefillSignal.consume);

    test('an empty request is not an event', () {
      final before = AirtimePrefillSignal.revision.value;
      AirtimePrefillSignal.emit(const AirtimePrefillRequest());
      expect(AirtimePrefillSignal.revision.value, before,
          reason: 'emitting nothing would clear a form for no reason');
      expect(AirtimePrefillSignal.pending, isNull);
    });

    test('two identical repeats in a row are two events', () {
      // A ValueNotifier holding the request itself would swallow the second:
      // an equal value notifies nobody, so tapping Repeat twice would do
      // nothing the second time.
      const req = AirtimePrefillRequest(
          phone: '08012345678', amount: 500, networkCode: 'mtn');
      final start = AirtimePrefillSignal.revision.value;
      AirtimePrefillSignal.emit(req);
      AirtimePrefillSignal.emit(req);
      expect(AirtimePrefillSignal.revision.value, start + 2);
    });

    test('consume clears, so a later rebuild cannot re-apply a stale repeat',
        () {
      AirtimePrefillSignal.emit(
          const AirtimePrefillRequest(phone: '08012345678'));
      expect(AirtimePrefillSignal.pending, isNotNull);
      AirtimePrefillSignal.consume();
      expect(AirtimePrefillSignal.pending, isNull,
          reason: 'a stale request would overwrite what the user has since '
              'typed');
    });

    test('a request with any one field set is real', () {
      expect(const AirtimePrefillRequest(amount: 100).isEmpty, isFalse);
      expect(const AirtimePrefillRequest(networkCode: 'glo').isEmpty, isFalse);
      expect(const AirtimePrefillRequest(phone: '   ').isEmpty, isTrue);
      expect(const AirtimePrefillRequest(amount: 0).isEmpty, isTrue);
    });
  });

  test('airtime repeat no longer stacks a duplicate screen', () {
    const path =
        'lib/src/features/airtime/presentation/widgets/airtime_history_actions_sheet.dart';
    final src = code(read(path));
    expect(src.contains('preventDuplicates: false'), isFalse,
        reason: 'repeat is pushing a duplicate airtime screen again — this is '
            'the reported "new screen showing"');
    expect(src.contains('AirtimeScreen.isOpen'), isTrue,
        reason: 'nothing checks whether the screen is already open, so the '
            'prefill can only be delivered by constructing a new one');
    expect(src.contains('AirtimePrefillSignal.emit'), isTrue);
  });

  test('the quick-buy applies a live prefill and detaches its listener', () {
    const path =
        'lib/src/features/airtime/presentation/widgets/airtime_quick_buy.dart';
    final src = code(read(path));
    expect(src.contains('AirtimePrefillSignal.revision.addListener'), isTrue,
        reason: 'an already-open quick-buy no longer receives repeats');
    expect(src.contains('AirtimePrefillSignal.revision.removeListener'), isTrue,
        reason: 'a listener outliving the widget notifies a dead State');
    // The repeat path must OVERWRITE. The cold-open path fills only empty
    // fields so it cannot clobber half-typed input; a repeat is an explicit
    // request for those exact values.
    expect(src.contains('_network = null;'), isTrue,
        reason: 'the network is not cleared before applying, so a repeat '
            'cannot change the carrier — _applyArgNetwork is a no-op while '
            'one is already selected');
  });

  test('the airtime screen counts its mounts in both directions', () {
    const path = 'lib/src/features/airtime/presentation/view/airtime_screen.dart';
    final src = code(read(path));
    expect(src.contains('AirtimeScreen.mountedCount++'), isTrue);
    expect(src.contains('AirtimeScreen.mountedCount--'), isTrue,
        reason: 'a count that only rises makes isOpen permanently true, and '
            'repeat would stop opening the screen when it is genuinely closed');
  });

  test('data repeat carries the bundle, not just the carrier', () {
    final sheet = code(read(
        'lib/src/features/data_bundles/presentation/widgets/data_history_actions_sheet.dart'));
    expect(sheet.contains("'planId': p.dataPlan"), isTrue,
        reason: 'the repeated bundle is not passed, so the user lands on the '
            'full plan list with only the carrier filled in');

    final screen = code(read(
        'lib/src/features/data_bundles/presentation/view/data_plan_selection_screen.dart'));
    expect(screen.contains('_maybeAdvanceRepeat'), isTrue,
        reason: 'nothing acts on planId, so passing it changes nothing');
    expect(screen.contains('_repeatAdvanced'), isTrue,
        reason: 'the advance must fire once — the builder reruns on every '
            'filter tap and would re-navigate each time');
    // Matched against the live list so the price is today's and a withdrawn
    // bundle falls back to the list rather than quoting a plan that is gone.
    expect(screen.contains('_maybeAdvanceRepeat(state.plans)'), isTrue,
        reason: 'the match must run against the UNFILTERED list, or an active '
            'filter hides it');
  });
}
