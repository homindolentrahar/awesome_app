import "package:awesome_app/core/api/response/base_list_respones.dart";
import "package:awesome_app/core/api/response/base_respone.dart";
import "package:awesome_app/features/gallery/data/dto/image_dto.dart";

import "../../../../core/api/api_service.dart";

abstract interface class GalleryRemoteDataSource {
  Future<BaseListResponse<ImageDto>> getImages({
    int page = 1,
    int perPage = 10,
  });

  Future<BaseResponse<ImageDto>> getImageDetail(int id);
}

class GalleryRemoteDataSourceImpl implements GalleryRemoteDataSource {
  final ApiService apiService;

  GalleryRemoteDataSourceImpl(this.apiService);

  @override
  Future<BaseResponse<ImageDto>> getImageDetail(int id) async {
    return apiService.getImageDetail(id: id);
  }

  @override
  Future<BaseListResponse<ImageDto>> getImages({
    int page = 1,
    int perPage = 10,
  }) async {
    return apiService.getImages(page: page, perPage: perPage);
  }
}
