import 'dart:io';
import 'package:flutter_test/flutter_test.dart';

/// THE "PAY WITH" ROW MUST MATCH THE ROWS IT SITS BETWEEN.
///
/// It is rendered on two different surfaces: the bill quick-buy sheets are
/// near-black, and the send-funds amount sheet is white. The colours were
/// hardcoded for the dark one, so on the white sheet the label was #E5E7EB on
/// #FFFFFF and the icon a pale violet — a row that read as disabled while
/// Category directly above it and Schedule / repeat directly below it were
/// solid. The operator's words: "Why is send with crypto dim and not showing
/// properly? The color should be like that of the scheduled and category rows
/// too."
///
/// So the light palette is not a taste choice, it is a match, and these pin it
/// to the very tokens those two rows use.
void main() {
  final selector = File('lib/src/features/crypto_pay/presentation/'
          'pay_with_crypto_selector.dart')
      .readAsStringSync();
  final sheet = File('lib/src/features/funds/presentation/widgets/'
          'send_funds/send_funds_amount_sheet.dart')
      .readAsStringSync();

  test('the light palette is the sibling rows\' palette', () {
    // What Category and Schedule / repeat actually paint with.
    final brand = RegExp(r'static const Color _purple = ([^;]+);')
        .firstMatch(sheet)
        ?.group(1)
        ?.trim();
    final label = RegExp(r'static const Color _textPrimary = ([^;]+);')
        .firstMatch(sheet)
        ?.group(1)
        ?.trim();
    expect(brand, isNotNull,
        reason: 'the amount sheet no longer declares _purple; this guard can '
            'no longer tell what the sibling rows look like');
    expect(label, isNotNull, reason: 'the amount sheet no longer declares '
        '_textPrimary');

    // SCOPED TO THE GETTERS, NOT THE WHOLE FILE.
    //
    // The first version of this guard asked whether the file CONTAINED the
    // colour. It passed against the restored bug: the same literal is also
    // the dialog's own accent further down, so the substring was there
    // whatever the row did. A guard that cannot fail is worse than no guard,
    // so this reads the two getters and nothing else.
    final brandGetter = RegExp(r'Color get _brand =>(.*?);', dotAll: true)
        .firstMatch(selector)
        ?.group(1);
    final labelGetter = RegExp(r'Color get _label =>(.*?);', dotAll: true)
        .firstMatch(selector)
        ?.group(1);
    expect(brandGetter, isNotNull,
        reason: 'the row no longer resolves its accent through a _brand '
            'getter, so it cannot be varying by surface');
    expect(labelGetter, isNotNull,
        reason: 'the row no longer resolves its label through a _label '
            'getter');

    expect(brandGetter!.contains(brand!), isTrue,
        reason: 'the row\'s light accent is not $brand, the colour the '
            'Category and Schedule rows use — it will not match them. '
            'Getter reads: $brandGetter');
    expect(labelGetter!.contains(label!), isTrue,
        reason: 'the row\'s light label is not $label, the colour the '
            'sibling row headings use. Getter reads: $labelGetter');
    // And both must still branch on the surface at all.
    expect(brandGetter.contains('onDarkSurface'), isTrue,
        reason: 'the accent no longer varies by surface');
    expect(labelGetter.contains('onDarkSurface'), isTrue,
        reason: 'the label no longer varies by surface');
  });

  test('the surface is declared by the caller, never defaulted', () {
    expect(selector.contains('required this.onDarkSurface'), isTrue,
        reason: 'onDarkSurface has become optional, so a new call site can '
            'silently inherit a palette built for the other surface — which '
            'is exactly how the white sheet ended up with near-white text');
    expect(RegExp(r'this\.onDarkSurface\s*=').hasMatch(selector), isFalse,
        reason: 'onDarkSurface has a default value; it must be stated');
  });

  test('every call site states which surface it is on', () {
    final dir = Directory('lib/src/features');
    final offenders = <String>[];
    var sites = 0;
    for (final f in dir.listSync(recursive: true).whereType<File>()) {
      if (!f.path.endsWith('.dart')) continue;
      if (f.path.contains('crypto_pay/presentation')) continue;
      final src = f.readAsStringSync();
      if (!src.contains('PayWithCryptoSelector(')) continue;
      sites++;
      if (!src.contains('onDarkSurface:')) offenders.add(f.path);
    }
    expect(sites, greaterThanOrEqualTo(8),
        reason: 'only $sites call sites found; the scan is not seeing them');
    expect(offenders, isEmpty,
        reason: 'these render the row without saying what it sits on:\n'
            '${offenders.join('\n')}');
  });
}
