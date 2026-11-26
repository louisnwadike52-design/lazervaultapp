import 'package:flutter/material.dart';
import 'package:lazervault/core/utils/currency_formatter.dart';
import 'package:lazervault/src/features/crypto/domain/crypto_order_floor.dart';
import 'package:lazervault/src/features/crypto/cubit/crypto_config_cubit.dart';
import 'package:get_it/get_it.dart';

import 'package:lazervault/core/services/active_account_snapshot.dart';
import 'package:lazervault/core/services/injection_container.dart';
import 'package:lazervault/src/core/grpc/crypto_grpc_client.dart';
import 'package:lazervault/src/features/crypto_pay/domain/crypto_quote_preview.dart';
import 'package:lazervault/src/features/crypto_pay/domain/pay_source.dart';
import 'package:lazervault/src/features/crypto_pay/presentation/crypto_coverage_dialog.dart';
import 'package:lazervault/src/features/crypto_pay/presentation/crypto_conversion_sheet.dart';
import 'package:lazervault/src/features/crypto_pay/presentation/pay_with_crypto_sheet.dart';

/// THE LAST THING BEFORE THE PIN, FOR EVERY SERVICE THAT TAKES CRYPTO.
///
/// Selling crypto is irreversible — the sub→master transfer at confirm is the
/// point of no return — so everything the customer needs in order to decide
/// has to be on screen BEFORE the PIN pad, not after a refusal.
///
/// Three things were missing, and all three were reported from production:
///
///   1. NO RATE ANYWHERE. The customer chose a coin and was never shown what
///      it converts at or how much of it would be sold. They found out from
///      the receipt.
///   2. A STALE PRICE. What little was shown came from the snapshot the coin
///      picker loaded with, which may be minutes old by the time Continue is
///      pressed. This re-reads it at the moment of the decision.
///   3. ONLY SEND FUNDS ASKED. Airtime, data, electricity, cable TV, internet
///      and water went straight from Continue to the PIN pad, so their only
///      feedback was a server refusal after the PIN — the thing the send-funds
///      flow had been fixed not to do.
///
/// Returns the [PaySource] to go ahead with — which may differ from the one
/// passed in, because the customer is offered a different coin when theirs is
/// short — or null when they backed out. A null return must abort the
/// payment; it is a decision, not an error.
Future<PaySource?> confirmCryptoPayment(
  BuildContext context, {
  required PaySource source,
  required int totalMinor,
  // Resolved from the active account when a caller does not pass it, exactly
  // as PayWithCryptoSelector resolves it — so the six bill screens, which
  // never held a balance of their own, call this in one line and still get
  // the same answer the picker gave.
  int? walletMinor,
}) async {
  // Fiat needs no confirmation: nothing is being converted and nothing is
  // irreversible. Returning the source unchanged keeps every call site a
  // single line rather than an if.
  if (!source.isCrypto) return source;

  // ONE PRICING AT A TIME, WHATEVER THE CALLER'S BUTTON IS DOING.
  //
  // Each screen disables its own CTA for the duration, and that is the real
  // fix — this is the floor under it. Seven screens call this and an eighth
  // will be written; a tap that lands in the same frame as the rebuild, or a
  // caller that forgets the flag, would otherwise start a second network
  // pricing and stack a second confirmation sheet on top of the first, with
  // the customer confirming a conversion they can no longer see the figures
  // for. Returning null is the same answer as backing out, which every
  // caller already handles by abandoning the payment — nothing is converted.
  if (_pricingInFlight) return null;
  _pricingInFlight = true;
  try {
    return await _confirm(context,
        source: source, totalMinor: totalMinor, walletMinor: walletMinor);
  } finally {
    _pricingInFlight = false;
  }
}

/// Guards [confirmCryptoPayment] against overlapping pricings. A single bool
/// is enough: Dart UI code is single-threaded, so there is no interleaving
/// between the read and the write above.
bool _pricingInFlight = false;

