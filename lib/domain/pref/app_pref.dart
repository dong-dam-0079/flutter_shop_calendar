import 'package:shop_laptop_project/data/model/calendar_model.dart';
import 'package:shop_laptop_project/data/model/shop_response.dart';

abstract class AppPref {
  Future<void> setItemFavorite(ShopResponse favorites);

  Future<ShopResponse> get favorites;

  Future<void> setPhoneNumber(String phoneNumber);

  Future<String> get phoneNumber;

  Future<void> setFirstTime(bool isFirstTime);

  Future<bool> get firstTime;

  Future<void> setHistoryCalendar(CalendarModel model);

  Future<List<CalendarModel>> get calendars;
}
