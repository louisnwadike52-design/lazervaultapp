import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:shared_preferences/shared_preferences.dart';

import 'package:lazervault/src/features/recipients/data/models/recipient_model.dart';
import 'package:lazervault/src/features/p2p_chat/presentation/widgets/p2p_chat_icon.dart';

/// How the saved-recipients preview is laid out.
///
/// Persisted per device so the choice survives leaving the screen — a display
/// preference the user has to re-make every visit is not a preference.
enum SavedRecipientsView { rail, list }

/// The number of recipients each mode shows.
///
/// The rail scrolls, so it can afford more; the list is stacked above the rest
/// of the form and three is as many as fits before the send action is pushed
/// off-screen. Both are served from ONE fetch of [fetchCount] — switching modes
/// must not cost a round trip, and the backend is asked once for the larger
/// number rather than re-queried when the user toggles.
class SavedRecipientsViewCounts {
  static const int rail = 7;
  static const int list = 3;
  static const int fetch = rail;
}

/// Remembers the chosen layout.
///
/// Plain SharedPreferences, NOT secure storage: SecureStorageService.clearAll()
/// runs on logout, and a display preference that resets every sign-in reads as
/// a bug. Scoped by user id so two people sharing a device do not inherit each
/// other's choice.
class SavedRecipientsViewPreference {
  static const _prefix = 'recipients.saved_view.';

  static Future<SavedRecipientsView> load(String userId) async {
    try {
      final prefs = await SharedPreferences.getInstance();
      final raw = prefs.getString('$_prefix$userId');
      return raw == 'list' ? SavedRecipientsView.list : SavedRecipientsView.rail;
    } catch (_) {
      // Storage unavailable: fall back to the default rather than blocking the
      // screen on a preference.
      return SavedRecipientsView.rail;
    }
  }

  static Future<void> save(String userId, SavedRecipientsView view) async {
    try {
      final prefs = await SharedPreferences.getInstance();
      await prefs.setString(
          '$_prefix$userId', view == SavedRecipientsView.list ? 'list' : 'rail');
    } catch (_) {
      // A preference that fails to persist is not worth interrupting a send for.
    }
  }
}

/// Horizontally scrollable saved recipients.
///
/// WHY CARDS AND NOT CIRCLES
/// -------------------------
/// A circle-and-name row (the messaging-app pattern) carries one line of text.
/// Picking a payment destination needs three — who, which bank, and the account
/// number — because that is what a sender checks before committing money, and
/// two people with the same first name are otherwise indistinguishable. The card
/// keeps the circular avatar for recognition and gives the identifying details
/// somewhere to live.
///
/// Every action the list row offers is here too: chat, the three-dot sheet, and
/// tapping the card itself to send. A denser layout that quietly drops actions
/// would make the toggle a downgrade rather than a choice.
class SavedRecipientsRail extends StatelessWidget {
  const SavedRecipientsRail({
    super.key,
    required this.recipients,
    required this.onTap,
    required this.onMore,
  });

  final List<RecipientModel> recipients;
  final void Function(RecipientModel) onTap;
  final void Function(RecipientModel) onMore;

  static const _cardWidth = 168.0;

  @override
  Widget build(BuildContext context) {
    if (recipients.isEmpty) return const SizedBox.shrink();

    return SizedBox(
      height: 158.h,
      child: ListView.separated(
        scrollDirection: Axis.horizontal,
        padding: EdgeInsets.symmetric(horizontal: 4.w),
        itemCount: recipients.length,
        separatorBuilder: (_, __) => SizedBox(width: 10.w),
        itemBuilder: (_, i) => _RecipientCard(
          recipient: recipients[i],
          width: _cardWidth.w,
          onTap: () => onTap(recipients[i]),
          onMore: () => onMore(recipients[i]),
        ),
      ),
    );
  }
}

class _RecipientCard extends StatelessWidget {
  const _RecipientCard({
    required this.recipient,
    required this.width,
    required this.onTap,
    required this.onMore,
  });

  final RecipientModel recipient;
  final double width;
  final VoidCallback onTap;
  final VoidCallback onMore;

