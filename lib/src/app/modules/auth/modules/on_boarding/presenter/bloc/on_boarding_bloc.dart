import 'package:flutter/material.dart';
import 'package:flutter_modular/flutter_modular.dart';
import 'package:is_it_safe_app/src/app/modules/auth/modules/login/presenter/pages/login_page.dart';
import 'package:is_it_safe_app/src/core/util/safe_log_util.dart';
import 'package:is_it_safe_app/src/domain/use_case/save_user_on_boarding_use_case.dart';
import 'package:is_it_safe_app/src/core/interfaces/safe_bloc.dart';

class OnBoardingBloc extends SafeBloC {
  final SaveUserOnBoardingUseCase saveUserOnBoardingUseCase;
  final onBoardingPageController = PageController(initialPage: 0);

  OnBoardingBloc({
    required this.saveUserOnBoardingUseCase,
  });

  @override
  Future<void> init() async {
    SafeLogUtil.instance.route(Modular.to.path);
  }

  Future<void> saveUserOnBoarding(bool value) async {
    try {
      await saveUserOnBoardingUseCase(value);
    } catch (e) {
      SafeLogUtil.instance.logError(e);
    }
  }

  void onSkipButtonPressed() {
    saveUserOnBoardingUseCase(true);
    Modular.to.navigate(LoginPage.route);
  }

  @override
  Future<void> dispose() async {
    onBoardingPageController.dispose();
  }
}
