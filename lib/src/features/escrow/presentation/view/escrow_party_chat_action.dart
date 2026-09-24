import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:get/get.dart';
import 'package:google_fonts/google_fonts.dart';

import 'package:lazervault/core/types/app_routes.dart';
import 'package:lazervault/core/shared_widgets/app_snackbar.dart';
import 'package:lazervault/src/features/escrow/domain/entities/escrow_deal_entity.dart';

/// The other side of an escrow deal, from one viewer's point of view.
class EscrowCounterparty {
  final String userId;
  final String name;

  const EscrowCounterparty({required this.userId, required this.name});
}

/// Resolve who the viewer would be talking to.
///
/// Returns null when the viewer is neither party — an escrow can be opened
/// from a share link by someone who has not claimed it, and offering them a
/// private channel to a stranger's counterparty would be wrong. Also null when
/// the other side has not been filled in yet, which is the normal state of an
/// open-link deal nobody has accepted.
EscrowCounterparty? escrowCounterpartyFor(
  EscrowDealEntity deal,
  String viewerUserId,
) {
  if (viewerUserId.isEmpty) return null;

  String id = '';
  String name = '';
  if (viewerUserId == deal.buyerUserId) {
    id = deal.sellerUserId;
    name = deal.sellerName;
  } else if (viewerUserId == deal.sellerUserId) {
    id = deal.buyerUserId;
    name = deal.buyerName;
  } else {
    return null;
  }

  if (id.trim().isEmpty) return null;
  // Never open a thread with yourself. Degenerate data (both sides the same
  // user) would otherwise route into a conversation with the viewer, which the
  // p2p screen is not built for — the existing P2PChatIcon guards the same way.
  if (id.trim() == viewerUserId) return null;
  return EscrowCounterparty(
    userId: id.trim(),
    // A blank name is common before a counterparty completes their profile;
    // the chat still works, so it falls back rather than blocking the action.
    name: name.trim().isNotEmpty ? name.trim() : 'Counterparty',
  );
}

/// AppBar action that opens a direct conversation with the other party.
///
/// Escrow is the one flow where two people who may not know each other are
/// mid-transaction over something physical — "have you posted it", "which
/// colour", "I've sent proof". Without a channel that conversation happens on
/// WhatsApp, off-platform, where none of it can be referenced if the deal is
/// disputed.
///
/// Routes into the existing direct-messaging thread rather than creating an
/// escrow-specific one. The pair already have a conversation if they have
/// dealt before, and splitting the same two people across two inboxes means
/// messages get missed.
class EscrowPartyChatAction extends StatelessWidget {
  const EscrowPartyChatAction({
    super.key,
    required this.deal,
    required this.viewerUserId,
  });

  final EscrowDealEntity deal;
  final String viewerUserId;

  @override
  Widget build(BuildContext context) {
    final other = escrowCounterpartyFor(deal, viewerUserId);

    // Hidden rather than disabled when there is nobody to talk to. A greyed
    // icon invites a tap that can never work, and on an unclaimed deal there
    // is genuinely no second party yet.
    if (other == null) return const SizedBox.shrink();

    return IconButton(
      tooltip: 'Message ${other.name}',
      icon: Icon(Icons.chat_bubble_outline_rounded,
          color: Colors.white, size: 20.sp),
      onPressed: () => openEscrowPartyChat(context, deal, viewerUserId),
    );
  }
}

/// Open the direct thread with the deal's other party.
///
/// Pushed, not replaced: the user is mid-deal and will want to come back to
/// the actions on this screen. `Get.toNamed` keeps the detail screen beneath
/// so the back gesture returns to the deal rather than the escrow list.
void openEscrowPartyChat(
  BuildContext context,
  EscrowDealEntity deal,
  String viewerUserId,
) {
  final other = escrowCounterpartyFor(deal, viewerUserId);
  if (other == null) {
    showAppSnackbar(
      'Escrow Pay',
      'There is no one to message on this deal yet.',
      type: AppSnackbarType.info,
    );
    return;
  }

  Get.toNamed(
    AppRoutes.p2pChat,
    arguments: {
      'otherUserId': other.userId,
      'otherUserName': other.name,
      // Not a saved recipient: these two are counterparties to one deal, which
      // is not the same as someone the user chose to keep. Marking it true
      // would quietly add a stranger to their saved list.
      'isSavedRecipient': false,
    },
  );
}

/// A full-width row for the deal body, for people who never look at an AppBar.
///
/// The icon alone is easy to miss on the screen where the question "can I talk
/// to them?" actually arises, so the same action is offered inline with a
/// label saying who it reaches.
class EscrowPartyChatRow extends StatelessWidget {
  const EscrowPartyChatRow({
    super.key,
    required this.deal,
    required this.viewerUserId,
  });

  final EscrowDealEntity deal;
  final String viewerUserId;

  @override
  Widget build(BuildContext context) {
    final other = escrowCounterpartyFor(deal, viewerUserId);
    if (other == null) return const SizedBox.shrink();

    // NO horizontal padding of its own. The detail screen's SingleChildScrollView
    // already applies EdgeInsets.all(16.w), and its sibling sections — the
    // buyer/seller tiles directly above, the timeline directly below — are bare
    // widgets that inherit it. Adding 16.w here inset this card by 32 while
    // everything around it sat at 16, so it read as misaligned on the one screen
    // where the eye has two cards right above to compare it against.
    return Padding(
      padding: EdgeInsets.only(top: 12.h),
      child: InkWell(
        onTap: () => openEscrowPartyChat(context, deal, viewerUserId),
        borderRadius: BorderRadius.circular(12.r),
        child: Container(
          padding: EdgeInsets.symmetric(horizontal: 12.w, vertical: 12.h),
          decoration: BoxDecoration(
            color: const Color(0xFF1C1C1E),
            borderRadius: BorderRadius.circular(12.r),
            border: Border.all(color: const Color(0xFF2A2A2C)),
          ),
          child: Row(
            children: [
              Container(
                width: 32.w,
                height: 32.w,
                decoration: BoxDecoration(
                  color: const Color(0xFF4E03D0).withValues(alpha: 0.15),
                  borderRadius: BorderRadius.circular(9.r),
                ),
                child: Icon(Icons.chat_bubble_outline_rounded,
                    size: 16.sp, color: const Color(0xFF9B6DFF)),
              ),
              SizedBox(width: 12.w),
              Expanded(
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    Text(
                      // Sized to sit UNDER the party tiles' names rather than
                      // compete with them: this is a secondary action, and at
                      // 14.sp semibold it was reading as another heading.
                      'Message ${other.name}',
                      maxLines: 1,
                      overflow: TextOverflow.ellipsis,
                      style: GoogleFonts.inter(
                        color: Colors.white,
                        fontSize: 13.sp,
                        height: 1.25,
                        fontWeight: FontWeight.w600,
                      ),
                    ),
                    SizedBox(height: 3.h),
                    Text(
                      'Ask about delivery or send an update',
                      maxLines: 1,
                      overflow: TextOverflow.ellipsis,
                      style: GoogleFonts.inter(
                        color: Colors.grey[500],
                        fontSize: 11.sp,
                        height: 1.25,
                      ),
                    ),
                  ],
                ),
              ),
              SizedBox(width: 8.w),
              Icon(Icons.chevron_right_rounded,
                  size: 18.sp, color: Colors.grey[600]),
            ],
          ),
        ),
      ),
    );
  }
}
