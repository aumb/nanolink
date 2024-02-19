sealed class BaseStatus<T> {
  const BaseStatus();
}

class InitialStatus<T> extends BaseStatus<T> {
  const InitialStatus();
}

class LoadingStatus<T> extends BaseStatus<T> {
  const LoadingStatus();
}

class LoadedStatus<T> extends BaseStatus<T> {
  const LoadedStatus();
}

class EmptyStatus<T> extends BaseStatus<T> {
  const EmptyStatus();
}

class ErrorStatus<T> extends BaseStatus<T> {
  const ErrorStatus(this.error);

  final String error;
}

extension BaseStatusX<T> on BaseStatus<T> {
  bool get isLoading => this is LoadingStatus;
  bool get isEmpty => this is EmptyStatus;
  bool get hasLoaded => this is LoadedStatus;
  bool get hasErrored => this is ErrorStatus;
}
