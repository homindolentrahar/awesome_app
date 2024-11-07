import 'package:awesome_app/features/gallery/data/dto/image_dto.dart';
import 'package:dio/dio.dart';
import 'package:retrofit/retrofit.dart';
import 'package:awesome_app/core/api/api_dio.dart';
import 'package:awesome_app/core/api/response/base_list_respones.dart';
import 'package:awesome_app/core/api/response/base_respone.dart';

part 'api_service.g.dart';

@RestApi()
abstract class ApiService {
  factory ApiService._(Dio dio, {String? baseUrl}) = _ApiService;

  static Future<ApiService> create({
    String? baseUrl,
    Map<String, dynamic> header = const {},
    String contentType = "application/json",
  }) async {
    final newHeader = <String, dynamic>{};

    newHeader.addAll(header);

    newHeader['Authorization'] = 'PASTE API KEY HERE';

    final dio = ApiDio.getDio(
      baseUrl: baseUrl,
      header: newHeader,
      contentType: contentType,
    );

    return ApiService._(dio);
  }

  @GET("/curated")
  Future<BaseListResponse<ImageDto>> getImages({
    @Query('page') required int page,
    @Query('per_page') required int perPage,
  });

  @GET("/photos/{id}")
  Future<BaseResponse<ImageDto>> getImageDetail({
    @Path('id') required int id,
  });
}
