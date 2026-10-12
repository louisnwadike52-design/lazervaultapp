import 'package:intl/intl.dart';

/// Projects an escrow ledger row's metadata into the rows a receipt shows.
///
/// WHY THIS EXISTS
/// ---------------
/// Every escrow ledger row ever written carried one metadata key,
/// `business_reference`. So the receipt and the share PDF had an amount, a
/// date and the sentence "Escrow funding: Laptop" — and nothing saying who the
/// other party was, what the fee was, who bore it, or which leg of the deal
/// the row actually was. Both parties got the same anonymous debit-shaped
/// document for two very different events.
///
/// escrow-service now stamps the whole deal on all three legs (the buyer's
/// funding debit, the seller's release credit, the buyer's refund credit) from
/// one builder, so the two sides cannot describe the same deal differently.
///
/// Rows written before that payload existed do not match [describes] and keep
/// rendering exactly as they do today — projecting an empty field set over
/// them would make old receipts worse, which is the same rule
/// CryptoReceiptFields follows.
class EscrowReceiptFields {
  const EscrowReceiptFields._();

  static final NumberFormat _money = NumberFormat('#,##0.00');

  /// Whether this row is an escrow leg carrying the canonical payload.
  ///
  /// Keyed on `escrow_event` rather than on the service type, for the reason
  /// in the class comment.
  static bool describes(Map<String, dynamic>? metadata) {
    final event = _str(metadata, 'escrow_event').toLowerCase();
    return const {'funded', 'released', 'refunded'}.contains(event) &&
        _str(metadata, 'escrow_reference').isNotEmpty;
  }

  /// What this leg did, in the viewer's own words. Used as the receipt's
  /// headline row so a buyer's copy and a seller's copy of one deal never
  /// read the same.
  static String headline(Map<String, dynamic>? metadata) {
    if (!describes(metadata)) return '';
    final isSeller = _str(metadata, 'escrow_role').toLowerCase() == 'seller';
    switch (_str(metadata, 'escrow_event').toLowerCase()) {
      case 'released':
        return isSeller ? 'Escrow released to you' : 'Escrow released';
      case 'refunded':
        return 'Escrow refunded to you';
      default:
        return isSeller ? 'Escrow funded' : 'Paid into escrow';
    }
  }

  /// The ordered rows, label → value.
  ///
  /// [fiatSymbol] is passed in rather than read from a locale singleton so
  /// this stays testable on its own, exactly as CryptoReceiptFields does.
  static List<MapEntry<String, String>> rows(
    Map<String, dynamic>? metadata, {
    required String fiatSymbol,
    String? reference,
  }) {
    if (!describes(metadata)) return const [];

    final event = _str(metadata, 'escrow_event').toLowerCase();
    final isSeller = _str(metadata, 'escrow_role').toLowerCase() == 'seller';
    final feePayer = _str(metadata, 'escrow_fee_payer').toLowerCase();
    final amount = _num(metadata, 'escrow_amount');
    final fee = _num(metadata, 'escrow_fee');
    final buyerTotal = _num(metadata, 'escrow_buyer_total');
    final sellerNet = _num(metadata, 'escrow_seller_net');

    final out = <MapEntry<String, String>>[];
    void add(String label, String value) {
      if (value.trim().isEmpty) return;
      out.add(MapEntry(label, value));
    }

    String cash(double v) => '$fiatSymbol${_money.format(v)}';

    add('What this is', headline(metadata));
    add('Item', _str(metadata, 'escrow_title'));
    add('Condition', _conditionLabel(_str(metadata, 'escrow_condition')));
    add('Buyer', _str(metadata, 'escrow_buyer_name'));
    add('Seller', _str(metadata, 'escrow_seller_name'));
    add('Your role', isSeller ? 'Seller' : 'Buyer');

    // The money, told as the deal rather than as one number. The item price
    // and the fee are SEPARATE facts: a ₦200 item with a ₦20 fee is not a
    // ₦220 purchase, and showing only the total is what made buyers think
    // they had been overcharged.
    if (amount > 0) add('Item price', cash(amount));
    if (fee > 0) {
      add('Escrow fee', cash(fee));
      add('Fee paid by', _feePayerLabel(feePayer));
      // Only a split needs spelling out — the other modes are already
      // unambiguous from the line above.
      if (feePayer == 'split') {
        final buyerHalf = _round2(buyerTotal - amount);
        final sellerHalf = _round2(amount - sellerNet);
        if (buyerHalf > 0) add("Fee — buyer's half", cash(buyerHalf));
        if (sellerHalf > 0) add("Fee — seller's half", cash(sellerHalf));
      }
    }
    if (buyerTotal > 0) add('Buyer paid', cash(buyerTotal));
    if (sellerNet > 0) add('Seller receives', cash(sellerNet));

    // What actually happened to the money, so a receipt read months later
    // still means something on its own.
    add('Outcome', _outcome(event, isSeller, metadata));

    add('Delivered', _date(_str(metadata, 'escrow_delivered_at')));
    add('Deadline', _date(_str(metadata, 'escrow_deadline_at')));
    add('Details', _str(metadata, 'escrow_description'));
    add('Escrow reference', _str(metadata, 'escrow_reference'));
    if ((reference ?? '').trim().isNotEmpty &&
        reference!.trim() != _str(metadata, 'escrow_reference')) {
      add('Transaction reference', reference.trim());
    }
    return out;
  }

  static String _outcome(
      String event, bool isSeller, Map<String, dynamic>? metadata) {
    final seller = _str(metadata, 'escrow_seller_name');
    final who = seller.isEmpty ? 'the seller' : seller;
    switch (event) {
      case 'released':
        return isSeller
            ? 'The buyer confirmed delivery and the money was released to you.'
            : 'You confirmed delivery and the money was released to $who.';
      case 'refunded':
        return 'The deal did not complete, so the money was returned to the '
            'buyer in full.';
      default:
        return isSeller
            ? 'The buyer has paid. Lazervault is holding the money until they '
                'confirm delivery.'
            : 'Lazervault is holding this money — $who is not paid until you '
                'confirm delivery.';
    }
  }

  static String _feePayerLabel(String feePayer) {
    switch (feePayer) {
      case 'buyer':
        return 'Buyer';
      case 'seller':
        return 'Seller';
      case 'none':
        return 'No fee';
      case 'split':
        return 'Split evenly';
      default:
        // An empty value means the deal deferred to configuration, whose
        // default is a split. Saying "buyer" there was wrong the moment the
        // default changed, so say what it resolves to.
        return feePayer.isEmpty ? 'Split evenly' : _titleCase(feePayer);
    }
  }

  static String _conditionLabel(String condition) {
    if (condition.trim().isEmpty) return '';
    return _titleCase(condition.replaceAll('_', ' '));
  }

  static String _titleCase(String s) {
    final t = s.trim();
    if (t.isEmpty) return '';
    return t[0].toUpperCase() + t.substring(1).toLowerCase();
  }

  static String _date(String iso) {
    if (iso.trim().isEmpty) return '';
    final parsed = DateTime.tryParse(iso.trim());
    if (parsed == null) return '';
    return DateFormat('d MMM yyyy, h:mm a').format(parsed.toLocal());
  }

  static double _round2(double v) => (v * 100).roundToDouble() / 100;

  static String _str(Map<String, dynamic>? m, String k) =>
      (m?[k] ?? '').toString().trim();

  static double _num(Map<String, dynamic>? m, String k) {
    final v = m?[k];
    if (v is num) return v.toDouble();
    return double.tryParse('${v ?? ''}'.trim()) ?? 0;
  }
}
