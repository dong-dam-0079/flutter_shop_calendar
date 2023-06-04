// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'calendar_model.dart';

// **************************************************************************
// JsonSerializableGenerator
// **************************************************************************

CalendarModel _$CalendarModelFromJson(Map<String, dynamic> json) =>
    CalendarModel(
      date: json['date'] as String,
      service: json['service'] as String,
      name: json['name'] as String,
      phone: json['phone'] as String,
      method: json['method'] as String,
      address: json['address'] as String?,
    );

Map<String, dynamic> _$CalendarModelToJson(CalendarModel instance) =>
    <String, dynamic>{
      'date': instance.date,
      'service': instance.service,
      'name': instance.name,
      'phone': instance.phone,
      'method': instance.method,
      'address': instance.address,
    };
