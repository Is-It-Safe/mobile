import 'dart:async';

import 'package:is_it_safe_app/src/domain/use_case/get_user_use_case.dart';
import 'package:is_it_safe_app/src/core/interfaces/safe_bloc.dart';
import 'package:is_it_safe_app/src/domain/entity/user_entity.dart';
import 'package:is_it_safe_app/src/domain/use_case/save_user_login_use_case.dart';
import 'package:is_it_safe_app/src/components/config/safe_event.dart';
import 'package:is_it_safe_app/src/service/api/configuration/api_interceptors.dart';
import 'package:is_it_safe_app/src/service/api/error/error_exceptions.dart';

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
    } on Exception catch (e) {
      if (e is UnauthorizedException) await ApiInterceptors.doLogout();
      userController.addError(e.toString());
    }
  }

  @override
  Future<void> dispose() async {}
}
