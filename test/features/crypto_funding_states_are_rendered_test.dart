import 'dart:io';

import 'package:flutter_test/flutter_test.dart';

/// A STATE NOBODY LISTENS FOR IS A SPINNER THAT NEVER STOPS.
///
/// `TaggedInvoiceCryptoFundingStarted` and `InvoiceCryptoFundingStarted` are
/// emitted after a crypto-funded invoice payment is authorised. They are NOT
/// success — the coin has not been sold and the invoice is not paid — and not
/// an error, so neither existing branch catches them.
///
/// Written and shipped exactly that way for a few minutes: the cubit emitted,
/// every listener fell through, and the payment screen held its spinner for
/// ever while the conversion ran. The customer had no way to learn the payment
/// was in flight. Nothing failed, nothing logged.
///
/// This is the cheapest guard that catches it: every listener that handles the
/// payment SUCCESS state must also handle the funding-started one, because
/// those are the screens a crypto-funded payment lands on.
void main() {
  String code(String path) {
    final f = File(path);
    if (!f.existsSync()) fail('missing file: $path');
    return f.readAsLinesSync().where((l) {
      final t = l.trimLeft();
      return !t.startsWith('//') && !t.startsWith('///');
    }).join('\n');
  }

  /// Every .dart under lib/ that branches on the given state name.
  List<String> filesHandling(String state) {
    final out = <String>[];
    for (final e in Directory('lib').listSync(recursive: true)) {
      if (e is! File || !e.path.endsWith('.dart')) continue;
      // The state's own declaration and the cubit that emits it are not
      // listeners; only screens are.
      if (e.path.contains('_state.dart') || e.path.contains('_cubit.dart')) {
        continue;
      }
      if (code(e.path).contains('state is $state')) out.add(e.path);
    }
    return out;
  }

  test(
      'every screen that handles a tagged-invoice payment also handles the '
      'conversion that precedes one', () {
    final success = filesHandling('TaggedInvoicePaymentSuccess').toSet();
    final funding = filesHandling('TaggedInvoiceCryptoFundingStarted').toSet();
    expect(success, isNotEmpty,
        reason: 'the success state is handled nowhere — this guard is looking '
            'at the wrong name and needs updating');
    final missing = success.difference(funding);
    expect(missing, isEmpty,
        reason: 'these screens render a completed invoice payment but not a '
            'crypto-funded one in flight, so the spinner never stops and the '
            'customer is told nothing: $missing');
  });

  test('the funding state is never treated as a success', () {
    // The distinction is the whole point: routing to the receipt, or showing
    // "paid", tells the customer the job is done in the one direction they
    // act on — they close the screen and tell the issuer it is settled.
    for (final path in filesHandling('TaggedInvoiceCryptoFundingStarted')) {
      final src = code(path);
      final i = src.indexOf('state is TaggedInvoiceCryptoFundingStarted');
      // Look only at that branch, up to the next `} else if` / end of block.
      var end = src.indexOf('} else if', i);
      if (end < 0) end = src.length;
      final branch = src.substring(i, end);
      expect(branch.contains('invoicePaymentReceipt'), isFalse,
          reason: '$path routes an in-flight conversion to the RECEIPT; there '
              'is nothing to receipt yet and it reads as "paid"');
    }
  });

  test('both cubits emit a funding state rather than reusing success', () {
    // If either cubit ever drops its dedicated state and falls back to the
    // ordinary success emit, the screens above go quiet again — and this
    // time with a false "paid" instead of a stuck spinner.
    expect(
      code(
          'lib/src/features/invoice/presentation/cubit/tagged_invoice_cubit.dart'),
      contains('TaggedInvoiceCryptoFundingStarted('),
      reason: 'the tagged cubit no longer emits the funding state',
    );
    expect(
      code('lib/src/features/invoice/presentation/cubit/invoice_cubit.dart'),
      contains('InvoiceCryptoFundingStarted('),
      reason: 'the invoice cubit no longer emits the funding state',
    );
  });
}
