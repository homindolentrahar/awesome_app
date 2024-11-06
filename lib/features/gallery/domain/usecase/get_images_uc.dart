import 'package:awesome_app/features/gallery/domain/model/image_model.dart';
import 'package:dartz/dartz.dart';
import '../../../../core/error/app_error.dart';
import '../../../../features/gallery/domain/repository/gallery_repository.dart';

class GetImagesUc {
  final GalleryRepository repository;

  GetImagesUc(this.repository);

  Future<Either<AppError, List<ImageModel>>> call({
    int page = 1,
    int limit = 10,
  }) async =>
      repository.getImages(page: page, perPage: limit);
}
