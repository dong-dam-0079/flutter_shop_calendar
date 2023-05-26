import 'package:get/get.dart';
import 'package:injectable/injectable.dart';
import 'package:shop_laptop_project/data/model/shop_response.dart';
import 'package:shop_laptop_project/domain/pref/app_pref.dart';

import '../../../../config/log/log.dart';
import '../../../../data/model/shop_model.dart';

@Singleton()
class FavController extends GetxController {
  FavController(this._pref);

  final AppPref _pref;

  final favorites = <ShopModel>[].obs;

  void getFavorites() async {
    var res = await _pref.favorites;
    favorites.value = res.response;
    update();
  }

  void setItemFavorite(ShopModel fav) async {
    var res = (await _pref.favorites).response;

    var firstItem =
        res.firstWhereOrNull((element) => element.shopId == fav.shopId);

    if (firstItem == null) {
      res.add(fav);
    }

    await _pref.setItemFavorite(ShopResponse(res));
    getFavorites();
  }

  void removeFavorite(ShopModel fav) async {
    var res = (await _pref.favorites).response;
    var iRemove = res.indexWhere((element) => element.shopId == fav.shopId);
    Log.e(iRemove.toString());
    res.removeAt(iRemove);

    await _pref.setItemFavorite(ShopResponse(res));
    getFavorites();
  }

  void removeAll() async {
    await _pref.setItemFavorite(ShopResponse([]));
    getFavorites();
  }
}
