import 'package:flutter/material.dart';

import '../../config/router/router.dart';

class CommonTabNavigator extends StatelessWidget {
  const CommonTabNavigator({
    Key? key,
    required this.navigatorKey,
    required this.initialRoute,
    required this.navigatorObserver,
  }) : super(key: key);

  final GlobalKey<NavigatorState> navigatorKey;
  final String initialRoute;
  final CommonNavigatorObserver navigatorObserver;

  @override
  Widget build(BuildContext context) {
    return Navigator(
      key: navigatorKey,
      onGenerateRoute: appRouter.generator,
      initialRoute: initialRoute,
      observers: [navigatorObserver],
    );
  }
}

class CommonNavigatorObserver extends NavigatorObserver {
  final List<Route<dynamic>> routeStacks = [];

  @override
  void didPop(Route route, Route? previousRoute) {
    routeStacks.removeLast();
  }

  @override
  void didPush(Route route, Route? previousRoute) {
    routeStacks.add(route);
  }

  @override
  void didRemove(Route route, Route? previousRoute) {
    routeStacks.removeLast();
  }

  @override
  void didReplace({Route? newRoute, Route? oldRoute}) {
    if (newRoute != null) {
      routeStacks.removeLast();
      routeStacks.add(newRoute);
    }
  }
}
