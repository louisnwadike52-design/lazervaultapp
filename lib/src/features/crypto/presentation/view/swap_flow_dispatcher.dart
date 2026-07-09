import 'dart:async';
import 'dart:math' as math;

import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:get/get.dart';
import 'package:get_it/get_it.dart';

import 'package:lazervault/core/services/locale_manager.dart';

import '../../../account_cards_summary/cubit/account_cards_summary_cubit.dart';
import '../../../account_cards_summary/cubit/account_cards_summary_state.dart';
import '../../../authentication/cubit/authentication_cubit.dart';
import '../../../authentication/cubit/authentication_state.dart';
import '../../cubit/crypto_config_cubit.dart';
import '../../cubit/crypto_cubit.dart';
import '../../cubit/crypto_state.dart';
import '../models/crypto_transaction_models.dart';
import '../widgets/quote_timer_card.dart';
import 'crypto_swap_processing_screen.dart';
import 'crypto_receipt_screen.dart';

// ============================================================================
// runSwapFlow — entry point used by buy_crypto_screen and sell_crypto_screen
// after PIN validation. Activates the Quidax swap_quotation pipeline:
//
//   1. Resolves the user's fiat account id (NGN) from AccountCardsSummaryCubit.
//   2. Calls cubit.createSwapQuote → server holds funds, pushes float, mints
//      a 15s locked quote.
//   3. Shows the QuoteTimerCard modal — ticks 15s, auto-refreshes at t-2s.
//   4. User taps Confirm in the sheet → cubit.confirmSwapQuote → cubit emits
//      SwapPending (or SwapCompleted if Quidax resolved inline).
//   5. The modal pops itself on terminal state; this function then surfaces a
//      snackbar with the outcome. Receipt-style polling (pollSwapStatus) is
//      kicked off in the background when the swap stays in SwapPending.
//
// Legacy `cubit.buyCrypto` / `cubit.sellCrypto` stay live for chat/voice
// agents — only the user-facing Flutter Buy/Sell buttons route through here.
// ============================================================================

class SwapFlowResult {
  final bool initiated;
  final String? message;
  const SwapFlowResult.initiated() : initiated = true, message = null;
  const SwapFlowResult.error(this.message) : initiated = false;
}

