import 'package:json_annotation/json_annotation.dart';
import 'package:shop_laptop_project/data/model/shop_model.dart';

part 'shop_response.g.dart';

@JsonSerializable()
class ShopResponse {
  ShopResponse(this.response);

  @JsonKey(name: 'list')
  final List<ShopModel> response;

  factory ShopResponse.fromJson(Map<String, dynamic> json) =>
      _$ShopResponseFromJson(json);

  Map<String, dynamic> toJson() => _$ShopResponseToJson(this);
}
