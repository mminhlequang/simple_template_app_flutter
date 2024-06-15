import 'dart:io';

import 'package:app/src/presentation/explore/widgets/widget_images_by_model.dart';
import 'package:flutter/material.dart';
import 'package:go_router/go_router.dart';

import '../network_resources/civitai/model/model.dart';
import '../presentation/home/home_screen.dart';
import '../presentation/settings/widgets/widget_hidden_content.dart';
import 'app_get.dart';

GlobalKey<NavigatorState> get appNavigatorKey =>
    findInstance<GlobalKey<NavigatorState>>();
bool get isAppContextReady => appNavigatorKey.currentContext != null;
BuildContext get appContext => appNavigatorKey.currentContext!;

pushWidget({required child, String? routeName}) {
  return Navigator.of(appContext).push(PageRouteBuilder(
    pageBuilder: (context, animation, secondaryAnimation) => child,
    transitionsBuilder: (context, animation, secondaryAnimation, child) =>
        FadeTransition(opacity: animation, child: child),
    settings: RouteSettings(name: routeName),
  ));
}

// GoRouter configuration
final goRouter = GoRouter(
  navigatorKey: appNavigatorKey,
  initialLocation: '/',
   
  routes: [
    GoRoute(
      name: '/',
      path: '/',
      builder: (context, state) => const HomeScreen(),
      routes: [
          
        GoRoute(
          name: 'image_by_model',
          path: 'image_by_model',
          pageBuilder: (context, state) => buildPageWithDefaultTransition(
            context: context,
            state: state,
            child: const WidgetImagesByModel(),
          ),
        ),
        GoRoute(
          name: 'hidden_content',
          path: 'hidden_content',
          pageBuilder: (context, state) => buildPageWithDefaultTransition(
            context: context,
            state: state,
            child: const WidgetHiddenContent(),
          ),
        ),
      ],
    ),
  ],
);

CustomTransitionPage buildPageWithDefaultTransition<T>({
  required BuildContext context,
  required GoRouterState state,
  required Widget child,
}) {
  return CustomTransitionPage<T>(
    key: state.pageKey,
    child: child,
    transitionsBuilder: (context, animation, secondaryAnimation, child) =>
        FadeTransition(opacity: animation, child: child),
  );
}
