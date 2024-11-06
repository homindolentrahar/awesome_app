part of 'gallery_detail_bloc.dart';

@freezed
class GalleryDetailEvent with _$GalleryDetailEvent {
  const factory GalleryDetailEvent.GetGalleryDetail(int id) = _GetGalleryDetail;
}
