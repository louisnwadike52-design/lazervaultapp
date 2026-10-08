import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:shared_preferences/shared_preferences.dart';

import 'package:lazervault/src/features/recipients/data/models/recipient_model.dart';
import 'package:lazervault/src/features/p2p_chat/presentation/widgets/p2p_chat_icon.dart';
import '../../../../../core/utils/brand_bank.dart';
import '../../../../../core/widgets/bank_logo.dart';

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
      return raw == 'list'
          ? SavedRecipientsView.list
          : SavedRecipientsView.rail;
    } catch (_) {
      // Storage unavailable: fall back to the default rather than blocking the
      // screen on a preference.
      return SavedRecipientsView.rail;
    }
  }

  static Future<void> save(String userId, SavedRecipientsView view) async {
    try {
      final prefs = await SharedPreferences.getInstance();
      await prefs.setString('$_prefix$userId',
          view == SavedRecipientsView.list ? 'list' : 'rail');
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

  static const _cardWidth = 150.0;

  @override
  Widget build(BuildContext context) {
    if (recipients.isEmpty) return const SizedBox.shrink();

    // The rail is a horizontal list, so its height must be bounded — which
    // means the card cannot simply grow to fit its text. It holds three lines
    // plus a 34px avatar row, so it has to TRACK the text scale: at a fixed
    // height an accessibility bump does not ellipsise, it overflows. (A
    // widget test caught exactly that — 2px at scale 1.0 before this, and far
    // more at 1.3.)
    //
    // Clamped at 1.5 so an extreme setting does not hand a horizontal strip
    // half the screen; past that the text ellipsises, which is the right
    // trade for a preview whose full detail is one tap away.
    final scale = MediaQuery.textScalerOf(context).scale(14) / 14;
    // +4h over the previous 132: the shadow gutters above and below the card
    // grew from 6/6 to 8/14, and a rail that does not grow with them clips the
    // very shadow it just made room for.
    final railHeight = 136.h * scale.clamp(1.0, 1.5);

    return SizedBox(
      height: railHeight,
      child: ListView.separated(
        scrollDirection: Axis.horizontal,
        // Asymmetric vertical padding, because the shadow is not symmetric.
        //
        // The ambient shadow needs ~6px above the card and the key shadow
        // needs its blur PLUS its downward offset below (12 + 4). An equal
        // 6/6 clipped the key shadow flat against the viewport, which is part
        // of why the elevation only half-read.
        padding: EdgeInsets.fromLTRB(4.w, 8.h, 4.w, 14.h),
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


  bool get _isInternal => recipient.type == 'internal';

  @override
  Widget build(BuildContext context) {
    final theme = Theme.of(context);
    final isDark = theme.brightness == Brightness.dark;
    // A card on a white sheet reads as a card because it sits ABOVE the sheet,
    // not because a 1px line traces its edge. The old hairline-on-grey did
    // both jobs badly: the border was too faint to define an edge and the grey
    // fill flattened the card into the background. White + a soft shadow is
    // the standard elevated-surface treatment and survives both themes.
    final surface = isDark ? const Color(0xFF1C1C1E) : Colors.white;
    final primaryText = isDark ? Colors.white : const Color(0xFF1A1A1A);
    final secondaryText = isDark ? Colors.grey[400] : Colors.grey[600];

    // TWO shadows, not Material's `elevation`.
    //
    // Material elevation draws a KEY shadow offset downward, so the card's top
    // edge got almost nothing and the rail read as if it were resting on the
    // sheet rather than floating above it — reported as "only bottom
    // elevations are visible". A real elevated surface needs an AMBIENT
    // shadow too: no offset, tight blur, visible on every side including the
    // top.
    //
    // It also has to exist in DARK mode. `elevation: isDark ? 0 : 2` meant the
    // dark theme had no elevation at all, which is where the rail is actually
    // used most. Dark surfaces need a deeper, tighter shadow to read at all,
    // hence the separate alpha rather than reusing the light values.
    //
    // Toned down twice. The first pass overshot and the rail read as if it
    // were hovering well off the sheet; 2026-10-01 roughly halved it; this
    // halves it again, because it still read heavier than the surfaces around
    // it.
    //
    // Both shadows keep their ROLES through every reduction — that shape is
    // the thing that was actually asked for originally (ambient on every side,
    // not only below). Only the weight changes: alpha down, blur tighter, key
    // offset shorter. Flattening to a single offset shadow would be lighter
    // still and would bring straight back the "only bottom elevations are
    // visible" report this two-shadow form was built to fix.
    final ambient = BoxShadow(
      color: isDark ? const Color(0x1F000000) : const Color(0x05101828),
      blurRadius: 3,
      spreadRadius: 0,
      offset: Offset.zero,
    );
    final key = BoxShadow(
      color: isDark ? const Color(0x1A000000) : const Color(0x0A101828),
      blurRadius: 5,
      spreadRadius: -1,
      offset: const Offset(0, 1),
    );

    return SizedBox(
      width: width,
      child: DecoratedBox(
        decoration: BoxDecoration(
          color: surface,
          borderRadius: BorderRadius.circular(14.r),
          boxShadow: [ambient, key],
        ),
        child: Material(
          color: Colors.transparent,
          borderRadius: BorderRadius.circular(14.r),
          clipBehavior: Clip.antiAlias,
          child: InkWell(
            onTap: onTap,
            child: Padding(
              padding: EdgeInsets.fromLTRB(11.w, 10.h, 6.w, 10.h),
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  Row(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      // The bank's own mark, not a coloured disc of initials.
                      // A saved list is scanned, not read — the logo is what
                      // the eye lands on, and it is the fastest way to tell
                      // two recipients at different banks apart. BankLogo
                      // already renders OUR mark when the bank is us and falls
                      // back to initials on a coloured tile when a bank has no
                      // logo, so this keeps the old look exactly where no
                      // better one exists.
                      BankLogo(
                        bankName: _isInternal && recipient.bankName.trim().isEmpty
                            ? BrandBank.displayName
                            : recipient.bankName,
                        bankCode: recipient.sortCode,
                        size: 34.w,
                        borderRadius: 17.w,
                      ),
                      const Spacer(),
                      // Chat and the three-dot sheet share the top-right, beside
                      // the avatar. Chat previously owned a full row at the foot
                      // of the card purely to hold one 20px icon — a whole band
                      // of height for an action that is secondary to sending.
                      // Both are small, adjacent targets now, and the card body
                      // below them is one uninterrupted tap target for "send".
                      P2PChatIcon(
                        otherUserId: recipient.internalUserId,
                        otherUserName: recipient.name,
                        isInternal: _isInternal,
                        accountNumber: recipient.accountNumber,
                      ),
                      InkWell(
                        borderRadius: BorderRadius.circular(14.r),
                        onTap: onMore,
                        child: Padding(
                          padding: EdgeInsets.all(3.w),
                          child: Icon(Icons.more_vert,
                              size: 17.w, color: secondaryText),
                        ),
                      ),
                    ],
                  ),
                  SizedBox(height: 7.h),
                  Text(
                    recipient.name.isNotEmpty ? recipient.name : 'Recipient',
                    maxLines: 1,
                    overflow: TextOverflow.ellipsis,
                    style: TextStyle(
                      color: primaryText,
                      fontSize: 13.sp,
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
                ],
              ),
            ),
          ),
        ),
      ),
    );
  }
}
