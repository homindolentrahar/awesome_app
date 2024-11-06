import '../entity/home_entity.dart';

abstract interface class HomeLocalDataSource {
  Future<List<HomeEntity>> getCachedHome();

  Future<HomeEntity> getCachedHomeById(String id);
}

class HomeLocalDataSourceImpl implements HomeLocalDataSource {
  @override
  Future<HomeEntity> getCachedHomeById(String id) {
    throw UnimplementedError();
  }

  @override
  Future<List<HomeEntity>> getCachedHome() {
    throw UnimplementedError();
  }
}
