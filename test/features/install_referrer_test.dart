import 'package:flutter_test/flutter_test.dart';
import 'package:lazervault/core/services/install_referrer_service.dart';

/// THE ONE WAY A REFERRAL SURVIVES AN INSTALL.
///
/// A universal link only reaches the app if the app is already there — which
/// the person an invite is aimed at does not have. Play's install referrer is
/// the only field that crosses the install, so what it carries has to be read
/// correctly or the referrer earns nothing and the invitee is asked to retype a
/// code out of a chat thread.
void main() {
  group('the website format', () {
    test('reads ref=<CODE> as the site writes it', () {
      expect(referralCodeFromReferrer('ref=NOBL0KEP'), 'NOBL0KEP');
    });

    test('survives percent-encoding', () {
      // Play may hand back the value still encoded.
      expect(referralCodeFromReferrer('ref%3DNOBL0KEP'), 'NOBL0KEP');
    });

    test('is found among the UTM tags an analytics tool adds', () {
      // The referrer field is shared; our key must still be found in it.
      expect(
        referralCodeFromReferrer(
            'utm_source=whatsapp&utm_medium=social&ref=NOBL0KEP&utm_campaign=prelaunch'),
        'NOBL0KEP',
      );
      expect(
        referralCodeFromReferrer('ref=NOBL0KEP&utm_source=x'),
        'NOBL0KEP',
      );
    });
  });

  group('forms nobody controls', () {
    test('a bare value is accepted', () {
      // referrer=NOBL0KEP has no '=', which a strict parser reads as a key with
      // no value. Refusing it would lose a good attribution on a formatting
      // detail.
      expect(referralCodeFromReferrer('NOBL0KEP'), 'NOBL0KEP');
    });

    test('casing and padding are normalised', () {
      expect(referralCodeFromReferrer('ref=nobl0kep'), 'NOBL0KEP');
      expect(referralCodeFromReferrer('  ref=  nobl0kep  '), 'NOBL0KEP');
      expect(referralCodeFromReferrer('nobl0kep'), 'NOBL0KEP');
    });
  });

  group('nothing is invented', () {
    test('an organic install yields no code', () {
      // What Play returns for an install that came from a plain store visit.
      for (final raw in <String?>[
        null,
        '',
        '   ',
        'utm_source=google-play&utm_medium=organic',
      ]) {
        expect(referralCodeFromReferrer(raw), isNull,
            reason: 'organic install must not be attributed to anyone');
      }
    });

    test('a code outside the issued shape is refused', () {
      // Same bounds as the website and the deep-link path: 4..16 alphanumeric.
      expect(referralCodeFromReferrer('ref=ABC'), isNull, reason: 'too short');
      expect(referralCodeFromReferrer('ref=${'A' * 17}'), isNull, reason: 'too long');
      expect(referralCodeFromReferrer('ref=!!!!'), isNull, reason: 'no alphanumerics');
    });

    test('a different key is not mistaken for ours', () {
      expect(referralCodeFromReferrer('utm_content=NOBL0KEP'), isNull);
      expect(referralCodeFromReferrer('referral=NOBL0KEP'), isNull);
    });
  });

  group('parity with the other two paths', () {
    test('accepts exactly what a deep link accepts', () {
      // The deep link, the website and this path must agree on every string, or
      // a code works on one route and silently fails on another.
      const code = 'NOBL0KEP';
      expect(referralCodeFromReferrer('ref=$code'), code);
      expect(referralCodeFromReferrer('ref=${code.toLowerCase()}'), code);
      // Separators are stripped, matching normaliseReferralCode on the site.
      expect(referralCodeFromReferrer('ref=NOBL-0KEP'), code);
    });
  });
}
