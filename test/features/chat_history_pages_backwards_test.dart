import 'dart:io';

import 'package:flutter_test/flutter_test.dart';
import 'package:lazervault/core/chat/chat_history_page.dart';

/// The per-service chat had NO pagination.
///
/// All three datasources hardcoded `limit: 50, offset: 0`, so a conversation
/// longer than 50 messages showed one page and the rest was unreachable from
/// the screen. And the Go gateway serving that path ordered its page
/// `created_at ASC`, so the one page you got was the OLDEST fifty — open a
/// long service chat and you were reading the start of the conversation with
/// the recent turns nowhere to be found.
///
/// The general chatbot DID paginate, by offset, and its own comments record
/// the problem that forced: "the optimistic user bubble makes the newest-end
/// count run ahead of the server, so the computed offset would drift". It
/// fixed that by refusing to paginate during its own send — which does nothing
/// about a message arriving from another device, or the assistant's reply
/// landing between two page reads. A cursor names a position in the
/// conversation, so nothing arriving at the newest end can move it.
void main() {
  String code(String p) => File(p)
      .readAsStringSync()
      .split('\n')
      .where((l) =>
          !l.trimLeft().startsWith('//') && !l.trimLeft().startsWith('///'))
      .join('\n');

  group('a page only invites another when it can actually serve one', () {
    test('both a flag AND a cursor are required', () {
      const noCursor = ChatHistoryPage<String>(
        messages: ['a'],
        hasMore: true,
        nextBefore: '',
      );
      expect(noCursor.canLoadOlder, isFalse,
          reason: 'hasMore with no cursor would drive an infinite loop '
              're-fetching the newest page');

      const both = ChatHistoryPage<String>(
        messages: ['a'],
        hasMore: true,
        nextBefore: '2026-10-15T09:30:00Z|12',
      );
      expect(both.canLoadOlder, isTrue);

      const done = ChatHistoryPage<String>(
        messages: ['a'],
        hasMore: false,
        nextBefore: '2026-10-15T09:30:00Z|12',
      );
      expect(done.canLoadOlder, isFalse);
    });

    test('a single page never invites a second', () {
      const p = ChatHistoryPage<String>.single(['a', 'b']);
      expect(p.hasMore, isFalse);
      expect(p.canLoadOlder, isFalse,
          reason: 'the gRPC history carries no cursor, so a paginating caller '
              'must stop rather than loop against an endpoint that would '
              'keep returning the same page');
      expect(p.nextBefore, isEmpty);
    });
  });

  group('the per-service datasources page', () {
    const dsDir = 'lib/src/features/microservice_chat/data/datasources/';

    test('none of them hardcodes limit 50 / offset 0 any more', () {
      for (final f in [
        'http_microservice_chat_datasource.dart',
        'http_direct_chat_datasource.dart',
        'grpc_direct_chat_datasource.dart',
      ]) {
        final s = code('$dsDir$f');
        expect(s, isNot(contains("'limit': 50")), reason: '$f pins the page size');
        expect(s, isNot(contains('limit: 50')), reason: '$f pins the page size');
        expect(s, contains('before'),
            reason: '$f cannot ask for an older page');
      }
    });

    test('a cursor and an offset are never sent together', () {
      // The server ignores offset beside a cursor, but sending the pair
      // invites a future build to apply them together — which skips a whole
      // page past the cursor and deletes it from the middle of the history.
      for (final f in [
        'http_microservice_chat_datasource.dart',
        'http_direct_chat_datasource.dart',
      ]) {
        final s = code('$dsDir$f');
        expect(s, contains("queryParams['before'] = before;"));
        expect(s, contains('} else {'),
            reason: '$f must send the offset only when there is no cursor');
      }
      final g = code('${dsDir}grpc_direct_chat_datasource.dart');
      expect(g, contains('before: before'));
      expect(g, isNot(contains('offset: 0')),
          reason: 'the gRPC request must not pin an offset beside a cursor');
    });
  });

  group('the cubits walk backwards with a cursor, not an offset', () {
    const cubits = [
      'lib/src/features/ai_chats/cubit/ai_chat_cubit.dart',
      'lib/src/features/microservice_chat/cubit/microservice_chat_cubit.dart',
      'lib/src/features/microservice_chat/cubit/general_chat_cubit.dart',
    ];

    test('each one has a load-older path driven by nextBefore', () {
      for (final p in cubits) {
        final s = code(p);
        expect(s, contains('loadOlderHistory'), reason: '$p cannot page back');
        expect(s, contains('_nextBefore'), reason: '$p has no cursor');
        expect(s, contains('page.canLoadOlder'),
            reason: '$p infers "is there more" instead of reading the '
                'server\'s answer');
      }
    });

    test('no cubit computes an offset from the loaded message count', () {
      // `offset: _currentMessages.length` is the shifting-window bug: a
      // message arriving while the user is scrolled up moves every row one
      // position, so the next page starts one row late.
      for (final p in cubits) {
        final s = code(p);
        expect(s, isNot(contains('offset: _currentMessages.length')),
            reason: '$p still pages by offset');
        expect(s, isNot(contains('final offset = _currentMessages.length')),
            reason: '$p still pages by offset');
      }
    });

    test('asking with no cursor is refused rather than re-fetching page one',
        () {
      for (final p in cubits) {
        final s = code(p);
        expect(s, contains('if (_nextBefore.isEmpty) {'),
            reason: '$p would re-fetch the NEWEST page and prepend a '
                'duplicate of what is already on screen');
      }
    });

    test('a page that lands after the cursor moved is dropped', () {
      // Two load-olders slipping past the guard, or a reload between request
      // and response, would otherwise prepend the same page twice.
      for (final p in cubits) {
        final s = code(p);
        expect(s, contains('cursorAtStart'),
            reason: '$p does not capture the cursor it fetched against');
        expect(s, contains('!= cursorAtStart'),
            reason: '$p prepends a page fetched against a stale cursor');
      }
    });

    test('clearing the messages clears the cursor', () {
      // A cursor outlives the messages it came from. Left behind, the first
      // scroll-up in the NEW thread prepends a page of the old one.
      final ai = code('lib/src/features/ai_chats/cubit/ai_chat_cubit.dart');
      final clearAt = ai.indexOf('_currentMessages = [];\n    _sessionId = null;');
      expect(clearAt, greaterThan(-1));
      expect(ai.substring(clearAt, clearAt + 400), contains("_nextBefore = ''"));

      for (final p in [
        'lib/src/features/microservice_chat/cubit/microservice_chat_cubit.dart',
        'lib/src/features/microservice_chat/cubit/general_chat_cubit.dart',
      ]) {
        expect(code(p), contains('_resetPaging()'),
            reason: '$p empties its message list without forgetting where it '
                'was in the history');
      }
    });
  });

  group('the scroll-up trigger', () {
    const mixin =
        'lib/src/features/microservice_chat/presentation/widgets/chat_load_older_mixin.dart';

    test('the viewport is re-anchored, repeatedly', () {
      // Prepending grows the scroll extent, so without re-anchoring the list
      // jumps and the user loses their place. Chat content (images, receipt
      // cards) finishes laying out AFTER the first post-frame and grows the
      // list again, so a single jump drifts.
      final s = code(mixin);
      expect(s, contains('jumpTo(beforePixels + delta)'));
      expect(s, contains('for (final ms in const [0, 120, 300])'),
          reason: 'one jump is not enough — late media layout moves it again');
    });

    test('the guard outlives the last re-anchor', () {
      // An intermediate jump can land the viewport back near the top, which
      // would re-trigger the fetch immediately.
      final s = code(mixin);
      final release = s.indexOf('Duration(milliseconds: 320)');
      expect(release, greaterThan(-1),
          reason: 'the guard must be held past the last re-anchor (300ms)');
    });

    test('all three per-service surfaces use it', () {
      const dir =
          'lib/src/features/microservice_chat/presentation/widgets/';
      for (final f in [
        'microservice_chat_content.dart',
        'general_chat_content.dart',
        'service_chat_bottom_sheet.dart',
      ]) {
        final s = code('$dir$f');
        expect(s, contains('ChatLoadOlderOnScrollTop'), reason: '$f');
        expect(s, contains('_scrollController.addListener(maybeLoadOlderChat)'),
            reason: '$f never arms the trigger');
        expect(s, contains('_scrollController.removeListener(maybeLoadOlderChat)'),
            reason: '$f leaks the listener past dispose');
        expect(s, contains('ChatLoadOlderHeader'),
            reason: '$f shows no loading state while a page is in flight');
      }
    });

    test('the header shifts every row by one, and the builders account for it',
        () {
      // The header sits at index 0, so `messages[index]` would be off by one
      // for every bubble and the last message would throw.
      const dir = 'lib/src/features/microservice_chat/presentation/widgets/';
      for (final f in [
        'microservice_chat_content.dart',
        'general_chat_content.dart',
        'service_chat_bottom_sheet.dart',
      ]) {
        final s = code('$dir$f');
        expect(s, contains('final i = index - 1;'), reason: '$f');
        expect(s, contains('messages[i]'), reason: '$f');
        final builderAt = s.indexOf('itemBuilder: (context, index)');
        final builder = s.substring(
            builderAt, (builderAt + 900).clamp(0, s.length));
        expect(builder, isNot(contains('messages[index]')),
            reason: '$f indexes past the end once the header is in the list');
      }
    });
  });
}
