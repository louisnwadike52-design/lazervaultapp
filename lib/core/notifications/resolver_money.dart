part of 'notification_route_resolver.dart';

/// Money movement: transfers, deposits, withdrawals, exchange, recurring
/// transfers, batch payouts and refunds.
///
/// Almost every destination here is a [TargetPrecision.serviceLanding]. That is
/// deliberate and worth stating plainly: the receipt screens in this domain are
/// built around hydrated entities — `sendFundReceipt` does
/// `Get.arguments as Transaction` — and a push payload carries only
/// `reference`, `amount`, `currency` and `status`. Constructing a half-populated
/// `Transaction` to satisfy the cast would render a receipt with missing fees,
/// missing counterparty details and a wrong running balance. On a money screen
/// that is worse than one extra tap, so these land on the service's transaction
/// history with the record newest-first instead.
///
/// The upgrade path is on the server, not here: once a payload carries the
/// transaction id, swap the `_history(...)` for a `_record(...)`.
NotificationTarget? _resolveMoney(String type, Map<String, String> data) {
  // ---- Wallet-to-wallet transfers -----------------------------------------
  // transfer, transfer.sent, transfer.received, transfer.reversed
  if (_is(type, 'transfer')) {
    if (type == 'transfer.reversed') {
      return _history(TransactionServiceType.reversal);
    }
    return _history(TransactionServiceType.transfer);
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
    return _history(TransactionServiceType.deposit);
  }
  if (_is(type, 'withdrawal') || _is(type, 'withdraw')) {
    return _history(TransactionServiceType.withdrawal);
  }
  if (_is(type, 'refund')) {
    return _history(TransactionServiceType.refund);
  }
  if (_is(type, 'fee')) {
    return _history(TransactionServiceType.fee);
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
    return _history(TransactionServiceType.batchTransfer);
  }

  // ---- Generic payment -----------------------------------------------------
  // `payment` is the catch-all notifications-service emits when a payment event
  // does not narrow to deposit/withdrawal/crypto/exchange. The payment_method
  // field is the only thing that distinguishes them, so use it when present.
  if (type == 'payment' || _is(type, 'payment')) {
    final method = (data['payment_method'] ?? '').toLowerCase();
    if (method.contains('card')) return _landing(AppRoutes.myAccount);
    return _landing(AppRoutes.dashboardTransactionHistory);
  }

  return null;
}
