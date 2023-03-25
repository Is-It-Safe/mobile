import 'package:flutter_modular/flutter_modular.dart';
import 'package:is_it_safe_app/generated/l10n.dart';
import 'package:is_it_safe_app/src/app/modules/auth/login/presenter/pages/login_page.dart';
import 'package:is_it_safe_app/src/app/modules/auth/register/presenter/store/register_store.dart';
import 'package:is_it_safe_app/src/core/constants/string_constants.dart';
import 'package:is_it_safe_app/src/core/extentions/validation_extentions.dart';
import 'package:is_it_safe_app/src/core/interfaces/safe_bloc.dart';
import 'package:is_it_safe_app/src/core/state/safe_stream.dart';
import 'package:is_it_safe_app/src/core/util/safe_log_util.dart';
import 'package:is_it_safe_app/src/domain/use_case/do_register_use_case.dart';
import 'package:is_it_safe_app/src/domain/use_case/get_genders_use_case.dart';
import 'package:is_it_safe_app/src/domain/use_case/get_sexual_orientation_use_case.dart';

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
    await getGenders();
    await getSexualOrientations();
  }

  Future<void> getGenders() async {
    store.listGender.loading();
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
    store.listSexualOrientation.loading();
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

  Future<void> doRegister({
    bool isAdvanceButton = false,
  }) async {
    store.registerEntity.loading();

    final birthDate = isAdvanceButton
        ? StringConstants.empty
        : store.birthdateTextController.text;
    final profilePhoto = isAdvanceButton
        ? StringConstants.empty
        : store.selectedProfilePhoto.data;
    final gender =
        isAdvanceButton ? 7 : int.parse(store.genderTextController.text);
    final sexualOrientation = isAdvanceButton
        ? 2
        : int.parse(store.sexualOrientationTextController.text);

    final response = await doRegisterUseCase.call(
      name: store.nameTextController.text,
      username: store.usernameTextController.text,
      birthDate: birthDate,
      pronoun: store.pronounTextController.text,
      email: store.emailTextController.text,
      password: store.passwordTextController.text,
      profilePhoto: profilePhoto,
      gender: gender,
      sexualOrientation: sexualOrientation,
    );

    response.fold(
      (success) {
        store.registerEntity.data = success;
        store.registerEntity.show();
        navigateToLogin();
      },
      (failure) {
        SafeLogUtil.instance.logError(failure);
        safeSnackBar.error(failure.message);
      },
    );
  }

  void navigateToLogin() {
    safeSnackBar.success(S.current.textRegisterSuccess);
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
    store.dispose();
  }
}
