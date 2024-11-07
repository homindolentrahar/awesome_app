import 'package:awesome_app/core/constant/local_constant.dart';
import 'package:awesome_app/features/gallery/gallery_module.dart';
import 'package:get_it/get_it.dart';
import 'package:hive/hive.dart';
import 'package:shared_preferences/shared_preferences.dart';
import 'package:flutter_secure_storage/flutter_secure_storage.dart';
import 'package:awesome_app/core/util/secure_storage_util.dart';
import 'package:awesome_app/core/api/api_service.dart';

final injector = GetIt.instance;

abstract class Injection {
  static Future<void> inject() async {
    // Declare global dependencies here
    injector.registerLazySingletonAsync(() => SharedPreferences.getInstance());
    injector.registerLazySingleton(() => const FlutterSecureStorage());

    // Global utils
    injector.registerLazySingleton(() => SecureStorageUtil.instance);

    // Global Service
    injector.registerLazySingletonAsync(() => ApiService.create());
    injector.registerLazySingleton(
      () => Hive.box(LocalConstant.cache),
      instanceName: LocalConstant.cache,
    );

    GalleryModule.inject();
  }
}