Future<SwapFlowResult> runSwapFlow({
  required BuildContext context,
  required String side, // "buy" | "sell" | "convert"
  required String cryptoSymbol, // e.g. "usdt"
  required double fiatAmount, // major units, e.g. 1000 NGN
  // For a SELL, the exact crypto quantity the user is selling (major units,
  // e.g. 0.5 SOL). Sent as the swap `from_amount` because Quidax quotes
  // crypto->fiat with from_amount denominated in the CRYPTO. `fiatAmount`
  // remains the fiat proceeds, used only for the min-order pre-check + display.
  // Ignored for buy (from = fiat) and convert (uses fromCryptoSymbol path).
  double cryptoAmount = 0,
  // When empty, resolved from LocaleManager.currentCurrency below.
  // Defaulting to a hardcoded "ngn" used to silently label every GHS
  // user's trade as NGN — the user's active locale is the source of truth.
  String fiatCurrency = '',
  // PR9d — for "convert" callers, this is the from-side crypto symbol.
  // The dispatcher then routes the saga as a crypto-to-crypto swap.
  String fromCryptoSymbol = '',
  String description = '',
  // The id the PIN token is minted against (the screen's transactionId).
  // Threaded to createSwapQuote as the clientIntentId so the server row's
  // intent id equals the token's binding id → ConfirmSwap can validate it.
  String clientIntentId = '',
  // Called when the user taps Confirm on the QUOTE sheet — shows the PIN sheet
  // and returns the verification token (null/empty if cancelled). Entering the
  // PIN finalizes the trade: the quote is shown first, then the PIN. The token
  // is minted here, right before ConfirmSwap, so it can't expire during the
  // quote countdown.
  Future<String?> Function()? requestPin,
  // Called AFTER the trade confirms and the running cubit is captured, but
  // BEFORE navigating to the processing/receipt screen. Callers launched from a
  // modal (e.g. the sell bottom sheet) use this to dismiss their sheet so the
  // processing→receipt screens land on a clean navigation stack — otherwise
  // Get.off can't replace a route sitting under an open modal and the receipt
  // never shows.
  void Function()? onBeforeProcessing,
}) async {
  if (side != 'buy' && side != 'sell' && side != 'convert') {
    return const SwapFlowResult.error('Invalid side');
  }
  // Resolve fiat from the user's active locale when the caller didn't
  // pass one explicitly. Quidax wants lowercase tickers.
  if (fiatCurrency.trim().isEmpty) {
    try {
      fiatCurrency = GetIt.I<LocaleManager>().currentCurrency.toLowerCase();
    } catch (_) {
      fiatCurrency = 'ngn'; // last-resort fallback; only when DI isn't wired
    }
  } else {
    fiatCurrency = fiatCurrency.toLowerCase();
  }

  // Min-order pre-check applies to the FROM leg only — matching the backend
  // (enforceMinOrder floors FromCurrency). For a BUY the from-leg is fiat, so
  // the NGN/USDT floor applies as a fast client pre-flight. For a SELL/CONVERT
  // the from-leg is crypto, which has NO app floor: the fiat *proceeds* must NOT
  // be gated by the buy floor — Quidax is the single source of truth for the
  // sell minimum and rejects a sub-minimum swap downstream. So only pre-check
  // buys here.
  try {
    await GetIt.I<CryptoConfigCubit>().load();
  } catch (_) {}
  final cryptoConfig = _readCryptoConfig(context);
  if (side == 'buy') {
    final minOrderError = _checkMinOrder(cryptoConfig, fiatCurrency, fiatAmount);
    if (minOrderError != null) {
      return SwapFlowResult.error(minOrderError);
    }
  }

  // Step 1 — resolve the user's primary fiat account id.
  final accountId = _resolveFiatAccountId(context, fiatCurrency);
  if (accountId == null) {
    return SwapFlowResult.error(
      'No ${fiatCurrency.toUpperCase()} account found. Please add one to continue.',
    );
  }

  final cubit = context.read<CryptoCubit>();
  final lowerFiat = fiatCurrency.toLowerCase();
  final lowerCrypto = cryptoSymbol.toLowerCase();

  // For Buy: from = fiat, to = crypto. For Sell: from = crypto, to = fiat.
  // The amount passed by the screen is always in fiat major units; for Sell
  // we still send the from_amount in crypto micro units, but the existing
  // screens express the user's intent in fiat. The saga supports either
  // direction so we route side-aware here.
  final String fromCurrency;
  final String toCurrency;
  final int fromAmountMinor;
  if (side == 'convert') {
    // PR9d — crypto-to-crypto. fromCryptoSymbol is the asset the user is
    // spending; cryptoSymbol is the asset they want to receive. The
    // `fiatAmount` parameter is reinterpreted as the from-asset major
    // units (e.g. 0.001 BTC) for "convert" mode.
    final lowerFromCrypto = fromCryptoSymbol.toLowerCase();
    if (lowerFromCrypto.isEmpty) {
      return const SwapFlowResult.error(
          'Convert requires a from-asset symbol');
    }
    if (lowerFromCrypto == lowerCrypto) {
      return const SwapFlowResult.error('Cannot convert an asset to itself');
    }
    fromCurrency = lowerFromCrypto;
    toCurrency = lowerCrypto;
    fromAmountMinor = cryptoConfig.toMinorUnits(fiatAmount, lowerFromCrypto);
  } else if (side == 'buy') {
    fromCurrency = lowerFiat;
    toCurrency = lowerCrypto;
    fromAmountMinor = cryptoConfig.toMinorUnits(fiatAmount, lowerFiat);
  } else {
    // Sell: the user is selling a specific CRYPTO quantity. Quidax quotes
    // crypto->fiat with `from_amount` denominated in the crypto, and the saga
    // reads `from_amount_minor_units` back as the crypto amount
    // (minorToDecimal(fromMinor, fromCurrency)). So we MUST send the crypto
    // quantity in the crypto's minor-unit scale — NOT the fiat proceeds.
    // (Sending the fiat value here made the backend sell a wildly wrong
    // quantity.) The fiat received and the platform spread are derived
    // server-side from the quote's to_amount; `fiatAmount` above is used only
    // for the min-order pre-check and receipt display.
    if (cryptoAmount <= 0) {
      return const SwapFlowResult.error('Enter the amount of crypto to sell.');
    }
    fromCurrency = lowerCrypto;
    toCurrency = lowerFiat;
    fromAmountMinor = cryptoConfig.toMinorUnits(cryptoAmount, lowerCrypto);
  }

  // Step 2 — create the quote. CryptoCubit emits SwapQuotePending on success
  // and SwapFailed on category error.
  // Quote is display-only — no PIN needed here. The PIN is collected on the
  // quote sheet's Confirm and finalizes the trade at ConfirmSwap.
  await cubit.createSwapQuote(
    accountId: accountId,
    side: side,
    fromCurrency: fromCurrency,
    toCurrency: toCurrency,
    fromAmountMinorUnits: fromAmountMinor,
    description: description,
    clientIntentId: clientIntentId,
  );

  // Bail early if the create failed before the modal even opens.
  if (cubit.state is SwapFailed) {
    final st = cubit.state as SwapFailed;
    // Compensation path: accounts-service released the hold (or never
    // placed one). Refresh the balance card so the user sees the real
    // state — otherwise stale "available" lingers from before the tap.
    if (context.mounted) _kickAccountSummariesRefresh(context);
    return SwapFlowResult.error(st.message);
  }
  if (cubit.state is! SwapQuotePending) {
    return const SwapFlowResult.error('Unable to create swap quote.');
  }

  // PR12 — no balance refresh here. CreateSwapQuote is display-only
  // now; the user's NGN isn't touched until they tap Confirm and the
  // saga places the hold + recomputes against Quidax. Refreshing the
  // balance card after CreateSwapQuote would be a wasted RPC (and
  // momentarily misleading — there's no hold to show).

  // Step 3 — modal: shows the quote (15s timer, auto-refresh). Its Confirm
  // triggers the PIN sheet; entering the PIN finalizes the trade via
  // confirmSwapQuote(token). Cancelling the PIN keeps the quote sheet open.
  if (!context.mounted) return const SwapFlowResult.initiated();
  await showQuoteTimerSheet(
    context,
    onConfirm: () async {
      final token = (await requestPin?.call()) ?? '';
      if (token.isEmpty) return; // PIN cancelled — leave the quote sheet up
      await cubit.confirmSwapQuote(transactionPin: token);
    },
  );
  if (!context.mounted) return const SwapFlowResult.initiated();

  // Step 4 — hand off to the processing screen. The cubit state is one of
  // SwapCompleted / SwapPending / SwapFailed after the modal popped. We
  // build the details payload here (the screen + receipt need it for
  // display) and navigate to the processing screen which polls until
  // terminal, then forwards to the crypto_receipt_screen.
  final terminal = cubit.state;
  if (terminal is SwapFailed) {
    // PR14: saga persisted the failed row + enqueued a rollback record.
    // Refresh transactions so the user sees "Trade failed" in history
    // on return to dashboard. Holdings refresh is harmless here (no
    // crypto moved on a failed buy) but cheap so we keep one call site.
    if (context.mounted) {
      unawaited(context.read<CryptoCubit>().refreshHoldingsAfterSwap());
    }
    // Compensation path: hold released by the saga, NGN restored. Same
    // refresh story as the early-fail branch above.
    if (context.mounted) _kickAccountSummariesRefresh(context);
    // Modal already closed; surface the error and let the screen recover.
    return SwapFlowResult.error(terminal.message);
  }

  // Post-confirm balance refresh: on SwapCompleted the captureHold
  // committed (balance debited; reserved cleared); on SwapPending the
  // hold remains. Either way the user-visible figures have changed
  // since the buy screen first loaded, so re-pull.
  _kickAccountSummariesRefresh(context);

  // Build the details payload for the receipt UI. We don't have all the
  // server-known numbers yet (fees, exact fill); the receipt screen
  // refreshes via cubit state on terminal.
  final details = _buildReceiptDetails(side, fromCurrency, toCurrency,
      fromAmountMinor, cryptoSymbol, fromCryptoSymbol, cubit.state);

  final transactionId = (terminal is SwapCompleted)
      ? terminal.transactionId
      : (terminal is SwapPending ? terminal.transactionId : '');
  final quidaxSwapId = (terminal is SwapCompleted)
      ? terminal.quidaxSwapId
      : (terminal is SwapPending ? terminal.quidaxSwapId : '');

  // Re-inject the SAME running cubit into the pushed route (Get.to pushes
  // OUTSIDE the crypto screen's subtree, so the CryptoCubit the receipt/
  // processing screen reads via BlocProvider isn't otherwise in scope).
  final cryptoCubit = context.read<CryptoCubit>();
  // Dismiss the caller's modal (sell bottom sheet) now that the cubit is
  // captured — the receipt/processing screen must not push over an open modal.
  onBeforeProcessing?.call();

  // ASYNC (the default) or an already-completed trade: skip the blocking
  // processing screen and go STRAIGHT to a LIVE receipt. It shows a pending
  // badge and polls ITSELF to completed — refreshing the wallet/holdings — when
  // settlement lands, so the user never waits on a spinner. Only a SYNC pending
  // trade (admin toggled sync off) keeps the wait-on-processing screen.
  final isAsyncPending = terminal is SwapPending && terminal.isAsync;
  if (terminal is SwapCompleted || isAsyncPending) {
    final receipt = CryptoTransactionReceipt(
      transactionId: transactionId,
      transactionDetails: details,
      timestamp: DateTime.now(),
      status: terminal is SwapCompleted
          ? CryptoTransactionStatus.completed
          : CryptoTransactionStatus.pending,
    );
    await Get.to(() => BlocProvider<CryptoCubit>.value(
          value: cryptoCubit,
          child: CryptoReceiptScreen(receipt: receipt),
        ));
    return const SwapFlowResult.initiated();
  }

  // SYNC pending: keep the processing screen. It polls and replaces itself with
  // the receipt on terminal (or after its safety timeout).
  await Get.to(() => BlocProvider<CryptoCubit>.value(
        value: cryptoCubit,
        child: CryptoSwapProcessingScreen(
          details: details,
          transactionId: transactionId,
          initialStatus: 'submitting',
          quidaxSwapId: quidaxSwapId,
        ),
      ));
  return const SwapFlowResult.initiated();
}

