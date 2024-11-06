import 'dart:developer';

import 'package:awesome_app/features/gallery/domain/model/image_model.dart';
import 'package:dartz/dartz.dart';
import '../../../../core/error/app_error.dart';
import '../../../../core/util/logger_util.dart';
import '../../../../features/gallery/data/data_source/gallery_remote_data_source.dart';
import '../../../../features/gallery/domain/repository/gallery_repository.dart';

class GalleryRepositoryImpl implements GalleryRepository {
  final GalleryRemoteDataSource remoteDataSource;

  GalleryRepositoryImpl({required this.remoteDataSource});

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

      final list = result.data?.map((e) => e.toModel()).toList() ?? [];
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

      return Right(result.data!.toModel());
    } on AppError catch (e) {
      LoggerUtil.instance().error(e.toString());
      return Left(e);
    }
  }
}
