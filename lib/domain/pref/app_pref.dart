import 'package:shop_laptop_project/data/model/shop_response.dart';

abstract class AppPref {
  Future<void> setItemFavorite(ShopResponse favorites);

  Future<ShopResponse> get favorites;

  Future<void> setPhoneNumber(String phoneNumber);

  Future<String> get phoneNumber;

  Future<void> setFirstTime(bool isFirstTime);

  Future<bool> get firstTime;
}