/// _buildReceiptDetails translates the dispatcher's per-side inputs into
/// the CryptoTransactionDetails shape the receipt screen expects. Some
/// fields (fees, network) are best-effort defaults; the receipt screen
/// substitutes server-known values via the cubit state observer.
CryptoTransactionDetails _buildReceiptDetails(
  String side,
  String fromCurrency,
  String toCurrency,
  int fromAmountMinor,
  String cryptoSymbol,
  String fromCryptoSymbol,
  CryptoState state,
) {
  final type = switch (side) {
    'buy' => CryptoTransactionType.buy,
    'sell' => CryptoTransactionType.sell,
    _ => CryptoTransactionType.swap,
  };

  // Pull the two legs from the terminal swap state (major-unit decimal
  // strings). Buy: from = fiat, to = crypto. Sell: from = crypto, to = fiat.
  // So the crypto amount and the fiat amount come from opposite legs depending
  // on side — a buy-centric mapping would show a sell's crypto qty as fiat.
  final isSell = side == 'sell';
  String fromAmountStr = '';
  String toAmountStr = '';
  double pricePerUnit = 0.0;
  if (state is SwapPending) {
    fromAmountStr = state.fromAmount;
    toAmountStr = state.toAmount;
  } else if (state is SwapCompleted) {
    fromAmountStr = state.fromAmount;
    toAmountStr = state.receivedAmount;
    pricePerUnit = double.tryParse(state.executionPrice) ?? 0.0;
  }

  final String cryptoAmount = isSell ? fromAmountStr : toAmountStr;
  final double fiatAmount = isSell
      ? (double.tryParse(toAmountStr) ?? 0.0)
      : (double.tryParse(fromAmountStr) ?? (fromAmountMinor.toDouble() / 100.0));

  return CryptoTransactionDetails(
    type: type,
    cryptoName: cryptoSymbol.toUpperCase(),
    cryptoSymbol: cryptoSymbol.toUpperCase(),
    cryptoAmount: cryptoAmount,
    pricePerUnit: pricePerUnit,
    fiatAmount: fiatAmount,
    networkFee: 0.0,
    tradingFee: 0.0,
    totalAmount: fiatAmount,
    paymentMethod: 'Lazervault Wallet',
    fromCrypto: type == CryptoTransactionType.swap ? fromCryptoSymbol.toUpperCase() : null,
    toCrypto: type == CryptoTransactionType.swap ? cryptoSymbol.toUpperCase() : null,
  );
}

