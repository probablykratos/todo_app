import 'package:go_router/go_router.dart';
import 'package:todo/core/routes/route_names.dart';

import '../../features/auth/presentations/view/login.dart';
import '../../features/splash/view/splash_view.dart';

final GoRouter router = GoRouter(
  routes: [
    GoRoute(
      name: RouteNames.splash,
      path: "/",
      builder: (context, state) => SplashView(),
    ),
    GoRoute(
      name: RouteNames.login,
      path: "/login",
      builder: (context, state) => LoginView(),
    ),
  ],
);
