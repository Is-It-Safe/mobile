import 'package:flutter/material.dart';
import 'package:flutter_modular/flutter_modular.dart';
import 'package:is_it_safe_app/generated/l10n.dart';
import 'package:is_it_safe_app/src/app/modules/auth/login/presenter/pages/login_page.dart';
import 'package:is_it_safe_app/src/app/modules/auth/register/presenter/bloc/register_bloc.dart';
import 'package:is_it_safe_app/src/app/modules/auth/register/presenter/pages/register_page.dart';
import 'package:is_it_safe_app/src/app/modules/auth/register/presenter/widgets/choose_profile_avatar.dart';
import 'package:is_it_safe_app/src/app/modules/auth/register/presenter/widgets/stream_safe_dropdown.dart';
import 'package:is_it_safe_app/src/components/config/safe_layout.dart';
import 'package:is_it_safe_app/src/components/widgets/safe_app_bar.dart';
import 'package:is_it_safe_app/src/components/widgets/safe_button.dart';
import 'package:is_it_safe_app/src/components/widgets/safe_dialogs.dart';
import 'package:is_it_safe_app/src/components/widgets/safe_loading.dart';
import 'package:is_it_safe_app/src/components/widgets/safe_snack_bar.dart';
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

  bool isDropdownExpanded = false;
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
              initialData: SafeEvent.initial(),
              builder: (context, snapshot) {
                return SafeLayout(
                  snapshot: snapshot,
                  onCompleted: const SizedBox.shrink(),
                  onInitial: Form(
                    key: _formKey,
                    child: Column(
                      children: [
                        ChooseProfileAvatar(controller: controller),
                        const SizedBox(height: 30),
                        SafeTextFormField(
                          controller: controller.birthdateController,
                          labelText: S.current.textDateOfBirth,
                          inputFormatters: [controller.birthdayInputMask],
                          keyboardType: TextInputType.number,
                          validator: (value) =>
                              controller.validateBirthdate(value),
                          textInputAction: TextInputAction.next,
                        ),
                        const SizedBox(height: 30),
                        StreamSafeDropdown<GenderEntity>(
                          stream: controller.gendersController.stream,
                          textController: controller.genderController,
                          isDropdownExpanded: isDropdownExpanded,
                          title: S.current.textGender,
                        ),
                        const SizedBox(height: 30),
                        StreamSafeDropdown<SexualOrientationEntity>(
                          stream:
                              controller.sexualOrientationsController.stream,
                          textController:
                              controller.sexualOrientationController,
                          isDropdownExpanded: isDropdownExpanded,
                          title: S.current.textSexualOrientation,
                        ),
                        const SizedBox(height: 30),
                        Row(
                          mainAxisAlignment: MainAxisAlignment.spaceBetween,
                          children: [
                            SafeButton(
                              title: S.current.textAdvance,
                              hasBackground: false,
                              size: ButtonSize.small,
                              onTap: () async {
                                await controller.doRegister(
                                    isAdvanceButton: true);
                              },
                            ),
                            SafeButton(
                              title: S.current.textFinish,
                              size: ButtonSize.small,
                              onTap: () async {
                                await controller.doRegister();
                              },
                            ),
                          ],
                        ),
                      ],
                    ),
                  ),
                );
              }),
        ),
      ),
    );
  }

  void onRegistrationInit() {
    controller.doRegisterController.stream.listen(
      (event) async {
        switch (event.status) {
          case Status.done:
            showDialog(
              context: context,
              builder: (context) => SafeDialog(
                title: S.current.textRegisterSuccess,
                message: S.current.textRegisterSuccessMessage,
                primaryBtn: SafeButton(
                  title: S.current.textOk,
                  onTap: () {
                    Modular.to.pop();
                    Modular.to.pushNamedAndRemoveUntil(
                      LoginPage.route,
                      (r) => false,
                    );
                  },
                ),
                type: SafeDialogType.success,
              ),
            );
            break;
          case Status.loading:
            const SafeLoading();
            break;
          case Status.error:
            showDialog(
              context: context,
              builder: (_) => SafeDialog(
                message: event.message ?? S.current.textErrorDropdown,
                primaryBtn: SafeButton(
                  title: S.current.textOk,
                  onTap: () {
                    Modular.to.pop();
                    Modular.to.pushNamedAndRemoveUntil(
                      LoginPage.route,
                      (r) => false,
                    );
                  },
                ),
                type: SafeDialogType.error,
              ),
            );
            break;
        }
      },
    );
  }
}
