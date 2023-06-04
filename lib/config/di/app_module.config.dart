// GENERATED CODE - DO NOT MODIFY BY HAND

// **************************************************************************
// InjectableConfigGenerator
// **************************************************************************

// ignore_for_file: unnecessary_lambdas
// ignore_for_file: lines_longer_than_80_chars
// coverage:ignore-file

// ignore_for_file: no_leading_underscores_for_library_prefixes
import 'package:dio/dio.dart' as _i3;
import 'package:get_it/get_it.dart' as _i1;
import 'package:injectable/injectable.dart' as _i2;
import 'package:shared_preferences/shared_preferences.dart' as _i7;

import '../../data/local/app_pref_impl.dart' as _i11;
import '../../data/repository/event_repository_impl.dart' as _i5;
import '../../data/service/api_service.dart' as _i9;
import '../../domain/pref/app_pref.dart' as _i10;
import '../../domain/repository/event_repository.dart' as _i4;
import '../../domain/usecase/shop_usecase.dart' as _i8;
import '../../presentation/view/cart/controller/cart_controller.dart' as _i12;
import '../../presentation/view/favorite/controller/fav_controller.dart'
    as _i13;
import '../../presentation/view/history/controller/history_controller.dart'
    as _i14;
import '../../presentation/view/home/controller/home_controller.dart' as _i15;
import '../../presentation/view/login/controller/login_controller.dart' as _i16;
import '../../presentation/view/profile/controller/profile_controller.dart'
    as _i17;
import '../../presentation/view/shop/controller/shop_controller.dart' as _i18;
import '../../presentation/widgets/common_gaps.dart' as _i6;
import 'app_module.dart' as _i19;

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
  gh.singleton<_i3.Dio>(appModule.dio);
  gh.singleton<_i4.EventRepository>(_i5.EventRepositoryImpl());
  gh.singleton<_i6.Gaps>(_i6.Gaps());
  await gh.singletonAsync<_i7.SharedPreferences>(
    () => appModule.sharedPreferences,
    preResolve: true,
  );
  gh.factory<_i8.ShopUseCase>(() => _i8.ShopUseCase(gh<_i4.EventRepository>()));
  gh.singleton<_i9.ApiService>(_i9.ApiService(gh<_i3.Dio>()));
  gh.singleton<_i10.AppPref>(_i11.AppPrefImpl(gh<_i7.SharedPreferences>()));
  gh.singleton<_i12.CartController>(_i12.CartController(gh<_i10.AppPref>()));
  gh.singleton<_i13.FavController>(_i13.FavController(gh<_i10.AppPref>()));
  gh.factory<_i14.HistoryController>(
      () => _i14.HistoryController(gh<_i10.AppPref>()));
  gh.factory<_i15.HomeController>(() => _i15.HomeController(
        gh<_i8.ShopUseCase>(),
        gh<_i10.AppPref>(),
      ));
  gh.singleton<_i16.LoginController>(_i16.LoginController(gh<_i10.AppPref>()));
  gh.factory<_i17.ProfileController>(
      () => _i17.ProfileController(gh<_i10.AppPref>()));
  gh.factory<_i18.ShopController>(
      () => _i18.ShopController(gh<_i8.ShopUseCase>()));
  return getIt;
}

class _$AppModule extends _i19.AppModule {}
