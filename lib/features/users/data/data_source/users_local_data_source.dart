import '../dto/user_dto.dart';

abstract interface class UsersLocalDataSource {
  Future<List<UserDto>> getCachedUsers();

  Future<UserDto> getCachedUserById(String id);
}

class UsersLocalDataSourceImpl implements UsersLocalDataSource {
  @override
  Future<UserDto> getCachedUserById(String id) {
    throw UnimplementedError();
  }

  @override
  Future<List<UserDto>> getCachedUsers() {
    throw UnimplementedError();
  }
}
