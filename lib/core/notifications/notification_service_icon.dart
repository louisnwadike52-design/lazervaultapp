import 'package:lazervault/core/types/services.dart';

/// Picks the service glyph for a notification row.
///
/// Matches on the type's DOMAIN, not the whole string. The previous version was
/// an exact-match switch on `'transfer'`, `'invoice'`, `'bill'` and a handful
/// more — but notifications-service emits `transfer.sent`, `split_bill.created`,
/// `tagpay.request`, `electricity_payment_completed` and so on, none of which
/// matched. Almost every row therefore fell through to the default and showed
/// the phone-banking glyph, so the feed looked like one undifferentiated list
/// regardless of what the notifications were about.
///
/// Ordering matters where one name contains another: `giftcard` is checked
/// before `card`, and `split_bill` before `bill`.
AppService notificationServiceFor(String type) {
  AppService of(AppServiceName n, AppServiceImg i) =>
      AppService(serviceName: n, serviceImg: i);

  final t = type.toLowerCase().trim();
  bool has(String prefix) =>
      t == prefix || t.startsWith('$prefix.') || t.startsWith('${prefix}_');

  // Longest / most specific first.
  if (has('split_bill') || has('splitbill')) {
    return of(AppServiceName.splitBills, AppServiceImg.splitBills);
  }
  if (has('giftcard') || has('gift_card')) {
    return of(AppServiceName.giftCards, AppServiceImg.giftCards);
  }
  if (has('tagpay') || has('tag_pay')) {
    return of(AppServiceName.tagPay, AppServiceImg.tagPay);
  }
  if (has('invoice')) {
    return of(AppServiceName.invoice, AppServiceImg.invoice);
  }
  if (has('escrow')) {
    return of(AppServiceName.escrow, AppServiceImg.escrow);
  }
  if (has('uplift')) return of(AppServiceName.uplift, AppServiceImg.uplift);
  if (has('crypto')) return of(AppServiceName.crypto, AppServiceImg.crypto);
  if (has('exchange')) {
    return of(AppServiceName.exchange, AppServiceImg.exchange);
  }
  if (has('rmb')) return of(AppServiceName.rmb, AppServiceImg.rmb);
  if (has('stock') || has('stocks')) {
    return of(AppServiceName.stocks, AppServiceImg.stocks);
  }
  if (has('investment')) return of(AppServiceName.invest, AppServiceImg.invest);
  if (has('insurance')) {
    return of(AppServiceName.insurance, AppServiceImg.insurance);
  }
  if (has('autosave') || has('auto_save')) {
    return of(AppServiceName.autoSave, AppServiceImg.autoSave);
  }
  if (has('lock_funds') || has('piggyvault')) {
    return of(AppServiceName.lockFunds, AppServiceImg.lockFunds);
  }
  if (has('crowdfund') || has('donation')) {
    return of(AppServiceName.crowdfund, AppServiceImg.crowdfund);
  }
  if (has('group') || has('group_funds') || has('contribution')) {
    return of(AppServiceName.groupAccount, AppServiceImg.groupAccount);
  }
  if (has('qr_pay') || has('qrpay')) {
    return of(AppServiceName.qrPay, AppServiceImg.qrPay);
  }
  if (has('id_pay') || has('idpay')) {
    return of(AppServiceName.idPay, AppServiceImg.idPay);
  }
  if (has('contactless')) {
    return of(AppServiceName.contactlessPay, AppServiceImg.contactlessPay);
  }
  if (has('airtime')) return of(AppServiceName.airtime, AppServiceImg.airtime);
  if (has('betting')) return of(AppServiceName.betting, AppServiceImg.betting);
  if (has('epin') || has('recharge_card')) {
    return of(AppServiceName.rechargeCard, AppServiceImg.rechargeCard);
  }
  if (has('bulk_sms') || has('bulksms')) {
    return of(AppServiceName.bulkSms, AppServiceImg.bulkSms);
  }
  if (has('payroll') || t.contains('payroll')) {
    return of(AppServiceName.payroll, AppServiceImg.payroll);
  }
  if (has('expense')) {
    return of(AppServiceName.expenses, AppServiceImg.expenses);
  }
  if (has('inventory') || t.contains('low_stock')) {
    return of(AppServiceName.inventory, AppServiceImg.inventory);
  }
  if (has('batch_transfer') || has('batch')) {
    return of(AppServiceName.batchTransfer, AppServiceImg.batchTransfer);
  }
  // Bills: the utility families and the generic `bill` feed type. AFTER
  // split_bill so a split bill is not filed as a utility payment.
  if (has('bill') ||
      t.startsWith('electricity') ||
      has('cable') ||
      has('internet') ||
      has('water') ||
      has('education') ||
      has('data')) {
    return of(AppServiceName.payBills, AppServiceImg.payBills);
  }
  // Money movement — transfer.sent/.received/.reversed, deposits, withdrawals,
  // refunds, fees and the generic payment type.
  if (has('transfer') ||
      has('payment') ||
      has('deposit') ||
      has('withdrawal') ||
      has('refund') ||
      has('fee')) {
    return of(AppServiceName.sendFunds, AppServiceImg.sendFunds);
  }
  // Everything account-shaped — security, account, kyc, budgets, planning,
  // ops alerts, and anything this build has not met before.
  return of(AppServiceName.phoneBanking, AppServiceImg.phoneBanking);
}
