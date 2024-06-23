import 'package:flutter/material.dart';
import 'package:go_router/go_router.dart';
import 'package:vtracker/features/auth/presentation/pages/login_page.dart';
import 'package:vtracker/features/auth/presentation/pages/multi_login_page.dart';
import 'package:vtracker/features/home/presentation/pages/home_page.dart';

part 'routes.dart';

class AppRouter {
  final router = GoRouter(
  initialLocation: Routes.LOGIN,
  routes: [
    GoRoute(
      path:Routes.LOGIN,
      builder: (context, state) =>const LoginPage(),
    ),
    GoRoute(
      path:Routes.MULTI_LOGIN,
      builder: (context, state) => const MultiLoginPage(),
    ),
  ],
);

}
