import 'package:dio/dio.dart';
import 'package:injectable/injectable.dart';
import 'package:retrofit/http.dart';

part 'api_service.g.dart';

@RestApi()
@Singleton()
abstract class ApiService {
  @factoryMethod
  factory ApiService(Dio dio) = _ApiService;
}
