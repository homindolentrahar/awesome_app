import 'package:awesome_app/features/gallery/domain/model/image_model.dart';
import 'package:cached_network_image/cached_network_image.dart';
import 'package:flutter/material.dart';

class GalleryGridItem extends StatelessWidget {
  final ImageModel data;
  final ValueChanged<int> onPressed;

  const GalleryGridItem(
      {super.key, required this.data, required this.onPressed});

  @override
  Widget build(BuildContext context) {
    return GestureDetector(
      onTap: () {
        onPressed(data.id ?? -1);
      },
      child: ShaderMask(
        blendMode: BlendMode.srcATop,
        shaderCallback: (rect) {
          return LinearGradient(
            begin: Alignment.bottomCenter,
            end: Alignment.topCenter,
            colors: [
              Colors.black.withOpacity(0.90),
              Colors.black.withOpacity(0.10),
            ],
          ).createShader(rect);
        },
        child: CachedNetworkImage(
          imageUrl: data.src?.medium ?? "",
          fit: BoxFit.cover,
        ),
      ),
    );
  }
}
