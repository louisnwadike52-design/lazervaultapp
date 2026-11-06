import 'package:flutter_test/flutter_test.dart';
import 'package:lazervault/src/features/data_bundles/presentation/widgets/data_prefill.dart';

void main() {
  setUp(DataPrefillSignal.consume);

  test('an empty request is not emitted — nothing should listen for nothing', () {
    final before = DataPrefillSignal.revision.value;
    DataPrefillSignal.emit(const DataPrefillRequest());
    expect(DataPrefillSignal.revision.value, before);
    expect(DataPrefillSignal.pending, isNull);
  });

  test('a request with only a plan id still counts — the bundle IS the repeat',
      () {
    final before = DataPrefillSignal.revision.value;
    DataPrefillSignal.emit(const DataPrefillRequest(planId: 'mtn-social-150mb'));
    expect(DataPrefillSignal.revision.value, before + 1);
    expect(DataPrefillSignal.pending?.planId, 'mtn-social-150mb');
  });

  test('two identical repeats in a row are two events', () {
    // A ValueNotifier holding the request alone would swallow the second:
    // `==` on an identical value notifies nobody, and tapping "repeat" twice
    // would silently do nothing the second time.
    const req = DataPrefillRequest(
        phone: '07067334850', networkCode: 'mtn-data', planId: 'mtn-1gb');
    var fired = 0;
    void onBump() => fired++;
    DataPrefillSignal.revision.addListener(onBump);
    addTearDown(() => DataPrefillSignal.revision.removeListener(onBump));

    DataPrefillSignal.emit(req);
    DataPrefillSignal.emit(req);
    expect(fired, 2);
  });

  test('consume clears it, so a later rebuild cannot re-apply a stale repeat',
      () {
    DataPrefillSignal.emit(const DataPrefillRequest(phone: '07067334850'));
    expect(DataPrefillSignal.pending, isNotNull);
    DataPrefillSignal.consume();
    expect(DataPrefillSignal.pending, isNull);
  });

  test('a pending request SURVIVES until consumed, which is what lets a '
      'late-mounted quick-buy collect it', () {
    // The International-tab case: the signal is bumped with no quick-buy
    // listening, the home screen switches the tab, and the widget that mounts
    // on the next frame reads `pending`. If the tab switch consumed the
    // request, that path would silently lose it.
    DataPrefillSignal.emit(const DataPrefillRequest(planId: 'glo-2gb'));
    // several unrelated rebuilds later…
    expect(DataPrefillSignal.pending?.planId, 'glo-2gb');
  });

  test('isEmpty treats whitespace as absent', () {
    expect(
        const DataPrefillRequest(phone: '  ', networkCode: '', planId: '   ')
            .isEmpty,
        isTrue);
  });
}
