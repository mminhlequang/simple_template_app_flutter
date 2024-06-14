import 'dart:io';

import 'package:app/src/presentation/explore/widgets/widget_images_by_model.dart';
import 'package:firebase_analytics/firebase_analytics.dart';
import 'package:flutter/material.dart';
import 'package:go_router/go_router.dart';

import '../network_resources/civitai/model/model.dart';
import '../presentation/home/home_screen.dart';
import '../presentation/image_view/image_view_screen.dart';
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
  observers: <NavigatorObserver>[
    if (!Platform.isWindows)
      FirebaseAnalyticsObserver(analytics: FirebaseAnalytics.instance)
  ],
  routes: [
    GoRoute(
      name: '/',
      path: '/',
      builder: (context, state) => const HomeScreen(),
      routes: [
        GoRoute(
          name: 'image_view',
          path: 'image_view',
          pageBuilder: (context, state) => buildPageWithDefaultTransition(
            context: context,
            state: state,
            child: (state.extra as Map)['isCollectionList'] == true
                ? ImageViewCollectionScreen(
                    index: (state.extra as Map)['index'],
                  )
                : (state.extra as Map)['isExploreList'] == true
                    ? ImageViewExploreScreen(
                        index: (state.extra as Map)['index'],
                      )
                    : ImageViewScreen(
                        images: ((state.extra as Map)['images'] as List)
                            .map((e) => e as CivitaiImage)
                            .toList(),
                        index: (state.extra as Map)['index'],
                      ),
          ),
        ),
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
