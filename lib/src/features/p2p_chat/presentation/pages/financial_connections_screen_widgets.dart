part of 'financial_connections_screen.dart';

/// Chat-list organisation filter. Keeps the money-heavy connections list clean:
/// Chats = active conversations, Unread = active with unread messages, Archived
/// = the user's archived chats. (Per-user "deleted" chats are hidden entirely.)
enum _ChatFilter { chats, unread, archived, birthdays }

/// Compact animated "typing…" indicator for a connections-list row — three
/// pulsing dots plus a label, styled to read as a live signal (mirrors the
/// in-chat typing bubble, condensed for a list subtitle). Shown for a peer who
/// is currently typing, in place of that row's last-message preview.
class _ConnectionTypingIndicator extends StatefulWidget {
  const _ConnectionTypingIndicator();

  @override
  State<_ConnectionTypingIndicator> createState() =>
      _ConnectionTypingIndicatorState();
}

class _ConnectionTypingIndicatorState extends State<_ConnectionTypingIndicator>
    with SingleTickerProviderStateMixin {
  late final AnimationController _c = AnimationController(
    vsync: this,
    duration: const Duration(milliseconds: 1000),
  )..repeat();

  @override
  void dispose() {
    _c.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    const accent = Color(0xFF10B981); // green — "live" signal
    return Row(
      mainAxisSize: MainAxisSize.min,
      children: [
        SizedBox(
          width: 22.w,
          height: 10.h,
          child: AnimatedBuilder(
            animation: _c,
            builder: (context, _) {
              return Row(
                mainAxisSize: MainAxisSize.min,
                children: List.generate(3, (i) {
                  // Each dot pulses on a staggered phase.
                  final phase = (_c.value + i * 0.33) % 1.0;
                  final opacity = 0.3 + 0.7 * (1 - (phase - 0.5).abs() * 2);
                  return Padding(
                    padding: EdgeInsets.only(right: 3.w),
                    child: Opacity(
                      opacity: opacity.clamp(0.3, 1.0),
                      child: Container(
                        width: 5.w,
                        height: 5.w,
                        decoration: const BoxDecoration(
                          color: accent,
                          shape: BoxShape.circle,
                        ),
                      ),
                    ),
                  );
                }),
              );
            },
          ),
        ),
        SizedBox(width: 4.w),
        Text(
          'typing…',
          style: GoogleFonts.inter(
            color: accent,
            fontSize: 13.sp,
            fontWeight: FontWeight.w600,
            fontStyle: FontStyle.italic,
          ),
        ),
      ],
    );
  }
}
