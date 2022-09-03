import 'package:flutter/material.dart';
import 'package:flutter_modular/flutter_modular.dart';
import 'package:is_it_safe_app/generated/l10n.dart';
import 'package:is_it_safe_app/src/app/modules/auth/login/presenter/pages/login_page.dart';
import 'package:is_it_safe_app/src/app/modules/auth/register/presenter/bloc/register_bloc.dart';
import 'package:is_it_safe_app/src/app/modules/auth/register/presenter/pages/register_profile_picture_page.dart';
import 'package:is_it_safe_app/src/components/style/text/text_styles.dart';
import 'package:is_it_safe_app/src/components/widgets/safe_app_bar.dart';
import 'package:is_it_safe_app/src/components/widgets/safe_button.dart';
import 'package:is_it_safe_app/src/components/widgets/safe_dialogs.dart';
import 'package:is_it_safe_app/src/components/widgets/safe_dropdown.dart';
import 'package:is_it_safe_app/src/components/widgets/safe_loading.dart';
import 'package:is_it_safe_app/src/components/widgets/safe_profile_avatar.dart';
import 'package:is_it_safe_app/src/components/widgets/safe_text_form_field.dart';
import 'package:is_it_safe_app/src/core/constants/string_constants.dart';
import 'package:is_it_safe_app/src/core/util/safe_log_util.dart';
import 'package:is_it_safe_app/src/domain/entity/gender_entity.dart';
import 'package:is_it_safe_app/src/domain/entity/register_entity.dart';
import 'package:is_it_safe_app/src/domain/entity/sexual_orientation_entity.dart';
import 'package:is_it_safe_app/src/components/config/safe_event.dart';

class RegisterProfilePage extends StatefulWidget {
  static const route = '/register-profile';
  const RegisterProfilePage({Key? key}) : super(key: key);

  @override
  State<RegisterProfilePage> createState() => _RegisterProfilePageState();
}

