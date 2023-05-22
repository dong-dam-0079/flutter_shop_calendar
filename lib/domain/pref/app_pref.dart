import 'package:shop_laptop_project/data/model/shop_response.dart';

abstract class AppPref {
  Future<void> setItemFavorite(ShopResponse favorites);

  Future<ShopResponse> get favorites;
}
