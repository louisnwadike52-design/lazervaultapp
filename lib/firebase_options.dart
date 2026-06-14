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
}
