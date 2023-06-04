import 'dart:convert';

import 'package:injectable/injectable.dart';
import 'package:shared_preferences/shared_preferences.dart';
import 'package:shop_laptop_project/common/constants/common_constants.dart';
import 'package:shop_laptop_project/config/log/log.dart';
import 'package:shop_laptop_project/data/model/calendar_model.dart';
import 'package:shop_laptop_project/domain/pref/app_pref.dart';

import '../model/shop_response.dart';

@Singleton(as: AppPref)
class AppPrefImpl implements AppPref {
  AppPrefImpl(this._pref);

  final SharedPreferences _pref;

  @override
  Future<ShopResponse> get favorites async {
    var data = _pref.getString(CommonConstants.keyFavorites);
    if (data == null || data.isEmpty) {
      return ShopResponse([]);
    } else {
      Map<String, dynamic> eventMap = jsonDecode(data);
      return ShopResponse.fromJson(eventMap);
    }
  }

  @override
  Future<void> setItemFavorite(ShopResponse favorites) async {
    String value = jsonEncode(favorites.toJson());
    _pref.setString(CommonConstants.keyFavorites, value);
  }

  @override
  Future<String> get phoneNumber async =>
      _pref.getString(CommonConstants.keyPhoneNumber) ?? '';

  @override
  Future<void> setPhoneNumber(String phoneNumber) async {
    _pref.setString(CommonConstants.keyPhoneNumber, phoneNumber);
  }

  @override
  Future<bool> get firstTime async =>
      _pref.getBool(CommonConstants.keyFirstTime) ?? false;

  @override
  Future<void> setFirstTime(bool isFirstTime) async {
    _pref.setBool(CommonConstants.keyFirstTime, isFirstTime);
  }

  @override
  Future<List<CalendarModel>> get calendars async {
    var histories = _pref.getString(CommonConstants.keyHistory) ?? '';

    if (histories.isNotEmpty) {
      var decode = json.decode(histories);

      return decode
          .map<CalendarModel>((item) => CalendarModel.fromJson(item))
          .toList();
    }

    return <CalendarModel>[];
  }

  @override
  Future<void> setHistoryCalendar(CalendarModel model) async {
    var list = await calendars;
    list.add(model);
    var data = json.encode(list);
    Log.e(data);
    await _pref.setString(CommonConstants.keyHistory, data);
  }
}
