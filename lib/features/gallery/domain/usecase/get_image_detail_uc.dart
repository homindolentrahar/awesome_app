import 'package:awesome_app/features/gallery/domain/model/image_model.dart';
import 'package:dartz/dartz.dart';
import '../../../../core/error/app_error.dart';
import '../../../../features/gallery/domain/repository/gallery_repository.dart';

class GetImageDetailUc {
  final GalleryRepository repository;

  GetImageDetailUc(this.repository);

  Future<Either<AppError, ImageModel>> call(int id) async =>
      repository.getImageDetail(id);
}
