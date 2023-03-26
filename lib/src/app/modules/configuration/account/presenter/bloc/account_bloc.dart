import 'dart:async';

import 'package:flutter_modular/flutter_modular.dart';
import 'package:is_it_safe_app/generated/l10n.dart';
import 'package:is_it_safe_app/src/app/modules/auth/login/presenter/pages/login_page.dart';
import 'package:is_it_safe_app/src/components/widgets/safe_profile_picture/bloc/safe_profile_picture_bloc.dart';
import 'package:is_it_safe_app/src/components/widgets/safe_profile_picture/safe_profile_picture_page.dart';
import 'package:is_it_safe_app/src/core/constants/string_constants.dart';
import 'package:is_it_safe_app/src/core/state/safe_stream.dart';
import 'package:is_it_safe_app/src/domain/use_case/get_user_use_case.dart';
import 'package:is_it_safe_app/src/core/interfaces/safe_bloc.dart';
import 'package:is_it_safe_app/src/domain/entity/user_entity.dart';
import 'package:is_it_safe_app/src/domain/use_case/save_user_image_use_case.dart';
import 'package:is_it_safe_app/src/domain/use_case/save_user_login_use_case.dart';
import 'package:is_it_safe_app/src/domain/use_case/update_user_use_case.dart';
import 'package:is_it_safe_app/src/service/api/modules/profile/request/resquest_update_user.dart';

class AccountBloc extends SafeBloC {
  final GetUserUseCase getUserUseCase;
  final UpdateUserUseCase updateUserUseCase;
  final SaveUserLoginUseCase saveUserLoginUseCase;
  final SafeProfilePictureBloC safeProfilePictureBloc;
  final SaveUserImageUseCase saveUserImageUseCase;

  final user = SafeStream<UserEntity>(data: UserEntity.empty());

  AccountBloc({
    required this.getUserUseCase,
    required this.updateUserUseCase,
    required this.saveUserLoginUseCase,
    required this.safeProfilePictureBloc,
    required this.saveUserImageUseCase,
  });
  @override
  Future<void> init() async {
    getUser();
  }

  Future<void> getUser() async {
    try {
      final result = await getUserUseCase.call();

      result.fold(
        (userEntity) => user.data = userEntity,
        (error) => null,
      );
    } on Exception catch (e) {
      user.error(e.toString());
    }
  }

  Future<void> updateUser(RequestUpdateUser request) async {
    try {
      user.loading();
      final result = await updateUserUseCase.call(request);

      result.fold(
        (userEntity) {
          user.data = userEntity;
          safeSnackBar.success(S.current.textAvatarSuccessUpated);
        },
        (error) => null,
      );
    } on Exception catch (e) {
      user.error(e.toString());
    }
  }

  void navigateToChangeProfilePicture() {
    Modular.to
        .pushNamed(StringConstants.dot + SafeProfilePicturePage.route)
        .then((value) async {
      safeProfilePictureBloc.setProfilePicture(value.toString());
      user.data = user.data.copyWith(profilePhoto: value.toString());
      await updateUser(RequestUpdateUser(
        id: user.data.id,
        profilePhoto: value.toString(),
      )).then((_) async {
        await updateUserImage(value.toString());
        await getUser();
      });
    });
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
