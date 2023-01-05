import 'package:flutter_modular/flutter_modular.dart';
import 'package:is_it_safe_app/src/app/modules/auth/login/presenter/pages/login_page.dart';
import 'package:is_it_safe_app/src/app/modules/auth/register/presenter/store/register_store.dart';
import 'package:is_it_safe_app/src/components/widgets/safe_snack_bar.dart';
import 'package:is_it_safe_app/src/core/constants/string_constants.dart';
import 'package:is_it_safe_app/src/core/extentions/validation_extentions.dart';
import 'package:is_it_safe_app/src/core/interfaces/safe_bloc.dart';
import 'package:is_it_safe_app/src/core/state/safe_stream.dart';
import 'package:is_it_safe_app/src/core/util/safe_log_util.dart';
import 'package:is_it_safe_app/src/domain/use_case/do_register_use_case.dart';
import 'package:is_it_safe_app/src/domain/use_case/get_genders_use_case.dart';
import 'package:is_it_safe_app/src/domain/use_case/get_sexual_orientation_use_case.dart';
import 'package:is_it_safe_app/src/l10n/l10n.dart';

class RegisterProfileBloc extends SafeBloC {
  final ISafeSnackBar safeSnackBar;
  final RegisterStore store;
  final DoRegisterUseCase doRegisterUseCase;
  final GetSexualOrientationsUseCase getSexualOrientationsUseCase;
  final GetGendersUseCase getGendersUseCase;

  final isDropdownExpanded = SafeStream<bool>(data: false);

  RegisterProfileBloc({
    required this.store,
    required this.safeSnackBar,
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
    try {
      store.listGender.loading();
      if (store.listGender.data.isEmpty) {
        store.listGender.data = await getGendersUseCase.call();
        store.listGender.show();
      }
    } catch (e) {
      store.listGender.error(StringConstants.empty);
      SafeLogUtil.instance.logError(e);
      safeSnackBar.error('$e');
    }
  }

  Future<void> getSexualOrientations() async {
    try {
      store.listSexualOrientation.loading();
      if (store.listSexualOrientation.data.isEmpty) {
        store.listSexualOrientation.data =
            await getSexualOrientationsUseCase.call();
        store.listSexualOrientation.show();
      }
    } catch (e) {
      store.listSexualOrientation.error(StringConstants.empty);
      SafeLogUtil.instance.logError(e);
      safeSnackBar.error('$e');
    }
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
      final gender = isAdvanceButton ? "${7}" : store.genderTextController.text;
      final sexualOrientation =
          isAdvanceButton ? "${2}" : store.sexualOrientationTextController.text;

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
      store.registerEntity.data = response;
      store.registerEntity.show();
      navigateToLogin();
    } catch (e) {
      SafeLogUtil.instance.logError(e);
      safeSnackBar.error('$e');
    }
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
