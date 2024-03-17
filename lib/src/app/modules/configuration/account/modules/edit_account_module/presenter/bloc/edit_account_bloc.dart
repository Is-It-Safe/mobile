import 'dart:async';

import 'package:catcher_2/catcher_2.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter_modular/flutter_modular.dart';
import 'package:is_it_safe_app/generated/l10n.dart';
import 'package:is_it_safe_app/src/app/modules/auth/modules/login/presenter/pages/login_page.dart';
import 'package:is_it_safe_app/src/app/modules/configuration/account/domain/usecases/get_genders_use_case.dart';
import 'package:is_it_safe_app/src/app/modules/configuration/account/domain/usecases/get_sexual_orientation_use_case.dart';
import 'package:is_it_safe_app/src/app/modules/configuration/account/domain/usecases/save_user_login_use_case.dart';
import 'package:is_it_safe_app/src/app/modules/configuration/account/domain/usecases/save_user_name_use_case.dart';
import 'package:is_it_safe_app/src/app/modules/configuration/account/presenter/pages/account_page.dart';
import 'package:is_it_safe_app/src/app/modules/profile/domain/models/request/resquest_update_user.dart';
import 'package:is_it_safe_app/src/app/modules/profile/domain/usecases/get_user_use_case.dart';
import 'package:is_it_safe_app/src/app/modules/profile/domain/usecases/update_user_use_case.dart';
import 'package:is_it_safe_app/src/core/constants/string_constants.dart';
import 'package:is_it_safe_app/src/core/state/safe_stream.dart';
import 'package:is_it_safe_app/src/core/util/safe_log_util.dart';
import 'package:is_it_safe_app/src/domain/entity/gender_entity.dart';
import 'package:is_it_safe_app/src/domain/entity/sexual_orientation_entity.dart';
import 'package:is_it_safe_app/src/core/interfaces/safe_bloc.dart';
import 'package:is_it_safe_app/src/app/modules/profile/domain/models/user_entity.dart';
import 'package:is_it_safe_app/src/service/api/error/error_exceptions.dart';
import 'package:mask_text_input_formatter/mask_text_input_formatter.dart';
import 'package:is_it_safe_app/src/core/extentions/validation_extentions.dart';

class EditAccountBloc extends SafeBloC {
  final GetUserUseCase getUserUseCase;
  final SaveUserLoginUseCase saveUserLoginUseCase;
  final GetSexualOrientationsUseCase getSexualOrientationsUseCase;
  final GetGendersUseCase getGendersUseCase;
  final UpdateUserUseCase updateUserUseCase;
  final SaveUserNameUseCase saveUserNameUseCase;

  final user = SafeStream<UserEntity?>(data: null);
  final updatedUser = SafeStream<UserEntity?>(data: null);
  final listGenders = SafeStream<List<GenderEntity>>(data: []);
  final listSexualOrientations =
      SafeStream<List<SexualOrientationEntity>>(data: []);
  final isButtonEnabled = SafeStream<bool>(data: false);
  final isGenderDropdownExpanded = SafeStream<bool>(data: false);
  final isSexualOrientationDropdownExpanded = SafeStream<bool>(data: false);

  final birthdayInputMask = MaskTextInputFormatter(
    mask: StringConstants.dateMask,
  );
  final nameController = TextEditingController(text: StringConstants.hyphen);

  final userIdController = TextEditingController(text: StringConstants.hyphen);
  final pronounController = TextEditingController(text: StringConstants.hyphen);
  final genderController = TextEditingController(text: StringConstants.hyphen);
  final usernameController = TextEditingController(
    text: StringConstants.hyphen,
  );
  final birthdateController = TextEditingController(
    text: StringConstants.hyphen,
  );
  final sexualOrientationController = TextEditingController(
    text: StringConstants.hyphen,
  );

  EditAccountBloc({
    required this.updateUserUseCase,
    required this.getUserUseCase,
    required this.saveUserLoginUseCase,
    required this.getGendersUseCase,
    required this.getSexualOrientationsUseCase,
    required this.saveUserNameUseCase,
  });

  @override
  Future<void> init() async {
    SafeLogUtil.instance.route(Modular.to.path);

    await getUser().whenComplete(() {
      getGenders();
      getSexualOrientations();
    });
  }

  Future<void> updateUser() async {
    updatedUser.loading();
    try {
      RequestUpdateUser request = RequestUpdateUser(
        id: int.parse(userIdController.text),
        name: nameController.text.trim(),
        nickname: usernameController.text.trim(),
        genderId: int.parse(genderController.text),
        sexualOrientationId: int.parse(sexualOrientationController.text),
        pronoun: pronounController.text,
      );
      final result = await updateUserUseCase.call(request);

      result.fold(
        (userEntity) async {
          updatedUser.data = userEntity;
          await saveUserName(userEntity.name!);
          final returnValue = EditAccountReturn(
            isAccountChanged: true
          );
          Modular.to.pop(returnValue);
          safeSnackBar.success(S.current.textInformationChangedSuccessfully);
        },
        (error) => throw Exception(error),
      );
    } catch (e, stacktrace) {
      SafeLogUtil.instance.logError(e);
      Catcher2.reportCheckedError(e, stacktrace);
      updatedUser.error(e.toString());
      safeSnackBar.error(S.current.textUnableToChangeInformation);
    }
  }

