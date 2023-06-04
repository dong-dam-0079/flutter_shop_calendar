import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:get/get.dart';
import 'package:injectable/injectable.dart';
import 'package:shop_laptop_project/common/extensions/date_extension.dart';
import 'package:shop_laptop_project/data/model/calendar_model.dart';
import 'package:shop_laptop_project/domain/pref/app_pref.dart';
import 'package:shop_laptop_project/domain/usecase/shop_usecase.dart';

@injectable
class HomeController extends GetxController {
  HomeController(this._shopUseCase, this._pref);

  final ShopUseCase _shopUseCase;
  final AppPref _pref;

  final services = <String>[
    'Vệ sinh - Bảo dưỡng máy',
    'Sửa/thay thế màn hình laptop',
    'Thay pin laptop',
    'Thay bàn phím laptop',
    'Nâng cấp phần cứng (SSD,RAM,...)',
    'Cài Win, phần mềm',
    'Bản lề bị nứt/vỡ'
  ].obs;
  final service = ''.obs;
  final isShowAddress = true.obs;
  final date = DateTime.now().toStringWithDate().obs;
  final method = 'Home'.obs;

  void initDropValue() {
    service.value = services.first;
  }

  Future<void> booking({
    required String name,
    required String phone,
    String? address,
  }) async {
    var orders = CalendarModel(
      date: date.value,
      service: service.value,
      name: name,
      phone: phone,
      method: method.value,
      address: address,
    );

    await FirebaseFirestore.instance.collection('calendar').add(orders.toJson());
    await _pref.setHistoryCalendar(orders);
  }
}
