part of 'notification_route_resolver.dart';

/// Person-to-person: split bills, TagPay, chat, family accounts, joint funds
/// and financial connections.
///
/// These are the notifications with the most at stake for deep linking. They
/// are requests — someone is waiting on the user — and the whole reason a
/// notification exists is to get them to the one screen where they can act. A
/// split-bill reminder that lands on the dashboard has failed at its only job.
NotificationTarget? _resolveSocial(String type, Map<String, String> data) {
  // ---- Split bills ---------------------------------------------------------
  // split_bill.created | .paid | .declined | .failed | .reminder
  //
  // SplitBillDetailScreen reads {'splitBillId': ...} and renders its own
  // "bill not found" state for an empty id, so only pass the id when we have
  // one — otherwise the list is the better landing.
  if (_is(type, 'split_bill') || _is(type, 'splitbill')) {
    final id = _first(data, const [
      'split_bill_id',
      'splitBillId',
      'bill_id',
      'reference_id',
      'entity_id',
    ]);
    if (id != null) {
      return _record(
        AppRoutes.splitBillDetail,
        arguments: {'splitBillId': id},
      );
    }
    return _landing(AppRoutes.splitBills);
  }

  // ---- TagPay --------------------------------------------------------------
  // tagpay.<status> for a payment's lifecycle, tagpay.request for an incoming
  // money request. Both land on the TagPay home, which carries the pending
  // queue and the claim/pay actions.
  if (_is(type, 'tagpay') || _is(type, 'tag_pay')) {
    return _landing(AppRoutes.tagPay);
  }

  // ---- P2P chat ------------------------------------------------------------
  // The chat screen needs the OTHER party — from the recipient's point of view
  // that is the sender. `fromPush`/`isSavedRecipient` mirror what
  // PendingChatNavigation already passes, so a deep-linked chat opens
  // identically to a push-tapped one.
  if (_is(type, 'p2p_message') || _is(type, 'p2p') || _is(type, 'chat')) {
    final otherId = _first(data, const [
      'sender_user_id',
      'other_user_id',
      'user_id',
      'entity_id',
    ]);
    if (otherId != null) {
      return _record(AppRoutes.p2pChat, arguments: {
        'otherUserId': otherId,
        if (data['sender_name'] != null) 'otherUserName': data['sender_name'],
        if (data['conversation_id'] != null)
          'conversationId': data['conversation_id'],
        'isSavedRecipient': true,
        'fromPush': true,
      });
    }
    return _landing(AppRoutes.financialConnections);
  }

  // ---- Financial connections ----------------------------------------------
  // Connection invites and their acceptances. The connections screen is both
  // the request inbox and the contact list, so it serves every variant.
  if (_is(type, 'financial_connection') ||
      _is(type, 'connection') ||
      _is(type, 'contact_request')) {
    return _landing(AppRoutes.financialConnections);
  }

  // ---- Family accounts -----------------------------------------------------
  // An invitation is actionable (accept/decline) and belongs in the invitations
  // inbox; anything else about an existing family belongs on that family's
  // detail page when the id travelled.
  if (_is(type, 'family')) {
    if (type.contains('invit')) {
      return _landing(AppRoutes.familyInvitations);
    }
    final familyId = _first(data, const [
      'family_id',
      'familyId'
          'entity_id',
    ]);
    if (familyId != null) {
      return _record(
        AppRoutes.familyDetails,
        arguments: {'familyId': familyId},
      );
    }
    return _landing(AppRoutes.familyAccounts);
  }

  // ---- Joint funds / group accounts ---------------------------------------
  // GroupDetailsScreen takes a bare String groupId.
  if (_is(type, 'group') ||
      _is(type, 'group_account') ||
      _is(type, 'joint') ||
      _is(type, 'contribution')) {
    if (type.contains('invit')) {
      return _landing(AppRoutes.groupAccount);
    }
    final groupId = _first(data, const [
      'group_id',
      'groupId',
      'account_id'
          'entity_id',
    ]);
    if (groupId != null) {
      return _record(AppRoutes.groupDetails, arguments: groupId);
    }
    return _landing(AppRoutes.groupAccount);
  }

  // Lazerspray is deliberately absent: it has no entries in AppRoutes and no
  // GetPages, so there is no name to route to, and notifications-service emits
  // no spray type today. Add the routes first if that changes — inventing a
  // constant here would compile and then dead-end at runtime.

  // ---- Referrals -----------------------------------------------------------
  if (_is(type, 'referral') || _is(type, 'lazer_points')) {
    return _landing(AppRoutes.referralDashboard);
  }

  // ---- Birthdays -----------------------------------------------------------
  // A birthday notification's action is to send the person something, so it
  // opens the connections list where that starts — not a read-only card.
  if (_is(type, 'birthday')) {
    return _landing(AppRoutes.financialConnections);
  }

  return null;
}
