import 'package:awesome_app/core/api/api_service.dart';
import 'package:awesome_app/core/constant/local_constant.dart';
import 'package:awesome_app/features/gallery/domain/usecase/get_image_detail_uc.dart';
import 'package:awesome_app/features/gallery/domain/usecase/get_images_uc.dart';

import '../../core/di/injection.dart';
import '../../features/gallery/data/data_source/gallery_remote_data_source.dart';
import '../../features/gallery/data/data_source/gallery_local_data_source.dart';
import '../../features/gallery/domain/repository/gallery_repository.dart';
import '../../features/gallery/data/repository/gallery_repository_impl.dart';

abstract class GalleryModule {
  static const String scopeName = "GalleryModule";

  static void dispose() {
    injector.dropScope(scopeName);
  }

  static void inject() async {
    if (injector.hasScope(scopeName)) {
      return;
    }

    injector.pushNewScope(scopeName: scopeName);

    final apiService = await injector.getAsync<ApiService>();
    injector.registerLazySingleton<GalleryRemoteDataSource>(
      () => GalleryRemoteDataSourceImpl(apiService),
    );
    injector.registerLazySingleton<GalleryLocalDataSource>(
      () => GalleryLocalDataSourceImpl(
        injector.get(instanceName: LocalConstant.cache),
      ),
    );
    injector.registerLazySingleton<GalleryRepository>(
      () => GalleryRepositoryImpl(
        remoteDataSource: injector.get(),
        localDataSource: injector.get(),
      ),
    );

    // Usecases
    injector.registerLazySingleton<GetImagesUc>(
      () => GetImagesUc(injector.get()),
    );
    injector.registerLazySingleton<GetImageDetailUc>(
      () => GetImageDetailUc(injector.get()),
    );
  }
}
