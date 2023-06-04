import 'package:get/get.dart';
import 'package:get/get_state_manager/src/simple/get_controllers.dart';
import 'package:injectable/injectable.dart';

import '../../../../data/model/shop_model.dart';
import '../../../../domain/usecase/shop_usecase.dart';

@injectable
class ShopController extends GetxController {
  ShopController(this._shopUseCase);

  final ShopUseCase _shopUseCase;

  final shopDevices = <ShopModel>[].obs;
  final shopServices = <ShopModel>[].obs;
  final isLoading = false.obs;

  void getListShop() async {
    isLoading.value = true;
    shopDevices.clear();
    final res = await _shopUseCase.call();

    if (res.isRight) {
      final list = res.right.response;

      shopDevices.addAll(list);
    }
    isLoading.value = false;
  }
}
