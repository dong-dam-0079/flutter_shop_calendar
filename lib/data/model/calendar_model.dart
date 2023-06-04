import 'package:json_annotation/json_annotation.dart';

part 'calendar_model.g.dart';

@JsonSerializable()
class CalendarModel {
  CalendarModel({
    required this.date,
    required this.service,
    required this.name,
    required this.phone,
    required this.method,
    this.address,
  });

  final String date;
  final String service;
  final String name;
  final String phone;
  final String method;
  final String? address;

  factory CalendarModel.fromJson(Map<String, dynamic> json) =>
      _$CalendarModelFromJson(json);

  Map<String, dynamic> toJson() => _$CalendarModelToJson(this);
}
