import 'dart:convert';

import 'package:awesome_app/core/api/response/base_list_respones.dart';
import 'package:awesome_app/core/api/response/base_respone.dart';
import 'package:awesome_app/core/error/app_error.dart';
import 'package:awesome_app/features/gallery/data/data_source/gallery_local_data_source.dart';
import 'package:awesome_app/features/gallery/data/data_source/gallery_remote_data_source.dart';
import 'package:awesome_app/features/gallery/data/dto/image_dto.dart';
import 'package:awesome_app/features/gallery/data/repository/gallery_repository_impl.dart';
import 'package:awesome_app/features/gallery/domain/model/image_model.dart';
import 'package:awesome_app/features/gallery/domain/repository/gallery_repository.dart';
import 'package:flutter_test/flutter_test.dart';
import 'package:mockito/annotations.dart';
import 'package:mockito/mockito.dart';

import '../../../core/constant/dummy_test_data.dart';
@GenerateMocks([GalleryRemoteDataSource, GalleryLocalDataSource])
import 'gallery_repository_test.mocks.dart';

void main() {
  late MockGalleryRemoteDataSource mockRemoteDataSource;
  late MockGalleryLocalDataSource mockLocalDataSource;
  late GalleryRepository repository;

  setUp(() {
    mockRemoteDataSource = MockGalleryRemoteDataSource();
    mockLocalDataSource = MockGalleryLocalDataSource();
    repository = GalleryRepositoryImpl(
      remoteDataSource: mockRemoteDataSource,
      localDataSource: mockLocalDataSource,
    );
  });

  test('should return the right side with images when statusCode is 200',
      () async {
    // Arrange
    const page = 1;
    const perPage = 10;

    when(mockRemoteDataSource.getImages(page: page, perPage: perPage))
        .thenAnswer(
      (_) async => BaseListResponse<ImageDto>.fromJson(
        json.decode(successCurratedJson),
      ),
    );

    // Act
    final result = await repository.getImages();

    // Assert
    expect(result.isRight(), true);
    expect(result.getOrElse(() => []).length, successCurratedModels.length);
    verify(mockRemoteDataSource.getImages(page: page, perPage: perPage));
  });

  test('should return the right side with single image data when id is valid',
      () async {
    // Arrange
    const id = 3573351;

    when(mockRemoteDataSource.getImageDetail(id)).thenAnswer(
      (_) async => BaseResponse<ImageDto>.fromJson(
        json.decode(successDetailPhotoJson),
      ),
    );

    // Act
    final result = await repository.getImageDetail(id);

    // Assert
    expect(result.isRight(), true);
    expect(
      result.getOrElse(() => ImageModel()).id,
      successCurratedModels.first.id,
    );
    verify(mockRemoteDataSource.getImageDetail(id));
  });

  test('should return the left side when AppError is throwed', () async {
    // Arrange
    const page = 1;
    const perPage = 10;

    when(mockRemoteDataSource.getImages(page: page, perPage: perPage))
        .thenThrow(
      AppError(message: 'Error', statusCode: 500),
    );

    // Act
    final result = await repository.getImages();

    // Assert
    expect(result.isLeft(), true);
    verify(mockRemoteDataSource.getImages(page: page, perPage: perPage));
  });

  test('should return the left side when id is invalid', () async {
    // Arrange
    const id = 1;

    when(mockRemoteDataSource.getImageDetail(id)).thenThrow(
      AppError(message: "Not found", statusCode: 404),
    );

    // Act
    final result = await repository.getImageDetail(id);

    // Assert
    expect(result.isLeft(), true);
    verify(mockRemoteDataSource.getImageDetail(id));
  });
}
