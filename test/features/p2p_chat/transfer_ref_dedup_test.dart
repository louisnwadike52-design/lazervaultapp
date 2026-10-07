import 'package:flutter_test/flutter_test.dart';

/// Mirror of P2PChatCubit._baseTransferRef. Kept in the test rather than
/// exported because the cubit's copy is private — the pairs below are what
/// actually matters, and they are REAL references pulled from production on
/// 2026-10-01 for a single ₦100 payment that rendered as two bubbles.
String baseTransferRef(String ref) {
  var r = ref.trim();
  if (r.startsWith('IDEM-XFER-')) r = r.substring(10);
  for (final suffix in const ['-FROM', '-TO', '-recv']) {
    if (r.endsWith(suffix)) {
      r = r.substring(0, r.length - suffix.length);
      break;
    }
  }
  if (r.startsWith('TRF-')) r = r.substring(4);
  return r;
}

void main() {
  test('every spelling of one payment folds to the same key', () {
    // A BATCH leg. Chat stored the bare ref; the ledger wrapped it.
    const chat = 'BTF-0-1790833303-120718e4';
    const debit = 'IDEM-XFER-BTF-0-1790833303-120718e4-FROM';
    const credit = 'IDEM-XFER-BTF-0-1790833303-120718e4-TO';
    expect(baseTransferRef(debit), baseTransferRef(chat));
    expect(baseTransferRef(credit), baseTransferRef(chat));

    // A SINGLE send. Chat prefixes TRF-; the ledger wraps that whole thing.
    const chatSingle = 'TRF-transfer_d69b3f1e-ba19-4e8b-be2f-c7e5fb722d66';
    const ledgerSingle =
        'IDEM-XFER-TRF-transfer_d69b3f1e-ba19-4e8b-be2f-c7e5fb722d66-FROM';
    const bare = 'transfer_d69b3f1e-ba19-4e8b-be2f-c7e5fb722d66';
    expect(baseTransferRef(ledgerSingle), baseTransferRef(chatSingle));
    expect(baseTransferRef(bare), baseTransferRef(chatSingle));

    // Legacy received rows.
    expect(baseTransferRef('$chat-recv'), baseTransferRef(chat));
  });

  test('DIFFERENT payments never fold together', () {
    // The guard that stops the fix over-reaching: two legs of the SAME batch
    // are different payments and must both render.
    const legZero = 'BTF-0-1790833303-120718e4';
    const legTwo = 'BTF-2-1790833306-c99ec6be';
    expect(baseTransferRef(legZero), isNot(baseTransferRef(legTwo)));

    // And two unrelated single sends.
    expect(
      baseTransferRef('TRF-transfer_d69b3f1e-ba19-4e8b-be2f-c7e5fb722d66'),
      isNot(baseTransferRef('TRF-transfer_f2580382-9e06-4fa2-a91a-c6de3afd4026')),
    );
  });

  test('only ONE suffix is stripped, so a ref ending in -TO-FROM is not over-trimmed', () {
    // Defensive: the loop breaks after the first match on purpose. Stripping
    // repeatedly could eat part of a reference that legitimately ends in one
    // of these words.
    expect(baseTransferRef('IDEM-XFER-ABC-TO-FROM'), 'ABC-TO');
  });

  test('a plain reference is returned unchanged', () {
    for (final r in const ['BTF-1-123-abc', 'transfer_x', 'PAYID-9', '']) {
      expect(baseTransferRef(r), r);
    }
  });

  test('whitespace does not defeat the match', () {
    expect(baseTransferRef('  BTF-0-1-a  '), baseTransferRef('BTF-0-1-a'));
  });
}
