import 'dart:async';

import 'package:flutter_modular/flutter_modular.dart';
import 'package:is_it_safe_app/core/utils/config/custom_shared_preferences_contract.dart';

class SplashBloc implements Disposable {
  final CustomSharedPreferencesContract customSharedPreferences;

  SplashBloc({required this.customSharedPreferences});

  final StreamController<bool> _splashController = StreamController();
  Stream<bool> get splashStream => _splashController.stream;
  Sink<bool> get splashSink => _splashController.sink;

  Future getUsuarioLogin() async {
    await customSharedPreferences.readUsuario().then((response) async {
      splashSink.add(response);
    });
  }

  @override
  void dispose() {}
}
