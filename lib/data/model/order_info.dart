import 'package:json_annotation/json_annotation.dart';

part 'order_info.g.dart';

@JsonSerializable()
class OrderInfo {
  OrderInfo(this.name, this.count);

  final String name;
  final String count;

  factory OrderInfo.fromJson(Map<String, dynamic> json) =>
      _$OrderInfoFromJson(json);

  Map<String, dynamic> toJson() => _$OrderInfoToJson(this);
}
