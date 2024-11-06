import 'package:awesome_app/core/di/injection.dart';
import 'package:awesome_app/features/users/data/data_source/users_remote_data_source.dart';
import 'package:awesome_app/features/users/data/repository/users_repository_impl.dart';
import 'package:awesome_app/features/users/domain/repository/users_repository.dart';
import 'package:awesome_app/features/users/domain/usecase/get_users_uc.dart';

abstract class UsersModule {
  static void inject() async {
    injector.registerLazySingleton<UsersRemoteDataSource>(
      () => UsersRemoteDataSourceImpl(),
    );
    injector.registerLazySingleton<UsersRepository>(
      () => UsersRepositoryImpl(remoteDataSource: injector.get()),
    );

    // Uscases
    injector.registerLazySingleton<GetUsersUc>(
      () => GetUsersUc(injector.get()),
    );
  }
}
