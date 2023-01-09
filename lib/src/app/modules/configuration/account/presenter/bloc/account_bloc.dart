import 'dart:async';

import 'package:flutter_modular/flutter_modular.dart';
import 'package:is_it_safe_app/src/app/modules/auth/login/presenter/pages/login_page.dart';
import 'package:is_it_safe_app/src/components/widgets/safe_profile_picture/bloc/safe_profile_picture_bloc.dart';
import 'package:is_it_safe_app/src/domain/use_case/get_user_use_case.dart';
import 'package:is_it_safe_app/src/core/interfaces/safe_bloc.dart';
import 'package:is_it_safe_app/src/domain/entity/user_entity.dart';
import 'package:is_it_safe_app/src/domain/use_case/save_user_login_use_case.dart';
import 'package:is_it_safe_app/src/components/config/safe_event.dart';
import 'package:is_it_safe_app/src/domain/use_case/update_user_use_case.dart';
import 'package:is_it_safe_app/src/service/api/error/error_exceptions.dart';
import 'package:is_it_safe_app/src/service/api/modules/profile/request/resquest_update_user.dart';

class AccountBloc extends SafeBloC {
  final GetUserUseCase getUserUseCase;
  final UpdateUserUseCase updateUserUseCase;
  final SaveUserLoginUseCase saveUserLoginUseCase;
  final SafeProfilePictureBloC safeProfilePictureBloc;

  late StreamController<SafeEvent<UserEntity>> userController;

  AccountBloc({
    required this.getUserUseCase,
    required this.updateUserUseCase,
    required this.saveUserLoginUseCase,
    required this.safeProfilePictureBloc,
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
    } on Exception catch (e) {
      //TODO colocar tratamento de erro de autenticação em todas as requisições
      userController.addError(e.toString());
      if (e is UnauthorizedException) await doLogout();
    }
  }

  Future<void> updateUser(RequestUpdateUser request) async {
    try {
      userController.sink.add(SafeEvent.load());
      final response = await updateUserUseCase.call(request);
      userController.sink.add(SafeEvent.done(response));
    } on Exception catch (e) {
      //TODO colocar tratamento de erro de autenticação em todas as requisições
      userController.addError(e.toString());
      if (e is UnauthorizedException) await doLogout();
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
