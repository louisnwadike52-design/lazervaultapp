import 'dart:io';

import 'package:flutter_test/flutter_test.dart';

/// No PDF receipt stamps "SENDER'S COPY" or "RECIPIENT'S COPY" on itself.
///
/// It printed an internal distinction onto a document people send to each other,
/// where it read as though the receipt were only partially valid — a receipt is a
/// record of one transfer, not a carbon copy of a form.
///
/// The copy TYPE still does real work and is deliberately kept: the sender's
/// version itemises the fee they paid, the recipient's shows only what arrived.
/// That difference belongs in the figures, which is where it now lives alone.
///
/// This is a repo-wide guard because the request was explicitly app-wide, across
/// every service's receipt. There are 39 PDF generators in lib/; only one ever
/// carried the caption, and a guard is what stops the next one from copying it.
void main() {
  /// Every file that builds a PDF.
  List<File> pdfGenerators() {
    final out = <File>[];
    for (final entity in Directory('lib').listSync(recursive: true)) {
      if (entity is! File || !entity.path.endsWith('.dart')) continue;
      final source = entity.readAsStringSync();
      if (source.contains('pw.Document()') ||
          source.contains('pdf.addPage') ||
          source.contains('pw.MultiPage')) {
        out.add(entity);
      }
    }
    return out;
  }

  test('there are PDF generators to check', () {
    // Guards the premise: if the detection above stops matching, every assertion
    // below passes vacuously.
    expect(pdfGenerators().length, greaterThan(20));
  });

  test('no PDF generator renders a copy caption', () {
    final offenders = <String>[];
    // Matches the caption inside a pw.Text — not a comment, and not the picker
    // sheet's own option labels, which are a legitimate way to CHOOSE which
    // receipt to generate.
    final caption = RegExp(
      r'''pw\.Text\(\s*[^)]*(Sender|Recipient)['’]?s?\s*Copy''',
      caseSensitive: false,
    );
    for (final file in pdfGenerators()) {
      final source = file.readAsStringSync();
      if (caption.hasMatch(source)) offenders.add(file.path);
      // The indirect form: a label getter whose value is the caption, rendered
      // through a variable. This is how it was actually written.
      if (source.contains('copyType.label')) offenders.add(file.path);
    }
    expect(offenders, isEmpty,
        reason: 'a receipt should not stamp our bookkeeping on itself:\n'
            '${offenders.join('\n')}');
  });

  test('the copy type still drives the fee difference', () {
    // The point of keeping the enum. Removing the caption must not have removed
    // the behaviour that made the two copies genuinely different.
    final service = File(
      'lib/src/features/tag_pay/services/tag_pay_pdf_service.dart',
    );
    expect(service.existsSync(), isTrue);
    final source = service.readAsStringSync();
    expect(source, contains('enum ReceiptCopyType'));
    expect(source, contains('bool get isRecipient'));
    expect(source, contains('copyType'),
        reason: 'the fee itemisation is still selected by the copy type');
  });

  test('the dead label getter is gone, not just unused', () {
    // Leaving a getter that renders "Sender's Copy" is how the caption finds its
    // way back onto a receipt later.
    final source = File(
      'lib/src/features/tag_pay/services/tag_pay_pdf_service.dart',
    ).readAsStringSync();
    // Narrowed to the COPY-TYPE getter. ReceiptFileFormat has its own unrelated
    // `label` ("PDF document" / "PNG image") that must stay.
    expect(
        source.contains('ReceiptCopyType.sender => "Sender\'s Copy"'), isFalse);
    expect(source.contains("Recipient's Copy"), isFalse);
  });

  test('the share subject no longer names the copy either', () {
    final source = File(
      'lib/src/features/tag_pay/services/tag_pay_pdf_service.dart',
    ).readAsStringSync();
    expect(source.contains(r'Receipt (${copyType.label})'), isFalse,
        reason: 'the file title is the first thing the recipient reads');
  });
}
