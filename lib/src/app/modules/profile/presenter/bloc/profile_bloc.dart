import 'dart:async';

import 'package:dio/dio.dart';
import 'package:flutter_modular/flutter_modular.dart';
import 'package:is_it_safe_app/src/app/modules/auth/login/domain/use_case/save_user_login_use_case.dart';
import 'package:is_it_safe_app/src/app/modules/auth/login/presenter/pages/login_page.dart';
import 'package:is_it_safe_app/src/app/modules/profile/domain/use_case/get_user_use_case.dart';
import 'package:is_it_safe_app/src/core/interfaces/safe_bloc.dart';
import 'package:is_it_safe_app/src/domain/entity/user_entity.dart';
import 'package:is_it_safe_app/src/service/api/configuration/stream_response.dart';

class ProfileBloc extends SafeBloC {
  final GetUserUseCase getUserUseCase;
  final SaveUserLoginUseCase saveUserLoginUseCase;

  late StreamController<SafeResponse<UserEntity>> userController;

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
      userController.sink.add(SafeResponse.loading());
      final response = await getUserUseCase.call();
      userController.sink.add(SafeResponse.completed(data: response));
    } on DioError catch (e) {
      //TODO colocar tratamento de erro de autenticação em todas as requisições
      if (e.response?.statusCode == 401) {
        await saveUserLoginUseCase
            .call(false)
            .then((_) => Modular.to.pushReplacementNamed(LoginPage.route));
      }
      userController.sink.add(SafeResponse.error(e.toString()));
    }
  }

  @override
  Future<void> dispose() async {}
}
