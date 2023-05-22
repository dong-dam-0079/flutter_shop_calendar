import 'package:get/get.dart';
import 'package:injectable/injectable.dart';
import 'package:shop_laptop_project/data/model/shop_model.dart';
import 'package:shop_laptop_project/domain/usecase/shop_usecase.dart';

@injectable
class HomeController extends GetxController {
  HomeController(this._shopUseCase);

  final ShopUseCase _shopUseCase;

  final shopNews = <ShopModel>[].obs;
  final shopPopular = <ShopModel>[].obs;
  final isLoading = false.obs;

  void getListShop() async {
    isLoading.value = true;
    final res = await _shopUseCase.call();

    if (res.isRight) {
      final list = res.right.response;

      for (var item in list) {
        if (item.isNewInfo) {
          shopNews.add(item);
        }

        if (item.isPopular) {
          shopPopular.add(item);
        }
      }
    }
    isLoading.value = false;
  }
}
