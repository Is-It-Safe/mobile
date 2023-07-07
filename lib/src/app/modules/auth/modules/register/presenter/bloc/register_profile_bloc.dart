import 'package:flutter_modular/flutter_modular.dart';
import 'package:is_it_safe_app/generated/l10n.dart';
import 'package:is_it_safe_app/src/app/modules/auth/domain/usecases/do_register_use_case.dart';
import 'package:is_it_safe_app/src/app/modules/auth/modules/login/presenter/pages/login_page.dart';
import 'package:is_it_safe_app/src/app/modules/auth/modules/register/presenter/store/register_store.dart';
import 'package:is_it_safe_app/src/app/modules/configuration/account/domain/usecases/get_genders_use_case.dart';
import 'package:is_it_safe_app/src/app/modules/configuration/account/domain/usecases/get_sexual_orientation_use_case.dart';
import 'package:is_it_safe_app/src/core/constants/string_constants.dart';
import 'package:is_it_safe_app/src/core/enum/user_sign_in_enum.dart';
import 'package:is_it_safe_app/src/core/extentions/validation_extentions.dart';
import 'package:is_it_safe_app/src/core/interfaces/safe_bloc.dart';
import 'package:is_it_safe_app/src/core/state/safe_stream.dart';
import 'package:is_it_safe_app/src/core/util/safe_log_util.dart';

class RegisterProfileBloc extends SafeBloC {
  final RegisterStore store;
  final DoRegisterUseCase doRegisterUseCase;
  final GetSexualOrientationsUseCase getSexualOrientationsUseCase;
  final GetGendersUseCase getGendersUseCase;

  final isDropdownExpanded = SafeStream<bool>(data: false);

  RegisterProfileBloc({
    required this.store,
    required this.doRegisterUseCase,
    required this.getSexualOrientationsUseCase,
    required this.getGendersUseCase,
  });

  @override
  Future<void> init() async {
    SafeLogUtil.instance.route(Modular.to.path);
    if (store.listGender.data.isEmpty ||
        store.listSexualOrientation.data.isEmpty) {
      store.listGender.loading();
      store.listSexualOrientation.loading();
    }
    await Future(() {
      getGenders();
      getSexualOrientations();
    });
  }

  Future<void> getGenders() async {
    if (store.listGender.data.isEmpty) {
      final result = await getGendersUseCase.call();
      result.fold(
        (success) {
          store.listGender.data = success;
          store.listGender.show();
        },
        (failure) {
          store.listGender.error(StringConstants.empty);
          SafeLogUtil.instance.logError(failure);
          safeSnackBar.error(failure.message);
        },
      );
    }
  }

  Future<void> getSexualOrientations() async {
    if (store.listSexualOrientation.data.isEmpty) {
      final result = await getSexualOrientationsUseCase.call();
      result.fold(
        (success) {
          store.listSexualOrientation.data = success;
          store.listSexualOrientation.show();
        },
        (failure) {
          store.listSexualOrientation.error(StringConstants.empty);
          SafeLogUtil.instance.logError(failure);
          safeSnackBar.error(failure.message);
        },
      );
    }
  }

  int getInt({
    required String value,
    required int defaultValue,
    required bool isAdvanceButton,
  }) {
    if (isAdvanceButton || value.isEmpty) return defaultValue;
    return int.parse(value);
  }

  Future<void> doRegister({
    bool isAdvanceButton = false,
  }) async {
    store.registerEntity.loading();
    try {
      final birthDate = isAdvanceButton
          ? StringConstants.empty
          : store.birthdateTextController.text;
      final profilePhoto = isAdvanceButton
          ? StringConstants.empty
          : store.selectedProfilePhoto.data;
      final gender = getInt(
        defaultValue: 7,
        value: store.genderTextController.text,
        isAdvanceButton: isAdvanceButton,
      );
      final sexualOrientation = getInt(
        value: store.sexualOrientationTextController.text,
        defaultValue: 8,
        isAdvanceButton: isAdvanceButton,
      );

      final response = await doRegisterUseCase.call(
        name: _getUserData(userSignInEnum: UserSignInEnum.user),
        username: _getUserData(userSignInEnum: UserSignInEnum.nickName),
        birthDate: birthDate,
        pronoun: _getUserData(userSignInEnum: UserSignInEnum.pronouns),
        email: _getUserData(userSignInEnum: UserSignInEnum.email),
        password: _getUserData(userSignInEnum: UserSignInEnum.password),
        profilePhoto: profilePhoto,
        gender: gender,
        sexualOrientation: sexualOrientation,
      );

      response.fold(
        (success) {
          store.registerEntity.data = success;
          store.registerEntity.show();
          navigateToLogin();
          safeSnackBar.success(success.message);
        },
        (failure) {
          store.registerEntity.show();
          SafeLogUtil.instance.logError(failure);
          safeSnackBar.error(failure.message);
        },
      );
    } catch (e) {
      store.registerEntity.show();
      SafeLogUtil.instance.logError(e);
      safeSnackBar.error(e.toString());
    }
  }

  String _getUserData({
    required UserSignInEnum userSignInEnum,
  }) {
    return store.listRegisterTextFieldVO
        .firstWhere((element) => element.userSignInEnum == userSignInEnum)
        .controller
        .text;
  }

  void navigateToLogin() {
    Modular.to.pushNamedAndRemoveUntil(LoginPage.route, (r) => false);
  }

  String? validateBirthdate(String? value) {
    if (!(value ?? StringConstants.empty).isDate) {
      return S.current.textErrorInvalidDate;
    } else if (value?.isEmpty ?? false) {
      return S.current.textErrorEmptyField;
    }
    return null;
  }

  void setProfilePicture(String path) {
    store.selectedProfilePhoto.data = path;
  }

  @override
  Future<void> dispose() async {
    if (store.registerEntity.data != null) {
      store.dispose();
    }
  }
}
