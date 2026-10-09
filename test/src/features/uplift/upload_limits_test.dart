import 'package:flutter_test/flutter_test.dart';
import 'package:lazervault/core/config/feature_flags.dart';
import 'package:shared_preferences/shared_preferences.dart';

/// "Max uploads" was two hardcoded things: the attachment rows had NO count
/// limit at all, and the file-size ceilings were `static const _maxFileSize =
/// 10 * 1024 * 1024` inside each uploader. Changing either meant a release and
/// a store review for a number an operator should be able to turn.
///
/// These are the app-side reads. The counts are enforced again by
/// financial-products against the same keys in its own system_settings; the
/// app's copies exist so the picker can stop at the limit instead of letting
/// someone upload a file the server will reject.
void main() {
  TestWidgetsFlutterBinding.ensureInitialized();

  /// Goes through the REAL path an admin value takes: the settings snapshot
  /// arrives as a map of strings and FeatureFlags.applyRemoteSnapshot decides
  /// what to persist. Writing straight into SharedPreferences would pass even
  /// if the key were missing from the hydration list — which is exactly the
  /// link that has been forgotten before, leaving an operator saving a value
  /// the app never receives.
  Future<void> withSettings(Map<String, String> remote) async {
    SharedPreferences.setMockInitialValues({});
    await FeatureFlags.debugResetForTest();
    await FeatureFlags.applyRemoteSnapshot(remote);
  }

  group('defaults when nothing is configured', () {
    setUp(() => withSettings({}));

    test('match what financial-products enforces', () async {
      // If these drift from the Go defaults the picker shows one number and
      // the RPC enforces another.
      expect(FeatureFlags.upliftFundGalleryMaxImages, 8);
      expect(FeatureFlags.upliftApplicationMaxImages, 8);
      expect(FeatureFlags.upliftApplicationMaxDocuments, 5);
    });

    test('size ceilings match the uploaders they replaced', () async {
      expect(FeatureFlags.mediaMaxImageMb, 10);
      expect(FeatureFlags.mediaMaxVideoMb, 64);
    });
  });

  group('an admin value is honoured', () {
    test('counts', () async {
      await withSettings({
        'uplift_fund_gallery_max_images': '12',
        'uplift_application_max_images': '3',
        'uplift_application_max_documents': '1',
      });
      expect(FeatureFlags.upliftFundGalleryMaxImages, 12);
      expect(FeatureFlags.upliftApplicationMaxImages, 3);
      expect(FeatureFlags.upliftApplicationMaxDocuments, 1);
    });

    test('sizes', () async {
      await withSettings({
        'media_max_image_mb': '25',
        'media_max_video_mb': '80',
      });
      expect(FeatureFlags.mediaMaxImageMb, 25);
      expect(FeatureFlags.mediaMaxVideoMb, 80);
    });

    test('surrounding whitespace is formatting, not a bad value', () async {
      await withSettings({'media_max_image_mb': '  20  '});
      expect(FeatureFlags.mediaMaxImageMb, 20);
    });
  });

  group('a bad admin value falls back rather than breaking uploads', () {
    test('an emptied field is not "no uploads allowed"', () async {
      // Clearing the box in the dashboard must restore the default, not set a
      // limit of zero that silently disables every attachment row.
      await withSettings({
        'uplift_application_max_images': '',
        'media_max_image_mb': '0',
        'uplift_application_max_documents': '-3',
      });
      expect(FeatureFlags.upliftApplicationMaxImages, 8);
      expect(FeatureFlags.mediaMaxImageMb, 10);
      expect(FeatureFlags.upliftApplicationMaxDocuments, 5);
    });

    test('non-numeric', () async {
      await withSettings({'media_max_video_mb': 'sixty four'});
      expect(FeatureFlags.mediaMaxVideoMb, 64);
    });
  });

  group('ceilings', () {
    test('MB is capped at the Cloudflare tunnel body limit', () async {
      // Above 100MB the upload dies at the edge with Cloudflare's error page
      // instead of ours, so a larger admin value would only produce uploads
      // that cannot succeed.
      await withSettings({
        'media_max_image_mb': '500',
        'media_max_video_mb': '4096',
      });
      expect(FeatureFlags.mediaMaxImageMb, 100);
      expect(FeatureFlags.mediaMaxVideoMb, 100);
    });

    test('counts are capped where the admin validator bounds them', () async {
      // A row written straight into the DB with psql skips the validator, so
      // the ceiling has to hold on read too.
      await withSettings({
        'uplift_fund_gallery_max_images': '9999',
        'uplift_application_max_documents': '400',
      });
      expect(FeatureFlags.upliftFundGalleryMaxImages, 30);
      expect(FeatureFlags.upliftApplicationMaxDocuments, 20);
    });
  });
}
