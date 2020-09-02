import 'dart:ui';

import 'package:async/async.dart';

enum ProviderModelAsyncResultState { none, active, done }

class ProviderModelAsyncResult<T> {
  Future<void> set(
      Future<Result<T>> futureResult, VoidCallback isLoadingChanged) async {
    _state = ProviderModelAsyncResultState.active;
    isLoadingChanged();

    result = await futureResult;

    _state = ProviderModelAsyncResultState.done;
    isLoadingChanged();
  }

  Result<T> result;
  ProviderModelAsyncResultState _state = ProviderModelAsyncResultState.none;

  ProviderModelAsyncResultState get state => _state;
}
