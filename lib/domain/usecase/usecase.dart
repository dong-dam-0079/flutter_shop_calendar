abstract class ParamUseCase<T, P> {
  Future<T> call(P param);
}

abstract class NoParamUseCase<T> {
  Future<T> call();
}

abstract class ParamStreamUseCase<T, P> {
  Stream<T> call(P param);
}

abstract class NoParamStreamUseCase<T> {
  Stream<T> call();
}
