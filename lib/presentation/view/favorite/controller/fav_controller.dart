import 'package:get/get.dart';
import 'package:injectable/injectable.dart';
import 'package:shop_laptop_project/data/model/shop_response.dart';
import 'package:shop_laptop_project/domain/pref/app_pref.dart';

import '../../../../data/model/shop_model.dart';

@injectable
class FavController extends GetxController {
  FavController(this._pref);

  final AppPref _pref;

  final favorites = <ShopModel>[].obs;

  void getFavorites() async {
    var res = await _pref.favorites;
    favorites.value = res.response;
  }

  void setItemFavorite(ShopModel fav) async {
    var res = (await _pref.favorites).response;
    res.add(fav);

    await _pref.setItemFavorite(ShopResponse(res));
  }
}
