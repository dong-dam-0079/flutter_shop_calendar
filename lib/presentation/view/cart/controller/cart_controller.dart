import 'package:get/get.dart';
import 'package:injectable/injectable.dart';
import 'package:shop_laptop_project/data/model/shop_model.dart';

@Singleton()
class CartController extends GetxController {
  final orderList = <ShopModel>[].obs;

  void addToCart(ShopModel item) {
    var firstItem =
        orderList.firstWhereOrNull((element) => element.shopId == item.shopId);

    if (firstItem != null) {
      firstItem.count++;
    } else {
      orderList.add(item);
    }
    update();
  }

  void removeFromCart(ShopModel item) {
    orderList.remove(item);
  }

  void plusCountItem(ShopModel item) {
    item.count++;
    update();
  }

  void minusCountItem(ShopModel item) {
    if (item.count == 1) {
      orderList.remove(item);
    } else {
      item.count--;
    }
    update();
  }
}
