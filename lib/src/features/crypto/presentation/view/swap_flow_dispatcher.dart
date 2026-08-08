import 'dart:async';
import 'dart:math' as math;

import 'package:flutter/material.dart';
import 'package:lazervault/core/types/app_routes.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
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
import '../widgets/crypto_kyc_gate.dart';
import '../widgets/quote_timer_card.dart';
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
  // Called when the user taps Confirm on the QUOTE sheet. Shows the tx-PIN sheet
  // and, on a valid PIN, runs [onValidated] (the trade confirmation) INSIDE the
  // PIN sheet's own processing phase — so the spinner lives on the PIN sheet and
  // the flow goes straight to the receipt, with no intermediate buy-sheet
  // spinner (matches every other money flow). Returns true when the PIN was
  // validated and onValidated ran; false on cancel/failure. The quote is shown
  // first, then the PIN; the token is minted right before ConfirmSwap so it
  // can't expire during the quote countdown.
  Future<bool> Function(Future<void> Function(String token) onValidated)?
      requestPin,
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
  // Preventive KYC gate for every buy/sell/swap entry (single chokepoint). Shows
  // the identity-verification modal when the user's tier is too low and returns
  // a silent no-op result (null message → callers don't snackbar) so the user
  // never falls into a failed Quidax flow. The crypto-service enforces the same
  // gate server-side as the authoritative backstop.
  final tradeVerb = side == 'buy'
      ? 'buy crypto'
      : side == 'sell'
          ? 'sell crypto'
          : 'swap crypto';
  if (!await ensureCryptoTradeAllowed(context, operation: tradeVerb)) {
    return const SwapFlowResult.error(null);
  }
  if (!context.mounted) return const SwapFlowResult.error(null);
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

  // Dedicated, ISOLATED swap cubit. The swap flow's states (SwapQuotePending /
  // SwapPending / SwapCompleted) must NOT clobber the SHARED CryptoCubit that the
  // crypto landing + asset-list screens rebuild on — otherwise those screens see
  // a non-asset state and get STUCK on skeleton loaders, and the receipt
  // navigation gets confused. This fresh factory instance (registerFactory)
  // drives ONLY the quote sheet + receipt, and is closed in the finally below
  // once the receipt is dismissed. Holdings / account-summary refreshes further
  // down still target the SHARED cubit via `context` so the landing updates.
  final cubit = GetIt.I<CryptoCubit>();
  try {
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
  var confirmAttempted = false;
  // Capture the swap OUTCOME the instant confirmSwapQuote emits it. We subscribe
  // BEFORE showing the quote sheet: an unrelated emit (e.g. a holdings refresh
  // emitting CryptosLoaded) can overwrite cubit.state between the swap emit and
  // our read below, so a post-hoc cubit.state read misses the outcome and the
  // receipt/processing screen is wrongly skipped (user lands back on the asset
  // list with no confirmation). firstWhere on the pre-subscribed broadcast
  // stream resolves with the FIRST terminal swap state — SwapPending for an
  // async 'processing' confirm, SwapCompleted for a sync one — even if a later
  // emit supersedes it. Never throws: timeout / stream-close fall back to state.
  // NOTE: deliberately NO .timeout() on this subscription. The quote review +
  // PIN entry can take longer than any reasonable timeout; a countdown started
  // here would fire mid-flow and resolve to the stale pre-confirm quote state,
  // skipping the receipt and stranding the caller's sheet on a spinner. We bound
  // it at the await point below (after confirm), where the emit has landed.
  final swapOutcome = cubit.stream.firstWhere(
      (s) => s is SwapCompleted || s is SwapPending || s is SwapFailed);
  await showQuoteTimerSheet(
    context,
    cubit: cubit,
    // The tx-PIN sheet runs the confirmation in its own processing phase, so
    // confirmSwapQuote executes WHILE the PIN spinner shows and the terminal
    // swap state is emitted before the sheet closes — captured by swapOutcome.
    onConfirm: () async {
      await requestPin?.call((token) async {
        confirmAttempted = true;
        await cubit.confirmSwapQuote(transactionPin: token);
      });
    },
  );
  if (!context.mounted) return const SwapFlowResult.initiated();

  // Step 4 — hand off to the processing screen. The cubit state is one of
  // SwapCompleted / SwapPending / SwapFailed after the modal popped. We
  // build the details payload here (the screen + receipt need it for
  // display) and navigate to the processing screen which polls until
  // terminal, then forwards to the crypto_receipt_screen.
  // When the user confirmed, use the captured swap outcome (robust against the
  // state being overwritten by an unrelated emit before we read it). When they
  // cancelled the PIN, confirmSwapQuote never ran — don't await the outcome (it
  // would block until the 25s timeout); just read the current state, which stays
  // SwapQuotePending and aborts quietly below.
  var terminal = cubit.state;
  if (confirmAttempted) {
    // confirmSwapQuote ran inside the PIN's processing phase, so the terminal
    // state has effectively already been emitted; the timeout is just a backstop.
    try {
      terminal = await swapOutcome.timeout(const Duration(seconds: 20));
    } catch (_) {
      terminal = cubit.state;
    }
    if (!context.mounted) return const SwapFlowResult.initiated();
  } else {
    // No confirm (PIN cancelled) — don't await; swallow the never-resolving
    // future's error so it can't surface as an unhandled exception.
    unawaited(swapOutcome.catchError((_) => cubit.state));
  }
  // CANCELLED: the user dismissed the quote sheet or tapped Cancel on the PIN
  // before confirming, so confirmSwapQuote never ran and the state is still the
  // pre-confirm quote state (SwapQuotePending). Abort quietly — do NOT push the
  // processing/receipt screen. Only a confirmed outcome (Completed/Pending/
  // Failed) proceeds below.
  if (terminal is! SwapCompleted &&
      terminal is! SwapPending &&
      terminal is! SwapFailed) {
    return const SwapFlowResult.initiated();
  }
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

  // Inject the DEDICATED swap cubit into the pushed route (Get.to pushes OUTSIDE
  // the crypto screen's subtree, so the CryptoCubit the receipt/processing screen
  // reads via BlocProvider isn't otherwise in scope). It stays alive while the
  // receipt polls and is closed in the finally once the receipt is dismissed.
  final cryptoCubit = cubit;
  // The ROOT navigator persists across the sheet teardown; the buy/sell sheet and
  // the asset-picker route (AllAssetsScreen / UserHoldingsScreen / SwapCryptoScreen)
  // all live on it (showModalBottomSheet uses the nearest = root navigator; the
  // pickers are Get-pushed on root).
  final rootNav = Navigator.of(context, rootNavigator: true);

  // Processing already ran INSIDE the tx-PIN sheet's own phase, so EVERY confirmed
  // outcome — completed or pending, async OR sync — goes STRAIGHT to a LIVE
  // receipt. There is no separate processing/loading screen anymore: the receipt
  // shows a pending badge and polls ITSELF to completed (refreshing the wallet/
  // holdings) when settlement lands. This removes the old CryptoSwapProcessingScreen
  // and its "View in History" → history-screen path (which lost the CryptoCubit
  // scope and surfaced a cubit error).
  final receipt = CryptoTransactionReceipt(
    transactionId: transactionId,
    transactionDetails: details,
    timestamp: DateTime.now(),
    status: terminal is SwapCompleted
        ? CryptoTransactionStatus.completed
        : CryptoTransactionStatus.pending,
  );
  // Push the receipt AND tear down the still-open buy/sell sheet + the asset-picker
  // routes up to the named crypto landing in ONE atomic pushAndRemoveUntil. This is
  // deliberately done BEFORE dismissing the caller's sheet and with NO settle delay:
  // the previous "pop the sheet, wait 320ms, then push" sequence briefly REVEALED
  // the asset picker (AllAssetsScreen) between the PIN sheet closing and the receipt
  // appearing — the flash the user saw. Removing everything up to /crypto in the
  // same frame the receipt is pushed means the picker is never shown. It also keeps
  // the Back chain correct: ONE Back from the receipt returns to the crypto landing,
  // a second Back returns to the dashboard (carousel state preserved).
  await rootNav.pushAndRemoveUntil(
    MaterialPageRoute(
      builder: (_) => BlocProvider<CryptoCubit>.value(
        value: cryptoCubit,
        child: CryptoReceiptScreen(receipt: receipt),
      ),
    ),
    (route) => route.settings.name == AppRoutes.crypto || route.isFirst,
  );
  // Best-effort: if a caller's sheet somehow lived on a different navigator and
  // survived the removeUntil, let it clean up. No-op when already torn down
  // (its context is unmounted → canPop guard fails).
  onBeforeProcessing?.call();
  return const SwapFlowResult.initiated();
  } finally {
    // Close the dedicated swap cubit now that the receipt / processing screen has
    // been dismissed (the Get.to calls above are awaited). The SHARED asset-list
    // cubit is untouched. Fire-and-forget cleanup.
    unawaited(cubit.close());
  }
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

// _toast and _backgroundPoll were removed when the post-modal flow moved to a
// LIVE receipt. The receipt (crypto_receipt_screen) owns the polling loop now
// (4s ticks, 5-min window) and renders the live status directly — there is no
// intermediate processing screen; processing runs inside the tx-PIN sheet.
