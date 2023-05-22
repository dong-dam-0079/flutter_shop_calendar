import 'dart:convert';

import 'package:either_dart/src/either.dart';
import 'package:flutter/services.dart';
import 'package:injectable/injectable.dart';
import 'package:shop_laptop_project/data/utils/errors.dart';
import 'package:shop_laptop_project/data/model/shop_response.dart';

import '../../common/constants/assets.dart';
import '../../config/log/log.dart';
import '../../domain/repository/event_repository.dart';

@Singleton(as: EventRepository)
class EventRepositoryImpl implements EventRepository {
  @override
  Future<Either<AppError, ShopResponse>> getShop() async {
    try {
      final res = await rootBundle.loadString(Assets.pathJson);

      var data = await jsonDecode(res) as Map<String, dynamic>;
      var stores = ShopResponse.fromJson(data);
      return Right(stores);
    } catch (e) {
      Log.e(e.toString());
      return Right(ShopResponse([]));
    }
  }
}
