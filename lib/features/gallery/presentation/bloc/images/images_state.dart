part of 'images_bloc.dart';

@freezed
class ImagesState with _$ImagesState {
  const factory ImagesState({
    @Default(BaseStatus.init) BaseStatus status,
    @Default([]) List<ImageModel> data,
    int? statusCode,
    String? message,
    @Default(1) int page,
    @Default(10) int perPage,
    @Default(false) bool hasMoreData,
    @Default(GalleryViewType.list) GalleryViewType viewType,
  }) = _ImagesState;
}
