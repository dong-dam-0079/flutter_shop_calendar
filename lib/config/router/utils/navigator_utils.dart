import 'package:fluro/fluro.dart';
import 'package:flutter/material.dart';

import '../../log/log.dart';
import '../router.dart';

class NavigatorUtils {
  static Future<dynamic> push(
    BuildContext context,
    String path, {
    bool replace = false,
    bool clearStack = false,
    bool rootNavigator = false,
    TransitionType transition = TransitionType.native,
    Object? sendData,
  }) async {
    unFocus();
    return await appRouter.navigateTo(
      context,
      path,
      replace: replace,
      clearStack: clearStack,
      transition: transition,
      rootNavigator: rootNavigator,
      routeSettings:
          sendData != null ? RouteSettings(arguments: sendData) : null,
    );
  }

  static void pushReplacement(
    BuildContext context,
    String path, {
    Object? sendData,
    bool rootNavigator = false,
    TransitionType transition = TransitionType.native,
  }) {
    push(
      context,
      path,
      replace: true,
      sendData: sendData,
      rootNavigator: rootNavigator,
      transition: transition,
    );
  }

  static void pushAndRemoveUntil(
    BuildContext context,
    String path, {
    Object? sendData,
    bool rootNavigator = false,
    TransitionType transition = TransitionType.native,
  }) {
    push(
      context,
      path,
      clearStack: true,
      sendData: sendData,
      rootNavigator: rootNavigator,
      transition: transition,
    );
  }

  static void pushResult(
    BuildContext context,
    String path,
    Function(Object?) onResult, {
    bool replace = false,
    bool clearStack = false,
    bool rootNavigator = false,
    TransitionType transition = TransitionType.native,
    Object? sendData,
  }) {
    unFocus();
    appRouter
        .navigateTo(
          context,
          path,
          replace: replace,
          clearStack: clearStack,
          rootNavigator: rootNavigator,
          transition: transition,
          routeSettings:
              sendData != null ? RouteSettings(arguments: sendData) : null,
        )
        .then<dynamic>((Object? result) => onResult.call(result))
        .catchError((dynamic error) => Log.e(error.toString()));
  }

  static Future<dynamic> pushWidget(
    BuildContext context,
    WidgetBuilder builder,
  ) {
    return Navigator.of(context).push<dynamic>(
      MaterialPageRoute<dynamic>(builder: builder),
    );
  }

  static void goBack(BuildContext context) {
    unFocus();
    appRouter.pop<dynamic>(context);
  }

  static void goBackWithParams(BuildContext context, Object result) {
    unFocus();
    appRouter.pop(context, result);
  }

  static void popRoot(BuildContext context,
      {Object? result, bool rootNavigator = true}) {
    if (Navigator.of(context, rootNavigator: rootNavigator).canPop()) {
      Navigator.of(context, rootNavigator: rootNavigator).pop(result);
    }
  }

  static void popUntilRouter(BuildContext context, String path) {
    Navigator.of(context).popUntil((route) => route.settings.name == path);
  }

  static void unFocus() {
    FocusManager.instance.primaryFocus?.unfocus();
  }
}
