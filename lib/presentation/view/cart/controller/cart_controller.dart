import 'package:get/get.dart';
import 'package:injectable/injectable.dart';
import 'package:shop_laptop_project/data/model/shop_model.dart';

@Singleton()
class CartController extends GetxController {
  final orderList = <ShopModel>[].obs;

  void addToCart(ShopModel item) {
    for(var order in orderList) {
      if(order.shopId == item.shopId) {

      }
    }
    orderList.add(item);
  }
}
