import 'dart:developer';

import 'package:awesome_app/features/gallery/data/data_source/gallery_local_data_source.dart';
import 'package:awesome_app/features/gallery/domain/model/image_model.dart';
import 'package:dartz/dartz.dart';
import '../../../../core/error/app_error.dart';
import '../../../../core/util/logger_util.dart';
import '../../../../features/gallery/data/data_source/gallery_remote_data_source.dart';
import '../../../../features/gallery/domain/repository/gallery_repository.dart';

class GalleryRepositoryImpl implements GalleryRepository {
  final GalleryRemoteDataSource remoteDataSource;
  final GalleryLocalDataSource localDataSource;

  GalleryRepositoryImpl({
    required this.remoteDataSource,
    required this.localDataSource,
  });

  @override
  Future<Either<AppError, List<ImageModel>>> getImages({
    int page = 1,
    int perPage = 10,
  }) async {
    try {
      final result = await remoteDataSource.getImages(
        page: page,
        perPage: perPage,
      );

      if (result.statusCode != 200) {
        throw AppError(
          statusCode: result.statusCode,
          message: result.message,
        );
      }

      await localDataSource.cachedImages(result.data ?? []);
      final cachedImages = await localDataSource.getCachedImages();

      if (cachedImages.isEmpty) {
        return Right(result.data?.map((e) => e.toModel()).toList() ?? []);
      }

      final list = cachedImages.map((e) => e.toModel()).toList();
      return Right(list);
    } on AppError catch (e) {
      return Left(e);
    }
  }

  @override
  Future<Either<AppError, ImageModel>> getImageDetail(int id) async {
    try {
      final result = await remoteDataSource.getImageDetail(id);

      if (result.statusCode != 200) {
        throw AppError(
          statusCode: result.statusCode,
          message: result.message,
        );
      }

      log("data: ${result.data?.toJson()}");

      if (result.data == null) {
        throw AppError(
          statusCode: 404,
          message: result.message,
        );
      }

      await localDataSource.cachedImage(result.data!);
      final cachedImage = await localDataSource.getCachedImageById(id);

      return Right(cachedImage?.toModel() ?? result.data!.toModel());
    } on AppError catch (e) {
      LoggerUtil.instance().error(e.toString());
      return Left(e);
    }
  }
}
