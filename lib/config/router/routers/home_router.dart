import 'package:fluro/fluro.dart';
import 'package:shop_laptop_project/presentation/view/cart/cart_view.dart';
import 'package:shop_laptop_project/presentation/view/favorite/favorite_view.dart';
import 'package:shop_laptop_project/presentation/view/home/home_view.dart';
import 'package:shop_laptop_project/presentation/view/login/login_view.dart';
import 'package:shop_laptop_project/presentation/view/main/main_view.dart';
import 'package:shop_laptop_project/presentation/view/profile/profile_view.dart';
import 'package:shop_laptop_project/presentation/view/shop/shop_view.dart';

import '../utils/navigator_paths.dart';
import '../utils/navigator_utils.dart';
import '../utils/router_provider.dart';

class HomeRouter extends IRouterProvider {
  @override
  void defineRoutes(FluroRouter router) {
    router.define(
      NavigatorPaths.login,
      handler: Handler(handlerFunc: (context, __) {
        return const LoginView();
      }),
    );

    router.define(
      NavigatorPaths.main,
      handler: Handler(handlerFunc: (context, __) {
        return const MainView();
      }),
    );

    router.define(
      NavigatorPaths.home,
      handler: Handler(handlerFunc: (context, __) {
        return const HomeView();
      }),
    );

    router.define(
      NavigatorPaths.shop,
      handler: Handler(handlerFunc: (context, __) {
        return const ShopView();
      }),
    );

    router.define(
      NavigatorPaths.cart,
      handler: Handler(handlerFunc: (context, __) {
        return const CartView();
      }),
    );

    router.define(
      NavigatorPaths.profile,
      handler: Handler(handlerFunc: (context, __) {
        return const ProfileView();
      }),
    );

    router.define(
      NavigatorPaths.favorite,
      handler: Handler(handlerFunc: (context, __) {
        return const FavoriteView();
      }),
    );
  }

  static void goMainView(context) {
    NavigatorUtils.pushAndRemoveUntil(
      context,
      NavigatorPaths.main,
    );
  }

  static void forceLogout(context) {
    NavigatorUtils.pushAndRemoveUntil(
      context,
      NavigatorPaths.login,
    );
  }

  static void goFavorite(context) {
    NavigatorUtils.push(
      context,
      NavigatorPaths.favorite,
    );
  }
}
