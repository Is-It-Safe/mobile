import 'package:is_it_safe_app/src/core/state/safe_observer.dart';
import 'package:is_it_safe_app/src/core/state/safe_status.dart';

class SafeStream<T> {
  SafeStatus status;
  String? alertMessage;
  final List<SafeObserver> _observers = [];
  DateTime? updatedAt;
  late T _data;
  bool ignore;

  SafeStream({
    required T data,
    this.status = SafeStatus.success,
    this.ignore = false,
  }) {
    _data = data;
  }

  T get data => _data;

  set data(T newData) {
    if (newData != _data || SafeStatus.success != status) {
      _data = newData;
      _changeState(SafeStatus.success);
    }
  }

  void _changeState(SafeStatus newState) {
    if (!ignore) {
      updatedAt = DateTime.now();
      status = newState;
      for (final e in _observers) {
        e.notifyState();
      }
    }
  }

  void error(String message) {
    alertMessage = message;
    _changeState(SafeStatus.error);
  }

  void loading() {
    _changeState(SafeStatus.loading);
  }

  void hide() {
    _changeState(SafeStatus.hidden);
  }

  void show() {
    if (status == SafeStatus.hidden || status == SafeStatus.loading) {
      _changeState(SafeStatus.success);
    }
  }

  void refresh() {
    _changeState(status);
  }

  void setUnauthorized() {
    if (!ignore) {
      _changeState(SafeStatus.unAuthorized);
    }
  }

  void addObserver(SafeObserver vmObserver) {
    if (!ignore) {
      _observers.add(vmObserver);
    }
  }

  void removeObserver(SafeObserver vmObserver) {
    if (!ignore) {
      _observers.remove(vmObserver);
    }
  }
}
