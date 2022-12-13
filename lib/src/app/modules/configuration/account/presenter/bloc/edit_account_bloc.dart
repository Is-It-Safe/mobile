import 'dart:async';

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
    getUser();
    // getGenders();
    // getSexualOrientations();
    birthdayInputMask = MaskTextInputFormatter(mask: StringConstants.dateMask);
    sexualOrientationsController = StreamController.broadcast();
    nameController = TextEditingController();
    usernameController = TextEditingController();
    birthdateController = TextEditingController();
    gendersController = StreamController.broadcast();
    sexualOrientationController = TextEditingController();
    genderController = TextEditingController();
    upDateButtonController = StreamController.broadcast();
  }

  Future<void> updateUser() async {
    try {
      upDateUserController.sink.add(SafeEvent.load());
      RequestUpdateUser request = RequestUpdateUser(
        // id: 1,
        name: nameController.text,
        nickname: usernameController.text,
        // birthDate: isAdvanceButton == true
        //     ? birthdateController.text
        //     : StringConstants.empty,
        // pronoun: "pronounController.text",
        genderId: int.parse(genderController.text ?? 11.toString()),
        sexualOrientationId:
            int.parse(sexualOrientationController.text ?? 8.toString()),
        // profilePhoto: /* isAdvanceButton == true
        //     ? selectedProfilePhoto
        //     : */
        //     StringConstants.empty,
      );
      UserEntity userEntity = await updateUserUseCase.call(request);
      upDateUserController.sink.add(SafeEvent.done(userEntity));
    } catch (e) {
      SafeLogUtil.instance.logError(e);
      upDateUserController.sink.add(SafeEvent.error(e.toString()));
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
      final response = await getUserUseCase.call();
      userController.sink.add(SafeEvent.done(response));
    } on Exception catch (e) {
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

  Future<void> getGenders() async {
    try {
      if (listGenders.isEmpty) {
        gendersController.sink.add(SafeEvent.load());
        listGenders = await getGendersUseCase.call();
        gendersController.sink.add(SafeEvent.done(listGenders));
      }
    } catch (e) {
      SafeLogUtil.instance.logError(e);
      gendersController.sink.add(SafeEvent.error(e.toString()));
    }
  }

  Future<void> getSexualOrientations() async {
    try {
      if (listSexualOrientations.isEmpty) {
        sexualOrientationsController.sink.add(SafeEvent.load());
        listSexualOrientations = await getSexualOrientationsUseCase.call();
        sexualOrientationsController.sink.add(
          SafeEvent.done(listSexualOrientations),
        );
      }
    } catch (e) {
      SafeLogUtil.instance.logError(e);
      sexualOrientationsController.sink.add(SafeEvent.error(e.toString()));
    }
  }

  String validateBirthdate(String? value) {
    if (!ValidationUtil.date(value ?? StringConstants.empty) || value == null) {
      return S.current.textErrorInvalidDate;
    }
    return StringConstants.empty;
  }

  @override
  Future<void> dispose() async {}
}