// ----------------------------------------------------------------------------
// Helpers
// ----------------------------------------------------------------------------

String? _resolveFiatAccountId(BuildContext context, String currency) {
  try {
    final state = context.read<AccountCardsSummaryCubit>().state;
    List<dynamic> summaries;
    if (state is AccountCardsSummaryLoaded) {
      summaries = state.accountSummaries;
    } else if (state is AccountBalanceUpdated) {
      summaries = state.accountSummaries;
    } else {
      return null;
    }
    final lowerCcy = currency.toLowerCase();
    for (final s in summaries) {
      if ((s.currency as String).toLowerCase() == lowerCcy) {
        return s.id as String;
      }
    }
  } catch (_) {
    // Cubit may not be in tree (unlikely; provided at app root). Fall through.
  }
  return null;
}

// Reads the latest CryptoRuntimeConfig snapshot. Tries the widget tree first
// (preferred — picks up any screen-local override), then falls back to the
// GetIt singleton registered in DI (PR5d.5), then to embedded defaults.
CryptoRuntimeConfig _readCryptoConfig(BuildContext context) {
  try {
    return context.read<CryptoConfigCubit>().config;
  } catch (_) {}
  try {
    return GetIt.I<CryptoConfigCubit>().config;
  } catch (_) {}
  return CryptoRuntimeConfig.defaults();
}

