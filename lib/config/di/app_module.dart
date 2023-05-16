import 'package:dio/dio.dart';
import 'package:flutter/foundation.dart';
import 'package:get_it/get_it.dart';
import 'package:injectable/injectable.dart';
import 'package:pretty_dio_logger/pretty_dio_logger.dart';
import 'package:shared_preferences/shared_preferences.dart';
import 'package:shop_laptop_project/common/constants/common_constants.dart';

import 'app_module.config.dart';
import 'interceptors.dart';

final serviceLocator = GetIt.instance;

@InjectableInit(
  initializerName: r'$initGetIt', // default
  preferRelativeImports: true, // default
  asExtension: false, // default
)
Future<void> configureDependencies() async => $initGetIt(serviceLocator);

@module
@Singleton()
abstract class AppModule {
  @preResolve
  @Singleton()
  Future<SharedPreferences> get sharedPreferences =>
      SharedPreferences.getInstance();

  @Singleton()
  Dio get dio {
    var interceptors = [
      AuthInterceptor(),
    ];
    return _createDio(interceptors);
  }

  Dio _createDio(List<Interceptor> interceptors) {
    final BaseOptions options = BaseOptions(
      connectTimeout: const Duration(seconds: 30),
      receiveTimeout: const Duration(seconds: 15),
      sendTimeout: const Duration(seconds: 30),
      baseUrl: CommonConstants.baseUrl,

      /// Dio defaults to json parsing, specify it here to return UTF8 string and handle it yourself.
      /// (It can also be achieved through a custom transformer)
      responseType: ResponseType.plain,
      validateStatus: (_) {
        /// Do not use http status code to judge the status, use AdapterInterceptor to handle (applicable to standard REST style)
        return true;
      },
    );

    final dio = Dio(options);
    for (var interceptor in interceptors) {
      dio.interceptors.add(interceptor);
    }

    if (!kReleaseMode) {
      dio.interceptors.add(PrettyDioLogger(
        requestHeader: true,
        requestBody: true,
      ));
    }

    return dio;
  }
}
