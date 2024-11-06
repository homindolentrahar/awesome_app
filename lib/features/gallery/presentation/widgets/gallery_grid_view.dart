import 'package:awesome_app/features/gallery/domain/model/image_model.dart';
import 'package:awesome_app/features/gallery/presentation/widgets/gallery_grid_item.dart';
import 'package:flutter/material.dart';
import 'package:flutter_staggered_grid_view/flutter_staggered_grid_view.dart';

class GalleryGridView extends StatelessWidget {
  final List<ImageModel> data;
  final ValueChanged<int> onPressed;

  const GalleryGridView({
    super.key,
    required this.data,
    required this.onPressed,
  });

  @override
  Widget build(BuildContext context) {
    return StaggeredGrid.count(
      crossAxisCount: 4,
      mainAxisSpacing: 4,
      crossAxisSpacing: 4,
      children: List.generate(
        data.length,
        (index) => StaggeredGridTile.count(
          mainAxisCellCount: index % 3 == 0 ? 2 : 1,
          crossAxisCellCount: 2,
          child: GalleryGridItem(
            data: data[index],
            onPressed: onPressed,
          ),
        ),
      ),
    );
  }
}
