import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:intl/intl.dart';

import 'package:lazervault/src/features/support/data/support_models.dart';

/// WHEN each support message was sent, on both sides of the desk.
///
/// WHY THIS IS SHARED. There are two support threads in the app — the
/// customer's [SupportChatScreen] and the agent's desk thread — plus the same
/// conversation again in the admin dashboard. A ticket is a record that gets
/// quoted back in disputes and chargebacks, so "when was this said" has to be
/// answered identically wherever it is read. Three private copies of a date
/// rule is how the app comes to say Yesterday while the dashboard says the
/// date, for the same message.
///
/// Both surfaces carried `createdAt` on [SupportMessage] already and neither
/// rendered it, so a thread read as a flat wall with no sense of whether a
/// reply took two minutes or two days.
///
/// The shape follows the P2P chat, which users already know from financial
/// connections: a centred day divider between days, and a small time under
/// each bubble.
class SupportMessageTime {
  const SupportMessageTime._();

  static bool sameDay(DateTime a, DateTime b) =>
      a.year == b.year && a.month == b.month && a.day == b.day;

  /// 'Today' | 'Yesterday' | 'MMMM d, yyyy' — matching p2p_chat_page.
  static String dayLabel(DateTime date) {
    final now = DateTime.now();
    if (sameDay(date, now)) return 'Today';
    if (sameDay(date, now.subtract(const Duration(days: 1)))) {
      return 'Yesterday';
    }
    return DateFormat('MMMM d, yyyy').format(date);
  }

  /// The per-message clock time. 24h, like the P2P bubbles.
  static String clock(DateTime date) => DateFormat('HH:mm').format(date);

  /// Whether a divider belongs ABOVE [index].
  ///
  /// True for the first message that has a date, and whenever the day changes.
  /// A message with no `createdAt` never introduces a day — an undated row
  /// must not invent a divider, and must not suppress the next real one.
  static bool needsDivider(List<SupportMessage> messages, int index) {
    if (index < 0 || index >= messages.length) return false;
    final at = messages[index].createdAt;
    if (at == null) return false;
    for (var i = index - 1; i >= 0; i--) {
      final prev = messages[i].createdAt;
      if (prev != null) return !sameDay(prev, at);
    }
    return true;
  }
}

/// The centred day divider.
class SupportDayDivider extends StatelessWidget {
  const SupportDayDivider({
    super.key,
    required this.date,
    required this.background,
    required this.textColor,
  });

  final DateTime date;
  final Color background;
  final Color textColor;

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: EdgeInsets.symmetric(vertical: 10.h),
      child: Center(
        child: Container(
          padding: EdgeInsets.symmetric(horizontal: 12.w, vertical: 4.h),
          decoration: BoxDecoration(
            color: background,
            borderRadius: BorderRadius.circular(12.r),
          ),
          child: Text(
            SupportMessageTime.dayLabel(date),
            style: TextStyle(color: textColor, fontSize: 11.sp),
          ),
        ),
      ),
    );
  }
}
