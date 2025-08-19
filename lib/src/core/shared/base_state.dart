enum BaseStatus {
  initial,

  loading,

  success,

  error,

  loadingMore,
}

extension BasseStatusExt on BaseStatus {
  bool get isInitial => this == BaseStatus.initial;

  bool get isLoading => this == BaseStatus.loading;

  bool get isSuccess => this == BaseStatus.success;

  bool get isError => this == BaseStatus.error;

  bool get isLoadingMore => this == BaseStatus.loadingMore;

  T when<T>({
    T Function()? onInitial,
    required T Function() onSuccess,
    required T Function() onLoading,
    required T Function() onError,
    required T Function() onLoadingMore,
  }) {
    switch (this) {
      case BaseStatus.initial:
        return onInitial?.call() ?? onLoading();
      case BaseStatus.loading:
        return onLoading();
      case BaseStatus.success:
        return onSuccess();
      case BaseStatus.error:
        return onError();
      case BaseStatus.loadingMore:
        return onLoadingMore();
    }
  }
}
