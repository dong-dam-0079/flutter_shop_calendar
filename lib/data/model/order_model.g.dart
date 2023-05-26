// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'order_model.dart';

// **************************************************************************
// JsonSerializableGenerator
// **************************************************************************

OrderModel _$OrderModelFromJson(Map<String, dynamic> json) => OrderModel(
      (json['listOrder'] as List<dynamic>)
          .map((e) => e as Map<String, dynamic>)
          .toList(),
      json['totalPrice'] as String,
      json['phoneNumber'] as String,
      json['location'] as String,
      json['timeOrder'] as String,
      json['paymentMethod'] as String,
    );

Map<String, dynamic> _$OrderModelToJson(OrderModel instance) =>
    <String, dynamic>{
      'listOrder': instance.listOrder,
      'totalPrice': instance.totalPrice,
      'phoneNumber': instance.phoneNumber,
      'location': instance.location,
      'timeOrder': instance.timeOrder,
      'paymentMethod': instance.paymentMethod,
    };
