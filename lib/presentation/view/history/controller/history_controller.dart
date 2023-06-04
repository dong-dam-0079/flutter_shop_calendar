import 'package:get/get.dart';
import 'package:injectable/injectable.dart';
import 'package:shop_laptop_project/data/model/calendar_model.dart';
import 'package:shop_laptop_project/domain/pref/app_pref.dart';

@injectable
class HistoryController extends GetxController {
  HistoryController(this._pref);

  final AppPref _pref;

  final histories = <CalendarModel>[].obs;

  void initHistory() async {
    histories.value = await _pref.calendars;
    update();
  }
}
