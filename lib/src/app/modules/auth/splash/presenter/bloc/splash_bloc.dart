import 'dart:async';
import 'package:flutter_modular/flutter_modular.dart';
import 'package:is_it_safe_app/src/core/interfaces/safe_bloc.dart';
import 'package:is_it_safe_app/src/core/util/log_util.dart';
import 'package:is_it_safe_app/src/domain/use_case/get_user_login_use_case.dart';
import 'package:is_it_safe_app/src/domain/use_case/get_user_on_boarding_use_case.dart';
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
    final response = await _getUserLoginUseCase.call();
    LogUtil().log(
      title: 'Is User Logged?',
      message: response.toString(),
      level: Level.warning,
    );
    return response;
  }

  Future<bool> getUserOnBoarding() async {
    final response = await _getUserOnBoaringUseCase.call();
    LogUtil().log(
      title: 'Did User See OnBoarding?',
      message: response.toString(),
      level: Level.warning,
    );
    return response;
  }

  @override
  Future<void> dispose() async {}
}