class _RegisterProfilePageState
    extends ModularState<RegisterProfilePage, RegisterBloc> {
  final _scaffoldKey = GlobalKey<ScaffoldState>();
  final _formKey = GlobalKey<FormState>();

  bool isGenderDropdownExpanded = false;
  bool isSexualOrientationDropdownExpanded = false;

  @override
  void initState() {
    super.initState();
    SafeLogUtil.instance.route(Modular.to.path);
    onRegistrationInit();
    controller.getGenders();
    controller.getSexualOrientations();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      key: _scaffoldKey,
      appBar: SafeAppBar(
        title: S.current.textAppBarProfileRegisterPage,
        hasLeading: false,
      ),
      body: SafeArea(
        child: SingleChildScrollView(
          padding: const EdgeInsets.symmetric(horizontal: 30.0),
          child: StreamBuilder<SafeEvent<RegisterEntity>>(
              stream: controller.doRegisterController.stream,
              builder: (context, snapshot) {
                return Form(
                  key: _formKey,
                  child: Column(
                    children: [
                      _mountChooseProfileAvatar(),
                      const SizedBox(height: 30),
                      _mountBirthdateField(),
                      const SizedBox(height: 30),
                      _mountGenderDropdown(),
                      const SizedBox(height: 30),
                      _mountSexualOrientationsDropdown(),
                      const SizedBox(height: 30),
                      _mountButtons(),
                    ],
                  ),
                );
              }),
        ),
      ),
    );
  }

  void onRegistrationInit() {
    controller.doRegisterController.stream.listen((event) async {
      switch (event.status) {
        case Status.done:
          showDialog(
            context: context,
            builder: (context) => SafeDialogs.dialog(
              title: S.current.textRegisterSuccess,
              message: S.current.textRegisterSuccessMessage,
              onTap: () {
                Modular.to.pop();
                Modular.to
                    .pushNamedAndRemoveUntil(LoginPage.route, (r) => false);
              },
            ),
          );
          break;
        case Status.loading:
          const SafeLoading();
          break;
        case Status.error:
          Modular.to.pop();

          showDialog(
            context: context,
            builder: (_) => SafeDialogs.error(message: event.message),
          );
          break;
      }
    });
  }

  Widget _mountButtons() {
    return Row(
      mainAxisAlignment: MainAxisAlignment.spaceBetween,
      children: [
        SafeButton(
          title: S.current.textAdvance,
          hasBackground: false,
          size: ButtonSize.small,
          onTap: () {
            controller.doRegister(
              isAdvanceButton: true,
            );
          },
        ),
        SafeButton(
          title: S.current.textFinish,
          size: ButtonSize.small,
          onTap: () {
            controller.doRegister();
          },
        ),
      ],
    );
  }

  Widget _mountSexualOrientationsDropdown() {
    return StreamBuilder<SafeEvent<List<SexualOrientationEntity>>>(
      stream: controller.sexualOrientationsController.stream,
      builder: (context, snapshot) {
        if (snapshot.hasData) {
          switch (snapshot.data?.status ?? Status.loading) {
            case Status.done:
              return SafeDropDown(
                title: S.current.textSexualOrientation,
                controller: controller.genderController,
                values: snapshot.data?.data ?? [],
                isExapanded: isGenderDropdownExpanded,
              );

            case Status.loading:
              return const SafeTextFormField(
                dropdownType: DropdownType.loading,
              );
            case Status.error:
              return const SafeTextFormField(
                dropdownType: DropdownType.error,
              );
          }
        }
        return const SafeTextFormField(
          dropdownType: DropdownType.loading,
        );
      },
    );
  }

  Widget _mountGenderDropdown() {
    return StreamBuilder<SafeEvent<List<GenderEntity>>>(
      stream: controller.gendersController.stream,
      builder: (context, snapshot) {
        if (snapshot.hasData) {
          switch (snapshot.data?.status ?? Status.loading) {
            case Status.done:
              return SafeDropDown(
                title: S.current.textGender,
                controller: controller.genderController,
                values: snapshot.data?.data ?? [],
                isExapanded: isGenderDropdownExpanded,
              );

            case Status.loading:
              return const SafeTextFormField(
                dropdownType: DropdownType.loading,
              );
            case Status.error:
              return const SafeTextFormField(
                dropdownType: DropdownType.error,
              );
          }
        }
        return const SafeTextFormField(
          dropdownType: DropdownType.loading,
        );
      },
    );
  }

  Widget _mountBirthdateField() {
    return SafeTextFormField(
      controller: controller.birthdateController,
      labelText: S.current.textDateOfBirth,
      inputFormatters: [controller.birthdayInputMask],
      keyboardType: TextInputType.number,
      validator: (value) => controller.validateBirthdate(value),
    );
  }

  Widget _mountChooseProfileAvatar() {
    return Center(
      child: Column(
        children: [
          _mountProfileAvatar(),
          const SizedBox(height: 20),
          Text(
            S.current.textPageTitleProfileRegisterPage,
            style: TextStyles.subtitle2(),
          ),
          const SizedBox(height: 4),
          Text(
            S.current.textYourRepresentationHereInside,
            style: TextStyles.helper(),
          ),
        ],
      ),
    );
  }

  Widget _mountProfileAvatar() {
    return StreamBuilder<String>(
      stream: controller.profilePictureController.stream,
      builder: (context, snapshot) {
        if (snapshot.hasData) {
          return SafeProfileAvatar(
            image: controller.selectedProfilePhoto,
            onTap: _goToProfilePicturePage,
          );
        } else {
          return SafeProfileAvatar(
            isEditable: true,
            onTap: _goToProfilePicturePage,
          );
        }
      },
    );
  }

  void _goToProfilePicturePage() {
    Modular.to
        .pushNamed(StringConstants.dot + RegisterProfilePicturePage.route)
        .then((value) {
      if (value != null) {
        controller.setProfitePicture(value.toString());
      }
    });
  }
}
