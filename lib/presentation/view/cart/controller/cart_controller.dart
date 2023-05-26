import 'package:get/get.dart';
import 'package:injectable/injectable.dart';
import 'package:shop_laptop_project/common/extensions/date_extension.dart';
import 'package:shop_laptop_project/data/model/order_info.dart';
import 'package:shop_laptop_project/data/model/order_model.dart';
import 'package:shop_laptop_project/data/model/shop_model.dart';
import 'package:cloud_firestore/cloud_firestore.dart';

@Singleton()
class CartController extends GetxController {
  final orderList = <ShopModel>[].obs;
  final subTotal = 0.0.obs;
  final ship = 0.0.obs;
  final total = 0.0.obs;
  final dayOrder = DateTime.now().toStringWithDate().obs;
  final timeOrder = DateTime.now().toStringWithTime().obs;
  final phone = '097327368'.obs;

  void addToCart(
    ShopModel item, {
    bool isDetail = false,
  }) {
    var firstItem =
        orderList.firstWhereOrNull((element) => element.shopId == item.shopId);

    if (firstItem != null) {
      if (isDetail) {
        orderList.remove(firstItem);
        orderList.add(item);
      } else {
        firstItem.count++;
      }
    } else {
      orderList.add(item);
    }
    calTotalPrice();
    update();
  }

  void removeFromCart(ShopModel item) {
    orderList.remove(item);
    calTotalPrice();
    update();
  }

  void plusCountItem(ShopModel item) {
    item.count++;
    calTotalPrice();
    update();
  }

  void minusCountItem(ShopModel item) {
    if (item.count == 1) {
      orderList.remove(item);
    } else {
      item.count--;
    }
    calTotalPrice();
    update();
  }

  void calTotalPrice() {
    if (orderList.isEmpty) {
      ship.value = 0.0;
    } else {
      ship.value = 5.0;
    }
    subTotal.value = 0.0;

    for (var item in orderList) {
      subTotal.value += item.totalPrice;
    }
    total.value = subTotal.value + ship.value;
  }

  Future<void> payment({required String location}) async {
    var orderInfo = <OrderInfo>[];
    for (var item in orderList) {
      orderInfo.add(OrderInfo(item.itemName, item.count.toString()));
    }

    var orders = OrderModel(
      orderInfo.map((e) => e.toJson()).toList(),
      total.value.toString(),
      phone.value,
      location,
      '$timeOrder $dayOrder',
      'Cash',
    ).toJson();

    await FirebaseFirestore.instance.collection('orders').add(orders);
    orderList.value = [];
    total.value = 0.0;
    subTotal.value = 0.0;
    ship.value = 0.0;
  }
}