Future<PaySource?> _confirm(
  BuildContext context, {
  required PaySource source,
  required int totalMinor,
  int? walletMinor,
}) async {
  final wallet = walletMinor ?? _activeWalletMinor();
  var current = source;

  // BOUNDED. Each pass needs a deliberate tap, but a future picker that
  // started returning without input must not be able to spin here.
  for (var attempt = 0; attempt < 5; attempt++) {
    final refreshed = await _repriced(current);
    if (!context.mounted) return null;

    final preview = CryptoQuotePreview.build(
      asset: refreshed.source.asset!,
      amountMinor: totalMinor,
      coinValueMinor: refreshed.source.assetFiatValueMinor ?? 0,
      balance: refreshed.source.assetBalance,
      stale: refreshed.stale,
    );
    // THE FLOOR THE EXCHANGE ACTUALLY ENFORCES, per coin.
    //
    // A crypto-funded payment is a SELL, so it clears the same floor the sell
    // sheet does — Quidax's minimum_order_size for THIS asset, converted to
    // fiat at the indicative rate, with the flat fiat notional as a backstop.
    // Both come from GetCryptoConfig's min_order_minor_units, which the server
    // builds as max(our config, Quidax's live floor).
    //
    // This replaced a single admin-tuned naira figure that was wrong in the
    // dangerous direction: it sat at ₦1,000 while Quidax wanted ₦1,253, so a
    // payment passed our gate and failed at theirs.
    final minFiatMinor = cryptoOrderFloorFiatMinor(
          config: GetIt.I<CryptoConfigCubit>().config,
          symbol: refreshed.source.asset!,
          fiatCurrency: CurrencySymbols.currentCurrency,
          unitPriceFiatMinor: preview.unitPriceMinor,
        ) ??
        0; // null = config not hydrated; the server remains the authority.

    final coverage = assessCoverage(
      amountMinor: totalMinor,
      coinValueMinor: refreshed.source.assetFiatValueMinor,
      walletMinor: wallet,
      minFiatMinor: minFiatMinor,
    );

    // UNPRICEABLE IS NOT INSUFFICIENT. A coin with no market, or a provider
    // that was down, means we cannot claim anything either way — and the
    // server makes the real decision. Refusing here would decline a payment
    // that would have worked; showing a sheet with no figures on it would
    // ask the customer to confirm nothing.
    if (coverage == CryptoCoverage.unknown) {
      // Unpriceable: there is no meaningful split to show, so the source goes
      // back without a quote and every reader falls back to naming the coin
      // alone. NOT a refusal — the server prices it properly at quote time.
      return refreshed.source;
    }

    final choice = await showCryptoConversionSheet(
      context,
      preview: preview,
      coverage: coverage,
      // So the sheet can NAME the floor rather than just refuse at it.
      minFiatMinor: minFiatMinor,
    );
    if (!context.mounted) return null;

    switch (choice) {
      case CoverageChoice.proceed:
        // THE PREVIEW TRAVELS WITH THE CHOICE.
        //
        // It used to end here: the sheet showed the split and the caller got
        // back only a coin symbol. Everything downstream — the PIN sheet, the
        // failure copy, the receipt, the shared PDF — then had no way to say
        // how much coin was being sold or what the wallet was topping up,
        // which is exactly what "the selected crypto is not passed down to
        // the screens and receipts" looks like from the outside.
        return PaySource.crypto(
          refreshed.source.asset!,
          assetBalance: refreshed.source.assetBalance,
          assetFiatValueMinor: refreshed.source.assetFiatValueMinor,
          quote: preview,
        );
      case CoverageChoice.cancel:
        return null;
      case CoverageChoice.pickAnother:
        final picked = await PayWithCryptoSheet.open(
          context,
          amountMinor: totalMinor,
          walletBalanceMinor: wallet ?? 0,
          current: refreshed.source.asset,
        );
        if (!context.mounted) return null;
        // BACKING OUT OF THE PICKER IS NOT CONSENT. It leaves the previous
        // coin selected and stops, rather than proceeding on a coin the
        // customer was just told is not enough.
        if (picked == null) return null;
        current = picked;
    }
  }
  return null;
}

/// The spendable balance of the active account, in kobo.
///
/// NULL IS NOT ZERO. A balance we could not read must read as unknown, and
/// assessCoverage treats unknown as "the wallet can probably finish it" —
/// because the server makes the real decision and refusing a payment on a
/// summary we failed to load would decline one that would have worked.
int? _activeWalletMinor() {
  final snap = activeAccountSnapshot();
  if (snap == null || !snap.isSpendable || snap.isProvisioning) return null;
  if (snap.balanceMajor <= 0) return 0;
  return (snap.balanceMajor * 100).round();
}

/// A source and whether its price is current.
class _Repriced {
  const _Repriced(this.source, this.stale);
  final PaySource source;
  final bool stale;
}

/// Re-read the chosen coin's value at the moment of the decision.
///
/// THE WHOLE POINT OF THIS FUNCTION IS THE FAILURE CASE. A price we could not
/// refresh must not stop the payment — the server prices it properly at quote
/// time and this is guidance — but it must also not be presented as current.
/// So a failure keeps the snapshot and returns stale=true, and the sheet says
/// the figures could not be refreshed.
Future<_Repriced> _repriced(PaySource source) async {
  final asset = (source.asset ?? '').trim().toLowerCase();
  if (asset.isEmpty) return _Repriced(source, true);
  try {
    final resp = await serviceLocator<CryptoGrpcClient>()
        .listPayableAssets()
        // A decision screen cannot hang on a ticker. Past this the snapshot
        // is used and labelled, which is strictly better than a spinner the
        // customer cannot dismiss.
        .timeout(const Duration(seconds: 6));
    for (final a in resp.assets) {
      if (a.symbol.trim().toLowerCase() != asset) continue;
      final value = a.fiatValueMinor.toInt();
      return _Repriced(
        PaySource.crypto(
          asset,
          assetBalance: a.balance,
          // Zero means "could not be priced", which must stay null — a coin
          // worth nothing and a coin we could not price are different claims.
          assetFiatValueMinor: value > 0 ? value : null,
        ),
        false,
      );
    }
    // The coin is no longer payable — delisted, or policy changed since the
    // picker loaded. The server will refuse it; saying so here is kinder than
    // the refusal, and the customer keeps the option to pick another.
    return _Repriced(
      PaySource.crypto(asset,
          assetBalance: source.assetBalance, assetFiatValueMinor: null),
      true,
    );
  } catch (_) {
    return _Repriced(source, true);
  }
}
