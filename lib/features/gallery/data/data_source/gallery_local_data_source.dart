import 'dart:convert';

import 'package:awesome_app/core/constant/local_constant.dart';
import 'package:awesome_app/core/util/map_util.dart';
import 'package:awesome_app/features/gallery/data/dto/image_dto.dart';
import 'package:hive/hive.dart';

abstract interface class GalleryLocalDataSource {
  Future<List<ImageDto>> getCachedImages();

  Future<ImageDto?> getCachedImageById(int id);

  Future<void> cachedImages(List<ImageDto> images);

  Future<void> cachedImage(ImageDto image);
}

class GalleryLocalDataSourceImpl implements GalleryLocalDataSource {
  final Box _box;

  GalleryLocalDataSourceImpl(this._box);

  @override
  Future<ImageDto> getCachedImageById(int id) async {
    final Map<String, dynamic> cachedImage =
        convertDynamicMap(json.decode(_box.get(id.toString())));

    return ImageDto.fromJson(cachedImage);
  }

  @override
  Future<List<ImageDto>> getCachedImages() async {
    final List<dynamic> cachedList = json.decode(
      _box.get(LocalConstant.galleryImages),
    );
    final List<Map<String, dynamic>> cachedImages =
        cachedList.map((e) => convertDynamicMap(e)).toList();

    return cachedImages.map((e) => ImageDto.fromJson(e)).toList();
  }

  @override
  Future<void> cachedImage(ImageDto image) async {
    await _box.put(image.id.toString(), json.encode(image.toJson()));
  }

  @override
  Future<void> cachedImages(List<ImageDto> images) async {
    await _box.put(
      LocalConstant.galleryImages,
      json.encode(images.map((e) => e.toJson()).toList()),
    );
  }
}
