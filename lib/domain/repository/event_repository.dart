import 'package:shop_laptop_project/data/utils/errors.dart';
import 'package:shop_laptop_project/data/model/shop_response.dart';
import 'package:either_dart/either.dart';

abstract class EventRepository {
  Future<Either<AppError, ShopResponse>> getShop();
}
