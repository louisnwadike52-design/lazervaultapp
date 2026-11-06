part of 'notification_route_resolver.dart';

/// Money movement: transfers, deposits, withdrawals, exchange, recurring
/// transfers, batch payouts and refunds.
///
/// Destinations here go through [_receipt], which reaches the ACTUAL receipt
/// whenever the payload names the record, and the service's history when it
/// does not.
///
/// This domain's receipts render a hydrated entity and a push payload carries
/// only identifiers, which is why the mapping used to stop at the history list
/// for everything. Rather than construct a half-populated entity — a receipt
/// with missing fees, no counterparty and a wrong running balance, which on a
/// money screen is worse than an extra tap — `_receipt` routes through a loader
/// that fetches the row by reference and then becomes the real receipt. The
/// fallback inside that loader is precisely the old `_history` destination, so
/// a stale or unresolvable id degrades to the previous behaviour instead of
/// dead-ending.
///
/// Non-ledger destinations — a recurring-transfer SCHEDULE, the exchange and
/// RMB histories whose receipts take their own entity types — stay on their own
/// routes below rather than going through the ledger loader.
NotificationTarget? _resolveMoney(String type, Map<String, String> data) {
  // ---- Wallet-to-wallet transfers -----------------------------------------
  // transfer, transfer.sent, transfer.received, transfer.reversed
  if (_is(type, 'transfer')) {
    if (type == 'transfer.reversed') {
      return _receipt(TransactionServiceType.reversal, data);
    }
    return _receipt(TransactionServiceType.transfer, data);
  }

  // ---- Recurring / scheduled transfers ------------------------------------
  // recurring_transfer_success | _failed | _auto_paused | _update
  //
  // These route to the schedule itself rather than to history: the actionable
  // thing about "your recurring transfer was auto-paused" is the schedule, not
  // the ledger entry. The detail screen takes a bare String id (it re-fetches
  // from the id alone), so this is exact whenever the id travelled.
  if (type.startsWith('recurring_transfer')) {
    final id = _first(data, const [
      'recurring_transfer_id',
      'scheduled_transfer_id',
      'schedule_id',
      'entity_id',
    ]);
    if (id != null) {
      return _record(AppRoutes.recurringTransferDetail, arguments: id);
    }
    return _landing(AppRoutes.recurringTransfers);
  }

  // ---- Account-level money in/out -----------------------------------------
  if (_is(type, 'deposit')) {
    return _receipt(TransactionServiceType.deposit, data);
  }
  if (_is(type, 'withdrawal') || _is(type, 'withdraw')) {
    return _receipt(TransactionServiceType.withdrawal, data);
  }
  if (_is(type, 'refund')) {
    return _receipt(TransactionServiceType.refund, data);
  }
  if (_is(type, 'fee')) {
    return _receipt(TransactionServiceType.fee, data);
  }

  // ---- Currency exchange ---------------------------------------------------
  // ExchangeDetailScreen only accepts a hydrated `CurrencyTransaction`
  // (`arg is CurrencyTransaction ? arg : null`) and renders an empty receipt
  // for anything else — so a payload-built target would land on a blank page.
  // History is the correct destination until the screen learns to fetch by id.
  if (_is(type, 'exchange')) {
    return _landing(AppRoutes.exchangeHistory);
  }

  // ---- RMB cross-border ----------------------------------------------------
  if (_is(type, 'rmb')) {
    return _landing(AppRoutes.rmbHistory);
  }

  // ---- Batch payouts -------------------------------------------------------
  if (_is(type, 'batch_transfer') || _is(type, 'batch')) {
    return _receipt(TransactionServiceType.batchTransfer, data);
  }

  // ---- Generic payment -----------------------------------------------------
  // `payment` is the catch-all notifications-service emits when a payment event
  // does not narrow to deposit/withdrawal/crypto/exchange. The payment_method
  // field is the only thing that distinguishes them, so use it when present.
  if (type == 'payment' || _is(type, 'payment')) {
    final method = (data['payment_method'] ?? '').toLowerCase();
    if (method.contains('card')) return _landing(AppRoutes.myAccount);

    // NARROW ON entity_type BEFORE GIVING UP ON A SERVICE.
    //
    // This passed no service type at all, and a null service type is exactly
    // what makes TransactionDeepLinkScreen fall back to the ALL-SERVICES
    // history. So whenever the record could not be loaded — an offline tap, a
    // slow lookup past its six-second budget, a reference the ledger search
    // misses — the user landed on the generic list and had to find the thing
    // the notification was already about.
    //
    // The payload has carried entity_type all along (handlers_payment.go
    // stamps it beside entity_id); it was simply not read here. With it, the
    // fallback is that service's own history instead.
    const byEntity = <String, TransactionServiceType>{
      'transfer': TransactionServiceType.transfer,
      'deposit': TransactionServiceType.deposit,
      'withdrawal': TransactionServiceType.withdrawal,
      'exchange': TransactionServiceType.exchange,
      'refund': TransactionServiceType.refund,
      'reversal': TransactionServiceType.reversal,
    };
    final entity = (data['entity_type'] ?? '').trim().toLowerCase();
    final narrowed = byEntity[entity];
    if (narrowed != null) return _receipt(narrowed, data);

    // Genuinely unidentifiable: the all-services history is the honest
    // landing, because a guessed service page is worse than a list that
    // definitely contains the record.
    final id = _transactionId(data);
    if (id != null) {
      return NotificationTarget(
        route: AppRoutes.transactionDeepLink,
        arguments: {'id': id},
        precision: TargetPrecision.record,
      );
    }
    return _landing(AppRoutes.dashboardTransactionHistory);
  }

  return null;
}
