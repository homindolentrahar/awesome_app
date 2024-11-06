
import '../../domain/model/gallery_model.dart';

class GalleryDto {
  final String? id;
  final String? name; 

  GalleryDto({
    this.id,
    this.name,
  });

  factory GalleryDto.fromJson(Map<String, dynamic> json) => GalleryDto(
    id: json["id"],
    name: json["name"],
  );

  Map<String, dynamic> toJson() => {
    "id": id,
    "name": name,
  };

  GalleryModel toModel() => GalleryModel(
    id: id,
    name: name,
  );
}