  void toogleUpdateButton() {
    isButtonEnabled.data = (nameController.text.isNotEmpty &&
        pronounController.text.isNotEmpty &&
        usernameController.text.isNotEmpty &&
        genderController.text.isNotEmpty &&
        sexualOrientationController.text.isNotEmpty);
  }

  Future<void> getUser() async {
    user.loading();
    try {
      final result = await getUserUseCase.call();
      result.fold((responseUser) async {
        _setValuesToTextControllers(responseUser);
        if (responseUser.genreId == null) {
          await loadGenderFromList(currentGender: responseUser.gender);
        }
        if (responseUser.sexualOrientationId == null) {
          await loadSexualOrientationFromList(
              currentSexualOrientation: responseUser.orientation);
        }
        user.data = responseUser;
      }, (error) => null);
    } on Exception catch (e, stacktrace) {
      user.error(e.toString());
      Catcher2.reportCheckedError(e, stacktrace);
      safeSnackBar.error(e.toString());
      if (e is UnauthorizedException) await doLogout();
    }
  }

  _setValuesToTextControllers(UserEntity user) {
    userIdController.text = user.id.toString();
    nameController.text = user.name!;
    usernameController.text = user.nickname!;
    birthdateController.text = user.birthDate!;
    pronounController.text = user.pronoun!;
    genderController.text = user.genreId.toString();
    sexualOrientationController.text = user.sexualOrientationId.toString();
  }

  Future<void> doLogout() async {
    await saveUserLoginUseCase.call(false).then(
          (_) => Modular.to.pushNamedAndRemoveUntil(
            LoginPage.route,
            (r) => false,
          ),
        );
  }

  Future<void> getGenders() async {
    try {
      if (listGenders.data.isEmpty) {
        listGenders.loading();
        final result = await getGendersUseCase.call();

        result.fold(
          (success) => listGenders.data = success,
          (error) => throw Exception(error),
        );
      }
    } catch (e, stacktrace) {
      SafeLogUtil.instance.logError(e);
      Catcher2.reportCheckedError(e, stacktrace);
      listGenders.error(e.toString());
      safeSnackBar.error(e.toString());
    }
  }

  Future<void> getSexualOrientations() async {
    try {
      if (listSexualOrientations.data.isEmpty) {
        listSexualOrientations.loading();
        final result = await getSexualOrientationsUseCase.call();
        result.fold(
          (success) => listSexualOrientations.data = success,
          (error) => throw Exception(error),
        );
      }
    } catch (e, stacktrace) {
      SafeLogUtil.instance.logError(e);
      Catcher2.reportCheckedError(e, stacktrace);
      listSexualOrientations.error(e.toString());
      safeSnackBar.error(e.toString());
    }
  }

  String validateBirthdate(String? value) {
    if (!(value ?? StringConstants.empty).isDate || value == null) {
      return S.current.textErrorInvalidDate;
    }
    return StringConstants.empty;
  }

  String? validateTextField(String? value) {
    if (!(value ?? StringConstants.empty).isName || value == null) {
      return S.current.textErrorEmptyField;
    }
    return null;
  }

  Future<void> loadGenderFromList({
    String? currentGender = StringConstants.empty,
  }) async {
    final result = await getGendersUseCase.call();
    result.fold(
      (success) {
        GenderEntity selectedGender = success.firstWhere(
          (element) => element.title == currentGender,
        );
        user.data?.genreId = selectedGender.id;
        genderController.text = selectedGender.id.toString();
      },
      (error) {},
    );
  }

  Future<void> loadSexualOrientationFromList({
    String? currentSexualOrientation = StringConstants.empty,
  }) async {
    final result = await getSexualOrientationsUseCase.call();

    result.fold(
      (success) {
        SexualOrientationEntity selectedSexualOrientation = success.firstWhere(
          (element) => element.title == currentSexualOrientation,
        );
        user.data?.sexualOrientationId = selectedSexualOrientation.id;
        sexualOrientationController.text =
            selectedSexualOrientation.id.toString();
      },
      (error) {},
    );
  }

  Future<void> saveUserName(String value) async {
    try {
      await saveUserNameUseCase.call(value);
    } catch (e, stacktrace) {
      SafeLogUtil.instance.logError(e);
      Catcher2.reportCheckedError(e, stacktrace);
    }
  }

  @override
  Future<void> dispose() async {
    user.data = null;
    updatedUser.data = null;
    nameController.clear();
    usernameController.clear();
    birthdateController.clear();
    genderController.clear();
    sexualOrientationController.clear();
    pronounController.clear();
    userIdController.clear();
  }
}
