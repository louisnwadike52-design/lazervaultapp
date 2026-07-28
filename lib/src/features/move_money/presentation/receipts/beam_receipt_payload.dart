import 'package:lazervault/core/types/app_routes.dart';
import 'package:lazervault/src/features/funds/data/datasources/payments_transfer_data_source.dart';
import 'package:lazervault/src/features/move_money/domain/entities/move_transfer.dart';

/// Canonical LazerBeam → shared receipt (`AppRoutes.transferProof`) payload
/// builders. One receipt experience platform-wide (`TransferReceiptScreen`);
/// only the payload varies per money product. Factored out of the two flow
/// screens so the flows AND history taps produce identical receipts.
///
/// Both builders attach `redoRoute`/`redoArgs` so the receipt can offer a
/// "Redo" CTA that re-opens the correct transfer flow.

/// Interbank (External Banks) LazerBeam transfer → receipt payload.
///
/// [statusFetch] (optional) wires the receipt's LIVE status header
/// (fetch-on-load + WS push + pull-to-refresh). History taps on a terminal
/// transfer can omit it. When provided it MUST capture only GetIt singletons
/// so it outlives the screen that built it.
Map<String, dynamic> beamReceiptPayloadFromMoveTransfer(
  MoveTransfer t, {
  Future<MoveTransfer> Function()? statusFetch,
  // Back from a Beam receipt returns to the LazerBeam landing = the bottom-nav
  // dashboard's Beam tab (index 3), NOT the standalone /move-money screen (which
  // has no bottom nav and stranded the user). See `backArgs` below.
  String backRoute = AppRoutes.dashboard,
}) {
  final currency = t.currency.isNotEmpty ? t.currency : 'NGN';
  return <String, dynamic>{
    // The receipt's "Type" row — describe WHAT the transfer is (the bank rail
    // moves money to a bank account), not the product name. "Lazerbeam" is the
    // product (shown in the flow/landing header), never the transaction type.
    'transferType': 'Bank transfer',
    'amount': t.amount / 100.0,
    'fee': t.totalFee / 100.0,
    'currency': currency,
    'status': t.status.displayName,
    'internalReference': t.reference,
    'providerReference':
        (t.debitReference?.isNotEmpty ?? false) ? t.debitReference : null,
    'transferId': t.id,
    'recipientName': t.destinationAccountName,
    'recipientBankName': t.destinationBankName,
    'recipientAccountMasked': t.destinationAccountNumber,
    'sourceAccountName': t.sourceAccountName,
    'sourceAccountInfo': '${t.sourceBankName}  ${t.sourceAccountNumber}',
    // Structured source leg -> receipt renders symmetric From/To sections
    // with full account details for both sides.
    'sourceBankName': t.sourceBankName,
    'sourceAccountMasked': t.sourceAccountNumber,
    if (statusFetch != null) 'moveStatusFetch': statusFetch,
    if (statusFetch != null) 'liveStatusReference': t.reference,
    'backRoute': backRoute,
    // Land on the Beam bottom-nav tab (index 3) when backRoute is the dashboard.
    'backArgs': const <String, dynamic>{'initialTab': 3},
    'narration': t.narration,
    'timestamp': t.createdAt.toLocal(),
    'createdAt': t.createdAt.toLocal(),
    // Redo → re-open the interbank flow, pre-selecting the destination and
    // pre-filling the amount/narration (best-effort; the flow re-resolves the
    // destination account by its linked-account id).
    'redoRoute': AppRoutes.moveMoneyTransfer,
    'redoArgs': <String, dynamic>{
      'destinationLinkedAccountId': t.destinationLinkedAccountId,
      'amount': t.amount / 100.0,
      'narration': t.narration,
    },
  };
}

/// Inter-Lazervault-account (Wallet) LazerBeam transfer → receipt payload.
/// Internal transfers settle synchronously, so the status is final (no live
/// fetcher). Prefers the record's OWN enriched fields (currency, counterparty
/// name/account, narration) — populated by `getPaymentHistory` — and only falls
/// back to the caller-supplied [currency]/[destName] when the record is thin
/// (e.g. the flow's freshly-synthesized success result).
Map<String, dynamic> beamReceiptPayloadFromWalletTransfer(
  PaymentsTransferResult r, {
  required String sourceName,
  String? destName,
  String? currency,
  String? sourceAccountMasked,
  String? destinationAccountMasked,
  // See note above — returns to the dashboard Beam tab, not standalone /move-money.
  String backRoute = AppRoutes.dashboard,
}) {
  final ccy = (r.currency?.isNotEmpty ?? false)
      ? r.currency!
      : (currency != null && currency.isNotEmpty ? currency : 'NGN');
  final status = (r.status?.isNotEmpty ?? false) ? r.status! : 'completed';
  final date = r.createdAt ?? DateTime.now();
  final dest = (r.recipientName?.isNotEmpty ?? false)
      ? r.recipientName!
      : (destName != null && destName.isNotEmpty
          ? destName
          : 'Lazervault account');
  return <String, dynamic>{
    // Wallet rail = Lazervault account → Lazervault account. See the note in
    // beamReceiptPayloadFromMoveTransfer: "Type" is the kind of transfer, not
    // the product name.
    'transferType': 'Wallet transfer',
    'amount': (r.amount ?? 0) / 100.0,
    'fee': (r.fee ?? 0) / 100.0,
    'currency': ccy,
    'status': status,
    'internalReference': r.reference,
    'providerReference': r.providerReference,
    'transferId': r.transferId,
    'recipientName': dest,
    'recipientBankName': 'Lazervault Wallet',
    'recipientAccountMasked':
        destinationAccountMasked ?? r.counterpartyAccount ?? '',
    'sourceAccountName': sourceName,
    'sourceBankName': 'Lazervault Wallet',
    'sourceAccountMasked': sourceAccountMasked ?? '',
    'sourceAccountInfo': 'Lazervault Wallet',
    'narration': r.description,
    'timestamp': date.toLocal(),
    'createdAt': date.toLocal(),
    'backRoute': backRoute,
    'backArgs': const <String, dynamic>{'initialTab': 3},
    // Redo → re-open the wallet flow. When the record carries the source/dest
    // account ids (history rows do), the flow pre-selects them; otherwise it
    // opens fresh. Amount pre-fills when known.
    'redoRoute': AppRoutes.walletTransfer,
    'redoArgs': <String, dynamic>{
      if (r.sourceAccountId != null) 'sourceAccountId': r.sourceAccountId,
      if (r.destinationAccountId != null)
        'destinationAccountId': r.destinationAccountId,
      'amount': (r.amount ?? 0) / 100.0,
    },
  };
}
