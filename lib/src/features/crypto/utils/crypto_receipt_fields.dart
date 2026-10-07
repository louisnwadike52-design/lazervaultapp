library;

import 'package:intl/intl.dart';

/// THE crypto receipt field set — one definition, every surface.
///
/// WHY THIS EXISTS
/// ---------------
/// The same purchase produced two different documents depending on how it was
/// opened:
///
///   from the crypto page   Description · Reference · Type · Category ·
///                          Currency · You receive · Rate · Total ·
///                          Payment method · Settlement · Custody
///
///   from transaction       Description ("crypto swap completion CRYPTO-…") ·
///   history                Balance before · Balance after · Type · Category ·
///                          Currency · Transaction ID · Asset · Paid with ·
///                          Asset amount · Order reference
///
/// Different fields, different wording, and — because each derived its total
/// from a different column — different money. The screen, the PDF and the
/// share image all inherited whichever one they were reached through.
///
/// The ledger row now carries the trade as DATA (`op`, `from_currency`,
/// `to_currency`, `from_amount`, `to_amount`, `fiat_total`, `unit_rate`,
/// `asset`, `order_reference` — see crypto-service swap_capture_metadata.go),
/// and this projects that data into the one field set above. Both entry points
/// call it, so there is nothing left to drift.
class CryptoReceiptFields {
  const CryptoReceiptFields._();

  static final NumberFormat _money = NumberFormat('#,##0.00');

  /// Canonical fiat codes. Used to tell a fiat leg from an asset leg without
  /// asking the server, which does not send the distinction on every path.
  static const Set<String> fiatCodes = {
    'NGN', 'USD', 'GBP', 'EUR', 'CAD', 'GHS', 'KES', 'ZAR', 'CNY', 'RMB',
  };

  /// Whether this ledger row is a crypto trade carrying the canonical payload.
  ///
  /// Deliberately keyed on `op` rather than on the service type: a crypto row
  /// that predates the payload has nothing to project, and projecting an empty
  /// field set over the generic rows would make OLD receipts worse. Those keep
  /// rendering exactly as they do today.
  static bool describes(Map<String, dynamic>? metadata) {
    final op = _str(metadata, 'op').toLowerCase();
    if (op.isEmpty) return false;
    if (!const {'buy', 'sell', 'convert', 'send'}.contains(op)) return false;
    // `convert`/`send` are also stamped by the crypto page itself, which does
    // not carry a fiat total — both are still crypto trades and both project.
    return _str(metadata, 'to_currency').isNotEmpty ||
        _str(metadata, 'from_currency').isNotEmpty;
  }

