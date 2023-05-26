import 'package:fluro/fluro.dart';
import 'package:shop_laptop_project/data/model/shop_model.dart';
import 'package:shop_laptop_project/presentation/view/cart/cart_view.dart';
import 'package:shop_laptop_project/presentation/view/cart/pay_view.dart';
import 'package:shop_laptop_project/presentation/view/detail/detail_view.dart';
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

    router.define(
      NavigatorPaths.detail,
      handler: Handler(handlerFunc: (context, __) {
        final data = context?.settings?.arguments as ShopModel;

        return DetailView(item: data);
      }),
    );

    router.define(
      NavigatorPaths.pay,
      handler: Handler(handlerFunc: (context, __) {
        return const PaymentView();
      }),
    );
  }

  static void goMainView(context) {
    NavigatorUtils.pushAndRemoveUntil(
      context,
      NavigatorPaths.main,
    );
  }

  static void goPay(context) {
    NavigatorUtils.push(
      context,
      NavigatorPaths.pay,
    );
  }

  static void goDetail(
    context, {
    required ShopModel shopModel,
  }) {
    NavigatorUtils.push(
      context,
      NavigatorPaths.detail,
      sendData: shopModel,
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
