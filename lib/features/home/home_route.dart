import 'package:go_router/go_router.dart';
import 'home_module.dart';
import 'presentation/pages/home_page.dart';

abstract class HomeRoute {
  static const String path = "/home";

  static GoRoute route = GoRoute(
    path: path,
    name: path,
    onExit: (context, state) {
      HomeModule.dispose();

      return true;
    },
    builder: (context, state) {
      HomeModule.inject();

      return const HomePage();
    },
  );
}
