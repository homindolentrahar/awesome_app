import 'package:awesome_app/features/gallery/domain/model/image_model.dart';
import 'package:dartz/dartz.dart';
import '../../../../core/error/app_error.dart';

abstract interface class GalleryRepository {
  Future<Either<AppError, List<ImageModel>>> getImages({
    int page = 1,
    int perPage = 10,
  });

  Future<Either<AppError, ImageModel>> getImageDetail(int id);
}
