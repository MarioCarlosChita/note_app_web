import 'package:flutter/material.dart';
import 'package:go_router/go_router.dart';
import 'package:note_app_web/core/enums/router_path_enum.dart';
import 'package:note_app_web/core/services/guard_route_service.dart';
import 'package:note_app_web/module/app/presentation/pages/home_page.dart';
import 'package:note_app_web/module/auth/presentation/pages/login_page.dart';
import 'package:note_app_web/module/shared/pages/app_loading_page.dart';

GoRouter router = GoRouter(
  initialLocation: RoutePath.initial.path,
  redirect: (BuildContext context, GoRouterState state) {
    final bool isUserAuthenticated = GuardRouteService.isUserAuthenticated;
    final bool isLoginPath = state.fullPath == RoutePath.login.path;
    final bool isSplashPath = state.fullPath == RoutePath.initial.path;

    if (isUserAuthenticated && isLoginPath) {
      return RoutePath.home.path;
    } else if (isUserAuthenticated && !isLoginPath) {
      return null;
    } else if (!isUserAuthenticated && isSplashPath) {
      // Only for splash screen loading;
      return null;
    }
    return RoutePath.login.path;
  },
  routes: [
    GoRoute(
      path: RoutePath.initial.path,
      builder: (BuildContext context, GoRouterState state) {
        return const AppLoadingPage();
      },
    ),
    GoRoute(
      path: RoutePath.login.path,
      builder: (BuildContext context, GoRouterState state) {
        return const LoginPage();
      },
    ),
    GoRoute(
      path: RoutePath.home.path,
      builder: (BuildContext context, GoRouterState state) {
        return const HomePage();
      },
    ),
  ],
);
