import 'dart:async';
import 'package:flutter_modular/flutter_modular.dart';
import 'package:is_it_safe_app/src/app/modules/auth/modules/login/presenter/pages/login_page.dart';
import 'package:is_it_safe_app/src/app/modules/auth/modules/on_boarding/presenter/pages/on_boarding_page.dart';
import 'package:is_it_safe_app/src/app/modules/home/presenter/pages/home_page.dart';
import 'package:is_it_safe_app/src/app/modules/navigation/presenter/pages/navigation_page.dart';
import 'package:is_it_safe_app/src/core/interfaces/safe_bloc.dart';
import 'package:is_it_safe_app/src/core/util/safe_log_util.dart';
import 'package:is_it_safe_app/src/domain/use_case/get_user_login_use_case.dart';
import 'package:is_it_safe_app/src/domain/use_case/get_user_on_boarding_use_case.dart';

class SplashBloc extends SafeBloC {
  final GetUserLoginUseCase getUserLoginUseCase;
  final GetUserOnBoaringUseCase getUserOnBoaringUseCase;

  SplashBloc({
    required this.getUserLoginUseCase,
    required this.getUserOnBoaringUseCase,
  });

  @override
  Future<void> init() async {
    SafeLogUtil.instance.route(Modular.to.path);
    defineRoute();
  }

  Future<bool> get isUserLogged async {
    final response = await getUserLoginUseCase();
    SafeLogUtil.instance.log(
      title: 'Is User Logged?',
      message: '$response',
      type: SafeLogType.warning,
    );
    return response;
  }

  Future<bool> get didUserSeeOnboarding async {
    final response = await getUserOnBoaringUseCase();
    SafeLogUtil.instance.log(
      title: 'Did User See OnBoarding?',
      message: '$response',
      type: SafeLogType.warning,
    );
    return response;
  }

  void defineRoute() async {
    await Future.delayed(const Duration(seconds: 4)).then((_) async {
      if (await isUserLogged) {
        goToHome();
      } else {
        goToOnBoarding();
      }
    });
  }

  void goToHome() {
    Modular.to.pushNamedAndRemoveUntil(
      NavigationPage.route + HomePage.route,
      (r) => false,
    );
  }

  void goToOnBoarding() async {
    if (await didUserSeeOnboarding) {
      goToLogin();
    } else {
      Modular.to.pushNamedAndRemoveUntil(
        OnBoardingPage.route,
        (r) => false,
      );
    }
  }

  void goToLogin() {
    Modular.to.pushNamedAndRemoveUntil(
      LoginPage.route,
      (r) => false,
    );
  }

  @override
  Future<void> dispose() async {}
}
