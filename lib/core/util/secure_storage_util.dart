import 'package:awesome_app/core/constant/local_constant.dart';
import 'package:awesome_app/core/di/injection.dart';
import 'package:flutter_secure_storage/flutter_secure_storage.dart';

class SecureStorageUtil {
  late FlutterSecureStorage _storage;

  SecureStorageUtil._() {
    _storage = injector.get<FlutterSecureStorage>();
  }

  static final SecureStorageUtil _instance = SecureStorageUtil._();

  static SecureStorageUtil get instance => _instance;

  Future<String?> get accessToken async {
    return _storage.read(key: LocalConstant.accessToken);
  }

  Future<void> saveAccessToken(String token) async {
    return _storage.write(key: LocalConstant.accessToken, value: token);
  }

  Future<String?> get userId async {
    return _storage.read(key: LocalConstant.userId);
  }

  Future<void> saveUserId(String userId) async {
    return _storage.write(key: LocalConstant.userId, value: userId);
  }

  Future<void> destroySession() async {
    await Future.wait([
      _storage.delete(key: LocalConstant.accessToken),
      _storage.delete(key: LocalConstant.userId),
    ]);
  }
}
