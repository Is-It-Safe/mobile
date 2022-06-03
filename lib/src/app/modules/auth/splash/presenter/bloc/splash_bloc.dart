import 'dart:async';
import 'package:flutter_modular/flutter_modular.dart';
import 'package:is_it_safe_app/src/app/modules/auth/splash/domain/use_case/get_user_login_use_case.dart';
import 'package:is_it_safe_app/src/app/modules/auth/splash/domain/use_case/get_user_on_boarding_use_case.dart';
import 'package:is_it_safe_app/src/core/interfaces/safe_bloc.dart';
import 'package:is_it_safe_app/src/core/util/log_util.dart';
import 'package:logger/logger.dart';

class SplashBloc extends SafeBloC {
  late GetUserLoginUseCase _getUserLoginUseCase;
  late GetUserOnBoaringUseCase _getUserOnBoaringUseCase;
  late bool isUserLogged;
  late bool isUserOnBoarding;

  SplashBloc() {
    init();
  }

  @override
  Future<void> init() async {
    _getUserLoginUseCase = Modular.get<GetUserLoginUseCase>();
    _getUserOnBoaringUseCase = Modular.get<GetUserOnBoaringUseCase>();
    isUserLogged = await getUserLogin();
    isUserOnBoarding = await getUserOnBoarding();
  }

  Future<bool> getUserLogin() async {
    final _response = await _getUserLoginUseCase.call();
    LogUtil().log(
      //TODO Add String to intl
      title: 'Is User Logged?',
      message: _response.toString(),
      level: Level.warning,
    );
    return _response;
  }

  Future<bool> getUserOnBoarding() async {
    final _response = await _getUserOnBoaringUseCase.call();
    LogUtil().log(
      //TODO Add String to intl
      title: 'Did User See OnBoarding?',
      message: _response.toString(),
      level: Level.warning,
    );
    return _response;
  }

  @override
  Future<void> dispose() async {}
}
