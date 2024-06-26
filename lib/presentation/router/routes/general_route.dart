import 'package:go_router/go_router.dart';

import '../../pages/pages.dart';

class GeneralRoute {
  static final routes = [
    GoRoute(
      path: HomePage.path,
      name: HomePage.path,
      builder: (context, state) => const HomePage(),
    ),
  ];
}
