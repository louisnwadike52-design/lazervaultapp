import 'dart:io';

import 'package:flutter_test/flutter_test.dart';

/// FUNDS WITHOUT A COVER FLICKERED — ON BOTH THE LIST AND THE DETAILS PAGE.
///
/// Reported repeatedly, and always about items with NO image, which is the
/// clue that identifies it.
///
/// UpRemoteImage exists to survive a slow or flaky image: on failure it
/// retries three times with backoff, evicting the cache each attempt so the
/// request is actually re-made, and setState-ing to rebuild. That is right
/// for an image that might arrive.
///
/// An EMPTY url is not an image that might arrive. It still went to
/// Image.network, which fails instantly, which runs errorBuilder, which
/// schedules a retry, which evicts and setStates, which rebuilds, which fails
/// again — three delayed rounds of that per widget, restarted every time a
/// rebuild recreated it. On a page of coverless funds that is continuous
/// repainting, which is what "flickering" looked like.
///
/// There is no question to ask the network when there is no url. The fallback
/// is the answer, synchronously and permanently.
void main() {
  final src = File(
    'lib/src/features/uplift/presentation/widgets/uplift_widgets.dart',
  ).readAsStringSync();

  group('an unfetchable url never reaches the retry machinery', () {
    test('build short-circuits to the fallback', () {
      expect(src, contains('if (!_looksFetchable(widget.url)) return fallback;'));
      // Before Image.network, not after: reaching Image.network at all is the
      // defect, because failing is what starts the loop.
      final guard = src.indexOf('_looksFetchable(widget.url)');
      final network = src.indexOf('return Image.network(', guard);
      expect(guard, greaterThan(0));
      expect(network, greaterThan(guard));
    });

    test('empty, relative and malformed urls all count as unfetchable', () {
      expect(src, contains('if (url.isEmpty) return false;'));
      expect(src, contains('!uri.hasAuthority'));
      expect(src, contains("uri.scheme == 'http' || uri.scheme == 'https'"));
    });
  });

  group('the retry protections that must stay', () {
    test('one retry in flight at a time', () {
      // errorBuilder runs on EVERY build of a failing image, not once per
      // failure, so without this each rebuild queued another timer.
      expect(src, contains('bool _retryPending = false;'));
      expect(src, contains('if (_givenUp || _retryPending) return;'));
    });

    test('giving up is deferred out of the build phase', () {
      expect(src, contains('addPostFrameCallback'));
    });

    test('the timer cannot fire into a disposed State', () {
      expect(src, contains('_retryTimer?.cancel()'));
    });
  });
}
