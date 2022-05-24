import 'dart:async';

import 'package:flutter_modular/flutter_modular.dart';
import 'package:is_it_safe_app/src/service/shared_preferences/ishared_preferences_custom.dart';

class SplashBloc implements Disposable {
  final ISharedPreferencesCustom sharedPreferences;

  SplashBloc({required this.sharedPreferences});

  final StreamController<bool> _splashController = StreamController();
  Stream<bool> get splashStream => _splashController.stream;
  Sink<bool> get splashSink => _splashController.sink;

  Future getUsuarioLogin() async {
    await sharedPreferences.readLogin().then((response) async {
      splashSink.add(response);
    });
  }

  @override
  void dispose() {}
}
