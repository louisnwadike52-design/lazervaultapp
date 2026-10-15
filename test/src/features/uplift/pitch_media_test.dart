import 'package:flutter_test/flutter_test.dart';
import 'package:lazervault/src/features/uplift/presentation/widgets/uplift_widgets.dart';

/// A pitch can be an UPLOAD or a LINK, and `video_url` carries both — so every
/// reader has to ask which kind it is before deciding what to do with it.
/// Handing a YouTube or Drive page to the inline video player produces a black
/// box that never loads, which reads as a broken application rather than as
/// "this is a link".
void main() {
  group('upIsHostedMedia — ours, or somebody else\'s', () {
    test('an uploaded object is ours', () {
      expect(
        upIsHostedMedia('https://api.lazervault.app/v1/storage/objects/'
            'uplift/806fd9c5/pitch.mp4'),
        true,
      );
    });

    test('matched on the PATH, so it survives the tunnel and dev hosts', () {
      // The host moves between prod, the Cloudflare tunnel and a local run;
      // the storage path does not.
      expect(upIsHostedMedia('http://localhost:8080/v1/storage/objects/x.mp4'),
          true);
    });

    test('an external pitch host is not ours', () {
      for (final u in [
        'https://youtu.be/dQw4w9WgXcQ',
        'https://www.loom.com/share/abc',
        'https://drive.google.com/file/d/abc/view',
      ]) {
        expect(upIsHostedMedia(u), false, reason: u);
      }
    });

    test('empty is not hosted media', () {
      expect(upIsHostedMedia(''), false);
      expect(upIsHostedMedia('   '), false);
    });
  });

  group('upIsAcceptablePitchLink — this gets opened on the FUNDER\'s device', () {
    test('ordinary web addresses pass', () {
      for (final u in [
        'https://youtu.be/dQw4w9WgXcQ',
        'http://example.com/deck',
        'https://www.loom.com/share/abc123',
      ]) {
        expect(upIsAcceptablePitchLink(u), true, reason: u);
      }
    });

    test('a scheme that is not the web is refused', () {
      // The applicant controls this string and the funder taps it. A
      // javascript: or data: URL here is our problem handed to somebody else.
      for (final u in [
        'javascript:alert(1)',
        'data:text/html;base64,PHNjcmlwdD4=',
        'file:///etc/passwd',
        'ftp://example.com/x',
      ]) {
        expect(upIsAcceptablePitchLink(u), false, reason: u);
      }
    });

    test('a link must name a host', () {
      for (final u in ['https://', 'http://', 'not a url', '']) {
        expect(upIsAcceptablePitchLink(u), false, reason: u);
      }
    });
  });
}
