import 'package:dio/dio.dart';

class AuthInterceptor extends QueuedInterceptor {
  @override
  Future<void> onRequest(
    RequestOptions options,
    RequestInterceptorHandler handler,
  ) async {
    options.headers['Content-Type'] = 'application/json';
    options.headers['Accept'] = 'application/json';

    handler.next(options);
  }

  @override
  void onResponse(Response response, ResponseInterceptorHandler handler) async {
    if (response.statusCode != 403 && response.statusCode != 401) {
      handler.next(response);
      return;
    }

    handler.next(response);
  }
}
