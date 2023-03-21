import 'dart:async';

import 'package:catcher/catcher.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter_modular/flutter_modular.dart';
import 'package:is_it_safe_app/generated/l10n.dart';
import 'package:is_it_safe_app/src/app/modules/auth/login/presenter/pages/login_page.dart';
import 'package:is_it_safe_app/src/core/constants/string_constants.dart';
import 'package:is_it_safe_app/src/core/util/safe_log_util.dart';
import 'package:is_it_safe_app/src/core/util/validation_util.dart';
import 'package:is_it_safe_app/src/domain/entity/gender_entity.dart';
import 'package:is_it_safe_app/src/domain/entity/sexual_orientation_entity.dart';
import 'package:is_it_safe_app/src/domain/use_case/get_genders_use_case.dart';
import 'package:is_it_safe_app/src/domain/use_case/get_sexual_orientation_use_case.dart';
import 'package:is_it_safe_app/src/domain/use_case/get_user_use_case.dart';
import 'package:is_it_safe_app/src/core/interfaces/safe_bloc.dart';
import 'package:is_it_safe_app/src/domain/entity/user_entity.dart';
import 'package:is_it_safe_app/src/domain/use_case/save_user_login_use_case.dart';
import 'package:is_it_safe_app/src/components/config/safe_event.dart';
import 'package:is_it_safe_app/src/domain/use_case/update_user_use_case.dart';
import 'package:is_it_safe_app/src/service/api/error/error_exceptions.dart';
import 'package:is_it_safe_app/src/service/api/modules/profile/request/resquest_update_user.dart';
import 'package:mask_text_input_formatter/mask_text_input_formatter.dart';
import 'package:result_dart/result_dart.dart';

class EditAccountBloc extends SafeBloC {
  final GetUserUseCase getUserUseCase;
  final SaveUserLoginUseCase saveUserLoginUseCase;
  final GetSexualOrientationsUseCase getSexualOrientationsUseCase;
  final GetGendersUseCase getGendersUseCase;
  final UpdateUserUseCase updateUserUseCase;

  late final MaskTextInputFormatter birthdayInputMask;

  late StreamController<SafeEvent<UserEntity>> userController;
  late StreamController<SafeEvent<List<GenderEntity>>> gendersController;
  late StreamController<SafeEvent<List<SexualOrientationEntity>>>
      sexualOrientationsController;
  late StreamController<SafeEvent<UserEntity>> upDateUserController;
  late StreamController<bool> upDateButtonController;
  late TextEditingController nameController;
  late TextEditingController usernameController;
  late TextEditingController birthdateController;
  late TextEditingController genderController;
  late TextEditingController sexualOrientationController;
  late TextEditingController userIdController;
  late TextEditingController pronounController;
  late UserEntity responseGetUSer;
  List<GenderEntity> listGenders = [];
  List<SexualOrientationEntity> listSexualOrientations = [];

  EditAccountBloc({
    required this.updateUserUseCase,
    required this.getUserUseCase,
    required this.saveUserLoginUseCase,
    required this.getGendersUseCase,
    required this.getSexualOrientationsUseCase,
  }) {
    init();
  }

  @override
  Future<void> init() async {
    userController = StreamController.broadcast();
    upDateButtonController = StreamController.broadcast();
    upDateUserController = StreamController.broadcast();
    sexualOrientationsController = StreamController.broadcast();
    gendersController = StreamController.broadcast();

    birthdayInputMask = MaskTextInputFormatter(mask: StringConstants.dateMask);

    nameController = TextEditingController();
    usernameController = TextEditingController();
    birthdateController = TextEditingController();
    sexualOrientationController = TextEditingController();
    genderController = TextEditingController();
    userIdController = TextEditingController();
    pronounController = TextEditingController();

    await getUser().whenComplete(() {
      getGenders();
      getSexualOrientations();
    });
  }

  Future<bool> updateUser({required int userId}) async {
    try {
      upDateUserController.sink.add(SafeEvent.load());
      RequestUpdateUser request = RequestUpdateUser(
        id: int.parse(userIdController.text),
        name: nameController.text.trim(),
        nickname: usernameController.text.trim(),
        genderId: int.parse(genderController.text),
        sexualOrientationId: int.parse(sexualOrientationController.text),
        pronoun: pronounController.text,
      );
      await updateUserUseCase.call(request).fold(
          (userEntity) =>
              upDateUserController.sink.add(SafeEvent.done(userEntity)),
          (error) => null);
      return true;
    } catch (e, stacktrace) {
      SafeLogUtil.instance.logError(e);
      Catcher.reportCheckedError(e, stacktrace);
      upDateUserController.sink.add(SafeEvent.error(e.toString()));
      return false;
    }
  }

