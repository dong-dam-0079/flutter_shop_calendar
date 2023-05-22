import 'package:either_dart/either.dart';
import 'package:injectable/injectable.dart';
import 'package:shop_laptop_project/data/model/shop_response.dart';
import 'package:shop_laptop_project/domain/repository/event_repository.dart';
import 'package:shop_laptop_project/domain/usecase/usecase.dart';

import '../../data/utils/errors.dart';

@injectable
class ShopUseCase extends NoParamUseCase<Either<AppError, ShopResponse>> {
  ShopUseCase(this._repository);

  final EventRepository _repository;

  @override
  Future<Either<AppError, ShopResponse>> call() {
    return _repository.getShop();
  }
}
