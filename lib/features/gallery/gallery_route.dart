import 'package:awesome_app/features/gallery/gallery_module.dart';
import 'package:awesome_app/features/gallery/presentation/pages/gallery_detail_page.dart';
import 'package:awesome_app/features/gallery/presentation/pages/gallery_page.dart';
import 'package:go_router/go_router.dart';

abstract class GalleryRoute {
  static const String path = "/gallery";

  static GoRoute route = GoRoute(
    path: path,
    name: path,
    onExit: (context, state) {
      GalleryModule.dispose();

      return true;
    },
    builder: (context, state) {
      GalleryModule.inject();

      return const GalleryPage();
    },
    routes: [
      GoRoute(
        path: ":id",
        builder: (_, state) {
          final int id = int.parse(state.pathParameters['id'] ?? "-1");

          return GalleryDetailPage(id: id);
        },
      )
    ],
  );
}
