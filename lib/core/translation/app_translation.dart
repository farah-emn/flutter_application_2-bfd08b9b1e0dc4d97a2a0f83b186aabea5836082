import 'package:get/get.dart';
import 'package:traveling/core/translation/languages/ar_language.dart';
import 'package:traveling/core/translation/languages/en_languages.dart';
import 'package:traveling/core/translation/languages/fr_languages.dart';

class AppTranslation extends Translations {
  @override
  Map<String, Map<String, String>> get keys => {
        "en_US": ENLanguage.map,
        "ar_SA": ARLanguage.map,
        "fr_FR": FRLanguage.map,
      };
}

tr(String key) => key.tr;
