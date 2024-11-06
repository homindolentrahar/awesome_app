import 'dart:convert';

import 'package:awesome_app/core/api/api_service.dart';
import 'package:awesome_app/core/api/response/base_list_respones.dart';
import 'package:awesome_app/core/api/response/base_respone.dart';
import 'package:awesome_app/features/gallery/data/data_source/gallery_remote_data_source.dart';
import 'package:awesome_app/features/gallery/data/dto/image_dto.dart';
import 'package:flutter_test/flutter_test.dart';
import 'package:mockito/annotations.dart';
import 'package:mockito/mockito.dart';
import '../../../../core/constant/dummy_test_data.dart';

@GenerateMocks([ApiService])
import 'gallery_remote_data_source_test.mocks.dart';

void main() {
  late MockApiService mockApiService;
  late GalleryRemoteDataSource dataSource;

  setUp(() {
    mockApiService = MockApiService();
    dataSource = GalleryRemoteDataSourceImpl(mockApiService);
  });

  test('should return a list of images when statusCode is 200', () async {
    // Arrange
    const page = 1;
    const perPage = 10;

    when(mockApiService.getImages(page: page, perPage: perPage)).thenAnswer(
      (_) async => BaseListResponse<ImageDto>.fromJson(
        json.decode(successCurratedJson),
      ),
    );

    // Act
    final result = await dataSource.getImages();

    // Assert
    expect(result.data?.length, equals(successCurrated.data?.length));
    verify(mockApiService.getImages(page: page, perPage: perPage));
  });

  test('should return detail image when id is valid', () async {
    // Arrange
    const id = 3573351;

    when(mockApiService.getImageDetail(id: id)).thenAnswer(
      (_) async => BaseResponse<ImageDto>.fromJson(
        json.decode(successDetailPhotoJson),
      ),
    );

    // Act
    final result = await dataSource.getImageDetail(id);

    // Assert
    expect(result.data?.id, equals(successDetailPhoto.data?.id));
    verify(mockApiService.getImageDetail(id: id));
  });

  test('should return statusCode 404 when id is invalid', () async {
    // Arrange
    const id = 1;

    when(mockApiService.getImageDetail(id: id)).thenAnswer(
      (_) async => BaseResponse<ImageDto>.fromJson(
        json.decode(notFoundDetailPhotoJson),
      ),
    );

    // Act
    final result = await dataSource.getImageDetail(id);

    // Assert
    expect(result.statusCode, equals(404));
    verify(mockApiService.getImageDetail(id: id));
  });
}
