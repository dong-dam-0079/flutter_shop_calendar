import 'package:json_annotation/json_annotation.dart';

part 'order_model.g.dart';

@JsonSerializable()
class OrderModel {
  OrderModel(
    this.listOrder,
    this.totalPrice,
    this.phoneNumber,
    this.location,
    this.timeOrder,
    this.paymentMethod,
  );

  List<Map<String, dynamic>> listOrder;

  final String totalPrice;
  final String phoneNumber;
  final String location;
  final String timeOrder;
  final String paymentMethod;

  factory OrderModel.fromJson(Map<String, dynamic> json) =>
      _$OrderModelFromJson(json);

  Map<String, dynamic> toJson() => _$OrderModelToJson(this);
}
