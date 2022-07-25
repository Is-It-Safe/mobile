import 'dart:async';

import 'package:dio/dio.dart';
import 'package:flutter_modular/flutter_modular.dart';
import 'package:is_it_safe_app/src/app/modules/auth/login/presenter/pages/login_page.dart';
import 'package:is_it_safe_app/src/domain/use_case/get_user_use_case.dart';
import 'package:is_it_safe_app/src/core/interfaces/safe_bloc.dart';
import 'package:is_it_safe_app/src/domain/entity/user_entity.dart';
import 'package:is_it_safe_app/src/domain/use_case/save_user_login_use_case.dart';
import 'package:is_it_safe_app/src/components/config/safe_event.dart';

class ProfileBloc extends SafeBloC {
  final GetUserUseCase getUserUseCase;
  final SaveUserLoginUseCase saveUserLoginUseCase;

  late StreamController<SafeEvent<UserEntity>> userController;

  ProfileBloc({
    required this.getUserUseCase,
    required this.saveUserLoginUseCase,
  }) {
    init();
  }

  @override
  Future<void> init() async {
    userController = StreamController.broadcast();
    getUser();
  }

  Future<void> getUser() async {
    try {
      userController.sink.add(SafeEvent.load());
      final response = await getUserUseCase.call();
      userController.sink.add(SafeEvent.done(response));
    } on DioError catch (e) {
      //TODO colocar tratamento de erro de autenticação em todas as requisições
      if (e.response?.statusCode == 401) await doLogout();

      userController.addError(e.error);
    }
  }

  Future<void> doLogout() async {
    await saveUserLoginUseCase.call(false).then(
          (_) => Modular.to.pushNamedAndRemoveUntil(
            LoginPage.route,
            (r) => false,
          ),
        );
  }

  @override
  Future<void> dispose() async {}
}
