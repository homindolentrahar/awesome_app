import "package:awesome_app/core/api/api_service.dart";
import "package:awesome_app/core/di/injection.dart";
import "package:awesome_app/features/users/data/dto/user_dto.dart";

abstract interface class UsersRemoteDataSource {
  Future<List<UserDto>> getUsers({
    int page = 1,
    int limit = 10,
  });
}

class UsersRemoteDataSourceImpl implements UsersRemoteDataSource {
  final Future<ApiService> apiService = injector.getAsync<ApiService>();

  @override
  Future<List<UserDto>> getUsers({
    int page = 1,
    int limit = 10,
  }) async {
    final service = await apiService;
    final result = await service.getUsers(
      page: page,
      limit: limit,
    );
    return result.data ?? [];
  }
}
