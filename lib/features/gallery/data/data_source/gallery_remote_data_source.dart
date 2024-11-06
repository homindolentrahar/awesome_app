import "package:awesome_app/core/api/response/base_list_respones.dart";
import "package:awesome_app/core/api/response/base_respone.dart";
import "package:awesome_app/features/gallery/data/dto/image_dto.dart";

import "../../../../core/api/api_service.dart";
import "../../../../core/di/injection.dart";

abstract interface class GalleryRemoteDataSource {
  Future<BaseListResponse<ImageDto>> getImages({
    int page = 1,
    int perPage = 10,
  });

  Future<BaseResponse<ImageDto>> getImageDetail(int id);
}

class GalleryRemoteDataSourceImpl implements GalleryRemoteDataSource {
  final Future<ApiService> apiService = injector.getAsync<ApiService>();

  @override
  Future<BaseResponse<ImageDto>> getImageDetail(int id) async {
    final service = await apiService;

    return service.getImageDetail(id: id);
  }

  @override
  Future<BaseListResponse<ImageDto>> getImages({
    int page = 1,
    int perPage = 10,
  }) async {
    final service = await apiService;

    return service.getImages(page: page, perPage: perPage);
  }
}