  /// The ordered rows, label → value. Empty when [describes] is false.
  ///
  /// [fiatSymbol] is the symbol for the row's own currency, passed in so this
  /// stays free of the app's locale singletons and testable on its own.
  /// [paymentMethod] overrides the funding wallet; when omitted it comes from
  /// the metadata, and failing that from the personal account every crypto
  /// flow debits. The fallback lives HERE rather than at each call site so the
  /// screen and the PDF cannot disagree about what funded the trade.
  static List<MapEntry<String, String>> rows(
    Map<String, dynamic>? metadata, {
    required String fiatSymbol,
    String? reference,
    String? paymentMethod,
  }) {
    if (!describes(metadata)) return const [];

    final op = _str(metadata, 'op').toLowerCase();
    final fromCcy = _str(metadata, 'from_currency').toUpperCase();
    final toCcy = _str(metadata, 'to_currency').toUpperCase();
    final fromAmt = _str(metadata, 'from_amount');
    final toAmt = _str(metadata, 'to_amount');
    final asset = _str(metadata, 'asset').toUpperCase();
    final fiatCcy = _str(metadata, 'fiat_currency').toUpperCase();
    final fiatTotal = _num(metadata, 'fiat_total');
    final unitRate = _num(metadata, 'unit_rate');
    final orderRef = _str(metadata, 'order_reference');

    final isConvert = op == 'convert';
    final isSell = op == 'sell';
    final isSend = op == 'send';

    // What the customer ends up holding, in its own unit. For a sell that is
    // the fiat; for everything else the asset.
    final assetAmountLabel = switch (op) {
      'sell' => 'You sell',
      'send' => 'You send',
      _ => 'You receive',
    };
    final assetQty = isSell || isSend ? fromAmt : toAmt;
    final assetCode = isSell || isSend
        ? (fromCcy.isNotEmpty ? fromCcy : asset)
        : (toCcy.isNotEmpty ? toCcy : asset);

    final out = <MapEntry<String, String>>[];

    void add(String label, String value) {
      if (value.trim().isEmpty) return;
      out.add(MapEntry(label, value));
    }

    // DESCRIPTION is what was traded, not the ledger's internal narration.
    // "crypto swap completion CRYPTO-93b0fc69-…" is the accounting entry's own
    // sentence; it told the customer nothing and repeated the reference.
    if (assetQty.isNotEmpty && assetCode.isNotEmpty) {
      add('Description', '$assetQty $assetCode');
    }
    final ref = (reference ?? '').trim().isNotEmpty
        ? reference!.trim()
        : orderRef;
    add('Reference', ref);
    add('Type', 'Crypto');
    add(
      'Category',
      isConvert
          ? 'Swap'
          : isSell
              ? 'Credit'
              : 'Debit',
    );
    // On a crypto→crypto trade there is no fiat leg at all, so naming one
    // currency is a lie in whichever direction you pick.
    add(
      'Currency',
      isConvert && fromCcy.isNotEmpty && toCcy.isNotEmpty
          ? '$fromCcy → $toCcy'
          : fiatCcy.isNotEmpty
              ? fiatCcy
              : (isSell ? toCcy : fromCcy),
    );
    if (isConvert) {
      if (fromAmt.isNotEmpty && fromCcy.isNotEmpty) add('From', '$fromAmt $fromCcy');
      if (toAmt.isNotEmpty && toCcy.isNotEmpty) add('To', '$toAmt $toCcy');
    } else if (assetQty.isNotEmpty && assetCode.isNotEmpty) {
      add(assetAmountLabel, '$assetQty $assetCode');
    }
    // RATE × QUANTITY REPRODUCES TOTAL. unit_rate is derived server-side from
    // the total actually moved, not from the provider quote, precisely so these
    // two rows multiply out on the page.
    if (!isConvert && unitRate > 0 && assetCode.isNotEmpty) {
      add('Rate', '1 $assetCode = $fiatSymbol${_money.format(unitRate)}');
    }
    if (!isConvert && fiatTotal > 0) {
      add('Total', '$fiatSymbol${_money.format(fiatTotal)}');
    } else if (isConvert && toAmt.isNotEmpty && toCcy.isNotEmpty) {
      add('Total', '$toAmt $toCcy');
    }
    add(
      'Payment method',
      (paymentMethod ?? '').trim().isNotEmpty
          ? paymentMethod!.trim()
          : (_str(metadata, 'payment_method').isNotEmpty
              ? _str(metadata, 'payment_method')
              : 'Personal account'),
    );
    add('Settlement', 'Instant');
    add('Custody', 'Managed by licensed partner');
    return out;
  }

  /// The raw keys this projection consumes. A caller rendering a generic
  /// metadata dump must hide these, or every value appears twice — once in a
  /// designed row and once as a snake_case key.
  static const Set<String> consumedKeys = {
    'op',
    'asset',
    'from_currency',
    'to_currency',
    'from_amount',
    'to_amount',
    'fiat_currency',
    'fiat_total',
    'unit_rate',
    'platform_fee',
    'order_reference',
    'payment_method',
    // The pre-payload spelling, still present on rows captured before this
    // shipped. Hidden rather than rendered so an old receipt degrades to the
    // generic layout instead of showing both vocabularies at once.
    'Asset',
    'Asset amount',
    'Paid with',
    'Order reference',
  };

  static String _str(Map<String, dynamic>? m, String k) =>
      (m?[k] ?? '').toString().trim();

  static double _num(Map<String, dynamic>? m, String k) {
    final v = m?[k];
    if (v is num) return v.toDouble();
    return double.tryParse('${v ?? ''}'.trim()) ?? 0;
  }
}
