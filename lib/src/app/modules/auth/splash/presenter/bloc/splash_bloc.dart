import 'dart:async';
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
  }) {
    init();
  }

  @override
  Future<void> init() async {}

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

  @override
  Future<void> dispose() async {}
}
