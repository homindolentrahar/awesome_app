import '../../core/di/injection.dart';
import '../../features/home/data/data_source/home_remote_data_source.dart';
import '../../features/home/data/data_source/home_local_data_source.dart';
import '../../features/home/domain/repository/home_repository.dart';
import '../../features/home/data/repository/home_repository_impl.dart';
import '../../features/home/domain/usecase/get_home_uc.dart';

abstract class HomeModule {
  static const String scopeName = "HomeModule";

  static void dispose() {
    injector.dropScope(scopeName);
  }

  static void inject() async {
    if (injector.hasScope(scopeName)) {
      return;
    }

    injector.pushNewScope(scopeName: scopeName);

    injector.registerLazySingleton<HomeRemoteDataSource>(
      () => HomeRemoteDataSourceImpl(),
    );
    injector.registerLazySingleton<HomeLocalDataSource>(
      () => HomeLocalDataSourceImpl(),
    );
    injector.registerLazySingleton<HomeRepository>(
      () => HomeRepositoryImpl(
        remoteDataSource: injector.get(),
        localDataSource: injector.get(),
      ),
    );

    // Usecases
    injector.registerLazySingleton<GetHomeUc>(
      () => GetHomeUc(
        injector.get(),
      ),
    );
  }
}