  /// Up to two letters, from the first and last word of the name.
  ///
  /// Falls back to the first character of the account number so a recipient
  /// saved with no name is still distinguishable rather than a blank disc.
  String get _initials {
    final parts = recipient.name
        .trim()
        .split(RegExp(r'\s+'))
        .where((w) => w.isNotEmpty)
        .toList();
    if (parts.isEmpty) {
      final acct = recipient.accountNumber.trim();
      return acct.isEmpty ? '?' : acct.characters.first.toUpperCase();
    }
    if (parts.length == 1) return parts.first.characters.first.toUpperCase();
    return (parts.first.characters.first + parts.last.characters.first)
        .toUpperCase();
  }

  bool get _isInternal => recipient.type == 'internal';

  @override
  Widget build(BuildContext context) {
    final theme = Theme.of(context);
    final isDark = theme.brightness == Brightness.dark;
    final surface = isDark ? const Color(0xFF1C1C1E) : const Color(0xFFF5F4F7);
    final border = isDark ? const Color(0xFF2A2A2C) : const Color(0xFFE6E4EA);
    final primaryText = isDark ? Colors.white : const Color(0xFF1A1A1A);
    final secondaryText = isDark ? Colors.grey[400] : Colors.grey[600];

    return SizedBox(
      width: width,
      child: Material(
        color: surface,
        borderRadius: BorderRadius.circular(16.r),
        clipBehavior: Clip.antiAlias,
        child: InkWell(
          onTap: onTap,
          child: Container(
            decoration: BoxDecoration(
              borderRadius: BorderRadius.circular(16.r),
              border: Border.all(color: border),
            ),
            padding: EdgeInsets.fromLTRB(12.w, 12.h, 4.w, 10.h),
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Row(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    Container(
                      width: 40.w,
                      height: 40.w,
                      decoration: const BoxDecoration(
                        shape: BoxShape.circle,
                        color: Color(0xFF4E03D0),
                      ),
                      alignment: Alignment.center,
                      child: Text(
                        _initials,
                        style: TextStyle(
                          color: Colors.white,
                          fontSize: 14.sp,
                          fontWeight: FontWeight.w700,
                        ),
                      ),
                    ),
                    const Spacer(),
                    // The three-dot sheet, same one the list row opens. Kept in
                    // the corner so it never competes with the card's own tap
                    // target, which is "send to this person".
                    InkWell(
                      borderRadius: BorderRadius.circular(16.r),
                      onTap: onMore,
                      child: Padding(
                        padding: EdgeInsets.all(4.w),
                        child: Icon(Icons.more_vert,
                            size: 18.w, color: secondaryText),
                      ),
                    ),
                  ],
                ),
                SizedBox(height: 8.h),
                Text(
                  recipient.name.isNotEmpty ? recipient.name : 'Recipient',
                  maxLines: 1,
                  overflow: TextOverflow.ellipsis,
                  style: TextStyle(
                    color: primaryText,
                    fontSize: 13.5.sp,
                    fontWeight: FontWeight.w700,
                  ),
                ),
                SizedBox(height: 2.h),
                Text(
                  recipient.bankName.isNotEmpty ? recipient.bankName : '—',
                  maxLines: 1,
                  overflow: TextOverflow.ellipsis,
                  style: TextStyle(color: secondaryText, fontSize: 11.sp),
                ),
                if (recipient.accountNumber.isNotEmpty)
                  Text(
                    recipient.accountNumber,
                    maxLines: 1,
                    overflow: TextOverflow.ellipsis,
                    style: TextStyle(
                      color: secondaryText,
                      fontSize: 11.sp,
                      // Account numbers are compared digit by digit; tabular
                      // figures keep them aligned between cards.
                      fontFeatures: const [FontFeature.tabularFigures()],
                    ),
                  ),
                const Spacer(),
                // Chat sits on its own row at the foot so the card's body stays
                // a single tap target for sending.
                Align(
                  alignment: Alignment.centerLeft,
                  child: P2PChatIcon(
                    otherUserId: recipient.internalUserId,
                    otherUserName: recipient.name,
                    isInternal: _isInternal,
                    accountNumber: recipient.accountNumber,
                  ),
                ),
              ],
            ),
          ),
        ),
      ),
    );
  }
}
