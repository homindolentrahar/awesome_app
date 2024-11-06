part of 'images_bloc.dart';

@freezed
class ImagesEvent with _$ImagesEvent {
  const factory ImagesEvent.GetImages({
    @Default(1) int page,
    @Default(10) int perPage,
  }) = _GetImages;

  const factory ImagesEvent.ChangeView({
    @Default(GalleryViewType.list) GalleryViewType viewType,
  }) = _ChangeView;
}
