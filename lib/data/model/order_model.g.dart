// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'order_model.dart';

// **************************************************************************
// JsonSerializableGenerator
// **************************************************************************

OrderModel _$OrderModelFromJson(Map<String, dynamic> json) => OrderModel(
      (json['listOrder'] as List<dynamic>)
          .map((e) => OrderInfo.fromJson(e as Map<String, dynamic>))
          .toList(),
      json['totalPrice'] as String,
    );

Map<String, dynamic> _$OrderModelToJson(OrderModel instance) =>
    <String, dynamic>{
      'listOrder': instance.listOrder,
      'totalPrice': instance.totalPrice,
    };
