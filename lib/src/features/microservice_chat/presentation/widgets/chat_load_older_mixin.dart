import 'package:flutter/material.dart';

/// "Scroll to the top to load more" for a chat transcript.
///
/// One implementation, mixed into all three per-service chat surfaces (the
/// service bottom sheet, the full-page service chat, the general chat page),
/// because the awkward part is not the fetch — it is keeping the viewport
/// anchored afterwards, and three hand-written copies of that would drift the
/// way the three history mappers in this feature already did once.
///
/// ## The part that is easy to get wrong
///
/// Prepending messages grows the scroll extent, so without re-anchoring the
/// list jumps and the user loses their place. Advancing `pixels` by the growth
/// keeps the same message under the viewport — but chat content (images,
/// receipt cards) finishes laying out AFTER the first post-frame and grows the
/// list again, so a single jump drifts. The jump is re-applied at a few
/// staggered delays, and the re-entrancy guard is held for the whole window:
/// an intermediate jump can land the viewport back near the top, which would
/// otherwise re-trigger the fetch immediately.
mixin ChatLoadOlderOnScrollTop<T extends StatefulWidget> on State<T> {
  /// The controller driving the transcript list.
  ScrollController get chatScrollController;

  /// Whether another older page is worth asking for. Wire this to the cubit's
  /// `hasMoreHistory && !isLoadingOlder`.
  bool get canLoadOlderChat;

  /// Fetch and prepend the next older page. Wire to the cubit.
  Future<void> loadOlderChat();

  /// Distance from the top, in pixels, that arms the fetch. Not zero: the
  /// gesture should load the next page while the user is still scrolling, not
  /// after they hit the end and stop.
  double get loadOlderThreshold => 120;

  bool _prependingOlder = false;

  /// True while a page is being prepended and the viewport re-anchored. Drive
  /// a top-of-list spinner from this.
  bool get isPrependingOlderChat => _prependingOlder;

  /// Call from the list's scroll listener.
  void maybeLoadOlderChat() {
    if (_prependingOlder) return;
    if (!chatScrollController.hasClients) return;
    if (chatScrollController.position.pixels > loadOlderThreshold) return;
    loadOlderChatAndReanchor();
  }

  Future<void> loadOlderChatAndReanchor() async {
    if (_prependingOlder) return;
    if (!canLoadOlderChat) return;
    if (!chatScrollController.hasClients) return;

    _prependingOlder = true;
    if (mounted) setState(() {});
    final beforeExtent = chatScrollController.position.maxScrollExtent;
    final beforePixels = chatScrollController.position.pixels;

    await loadOlderChat();

    if (!mounted) {
      _prependingOlder = false;
      return;
    }

    void reAnchor() {
      if (!mounted || !chatScrollController.hasClients) return;
      final delta =
          chatScrollController.position.maxScrollExtent - beforeExtent;
      if (delta > 0) {
        chatScrollController.jumpTo(beforePixels + delta);
      }
    }

    for (final ms in const [0, 120, 300]) {
      Future.delayed(Duration(milliseconds: ms), reAnchor);
    }
    // Release the guard only after the last re-anchor settles, or an
    // intermediate jump that lands near the top re-fires the fetch.
    Future.delayed(const Duration(milliseconds: 320), () {
      if (!mounted) {
        _prependingOlder = false;
        return;
      }
      setState(() => _prependingOlder = false);
    });
  }
}


/// The top-of-list "loading older messages" strip.
///
/// A header ROW inside the list rather than a bar above it: it has to scroll
/// with the transcript, and anything laid out outside the list would change
/// the list's height when it appears and fight the viewport re-anchoring the
/// mixin does.
///
/// Deliberately has no "start of conversation" state. The honest version of
/// that label needs to know a page actually came back empty, and the flag
/// available here ([canLoadOlderChat]) is also false before the FIRST page
/// lands — so the label would appear on every freshly-opened thread and claim
/// the user had reached the beginning of a conversation nobody had read yet.
class ChatLoadOlderHeader extends StatelessWidget {
  final bool visible;

  const ChatLoadOlderHeader({super.key, required this.visible});

  @override
  Widget build(BuildContext context) {
    // Zero-height when idle, so the item count is stable and a prepend does
    // not also insert or remove a row mid-animation.
    if (!visible) return const SizedBox.shrink();
    return const Padding(
      padding: EdgeInsets.only(bottom: 12),
      child: Center(
        child: SizedBox(
          width: 18,
          height: 18,
          child: CircularProgressIndicator(strokeWidth: 2),
        ),
      ),
    );
  }
}
