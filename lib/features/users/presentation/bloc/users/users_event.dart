part of 'users_bloc.dart';

@freezed
class UsersEvent with _$UsersEvent {
  const factory UsersEvent.GetUsers({
    String? query,
    @Default(1) int page,
    @Default(10) int limit,
  }) = _GetUsers;
}
