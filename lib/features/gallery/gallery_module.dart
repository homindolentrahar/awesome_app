import 'package:awesome_app/features/gallery/domain/usecase/get_image_detail_uc.dart';
import 'package:awesome_app/features/gallery/domain/usecase/get_images_uc.dart';

import '../../core/di/injection.dart';
import '../../features/gallery/data/data_source/gallery_remote_data_source.dart';
import '../../features/gallery/data/data_source/gallery_local_data_source.dart';
import '../../features/gallery/domain/repository/gallery_repository.dart';
import '../../features/gallery/data/repository/gallery_repository_impl.dart';

abstract class GalleryModule {
  static void inject() async {
    injector.registerLazySingleton<GalleryRemoteDataSource>(
      () => GalleryRemoteDataSourceImpl(),
    );
    injector.registerLazySingleton<GalleryLocalDataSource>(
      () => GalleryLocalDataSourceImpl(),
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
