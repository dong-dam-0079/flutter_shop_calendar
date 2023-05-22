// GENERATED CODE - DO NOT MODIFY BY HAND

// **************************************************************************
// InjectableConfigGenerator
// **************************************************************************

// ignore_for_file: unnecessary_lambdas
// ignore_for_file: lines_longer_than_80_chars
// coverage:ignore-file

// ignore_for_file: no_leading_underscores_for_library_prefixes
import 'package:dio/dio.dart' as _i4;
import 'package:get_it/get_it.dart' as _i1;
import 'package:injectable/injectable.dart' as _i2;
import 'package:shared_preferences/shared_preferences.dart' as _i8;

import '../../data/local/app_pref_impl.dart' as _i12;
import '../../data/repository/event_repository_impl.dart' as _i6;
import '../../data/service/api_service.dart' as _i10;
import '../../domain/pref/app_pref.dart' as _i11;
import '../../domain/repository/event_repository.dart' as _i5;
import '../../domain/usecase/shop_usecase.dart' as _i9;
import '../../presentation/view/cart/controller/cart_controller.dart' as _i3;
import '../../presentation/view/favorite/controller/fav_controller.dart'
    as _i13;
import '../../presentation/view/home/controller/home_controller.dart' as _i14;
import '../../presentation/view/shop/controller/shop_controller.dart' as _i15;
import '../../presentation/widgets/common_gaps.dart' as _i7;
import 'app_module.dart' as _i16;

// ignore_for_file: unnecessary_lambdas
// ignore_for_file: lines_longer_than_80_chars
// initializes the registration of main-scope dependencies inside of GetIt
Future<_i1.GetIt> $initGetIt(
  _i1.GetIt getIt, {
  String? environment,
  _i2.EnvironmentFilter? environmentFilter,
}) async {
  final gh = _i2.GetItHelper(
    getIt,
    environment,
    environmentFilter,
  );
  final appModule = _$AppModule();
  gh.singleton<_i3.CartController>(_i3.CartController());
  gh.singleton<_i4.Dio>(appModule.dio);
  gh.singleton<_i5.EventRepository>(_i6.EventRepositoryImpl());
  gh.singleton<_i7.Gaps>(_i7.Gaps());
  await gh.singletonAsync<_i8.SharedPreferences>(
    () => appModule.sharedPreferences,
    preResolve: true,
  );
  gh.factory<_i9.ShopUseCase>(() => _i9.ShopUseCase(gh<_i5.EventRepository>()));
  gh.singleton<_i10.ApiService>(_i10.ApiService(gh<_i4.Dio>()));
  gh.singleton<_i11.AppPref>(_i12.AppPrefImpl(gh<_i8.SharedPreferences>()));
  gh.factory<_i13.FavController>(() => _i13.FavController(gh<_i11.AppPref>()));
  gh.factory<_i14.HomeController>(
      () => _i14.HomeController(gh<_i9.ShopUseCase>()));
  gh.factory<_i15.ShopController>(
      () => _i15.ShopController(gh<_i9.ShopUseCase>()));
  return getIt;
}

class _$AppModule extends _i16.AppModule {}
