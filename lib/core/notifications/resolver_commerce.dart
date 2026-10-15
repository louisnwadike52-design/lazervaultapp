part of 'notification_route_resolver.dart';

/// Services the user buys or holds something through: bills, airtime, data,
/// gift cards, invoices, escrow, crypto, investments, insurance, savings.
///
/// Richer than the money domain, because several of these screens already
/// accept an id or reference — invoices and gift cards resolve to the exact
/// record, and escrow has a `/escrow/detail/:reference` route minted for the
/// chat receipt deep link, reused here rather than duplicated.
NotificationTarget? _resolveCommerce(String type, Map<String, String> data) {
  // ---- Invoices ------------------------------------------------------------
  // InvoiceDetailsScreen accepts {'invoiceId': ...} or a bare String id.
  //
  // `invoice.external_tag` is the "someone tagged you on an invoice" push — the
  // payer's action is to pay it, so it goes to the incoming-tagged list where
  // the QuickPay entry lives, not to the read-only detail view.
  if (_is(type, 'invoice')) {
    if (type == 'invoice.external_tag' || type.contains('tag')) {
      return _landing(AppRoutes.incomingTaggedInvoices);
    }
    final id = _first(data, const [
      'invoice_id',
      'invoiceId',
      'reference_id',
      'entity_id',
    ]);
    if (id != null) {
      return _record(
        AppRoutes.invoiceDetails,
        arguments: {'invoiceId': id, 'isFromReceivedTab': true},
      );
    }
    return _landing(AppRoutes.invoiceList);
  }

  // ---- Gift cards ----------------------------------------------------------
  // giftCardFromReference takes a String reference (or a Map carrying one) and
  // fetches the card itself — exact whenever a reference travelled.
  if (_is(type, 'giftcard') || _is(type, 'gift_card')) {
    final ref = _first(data, const [
      'reference',
      'order_reference',
      'reference_id',
      'entity_id',
    ]);
    if (ref != null) {
      return _record(AppRoutes.giftCardFromReference, arguments: ref);
    }
    return _landing(AppRoutes.myGiftCards);
  }

  // ---- Escrow OFFERS (must precede the general escrow branch — every
  // escrow_offer_* type also contains "escrow" and would otherwise land on the
  // deal-detail route with an OFFER id, a guaranteed dead end) ---------------
  if (type.contains('escrow_offer')) {
    final offerId = _first(data, const ['offer_id', 'entity_id']);
    if (offerId != null) {
      return _record(AppRoutes.escrowOfferView,
          arguments: {'offerId': offerId});
    }
    return _landing(AppRoutes.escrow);
  }

  // ---- Escrow --------------------------------------------------------------
  // Reuses the `/escrow/detail/:reference` path-param route already wired for
  // the chat receipt deep link.
  if (_is(type, 'escrow')) {
    final ref = _first(data, const [
      'escrow_id',
      'deal_id',
      'reference',
      'entity_id',
    ]);
    if (ref != null) {
      // The only target built by string interpolation rather than a constant,
      // because `/escrow/detail/:reference` is a path-param route. Encode the
      // reference: an unescaped `/`, `?` or `#` in it would silently produce a
      // different path than intended and land somewhere else entirely.
      return _record('${AppRoutes.escrowDetail}/${Uri.encodeComponent(ref)}');
    }
    return _landing(AppRoutes.escrow);
  }

  // ---- Utility bills -------------------------------------------------------
  // Each bill family has its own history screen, which is where a "payment
  // completed / failed / refunded" notification belongs. Electricity is the
  // one with a full event vocabulary today; the rest arrive as `bill` plus a
  // biller name, handled at the bottom of this block.
  if (type.startsWith('electricity')) {
    return _landing(AppRoutes.electricityBillHistory);
  }
  if (_is(type, 'cable') || _is(type, 'cabletv') || _is(type, 'tv')) {
    return _landing(AppRoutes.cableTVHistory);
  }
  if (_is(type, 'internet')) {
    return _landing(AppRoutes.internetBillHistory);
  }
  if (_is(type, 'water')) {
    return _landing(AppRoutes.waterBillHistory);
  }
  if (_is(type, 'education')) {
    return _landing(AppRoutes.educationHistory);
  }
  if (_is(type, 'betting')) {
    return _landing(AppRoutes.bettingHistory);
  }
  if (_is(type, 'epin') || _is(type, 'recharge_card')) {
    return _landing(AppRoutes.epinOrders);
  }
  if (_is(type, 'airtime_to_cash') || _is(type, 'a2c')) {
    return _landing(AppRoutes.airtimeToCashPending);
  }
  if (_is(type, 'airtime')) {
    return _landing(AppRoutes.airtimeHistory);
  }
  if (_is(type, 'data') || _is(type, 'data_bundle')) {
    return _landing(AppRoutes.dataBundlesHistory);
  }

  // Generic `bill` — the feed type notifications-service uses when a bill
  // payment does not narrow further. The biller name is the only discriminator
  // available, so use it to reach the right family before falling back to the
  // bills hub.
  if (_is(type, 'bill')) {
    final biller = (data['biller_name'] ?? '').toLowerCase();
    if (biller.contains('electric') || biller.contains('disco')) {
      return _landing(AppRoutes.electricityBillHistory);
    }
    if (biller.contains('dstv') ||
        biller.contains('gotv') ||
        biller.contains('startimes')) {
      return _landing(AppRoutes.cableTVHistory);
    }
    if (biller.contains('water')) return _landing(AppRoutes.waterBillHistory);
    return _landing(AppRoutes.billsHub);
  }

  // ---- Subscriptions -------------------------------------------------------
  if (_is(type, 'subscription')) {
    return _landing(AppRoutes.subscriptionDashboard);
  }

  // ---- Crypto / stocks / investments --------------------------------------
  // The detail screens take hydrated `Crypto` / `Insurance` entities, which a
  // payload cannot build, so these land on the service.
  //
  // AppRoutes.cryptoPortfolio and .cryptoOrders would read better here but are
  // constants with no GetPage and no other caller — naming them would compile
  // and then dead-end at runtime. AppRoutes.crypto is the registered landing.
  if (_is(type, 'crypto')) {
    return _landing(AppRoutes.crypto);
  }
  if (_is(type, 'stock') || _is(type, 'stocks')) {
    return _landing(AppRoutes.stockPortfolio);
  }
  // `investment` is a shared envelope, not a product. Four different services
  // publish InvestmentNotificationEvent — investments, group accounts,
  // crowdfund and insurance — and notifications-service stamps them all
  // `type: investment`, so a "money added to your group" push used to land on
  // the Investments screen.
  //
  // entity_type (set at the publish site) says which product it really is;
  // event_type is the fallback for events published before that existed.
  if (_is(type, 'investment')) {
    final kind =
        (data['entity_type'] ?? data['event_type'] ?? '').toLowerCase();
    final id = _first(data, const ['entity_id']);

    if (kind.startsWith('group')) {
      if (id != null) return _record(AppRoutes.groupDetails, arguments: id);
      return _landing(AppRoutes.groupAccount);
    }
    if (kind.startsWith('crowdfund')) {
      return _landing(AppRoutes.crowdfundList);
    }
    if (kind.startsWith('insurance')) {
      return _landing(AppRoutes.insuranceAllPolicies);
    }
    return _landing(AppRoutes.investments);
  }
  if (_is(type, 'insurance')) {
    if (type.contains('claim')) return _landing(AppRoutes.insuranceMyClaims);
    return _landing(AppRoutes.insuranceAllPolicies);
  }

  // ---- Savings -------------------------------------------------------------
  if (_is(type, 'autosave') || _is(type, 'auto_save')) {
    return _landing(AppRoutes.autoSaveDashboard);
  }
  // ---- PiggyVault ---------------------------------------------------------
  // `lock_fund` SINGULAR is what accounts-service actually emits —
  // lock_fund.matured, .settled, .renewed, .renewal_skipped,
  // .approval_approved, .approval_rejected, .pending_approval. The branch
  // here only listed the PLURAL `lock_funds`, which `_is` does not match
  // against `lock_fund.matured`, so every one of those dead-ended on the feed.
  // Both spellings are accepted now; neither is worth a server change.
  //
  // Interest categories are PiggyVault events without "lock" in the slug —
  // tapping an ROI payout must land on the plan, not nowhere.
  if (_is(type, 'lock_fund') ||
      _is(type, 'lock_funds') ||
      _is(type, 'piggyvault') ||
      _is(type, 'piggy')) {
    // The plan itself when the payload names one. Every PiggyVault lifecycle
    // notification carries `lock_fund_id`, and the detail route fetches from
    // the id alone — so these are exact, not a landing.
    //
    // `reference_id` is accepted ONLY behind a matching `reference_type`. The
    // generic notification envelope puts the plan's id there, but that field
    // is shared by every producer on the channel, so reading it unconditionally
    // would eventually hand some other service's id to the plan screen. A
    // near-identical mistake on the uplift resolver handed a MILESTONE id to a
    // fund screen, so the rule here is: only an id whose own payload says what
    // it is.
    var id = _first(data, const [
      'lock_fund_id',
      'lockFundId',
      'lockfunds_id',
    ]);
    if (id == null &&
        (data['reference_type'] ?? '').toLowerCase() == 'lock_fund') {
      id = _first(data, const ['reference_id']);
    }
    if (id != null) {
      return _record(AppRoutes.lockFundDetails, arguments: id);
    }
    return _landing(AppRoutes.lockFunds);
  }
  // Interest categories are PiggyVault events without "lock" in the slug.
  // Kept as a LANDING on purpose: nothing publishes them as notifications
  // today, so there is no payload to trust for an id, and routing a
  // speculative `entity_id` at the plan screen would open "we could not find
  // this plan" the first time somebody published a transaction id there.
  if (_is(type, 'interest_payout') ||
      _is(type, 'upfront_interest') ||
      _is(type, 'interest_accrual')) {
    return _landing(AppRoutes.lockFunds);
  }
  if (_is(type, 'goal') || _is(type, 'financial_goal')) {
    return _landing(AppRoutes.financialGoals);
  }
  if (_is(type, 'crowdfund') || _is(type, 'donation')) {
    return _landing(AppRoutes.crowdfundList);
  }

  // ---- Point-of-sale style rails ------------------------------------------
  if (_is(type, 'qr_pay') || _is(type, 'qrpay') || _is(type, 'qr')) {
    return _landing(AppRoutes.qrPaymentsHistory);
  }
  if (_is(type, 'id_pay') || _is(type, 'idpay')) {
    return _history(TransactionServiceType.idPay);
  }
  if (_is(type, 'contactless')) {
    return _history(TransactionServiceType.contactlessPay);
  }

  // ---- Cards ---------------------------------------------------------------
  // AppRoutes.cardsList has no GetPage (constant only, referenced nowhere), and
  // cardCreationForm is "create a card" — the wrong place to land a "your card
  // was issued" push. My Account is where cards live and is registered.
  if (_is(type, 'card')) {
    return _landing(AppRoutes.myAccount);
  }

  // ---- Business ------------------------------------------------------------
  // These arrive through the GENERIC notification path, where the publisher
  // picks the type string freely, so the names are not always prefixed the way
  // a domain enum would be — `scheduled_payroll` does not start with
  // "payroll", and matching only the prefix silently dropped it to the feed.
  if (_is(type, 'payroll') || type.contains('payroll')) {
    return _landing(AppRoutes.payRuns);
  }
  if (_is(type, 'expense')) return _landing(AppRoutes.expenses);
  if (_is(type, 'bulk_sms') || _is(type, 'bulksms')) {
    return _landing(AppRoutes.bulkSmsCampaigns);
  }
  // inventory_low_stock, published by financial-products-service.
  if (_is(type, 'inventory') || type.contains('low_stock')) {
    return _landing(AppRoutes.inventory);
  }
  // Lazerfunds (uplift).
  //
  // EVERY uplift notice used to land on the transaction history, because the
  // feature had no named route — so "Applications closing soon", "Pool
  // committed", "Fund expired" and the rest all took the user to a list of
  // transactions instead of the fund they were about. The routes exist now.
  //
  // Money-movement notices are the exception and still go to the history: a
  // disbursement or a refund is a question about an amount landing in an
  // account, and the history is where that is answered.
  if (_is(type, 'uplift')) {
    // Money landing in an account is a question the HISTORY answers, so these
    // go there — including the milestone release, which is the notification a
    // business gets when funding actually arrives.
    if (type.contains('disbursement') ||
        type.contains('refund') ||
        type.contains('milestone')) {
      return _landing(AppRoutes.dashboardTransactionHistory);
    }
    // fund_id FIRST, and reference_id only as a fallback.
    //
    // reference_id is whatever the notice points at, which is not always a
    // fund — an application or milestone notice carries its own id. The
    // service now labels the payload by type, so a notice that is not about a
    // fund simply has no fund_id and falls through to the landing rather than
    // handing the detail screen an id it can never fetch.
    final fundId = _first(data, const [
      'fund_id',
      'fundId',
      'reference_id',
    ]);
    // MUST LOOK LIKE AN ID.
    //
    // The deadline reminders used to smuggle their dedup key into the
    // reference — `"<uuid>:appdl:2026-10-16"` — and that string arrives here
    // as the only id on the payload. Handing it to the detail screen means
    // asking the server for a fund that cannot exist, which renders as a
    // screen that loads forever. The backend no longer sends that shape, but
    // queued notifications and other callers still can.
    if (fundId != null && _looksLikeId(fundId)) {
      return _record(
        AppRoutes.lazerfundDetails,
        arguments: {'fundId': fundId},
      );
    }
    // No id — the Lazerfunds landing still beats a transaction list, because
    // the message was about a fund.
    return _landing(AppRoutes.lazerfunds);
  }

  return null;
}
