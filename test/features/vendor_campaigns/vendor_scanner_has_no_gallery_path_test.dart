import 'dart:io';

import 'package:flutter_test/flutter_test.dart';

/// THE REDEMPTION SCANNER MUST BE CAMERA-ONLY.
///
/// The recipients and QR-pay scanners both offer "upload from gallery", and
/// for a PAYMENT that is sound: the uploaded code runs through the same
/// parser, validation and routing as a live scan, so there is no weaker path
/// into a payment.
///
/// A REDEMPTION is a different claim. It asserts that a specific person is
/// standing at this counter right now, and a screenshot of someone else's
/// profile code proves nothing of the sort. A gallery import would turn
/// "serve this customer" into "claim for anyone whose code you have", and the
/// platform pays for every claim.
///
/// Asserted on the SOURCE because the defect would be an ADDED widget, not a
/// behaviour an existing test could exercise — there is nothing to drive if
/// the button is absent, and nothing fails if someone adds it.
void main() {
  late String src;

  setUpAll(() {
    src = File(
      'lib/src/features/vendor_campaigns/presentation/views/vendor_scan_screen.dart',
    ).readAsStringSync();
  });

  test('there is no gallery import', () {
    for (final forbidden in [
      'ImagePicker',
      'ImageSource.gallery',
      'analyzeImage',
      'pickImage',
    ]) {
      expect(src, isNot(contains(forbidden)),
          reason: '$forbidden puts a stored image on the redemption path; a '
              'screenshot of a profile code is not a customer at the door');
    }
  });

  test('there is no manual code entry either', () {
    // Same reasoning: typing an id claims a customer who may be nowhere near
    // the venue.
    expect(src, isNot(contains('TextField')),
        reason: 'a typed customer id is a claim with nobody present');
  });

  test('it uses the camera', () {
    expect(src, contains('MobileScanner'));
    expect(src, contains('Permission.camera'),
        reason: 'the camera permission must be requested, and a refusal '
            'explained, or the screen is a black rectangle');
  });

  test('a payment QR is refused with its own message', () {
    // A payment code and a profile code look identical to someone holding a
    // phone. One message for both would leave a vendor re-scanning the same
    // wrong screen all evening.
    expect(src, contains('ServerPayQr'));
    expect(src, contains('That is a payment code'));
  });

  test('a scan that did not reach the server says so', () {
    // Scans are server-authoritative. The UI must never imply a customer was
    // served when the call failed.
    expect(src, contains('Scan not recorded'));
  });
}
