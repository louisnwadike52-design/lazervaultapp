import 'dart:io';

import 'package:flutter_test/flutter_test.dart';
import 'package:lazervault/core/pagination/next_page_prefetch.dart';

/// PAGING A LIST SHOULD NOT MEAN A SECOND SHIMMER.
///
/// Escrow Pay fetches page N+1 in the background as soon as page N is on
/// screen, so tapping "2" is instant. Tag pay and invoices paged the same way
/// and did not — every page change was a fresh round trip the user waited
/// for.
///
/// The two details that make the pattern CORRECT rather than merely faster
/// are what this pins, because both fail silently:
///
///   * a prefetch served for the wrong list shows plausible-looking rows from
///     the previous filter;
///   * a prefetch served after a mutation offers an action the customer has
///     already taken.
void main() {
  group('NextPagePrefetch', () {
    test('serves only the page it was fetched for', () async {
      final p = NextPagePrefetch<String>();
      p.warm('paid|20#2', () async => 'page2-paid');
      await Future<void>.delayed(Duration.zero);

      expect(p.take('pending|20#2'), isNull,
          reason: 'a filter change must never be served the previous '
              "filter's rows — they look plausible and are wrong");
      expect(p.take('paid|20#2'), isNull,
          reason: 'a miss consumes the hit: a stale page must not survive to '
              'be matched later');
    });

    test('serves an exact match exactly once', () async {
      final p = NextPagePrefetch<String>();
      p.warm('paid|20#2', () async => 'page2');
      await Future<void>.delayed(Duration.zero);
      expect(p.take('paid|20#2'), 'page2');
      expect(p.take('paid|20#2'), isNull, reason: 'the caller now owns it');
    });

    test('a failed prefetch is silent and holds nothing', () async {
      final p = NextPagePrefetch<String>();
      p.warm('paid|20#2', () async => throw StateError('offline'));
      await Future<void>.delayed(Duration.zero);
      expect(p.has('paid|20#2'), isFalse,
          reason: 'a prefetch that cannot run is a missed optimisation, not '
              'an error anyone should see');
    });

    test('clear drops the held page', () async {
      final p = NextPagePrefetch<String>();
      p.warm('k#2', () async => 'v');
      await Future<void>.delayed(Duration.zero);
      p.clear();
      expect(p.take('k#2'), isNull);
    });

    test('the key covers every axis that changes the rows', () {
      expect(pageKey(['paid', 20], 2), isNot(pageKey(['pending', 20], 2)));
      expect(pageKey(['paid', 20], 2), isNot(pageKey(['paid', 50], 2)));
      expect(pageKey(['paid', 20], 2), isNot(pageKey(['paid', 20], 3)));
      expect(pageKey([null, 20], 2), pageKey([null, 20], 2));
    });
  });

  group('the listings actually use it', () {
    String read(String p) => File(p).readAsStringSync();

    test('tag pay prefetches both tabs, separately', () {
      final src = read(
          'lib/src/features/tag_pay/presentation/cubit/tag_pay_cubit.dart');
      expect(src, contains('_incomingAhead'));
      expect(src, contains('_outgoingAhead'));
      // Two slots, not one: Received and Created are tabs the user moves
      // between, and a single slot would have each evict the other's page.
      expect(src, contains('_incomingAhead.warm('));
      expect(src, contains('_outgoingAhead.warm('));
      expect(src, contains('_incomingAhead.take('));
      expect(src, contains('_outgoingAhead.take('));
    });

    test('invoices prefetch on both the sent and received lists', () {
      expect(
          read(
              'lib/src/features/invoice/presentation/cubit/invoice_cubit.dart'),
          contains('_ahead.warm('));
      expect(
          read('lib/src/features/invoice/presentation/cubit/'
              'tagged_invoice_cubit.dart'),
          contains('_incomingAhead.warm('));
    });

    test('tag pay remembers page one across opens', () {
      // A factory cubit starts from Initial on every open, so the screen
      // blanked a list the user was looking at seconds earlier and asked the
      // network for the same rows. Escrow Pay already did this; tag pay did
      // not.
      final src =
          File('lib/src/features/tag_pay/presentation/cubit/tag_pay_cubit.dart')
              .readAsStringSync();
      expect(src, contains('incomingTagsPageStore.peek('));
      expect(src, contains('outgoingTagsPageStore.peek('));
      expect(src, contains('incomingTagsPageStore.put('));
      expect(src, contains('outgoingTagsPageStore.put('));
      // Scoped by the SAME filter the prefetch keys on, or a page stored
      // under "pending" paints when the user reopens on "all".
      expect(src, contains('scope: tagsScope(effective)'));
    });

    test('every mutation drops what was fetched ahead', () {
      // The specific way a prefetch becomes WORSE than none: a page read
      // before the tag was paid, served after.
      final tag = read(
          'lib/src/features/tag_pay/presentation/cubit/tag_pay_cubit.dart');
      expect(RegExp(r'_invalidateTagPages\(\);').allMatches(tag).length,
          greaterThanOrEqualTo(6),
          reason: 'createTag, payTag, cancelTag, declineTag and both money '
              'request actions all change what the next page holds');

      for (final f in const [
        'lib/src/features/invoice/presentation/cubit/invoice_cubit.dart',
        'lib/src/features/invoice/presentation/cubit/tagged_invoice_cubit.dart',
      ]) {
        expect(read(f), contains('invalidatePrefetch();'), reason: f);
      }

      // The remembered page goes with it: painting it after a tag is paid
      // shows the row still pending, offering the button just pressed.
      expect(tag, contains('incomingTagsPageStore.clear();'));
      expect(tag, contains('outgoingTagsPageStore.clear();'));
    });

    test('the prefetch is fired after the emit, never before', () {
      // A prefetch that delays the page the user asked for has inverted its
      // own purpose.
      for (final f in const [
        'lib/src/features/invoice/presentation/cubit/invoice_cubit.dart',
        'lib/src/features/invoice/presentation/cubit/'
            'tagged_invoice_cubit.dart',
      ]) {
        final src = read(f);
        final warmAt = src.indexOf('Ahead.warm(') >= 0
            ? src.indexOf('Ahead.warm(')
            : src.indexOf('_ahead.warm(');
        final emitAt = src.lastIndexOf('Loaded(', warmAt);
        expect(emitAt, greaterThan(0), reason: f);
        expect(emitAt, lessThan(warmAt), reason: '$f warms before it emits');
      }
    });
  });
}