// _checkMinOrder enforces the per-currency Quidax minimum order BEFORE the
// user types a PIN. Returns null if the amount is acceptable, otherwise a
// user-facing error string. The floor comes from CryptoConfigCubit
// (`crypto.min_order.{ccy}.minor_units` system_settings); a currency without
// a configured floor passes through (the server is the security boundary).
String? _checkMinOrder(CryptoRuntimeConfig config, String fiatCurrency, double amount) {
  final ccy = fiatCurrency.toLowerCase();
  final minMinor = config.minOrderFor(ccy);
  if (minMinor == null || minMinor <= 0) {
    return null;
  }
  final minMajor = minMinor / math.pow(10, config.decimalsFor(ccy));
  if (amount < minMajor) {
    return 'Minimum order is ${_formatMajor(minMajor, ccy)} ${ccy.toUpperCase()}.';
  }
  return null;
}

String _formatMajor(double value, String currency) {
  // NGN: no decimals; others: trim trailing zeros up to currency precision.
  if (currency.toLowerCase() == 'ngn') {
    return value.round().toString();
  }
  return value.toString();
}

// _kickAccountSummariesRefresh fires a non-blocking refresh of the
// dashboard balance card. We call this at every swap state transition
// where accounts-service mutates balances:
//   • after CreateSwapQuote (hold placed)
//   • after ConfirmSwap (hold captured → balance debited)
//   • after SwapFailed (hold released → balance restored)
// Without this the balance card lags until the user pulls-to-refresh
// because HoldFunds / CaptureHold / ReleaseHold don't publish a
// balance.changed Kafka event the BalanceWebSocketService listens to.
//
// Silent-on-error: a stale balance card is preferable to a thrown
// exception derailing the swap flow. The next manual fetch (next
// navigation / pull-to-refresh) will catch up.
void _kickAccountSummariesRefresh(BuildContext context) {
  try {
    final authState = context.read<AuthenticationCubit>().state;
    if (authState is! AuthenticationSuccess) return;
    final profile = authState.profile;
    final userId = profile.user.id;
    final accessToken = profile.session.accessToken;
    if (userId.isEmpty || accessToken.isEmpty) return;
    // Don't await — the caller is in a hot path and the balance card
    // shouldn't block UI navigation.
    unawaited(context.read<AccountCardsSummaryCubit>().fetchAccountSummaries(
          userId: userId,
          accessToken: accessToken,
        ));
  } catch (_) {
    // Cubit/context not available (shouldn't happen — both are app-root
    // providers). Swallow so we never poison the swap flow.
  }
}

// (dart:async provides `unawaited` — no local shim needed.)

// _toast and _backgroundPoll were removed when the post-modal flow moved
// to CryptoSwapProcessingScreen. The processing screen owns the polling
// loop now (3s ticks, 90s safety timeout) and renders the live status
// directly instead of relying on snackbar feedback.
