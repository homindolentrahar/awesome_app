import 'package:awesome_app/core/constant/local_constant.dart';
import 'package:hive_flutter/adapters.dart';

abstract class Initializer {
  static Future<void> init() async {
    initLocalDb();
  }

  static void initLocalDb() async {
    await Hive.initFlutter();

    await Hive.openBox(LocalConstant.cache);
  }
}
