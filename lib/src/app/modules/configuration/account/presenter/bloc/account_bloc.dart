import 'dart:async';

import 'package:flutter_modular/flutter_modular.dart';
import 'package:is_it_safe_app/src/app/modules/auth/login/presenter/pages/login_page.dart';
import 'package:is_it_safe_app/src/components/widgets/safe_profile_picture/bloc/safe_profile_picture_bloc.dart';
import 'package:is_it_safe_app/src/domain/use_case/get_user_use_case.dart';
import 'package:is_it_safe_app/src/core/interfaces/safe_bloc.dart';
import 'package:is_it_safe_app/src/domain/entity/user_entity.dart';
import 'package:is_it_safe_app/src/domain/use_case/save_user_image_use_case.dart';
import 'package:is_it_safe_app/src/domain/use_case/save_user_login_use_case.dart';
import 'package:is_it_safe_app/src/components/config/safe_event.dart';
import 'package:is_it_safe_app/src/domain/use_case/update_user_use_case.dart';
import 'package:is_it_safe_app/src/service/api/error/error_exceptions.dart';
import 'package:is_it_safe_app/src/service/api/modules/profile/request/resquest_update_user.dart';
import 'package:result_dart/result_dart.dart';

class AccountBloc extends SafeBloC {
  final GetUserUseCase getUserUseCase;
  final UpdateUserUseCase updateUserUseCase;
  final SaveUserLoginUseCase saveUserLoginUseCase;
  final SafeProfilePictureBloC safeProfilePictureBloc;
  final SaveUserImageUseCase saveUserImageUseCase;

  late StreamController<SafeStream<UserEntity>> userController;

  AccountBloc({
    required this.getUserUseCase,
    required this.updateUserUseCase,
    required this.saveUserLoginUseCase,
    required this.safeProfilePictureBloc,
    required this.saveUserImageUseCase,
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
      userController.sink.add(SafeStream.load());
      await getUserUseCase.call().fold(
          (userEntity) => userController.sink.add(SafeStream.done(userEntity)),
          (error) => null);
    } on Exception catch (e) {
      //TODO colocar tratamento de erro de autenticação em todas as requisições
      userController.addError(e.toString());
      if (e is UnauthorizedException) await doLogout();
    }
  }

  Future<void> updateUser(RequestUpdateUser request) async {
    try {
      userController.sink.add(SafeStream.load());
      await updateUserUseCase.call(request).fold(
          (userEntity) => userController.sink.add(SafeStream.done(userEntity)),
          (error) => null);
    } on Exception catch (e) {
      //TODO colocar tratamento de erro de autenticação em todas as requisições
      userController.addError(e.toString());
      if (e is UnauthorizedException) await doLogout();
    }
  }

  Future<void> updateUserImage(String imagePath) async {
    await saveUserImageUseCase.call(imagePath);
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
