/// One page of a conversation, plus what the client needs to ask for the next.
///
/// Every chat surface in the app reads history the same way — "newest page
/// first, then walk backwards as the user scrolls up" — and each one used to
/// get back a bare `List` and reconstruct the paging state from its length.
/// That is where the bugs were: a short page could mean "the conversation ends
/// here" or "the server trimmed it", and nothing could tell the two apart.
///
/// [nextBefore] replaces offset arithmetic. OFFSET pagination on a live
/// conversation is wrong twice over: it walks and discards rows to reach the
/// page, so scrolling far up gets slower on the exact gesture that fires in
/// bursts; and the window SHIFTS, so a message arriving while the user is
/// scrolled up makes the next page start one row late and silently drops a
/// message out of the middle of their history. The general chatbot worked
/// around the second half by refusing to paginate during its own send — which
/// does nothing about a message arriving from another device, or the
/// assistant's reply landing between two page reads.
class ChatHistoryPage<T> {
  /// Chronological ASC (oldest→newest) — the order a thread renders. The
  /// NEWEST page arrives first; older pages are prepended.
  final List<T> messages;

  /// Count of the whole thread, not of this page.
  final int totalCount;

  /// Pass back as `before` to fetch the next OLDER page. Empty when this page
  /// reached the start of the conversation.
  final String nextBefore;

  /// Whether an older page exists.
  ///
  /// A scroll-up loop must stop on false rather than keep asking — and the
  /// server answers false on its own errors for exactly that reason, so a
  /// failing query is not retried on every scroll event.
  final bool hasMore;

  const ChatHistoryPage({
    required this.messages,
    this.totalCount = 0,
    this.nextBefore = '',
    this.hasMore = false,
  });

  /// A page from a surface that does not paginate yet. [hasMore] is false, so
  /// a caller wired for pagination simply never asks for a second page rather
  /// than looping against an endpoint that would keep returning the same one.
  const ChatHistoryPage.single(this.messages)
      : totalCount = 0,
        nextBefore = '',
        hasMore = false;

  /// Whether it is worth asking for another page. Both conditions are
  /// required: a server that reports `has_more` but no cursor would otherwise
  /// drive an infinite loop re-fetching the newest page.
  bool get canLoadOlder => hasMore && nextBefore.isNotEmpty;

  ChatHistoryPage<T> copyWith({
    List<T>? messages,
    int? totalCount,
    String? nextBefore,
    bool? hasMore,
  }) =>
      ChatHistoryPage<T>(
        messages: messages ?? this.messages,
        totalCount: totalCount ?? this.totalCount,
        nextBefore: nextBefore ?? this.nextBefore,
        hasMore: hasMore ?? this.hasMore,
      );
}
