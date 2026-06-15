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

  // PASTE — replace empty strings with the public VAPID keys from Firebase
  // Console. Long base64 strings (~88 chars), starting with "B".
  static const String _vapidKeyDev = '';
  static const String _vapidKeyStaging = '';
  static const String _vapidKeyProd = '';
}
