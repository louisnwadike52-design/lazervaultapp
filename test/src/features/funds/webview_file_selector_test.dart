import 'package:flutter_test/flutter_test.dart';
import 'package:lazervault/src/features/funds/presentation/widgets/webview_file_selector.dart';

/// "I'VE TRIED TO CLICK THESE BUTTONS AND NONE OF THEM ARE RESPONDING."
///
/// Reported 2026-11-09 by a customer stuck on Mono's documentary-verification
/// step — "Scan or Upload your NIMC Slip", which is an `<input type="file">`.
///
/// Android's WebView does not open a file picker on its own. It asks the host
/// app via onShowFileChooser, which webview_flutter_android exposes as
/// setOnShowFileSelector. Nothing in this app registered one, so the tap did
/// NOTHING — no picker, no error, no feedback. The customer had completed
/// their OTP and their BVN/NIN check and could not go further, and the app
/// gave them no reason.
///
/// These pin the accept-type decision, which is what sends somebody to a
/// camera rather than a document browser.
void main() {
  group('acceptsImages decides camera vs file browser', () {
    test('an empty accept list is NOT treated as images', () {
      // A bare <input type="file"> accepts anything. Pushing that customer
      // into a camera would be guessing at what they meant; the full picker
      // can reach a photo, a camera cannot reach a PDF.
      expect(WebViewFileSelector.acceptsImages(const []), isFalse);
      expect(WebViewFileSelector.acceptsImages(const ['']), isFalse);
      expect(WebViewFileSelector.acceptsImages(const ['  ']), isFalse);
    });

    test('an image-only accept list opts into the camera', () {
      // This is the scan-a-slip case: the document is on paper, so the camera
      // is the point of the step. Android's system document picker has no
      // camera source, which is why this distinction has to exist.
      expect(WebViewFileSelector.acceptsImages(const ['image/*']), isTrue);
      expect(
        WebViewFileSelector.acceptsImages(const ['image/jpeg', 'image/png']),
        isTrue,
      );
      expect(WebViewFileSelector.acceptsImages(const ['.jpg', '.PNG']), isTrue);
    });

    test('a mixed list falls back to the file browser', () {
      // A step that will also take a PDF must not trap the customer in a
      // camera, so anything non-image in the list wins.
      expect(
        WebViewFileSelector.acceptsImages(const ['image/*', 'application/pdf']),
        isFalse,
      );
      expect(WebViewFileSelector.acceptsImages(const ['application/pdf']), isFalse);
      expect(WebViewFileSelector.acceptsImages(const ['*/*']), isFalse);
    });

    test('casing and whitespace are not meaningful', () {
      expect(
        WebViewFileSelector.acceptsImages(const [' IMAGE/JPEG ', 'image/png']),
        isTrue,
      );
    });
  });
}
