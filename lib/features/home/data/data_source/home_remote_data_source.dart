import "../../../../core/api/api_service.dart";
import "../../../../core/di/injection.dart";
import '../dto/home_dto.dart';

abstract interface class HomeRemoteDataSource {
  Future<List<HomeDto>> getHome({
    int page = 1,
    int limit = 10,
  });

  Future<HomeDto> getHomeById(String id);
}

class HomeRemoteDataSourceImpl implements HomeRemoteDataSource {
  final Future<ApiService> apiService = injector.getAsync<ApiService>();

  @override
  Future<HomeDto> getHomeById(String id) async {
    throw UnimplementedError();
  }

  @override
  Future<List<HomeDto>> getHome({
    int page = 1,
    int limit = 10,
  }) async {
    throw UnimplementedError();
  }
}
