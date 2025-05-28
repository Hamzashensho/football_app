import 'package:flutter/material.dart';
import 'package:sport_app_user/core/utils/logger.dart';

class MyRouteObserver extends RouteObserver<PageRoute<dynamic>> {
  String? currentRouteName;

  @override
  void didPush(Route route, Route? previousRoute) {
    if (route is PageRoute) {
      currentRouteName = route.settings.name;
      AppLogger.info('Pushed route: $currentRouteName');
    }
    super.didPush(route, previousRoute);
  }

  @override
  void didPop(Route route, Route? previousRoute) {
    if (previousRoute is PageRoute) {
      currentRouteName = previousRoute.settings.name;
      AppLogger.info('Popped back to: $currentRouteName');
    }
    super.didPop(route, previousRoute);
  }
}
