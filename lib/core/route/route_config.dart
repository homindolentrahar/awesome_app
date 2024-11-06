import 'package:awesome_app/core/route/routes.dart';
import 'package:awesome_app/features/gallery/gallery_route.dart';
import 'package:awesome_app/global/presentation/page/initial_page.dart';
import 'package:go_router/go_router.dart';

abstract class RouteConfig {
  static GoRouter router = GoRouter(
    initialLocation: Routes.initial,
    debugLogDiagnostics: true,
    routes: [
      GoRoute(
        path: Routes.initial,
        name: Routes.initial,
        builder: (ctx, state) => const InitialPage(),
      ),
      GalleryRoute.route,
    ],
  );
}
