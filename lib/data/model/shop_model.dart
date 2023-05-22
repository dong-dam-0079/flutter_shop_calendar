import 'package:json_annotation/json_annotation.dart';

part 'shop_model.g.dart';

@JsonSerializable()
class ShopModel {
  ShopModel({
    required this.shopId,
    required this.itemName,
    required this.category,
    required this.describe,
    required this.rating,
    required this.price,
    this.isNew,
    this.count = 1,
  });

  @JsonKey(name: 'id')
  final String shopId;

  @JsonKey(name: 'name')
  final String itemName;

  @JsonKey(name: 'category')
  final int category;

  @JsonKey(name: 'describe')
  final String describe;

  @JsonKey(name: 'rating')
  final double rating;

  @JsonKey(name: 'price')
  final double price;

  @JsonKey(name: 'is_new')
  final int? isNew;

  int count;

  bool get isCateDevices => category == 1 ? true : false;

  bool get isNewInfo => isNew == 0 ? true : false;

  bool get isPopular => rating > 4.2 ? true : false;

  factory ShopModel.fromJson(Map<String, dynamic> json) =>
      _$ShopModelFromJson(json);

  Map<String, dynamic> toJson() => _$ShopModelToJson(this);
}
