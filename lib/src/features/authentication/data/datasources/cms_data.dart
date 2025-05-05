import 'package:get/get.dart';

Map<String, Map<String, String>> get data => {
      'en_US': {
        'logged_in': 'logged in as @name with email @email',
      },
      'es_ES': {
        'logged_in': 'iniciado sesión como @name con e-mail @email',
      }
    };

class CMSData extends Translations {
  @override
  Map<String, Map<String, String>> get keys => data;
}
