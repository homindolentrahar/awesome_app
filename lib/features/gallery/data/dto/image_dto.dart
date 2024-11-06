import 'package:awesome_app/features/gallery/domain/model/image_model.dart';

class ImageDto {
  final int? id;
  final int? width;
  final int? height;
  final String? url;
  final String? photographer;
  final String? photographerUrl;
  final int? photographerId;
  final String? avgColor;
  final ImageSrcDto? src;
  final bool? liked;
  final String? alt;

  ImageDto({
    this.id,
    this.width,
    this.height,
    this.url,
    this.photographer,
    this.photographerUrl,
    this.photographerId,
    this.avgColor,
    this.src,
    this.liked,
    this.alt,
  });

  factory ImageDto.fromJson(Map<String, dynamic> json) => ImageDto(
        id: json["id"],
        width: json["width"],
        height: json["height"],
        url: json["url"],
        photographer: json["photographer"],
        photographerUrl: json["photographer_url"],
        photographerId: json["photographer_id"],
        avgColor: json["avg_color"],
        src: json["src"] == null ? null : ImageSrcDto.fromJson(json["src"]),
        liked: json["liked"],
        alt: json["alt"],
      );

  Map<String, dynamic> toJson() => {
        "id": id,
        "width": width,
        "height": height,
        "url": url,
        "photographer": photographer,
        "photographer_url": photographerUrl,
        "photographer_id": photographerId,
        "avg_color": avgColor,
        "src": src?.toJson(),
        "liked": liked,
        "alt": alt,
      };

  ImageModel toModel() => ImageModel(
        id: id,
        width: width,
        height: height,
        url: url,
        photographer: photographer,
        photographerUrl: photographerUrl,
        photographerId: photographerId,
        avgColor: avgColor,
        src: src?.toModel(),
        liked: liked,
        alt: alt,
      );
}

class ImageSrcDto {
  final String? original;
  final String? large2X;
  final String? large;
  final String? medium;
  final String? small;
  final String? portrait;
  final String? landscape;
  final String? tiny;

  ImageSrcDto({
    this.original,
    this.large2X,
    this.large,
    this.medium,
    this.small,
    this.portrait,
    this.landscape,
    this.tiny,
  });

  factory ImageSrcDto.fromJson(Map<String, dynamic> json) => ImageSrcDto(
        original: json["original"],
        large2X: json["large2x"],
        large: json["large"],
        medium: json["medium"],
        small: json["small"],
        portrait: json["portrait"],
        landscape: json["landscape"],
        tiny: json["tiny"],
      );

  Map<String, dynamic> toJson() => {
        "original": original,
        "large2x": large2X,
        "large": large,
        "medium": medium,
        "small": small,
        "portrait": portrait,
        "landscape": landscape,
        "tiny": tiny,
      };

  ImageSrcModel toModel() => ImageSrcModel(
        original: original,
        large2X: large2X,
        large: large,
        medium: medium,
        small: small,
        portrait: portrait,
        landscape: landscape,
        tiny: tiny,
      );
}
