import 'dart:async';

import 'package:flutter_modular/flutter_modular.dart';
import 'package:is_it_safe_app/core/utils/config/custom_shared_preferences.dart';

class SplashBloc implements Disposable {
  final StreamController<bool> _splashController = StreamController();
  Stream<bool> get splashStream => _splashController.stream;
  Sink<bool> get splashSink => _splashController.sink;

  Future getUsuarioLogin() async {
    await CustomSharedPreferences.readUsuario().then((response) async {
      splashSink.add(response);
    });
  }

  @override
  void dispose() {}
}
