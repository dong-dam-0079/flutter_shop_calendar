import 'dart:async';

import 'package:flutter/material.dart';
import 'package:shop_laptop_project/common/base/base_mixin.dart';

import '../../../common/res/colors.dart';
import '../../../config/router/utils/navigator_paths.dart';
import '../../widgets/common_bottom_navigation.dart';
import '../../widgets/common_tab_navigator.dart';

class MainView extends StatefulWidget {
  const MainView({Key? key}) : super(key: key);

  @override
  State<MainView> createState() => _MainViewState();
}

class _MainViewState extends State<MainView> with BaseMixin {
  final _navigatorKeys = {
    BottomNavItem.home: GlobalKey<NavigatorState>(),
    BottomNavItem.shop: GlobalKey<NavigatorState>(),
    BottomNavItem.favorite: GlobalKey<NavigatorState>(),
    BottomNavItem.profile: GlobalKey<NavigatorState>(),
  };
  final _navigatorObservers = {
    BottomNavItem.home: CommonNavigatorObserver(),
    BottomNavItem.shop: CommonNavigatorObserver(),
    BottomNavItem.favorite: CommonNavigatorObserver(),
    BottomNavItem.profile: CommonNavigatorObserver(),
  };
  var _currentNavItem = BottomNavItem.home;

  @override
  Widget build(BuildContext context) {
    return WillPopScope(
      onWillPop: _onWillPop,
      child: Scaffold(
        backgroundColor: ColorsRes.white,
        body: Stack(
          children: <Widget>[
            _buildOffstageNavigator(BottomNavItem.home),
            _buildOffstageNavigator(BottomNavItem.shop),
            _buildOffstageNavigator(BottomNavItem.favorite),
            _buildOffstageNavigator(BottomNavItem.profile),
          ],
        ),
        bottomNavigationBar: CommonBottomNavigation(
          currentNavItem: _currentNavItem,
          onNavItemSelected: _onNavItemSelected,
        ),
      ),
    );
  }

  Widget _buildOffstageNavigator(BottomNavItem navItem) {
    return Offstage(
      offstage: _currentNavItem != navItem,
      child: CommonTabNavigator(
        navigatorKey: _navigatorKeys[navItem]!,
        navigatorObserver: _navigatorObservers[navItem]!,
        initialRoute: _getInitialRoute(navItem),
      ),
    );
  }

  String _getInitialRoute(BottomNavItem navItem) {
    switch (navItem) {
      case BottomNavItem.home:
        return NavigatorPaths.home;
      case BottomNavItem.shop:
        return NavigatorPaths.shop;
      case BottomNavItem.favorite:
        return NavigatorPaths.favorite;
      case BottomNavItem.profile:
        return NavigatorPaths.profile;
    }
  }

  Future<bool> _onWillPop() async {
    final routeCount = _navigatorObservers[_currentNavItem]!.routeStacks.length;
    // If current route stack contains only [root] + [page not found] -> exit app
    if (routeCount <= 2) {
      return true;
    }
    return !await _navigatorKeys[_currentNavItem]!.currentState!.maybePop();
  }

  void _onNavItemSelected(BottomNavItem navItem) async {
    final routeStacks = _navigatorObservers[_currentNavItem]!.routeStacks;
    if (_currentNavItem == navItem && routeStacks.length > 2) {
      _navigatorKeys[navItem]!.currentState?.popUntil(
          (route) => route.settings.name == routeStacks[1].settings.name);
    }
    setState(() => _currentNavItem = navItem);
  }
}
