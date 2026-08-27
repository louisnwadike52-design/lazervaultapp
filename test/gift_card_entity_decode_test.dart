import 'package:flutter_test/flutter_test.dart';
import 'package:lazervault/src/features/gift_cards/presentation/view/widgets/rich_card_text.dart';

void main() {
  test('decodes the malformed references the live catalogue actually sends', () {
    // Real values from the production gift-card catalogue.
    expect(decodeHtmlEntities('A&233;ropostale'), 'Aéropostale');
    // &10; is a newline, and that is what the rich renderer should show.
    expect(decodeHtmlEntities('From truly original&10;designs'),
        'From truly original\ndesigns');
    // The compact one-line tiles collapse it to a space instead.
    expect(plainFromRichText('From truly original&10;designs'),
        'From truly original designs');
  });

  test('decodes well-formed numeric, hex and named entities', () {
    expect(decodeHtmlEntities('caf&#233;'), 'café');
    expect(decodeHtmlEntities('caf&#xE9;'), 'café');
    expect(decodeHtmlEntities('Ben &amp; Jerry&apos;s'), "Ben & Jerry's");
    expect(decodeHtmlEntities('50&nbsp;USD'), '50 USD');
    expect(decodeHtmlEntities('Nike&trade;'), 'Nike™');
  });

  test('leaves what it cannot resolve alone rather than corrupting it', () {
    // The old code turned every unrecognised entity into an apostrophe.
    expect(decodeHtmlEntities('&notarealentity;'), '&notarealentity;');
    expect(decodeHtmlEntities('Tom & Jerry'), 'Tom & Jerry');
    expect(decodeHtmlEntities('no entities here'), 'no entities here');
    expect(decodeHtmlEntities(''), '');
  });

  test('plain flattening strips tags AND decodes entities', () {
    expect(plainFromRichText('<span>A&233;ropostale</span> gift card'),
        'Aéropostale gift card');
  });
}
