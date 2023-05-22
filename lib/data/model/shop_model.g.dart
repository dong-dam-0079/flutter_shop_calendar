// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'shop_model.dart';

// **************************************************************************
// JsonSerializableGenerator
// **************************************************************************

ShopModel _$ShopModelFromJson(Map<String, dynamic> json) => ShopModel(
      shopId: json['id'] as String,
      itemName: json['name'] as String,
      category: json['category'] as int,
      describe: json['describe'] as String,
      rating: (json['rating'] as num).toDouble(),
      price: (json['price'] as num).toDouble(),
      isNew: json['is_new'] as int?,
      count: json['count'] as int? ?? 1,
    );

Map<String, dynamic> _$ShopModelToJson(ShopModel instance) => <String, dynamic>{
      'id': instance.shopId,
      'name': instance.itemName,
      'category': instance.category,
      'describe': instance.describe,
      'rating': instance.rating,
      'price': instance.price,
      'is_new': instance.isNew,
      'count': instance.count,
    };
