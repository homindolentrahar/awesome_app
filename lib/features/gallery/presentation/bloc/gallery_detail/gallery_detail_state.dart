part of 'gallery_detail_bloc.dart';

@freezed
class GalleryDetailState with _$GalleryDetailState {
  factory GalleryDetailState.init() = _Init;
  factory GalleryDetailState.loading() = _Loading;
  factory GalleryDetailState.success(ImageModel data) = _Success;
  const factory GalleryDetailState.error({
    int? statusCode,
    String? message,
  }) = _Error;
}
