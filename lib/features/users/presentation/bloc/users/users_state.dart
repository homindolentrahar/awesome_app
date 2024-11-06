part of 'users_bloc.dart';

@freezed
class UsersState with _$UsersState {
  const factory UsersState({
    @Default(BaseStatus.init) BaseStatus status,
    @Default([]) List<UserModel> data,
    int? statusCode,
    String? message,
    String? query,
    @Default(1) int page,
    @Default(10) int limit,
    @Default(false) bool hasMoreData,
  }) = _UsersState;
}
