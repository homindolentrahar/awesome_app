import '../entity/gallery_entity.dart';

abstract interface class GalleryLocalDataSource {
  Future<List<GalleryEntity>> getCachedGallery();

  Future<GalleryEntity> getCachedGalleryById(String id);
}

class GalleryLocalDataSourceImpl implements GalleryLocalDataSource {
  @override
  Future<GalleryEntity> getCachedGalleryById(String id) {
    throw UnimplementedError();
  }

  @override
  Future<List<GalleryEntity>> getCachedGallery() {
    throw UnimplementedError();
  }
}
