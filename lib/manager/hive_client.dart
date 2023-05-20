import 'package:hive_flutter/hive_flutter.dart';
import 'package:mehonot_admin/presentation/template/template.dart';

class HiveClient {
  static const String userIdKey = 'userId';
  static const String languageKey = 'language';
  static const String divisionKey = 'division';

  static Future<Box> getBox(String box) async {
    return await Hive.openBox('testBox');
  }

  //Boxes
  static const String userBox = 'userBox';

  static String? getUserId() => Hive.box(userBox).get(userIdKey);

  static Future<void> setUserId(String userId) async {
    await Hive.box(userBox).put(userIdKey, userId);
  }

  static String? getLanguage() => Hive.box(userBox).get(languageKey);

  static Future<void> setLanguage(String language) =>
      Hive.box(userBox).put(languageKey, language);

  static String? getDivision() => Hive.box(userBox).get(divisionKey);

  static Future<void> setDivision(String division) =>
      Hive.box(userBox).put(divisionKey, division);

  //Methods
  static Future<void> init() async {
    int step = 1;
    logger('[STEP: $step] - Running initFlutter');
    await Hive.initFlutter();
    step++;
    logger('[STEP: $step] - Running Register Adapters');
    step++;
    logger('[STEP: $step] - Running Open Box $userBox');
    await Hive.openBox(userBox);
  }
}
