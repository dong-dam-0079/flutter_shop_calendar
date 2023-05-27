import 'package:get/get.dart';
import 'package:injectable/injectable.dart';
import 'package:shop_laptop_project/domain/pref/app_pref.dart';

@injectable
class ProfileController extends GetxController {
  ProfileController(this._pref);

  final AppPref _pref;

  final phone = ''.obs;

  Future<void> getPhoneNumber() async {
    phone.value = await _pref.phoneNumber;
  }
}
