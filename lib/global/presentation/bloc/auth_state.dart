import 'package:awesome_app/core/constant/auth_constant.dart';

class AuthState {
  final AuthStatus status;
  final String? userId;
  final String? accessToken;

  AuthState({
    this.status = AuthStatus.init,
    this.userId,
    this.accessToken,
  });

  AuthState copyWith({
    AuthStatus? status,
    String? userId,
    String? accessToken,
  }) =>
      AuthState(
        status: status ?? this.status,
        userId: userId ?? this.userId,
        accessToken: accessToken ?? this.accessToken,
      );
}
