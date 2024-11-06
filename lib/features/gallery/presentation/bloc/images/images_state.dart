part of 'images_bloc.dart';

@freezed
class ImagesState with _$ImagesState {
  const factory ImagesState({
    @Default(BaseStatus.init) BaseStatus status,
    @Default([]) List<dynamic> data,
    int? statusCode,
    String? message,
    String? query,
    @Default(1) int page,
    @Default(10) int limit,
    @Default(false) bool hasMoreData,
  }) = _ImagesState;
}
