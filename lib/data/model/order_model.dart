import 'package:json_annotation/json_annotation.dart';
import 'package:shop_laptop_project/data/model/order_info.dart';

part 'order_model.g.dart';

@JsonSerializable()
class OrderModel {
  OrderModel(this.listOrder, this.totalPrice);

  List<OrderInfo> listOrder;

  final String totalPrice;

  factory OrderModel.fromJson(Map<String, dynamic> json) =>
      _$OrderModelFromJson(json);

  Map<String, dynamic> toJson() => _$OrderModelToJson(this);
}
