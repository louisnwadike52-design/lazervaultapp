import 'package:flutter/material.dart';

import '../../data/datasources/chat_progress_channel.dart';

/// THE LINE THAT SAYS WHAT NOVA IS ACTUALLY DOING.
///
/// Renders the most recent backend stage — "Checking your balance", "Finding
/// that person on Lazervault", "Sending the money" — beside the typing dots.
///
/// ## It renders NOTHING until the backend has spoken
///
/// A socket that is open but silent is not evidence that the backend is
/// reporting: the channel may have connected to a gateway that has stage
/// events switched off, or the turn may be answered before any tool runs. So
/// this collapses to a zero-size box until the first frame arrives, and the
/// host's existing timed indicator is what the customer sees meanwhile. The
/// fallback is never removed — it is what shows when this has nothing true to
/// say.
///
/// ## Why the label animates in
///
/// Stages replace each other every second or two. Swapping the text in place
/// reads as a glitch; a short cross-fade reads as progress, which is what it
/// is.
class ChatStageLine extends StatelessWidget {
  const ChatStageLine({
    super.key,
    required this.channel,
    this.style,
  });

  /// Null is explicitly allowed: a host that could not build a channel (no
  /// session yet, no token) passes null and this renders nothing, rather than
  /// the host needing a conditional at the call site.
  final ChatProgressChannel? channel;

  final TextStyle? style;

  @override
  Widget build(BuildContext context) {
    final c = channel;
    if (c == null) return const SizedBox.shrink();

    return StreamBuilder<ChatProgressStage>(
      stream: c.stages,
      builder: (context, snap) {
        final label = snap.data?.label.trim() ?? '';
        if (label.isEmpty) return const SizedBox.shrink();
        return Padding(
          padding: const EdgeInsets.only(left: 10),
          child: _StageLabel(label: label, style: style),
        );
      },
    );
  }
}

/// Cross-fades between stage labels.
///
/// PRIVATE, and deliberately not called `AnimatedSwitcher`: that is the name
/// of a Flutter widget, and shadowing it in a file that may one day import
/// both is a conflict waiting to happen.
class _StageLabel extends StatelessWidget {
  const _StageLabel({required this.label, this.style});

  final String label;
  final TextStyle? style;

  @override
  Widget build(BuildContext context) {
    return AnimatedSize(
      duration: const Duration(milliseconds: 180),
      curve: Curves.easeOut,
      alignment: Alignment.centerLeft,
      child: Text(
        label,
        // KEYED ON THE LABEL so AnimatedSize treats a new line as new content
        // rather than as the same Text with different characters.
        key: ValueKey<String>(label),
        maxLines: 1,
        overflow: TextOverflow.ellipsis,
        style: style ??
            TextStyle(
              fontSize: 11.5,
              color: Colors.white.withValues(alpha: 0.65),
              fontWeight: FontWeight.w500,
            ),
      ),
    );
  }
}
