part of 'images_bloc.dart';

@freezed
class ImagesEvent with _$ImagesEvent {
  const factory ImagesEvent.GetImages({
    String? query,
    @Default(1) int page,
    @Default(10) int limit,
  }) = _GetImages;
}
