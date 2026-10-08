import 'package:flutter_test/flutter_test.dart';
import 'package:lazervault/src/core/services/deep_link_service.dart';
import 'package:lazervault/src/features/ai_scan_to_pay/domain/services/scanned_code_classifier.dart';

/// The escrow offer QR, end to end through the parts that decide what happens
/// to it.
///
/// WHY THIS IS ONE TEST AND NOT THREE
///
/// Scanning an escrow offer with AI Scan to Pay crosses three components that
/// are each separately correct and could still disagree:
///
///   1. EscrowShareService mints `https://lazervault.app/escrow/offer/<token>`
///      into the QR.
///   2. ScannedCodeClassifier.lazervaultLink decides the string is one of ours.
///   3. DeepLinkService.parse decides what it points at.
///
/// AiScanCubit only forwards the link when parse returns something OTHER than
/// unknown — otherwise the scan falls through to OCR, which on a QR image finds
/// nothing, and the user gets "we couldn't read that" while holding a QR the
/// app itself printed. So a drift in any one of the three fails silently and
/// looks like a camera problem. Pinning the chain in one test is what makes
/// that drift visible.
void main() {
  final classifier = ScannedCodeClassifier();

  // The exact string EscrowShareService.shareUrlForToken builds.
  const token = 'c3f1a9d47b2e4c8fa0516d93be77ce41';
  const universal = 'https://lazervault.app/escrow/offer/$token';
  const customScheme = 'lazervault://escrow/offer/$token';

  group('an escrow offer QR survives the scan chain', () {
    test('the universal link is recognised as ours and resolves to the offer',
        () {
      final link = classifier.lazervaultLink(universal);
      expect(link, isNotNull, reason: 'scanner must claim our own URL');

      final parsed = DeepLinkService.instance.parse(link!);
      // The cubit's actual gate. Unknown here means the scan is abandoned to
      // OCR and the offer never opens.
      expect(parsed.type, isNot(DeepLinkType.unknown));
      expect(parsed.type, DeepLinkType.escrowOffer);
      expect(parsed.escrowOfferToken, token);
    });

    test('the custom-scheme form resolves identically', () {
      final link = classifier.lazervaultLink(customScheme);
      expect(link, isNotNull);
      final parsed = DeepLinkService.instance.parse(link!);
      expect(parsed.type, DeepLinkType.escrowOffer);
      expect(parsed.escrowOfferToken, token);
    });

    test('www is accepted — a shared link often gains it', () {
      final link =
          classifier.lazervaultLink('https://www.lazervault.app/escrow/offer/$token');
      expect(link, isNotNull);
      expect(DeepLinkService.instance.parse(link!).type,
          DeepLinkType.escrowOffer);
    });
  });

  group('what the scanner must NOT claim', () {
    test('a look-alike host is refused', () {
      // A suffix match would hand an attacker's URL to our own router, and the
      // router opens screens that act on the user's account.
      for (final bad in <String>[
        'https://lazervault.app.attacker.example/escrow/offer/$token',
        'https://notlazervault.app/escrow/offer/$token',
        'https://lazervault.app.evil.co/escrow/offer/$token',
      ]) {
        expect(classifier.lazervaultLink(bad), isNull, reason: bad);
      }
    });

    test('a non-http scheme is refused', () {
      expect(classifier.lazervaultLink('javascript:alert(1)'), isNull);
      expect(classifier.lazervaultLink('file:///etc/passwd'), isNull);
    });

    test('an escrow QR is not mistaken for a payable intent', () {
      // classify() is the payable-intent path. An offer link is a thing to
      // OPEN, not a thing to charge: if this ever returned an intent the user
      // would be taken to a payment confirm for an amount nobody quoted.
      expect(classifier.classify(universal), isNull);
    });
  });
}
