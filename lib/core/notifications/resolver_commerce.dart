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
  if (_is(type, 'lock_funds') ||
      _is(type, 'piggyvault') ||
      _is(type, 'piggy')) {
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
  if (_is(type, 'payroll')) return _landing(AppRoutes.payRuns);
  if (_is(type, 'expense')) return _landing(AppRoutes.expenses);
  if (_is(type, 'bulk_sms') || _is(type, 'bulksms')) {
    return _landing(AppRoutes.bulkSmsCampaigns);
  }

  return null;
}
