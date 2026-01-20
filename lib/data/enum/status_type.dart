enum LoadStatus { initial, loading, success, failure, loadingMore }

extension LoadStatusExt on LoadStatus {
  bool get isLoading => this == LoadStatus.loading;

  bool get isSuccess => this == LoadStatus.success;

  bool get isError => this == LoadStatus.failure;

  LoadStatus statusButton(bool enable) {
    if (enable == true) {
      return LoadStatus.loading;
    } else {
      return LoadStatus.initial;
    }
  }
}