import 'package:firebase_core/firebase_core.dart' show FirebaseOptions;

import 'firebase_options_dev.dart' as dev;
import 'firebase_options_prod.dart' as prod;
import 'firebase_options_staging.dart' as staging;

const _flavor = String.fromEnvironment('FLAVOR', defaultValue: 'dev');

class DefaultFirebaseOptions {
  static FirebaseOptions get currentPlatform {
    switch (_flavor) {
      case 'prod':
        return prod.DefaultFirebaseOptions.currentPlatform;
      case 'staging':
        return staging.DefaultFirebaseOptions.currentPlatform;
      case 'dev':
      default:
        return dev.DefaultFirebaseOptions.currentPlatform;
    }
  }

  static String get flavor => _flavor;

  /// VAPID public key for FCM web push. Generated per project in Firebase
  /// Console → Cloud Messaging → Web configuration → Generate key pair.
  /// Passed to FirebaseMessaging.getToken(vapidKey:) on web. Empty until
  /// the keys are generated.
  static String get vapidKey {
    switch (_flavor) {
      case 'prod':
        return _vapidKeyProd;
      case 'staging':
        return _vapidKeyStaging;
      case 'dev':
      default:
        return _vapidKeyDev;
    }
  }

  // Public VAPID keys from Firebase Console → Cloud Messaging → Web
  // configuration → Generate key pair (one per project). These identify
  // the LazerVault server to the push service for verified delivery; they
  // are NOT secrets (the private half stays in Firebase). Rotation: bump
  // the env's key in Console + replace here + commit.
  static const String _vapidKeyDev =
      'BHWDhvqYw7-xVVu-ymCvBK8aZYm2NwuVNM1BhkCDOEg4IS4tDGkDjff65kodvC0lcn6pRdH7vPb3Y1OXaFiMboU';
  static const String _vapidKeyStaging =
      'BLB0Khtw1IUSEBvpRE19khszHBPSMqbLGPe5F4wSYCEZDErLjjaRUCMMIFFAsGZghYoih5skN2DAne8QzA9_JmQ';
  static const String _vapidKeyProd =
      'BFa8GCs0KawZ09d_TfUPw5Kj-PIJrTK-AyUX1fs2cbfukHETfT8HamprOgcF-K290qJZunkMmTNS3Ap0iQQ67wg';
}
