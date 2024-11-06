import 'package:awesome_app/core/constant/auth_constant.dart';
import 'package:awesome_app/core/di/injection.dart';
import 'package:awesome_app/core/util/secure_storage_util.dart';
import 'package:awesome_app/global/presentation/bloc/auth_state.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

class AuthCubit extends Cubit<AuthState> {
  final SecureStorageUtil secureStorageUtil = injector.get<SecureStorageUtil>();

  AuthCubit() : super(AuthState());

  Future<void> authenticate({
    String? userId,
    String? accessToken,
  }) async {
    await Future.wait([
      secureStorageUtil.saveUserId(userId ?? ""),
      secureStorageUtil.saveAccessToken(accessToken ?? ""),
    ]);

    emit(state.copyWith(
      status: AuthStatus.authenticated,
    ));
  }

  Future<void> logout() async {
    await secureStorageUtil.destroySession();

    emit(state.copyWith(
      status: AuthStatus.unauthenticated,
    ));
  }
}
