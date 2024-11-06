import 'package:dio/dio.dart';
import 'package:retrofit/retrofit.dart';
import 'package:awesome_app/core/api/api_dio.dart';
import 'package:awesome_app/core/api/response/base_list_respones.dart';
import 'package:awesome_app/core/api/response/base_respone.dart';
import 'package:awesome_app/core/di/injection.dart';
import 'package:awesome_app/core/util/secure_storage_util.dart';
import 'package:awesome_app/features/users/data/dto/user_dto.dart';

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

    // Attach access token herea
    final accessToken = await injector.get<SecureStorageUtil>().accessToken;

    if (newHeader['Authorization'] == null) {
      newHeader['Authorization'] = 'Bearer $accessToken';
    }

    final dio = ApiDio.getDio(
      baseUrl: baseUrl,
      header: newHeader,
      contentType: contentType,
    );

    return ApiService._(dio);
  }

  @POST("/login")
  Future<BaseResponse> login(@Body() Map<String, dynamic> json);

  @GET("/users")
  Future<BaseListResponse<UserDto>> getUsers({
    @Query('page') int page = 1,
    @Query('per_page') int limit = 10,
  });

  @GET("/users/{id}")
  Future<BaseResponse<UserDto>> getUserById({@Path('id') required int id});
}
