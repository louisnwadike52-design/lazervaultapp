import 'dart:math' as math;

import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:get/get.dart';
import 'package:get_it/get_it.dart';

import '../../../account_cards_summary/cubit/account_cards_summary_cubit.dart';
import '../../../account_cards_summary/cubit/account_cards_summary_state.dart';
import '../../cubit/crypto_config_cubit.dart';
import '../../cubit/crypto_cubit.dart';
import '../../cubit/crypto_state.dart';
import '../models/crypto_transaction_models.dart';
import '../widgets/quote_timer_card.dart';
import 'crypto_swap_processing_screen.dart';

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
  String fiatCurrency = 'ngn', // Quidax convention is lowercase
  // PR9d — for "convert" callers, this is the from-side crypto symbol.
  // The dispatcher then routes the saga as a crypto-to-crypto swap.
  String fromCryptoSymbol = '',
  String description = '',
}) async {
  if (side != 'buy' && side != 'sell' && side != 'convert') {
    return const SwapFlowResult.error('Invalid side');
  }

  // Min-order pre-check (PR5a.4 + PR5d.4). Read the per-currency floor from
  // CryptoConfigCubit which mirrors `crypto.min_order.*` system_settings —
  // no hardcoded 1000 NGN / 0.9 USDT here. The server enforces the same
  // floor again as the security boundary. Best-effort load to warm the
  // cache before reading; it's idempotent under a 5-min TTL.
  try {
    await GetIt.I<CryptoConfigCubit>().load();
  } catch (_) {}
  final cryptoConfig = _readCryptoConfig(context);
  final minOrderError = _checkMinOrder(cryptoConfig, fiatCurrency, fiatAmount);
  if (minOrderError != null) {
    return SwapFlowResult.error(minOrderError);
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
    // For sell, the screen tells us the fiat value the user wants out; we
    // approximate the from-amount in crypto by the same fiat figure
    // converted to crypto minor units via the displayed price. The saga
    // returns the precise execution via the swap_transaction webhook.
    // The screen passes `fiatAmount` for both directions; we forward it as
    // the from_amount in fiat minor units to keep the contract simple. The
    // server-side spread + Quidax quote produce the exact crypto received.
    //
    // Practical effect: a Sell from this screen behaves identically to a
    // Buy from a UX standpoint — user picks fiat target, sees a quote, and
    // confirms. The saga handles the asymmetric ledger legs.
    fromCurrency = lowerCrypto;
    toCurrency = lowerFiat;
    fromAmountMinor = cryptoConfig.toMinorUnits(fiatAmount, lowerFiat);
  }

  // Step 2 — create the quote. CryptoCubit emits SwapQuotePending on success
  // and SwapFailed on category error.
  await cubit.createSwapQuote(
    accountId: accountId,
    side: side,
    fromCurrency: fromCurrency,
    toCurrency: toCurrency,
    fromAmountMinorUnits: fromAmountMinor,
    description: description,
  );

  // Bail early if the create failed before the modal even opens.
  if (cubit.state is SwapFailed) {
    final st = cubit.state as SwapFailed;
    return SwapFlowResult.error(st.message);
  }
  if (cubit.state is! SwapQuotePending) {
    return const SwapFlowResult.error('Unable to create swap quote.');
  }

  // Step 3 — modal: 15s timer, auto-refresh, Confirm/Cancel.
  if (!context.mounted) return const SwapFlowResult.initiated();
  await showQuoteTimerSheet(context);
  if (!context.mounted) return const SwapFlowResult.initiated();

  // Step 4 — hand off to the processing screen. The cubit state is one of
  // SwapCompleted / SwapPending / SwapFailed after the modal popped. We
  // build the details payload here (the screen + receipt need it for
  // display) and navigate to the processing screen which polls until
  // terminal, then forwards to the crypto_receipt_screen.
  final terminal = cubit.state;
  if (terminal is SwapFailed) {
    // Modal already closed; surface the error and let the screen recover.
    return SwapFlowResult.error(terminal.message);
  }

  // Build the details payload for the receipt UI. We don't have all the
  // server-known numbers yet (fees, exact fill); the receipt screen
  // refreshes via cubit state on terminal.
  final details = _buildReceiptDetails(side, fromCurrency, toCurrency,
      fromAmountMinor, cryptoSymbol, fromCryptoSymbol, cubit.state);

  final initialStatus = (terminal is SwapCompleted) ? 'completed' : 'submitting';
  final transactionId = (terminal is SwapCompleted)
      ? terminal.transactionId
      : (terminal is SwapPending ? terminal.transactionId : '');
  final quidaxSwapId = (terminal is SwapCompleted)
      ? terminal.quidaxSwapId
      : (terminal is SwapPending ? terminal.quidaxSwapId : '');

  // Navigate to processing screen. It polls cubit.pollSwapStatus every 3s
  // and replaces itself with the crypto_receipt_screen on terminal state.
  // Use Get.to (not offNamed) so the user can back-navigate to the buy
  // screen if they want to make another trade after seeing the receipt.
  await Get.to(() => CryptoSwapProcessingScreen(
        details: details,
        transactionId: transactionId,
        initialStatus: initialStatus,
        quidaxSwapId: quidaxSwapId,
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

  String cryptoAmount = '';
  double pricePerUnit = 0.0;
  double fiatAmount = fromAmountMinor.toDouble() / 100.0; // best-effort minor→major
  if (state is SwapPending) {
    cryptoAmount = state.toAmount;
    fiatAmount = double.tryParse(state.fromAmount) ?? fiatAmount;
  } else if (state is SwapCompleted) {
    cryptoAmount = state.receivedAmount;
    pricePerUnit = double.tryParse(state.executionPrice) ?? 0.0;
    fiatAmount = double.tryParse(state.fromAmount) ?? fiatAmount;
  }

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
    paymentMethod: 'LazerVault Wallet',
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

// _toast and _backgroundPoll were removed when the post-modal flow moved
// to CryptoSwapProcessingScreen. The processing screen owns the polling
// loop now (3s ticks, 90s safety timeout) and renders the live status
// directly instead of relying on snackbar feedback.
