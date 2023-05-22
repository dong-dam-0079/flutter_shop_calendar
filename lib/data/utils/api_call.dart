import 'package:dio/dio.dart';
import 'package:either_dart/either.dart';
import 'package:retrofit/retrofit.dart';

import 'errors.dart';

Future<Either<AppError, T>> safeApiCall<T>(
  Future<HttpResponse<T>> Function() function,
) async {
  try {
    final res = await function.call();
    if (res.response.statusCode == 200) {
      return Right(res.data);
    } else if (res.response.statusCode == 401) {
      return const Left(AuthorizationError(""));
    }
    return Left(ServerError(res.response.statusMessage ?? ''));
  } on DioError catch (e) {
    return Left(NetworkError(e.toString()));
  } catch (e) {
    return Left(OtherError(e.toString()));
  }
}