  void toogleUpdateButton() {
    bool isRegisterButtonEnabled = (nameController.text.isNotEmpty &&
        usernameController.text.isNotEmpty &&
        genderController.text.isNotEmpty &&
        sexualOrientationController.text.isNotEmpty);
    upDateButtonController.sink.add(isRegisterButtonEnabled);
  }

  Future<void> getUser() async {
    try {
      userController.sink.add(SafeEvent.load());
      await getUserUseCase.call().fold((responseGetUSer) {
        userIdController.text = responseGetUSer.id.toString();
        nameController.text = responseGetUSer.name!;
        usernameController.text = responseGetUSer.nickname!;
        birthdateController.text = responseGetUSer.birthDate!;
        pronounController.text = responseGetUSer.pronoun!;
        genderController.text = responseGetUSer.genreId.toString();
        sexualOrientationController.text =
            responseGetUSer.sexualOrientationId.toString();
        if (responseGetUSer.genreId == null ||
          responseGetUSer.sexualOrientationId == null) {
        await Future.microtask(
          () {
            loadGenderFromList(
              currentGender: responseGetUSer.gender ?? '',
            );
            loadSexualOrientationFromList(
              currentSexualOrientation: responseGetUSer.orientation ?? '',
            );
          },
        );
      }
      userController.sink.add(SafeEvent.done(responseGetUSer));
      }, (error) => null);
    } on Exception catch (e, stacktrace) {
      userController.addError(e.toString());
      Catcher.reportCheckedError(e, stacktrace);
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

  Future<void> getGenders() async {
    try {
      if (listGenders.isEmpty) {
        gendersController.sink.add(SafeEvent.load());
        await getGendersUseCase.call().fold(
          (success) {
            listGenders = success;
          },
          (error) {},
        );
        gendersController.sink.add(SafeEvent.done(listGenders));
      }
    } catch (e, stacktrace) {
      SafeLogUtil.instance.logError(e);
      Catcher.reportCheckedError(e, stacktrace);
      gendersController.sink.add(SafeEvent.error(e.toString()));
    }
  }

  Future<void> getSexualOrientations() async {
    try {
      if (listSexualOrientations.isEmpty) {
        sexualOrientationsController.sink.add(SafeEvent.load());
        await getSexualOrientationsUseCase.call().fold(
          (success) {
            listSexualOrientations = success;
          },
          (error) {},
        );
        sexualOrientationsController.sink.add(
          SafeEvent.done(listSexualOrientations),
        );
      }
    } catch (e, stacktrace) {
      SafeLogUtil.instance.logError(e);
      Catcher.reportCheckedError(e, stacktrace);
      sexualOrientationsController.sink.add(SafeEvent.error(e.toString()));
    }
  }

  String validateBirthdate(String? value) {
    if (!ValidationUtil.date(value ?? StringConstants.empty) || value == null) {
      return S.current.textErrorInvalidDate;
    }
    return StringConstants.empty;
  }

  String validateTextField(String? value) {
    if (!ValidationUtil.name(value ?? StringConstants.empty) || value == null) {
      return S.current.textErrorEmptyField;
    }
    return StringConstants.empty;
  }

  @override
  Future<void> dispose() async {}

  Future<void> loadGenderFromList({
    required String currentGender,
  }) async {
    getGendersUseCase.call().fold(
      (success) {
        GenderEntity selectedGender = success.firstWhere(
          (element) => element.title == currentGender,
        );
        genderController.text = selectedGender.id.toString();
      },
      (error) {},
    );
  }

  Future<void> loadSexualOrientationFromList({
    required String currentSexualOrientation,
  }) async {
    getSexualOrientationsUseCase.call().fold(
      (success) {
        SexualOrientationEntity selectedSexualOrientation = success.firstWhere(
          (element) => element.title == currentSexualOrientation,
        );
        sexualOrientationController.text = selectedSexualOrientation.id.toString();
      },
      (error) {},
    );
  }
}
