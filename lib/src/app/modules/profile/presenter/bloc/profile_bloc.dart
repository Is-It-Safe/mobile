import 'dart:async';

import 'package:is_it_safe_app/src/app/modules/profile/domain/use_case/get_user_use_case.dart';
import 'package:is_it_safe_app/src/core/interfaces/safe_bloc.dart';
import 'package:is_it_safe_app/src/domain/entity/user_entity.dart';
import 'package:is_it_safe_app/src/service/api/configuration/stream_response.dart';

class ProfileBloc extends SafeBloC {
  final GetUserUseCase getUserUseCase;

  late StreamController<SafeResponse<UserEntity>> userController;

  ProfileBloc({
    required this.getUserUseCase,
  }) {
    init();
  }

  @override
  Future<void> init() async {
    userController = StreamController.broadcast();
  }

  Future<void> getUser() async {
    try {
      userController.sink.add(SafeResponse.loading());
      final response = await getUserUseCase.call();
      userController.sink.add(SafeResponse.completed(data: response));
    } catch (e) {
      userController.sink.add(SafeResponse.error(e.toString()));
    }
  }

  @override
  Future<void> dispose() async {}
}
