import 'package:catcher/catcher.dart';
import 'package:flutter/material.dart';
import 'package:flutter_modular/flutter_modular.dart';
import 'package:is_it_safe_app/src/core/util/safe_log_util.dart';
import 'package:is_it_safe_app/src/domain/use_case/save_user_on_boarding_use_case.dart';
import 'package:is_it_safe_app/src/core/interfaces/safe_bloc.dart';

class OnBoardingBloc extends SafeBloC {
  late final PageController onBoardingPageController;
  late final SaveUserOnBoardingUseCase saveUserOnBoardingUseCase;

  OnBoardingBloc() {
    init();
  }

  @override
  Future<void> init() async {
    saveUserOnBoardingUseCase = Modular.get<SaveUserOnBoardingUseCase>();
    onBoardingPageController = PageController(initialPage: 0);
  }

  Future<void> saveUserOnBoarding(bool value) async {
    try {
      await saveUserOnBoardingUseCase.call(value);
    } catch (e, stacktrace) {
      SafeLogUtil.instance.logError(e);
      Catcher.reportCheckedError(e, stacktrace);
    }
  }

  @override
  Future<void> dispose() async {}
}
