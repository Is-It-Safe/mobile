import 'package:flutter/material.dart';
import 'package:flutter_modular/flutter_modular.dart';
import 'package:is_it_safe_app/generated/l10n.dart';
import 'package:is_it_safe_app/src/app/modules/configuration/account/presenter/bloc/edit_account_bloc.dart';
import 'package:is_it_safe_app/src/app/modules/configuration/account/presenter/widgets/edit_account_banner.dart';
import 'package:is_it_safe_app/src/app/modules/configuration/account/presenter/widgets/gender_edit_account.dart';
import 'package:is_it_safe_app/src/app/modules/configuration/account/presenter/widgets/sexual_orientaion_edit_account.dart';
import 'package:is_it_safe_app/src/components/style/text/text_styles.dart';
import 'package:is_it_safe_app/src/components/widgets/safe_app_bar.dart';
import 'package:is_it_safe_app/src/components/widgets/safe_button.dart';
import 'package:is_it_safe_app/src/components/widgets/safe_dialogs.dart';
import 'package:is_it_safe_app/src/components/widgets/safe_loading.dart';
import 'package:is_it_safe_app/src/components/widgets/safe_text_form_field.dart';
import 'package:is_it_safe_app/src/app/modules/profile/domain/models/user_entity.dart';
import 'package:is_it_safe_app/src/components/config/safe_event.dart';

import '../../../../../../core/util/safe_log_util.dart';

class EditAccountPage extends StatefulWidget {
  static const route = '/edit-account/';

  const EditAccountPage({Key? key}) : super(key: key);

  @override
  State<EditAccountPage> createState() => _EditAccountPageState();
}

final _scaffoldKey = GlobalKey<ScaffoldState>();
final _formKey = GlobalKey<FormState>();
bool isGenderDropdownExpanded = false;
bool isSexualOrientationDropdownExpanded = false;

class _EditAccountPageState
    extends ModularState<EditAccountPage, EditAccountBloc> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
        key: _scaffoldKey,
        appBar: SafeAppBar(
          title: S.current.textConfiguration,
        ),
        body: Form(
          key: _formKey,
          child: SingleChildScrollView(
            padding: const EdgeInsets.only(left: 20, right: 20),
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                EditAccountBanner(text: S.current.textEditPersonalInformation),
                const SizedBox(height: 16),
                _mountEditNameField(),
                const SizedBox(height: 16),
                _mountEditNickNameField(),
                const SizedBox(height: 16),
                _mountEditPronoun(),
                const SizedBox(height: 16),
                SexualOrientationEditAcount(
                  controller: controller.sexualOrientationsController,
                  sexualOrientationController:
                      controller.sexualOrientationController,
                  isSexualOrientationDropdownExpanded:
                      isSexualOrientationDropdownExpanded,
                ),
                const SizedBox(height: 16),
                GenderEditAcount(
                  controller: controller.gendersController,
                  genderController: controller.genderController,
                  isGenderDropdownExpanded: isGenderDropdownExpanded,
                ),
                const SizedBox(height: 24),
                _mountUpdateUserButton(),
                const SizedBox(height: 20),
              ],
            ),
          ),
        ));
  }

  Widget _mountUpdateUserButton() {
    return StreamBuilder<SafeStream<UserEntity>>(
        stream: controller.userController.stream,
        builder: (context, snapshot) {
          final userId = snapshot.data?.data!.id;
          switch (snapshot.data?.status) {
            case Status.loading:
              return SafeButton(
                  title: S.current.textUpdateInformation,
                  size: ButtonSize.large,
                  state: ButtonState.disabled,
                  onTap: () async {});

            case Status.error:
              showDialog(
                context: context,
                builder: (context) => SafeDialog(
                  primaryBtn: SafeButton(
                      title: S.current.textSafeDialogTypeError,
                      size: ButtonSize.large,
                      state: ButtonState.disabled,
                      onTap: () async {}),
                  type: SafeDialogType.error,
                  message: snapshot.data!.message.toString(),
                ),
              );
              break;
            case Status.done:
              return SafeButton(
                title: S.current.textUpdateInformation,
                size: ButtonSize.large,
                state: ButtonState.rest,
                onTap: () async {
                  _formKey.currentState?.save();
                  bool status = await controller.updateUser(userId: userId!);
                  if (status) {
                    controller.safeSnackBar
                        .success(S.current.textInformationChangedSuccessfully);

                    Modular.to.pop();
                    Modular.to.pop();
                  } else {
                    controller.safeSnackBar.error(
                      S.current.textUnableToChangeInformation,
                    );
                  }
                },
              );
            default:
              return SafeButton(
                  title: S.current.textUpdateInformation,
                  size: ButtonSize.large,
                  state: ButtonState.disabled,
                  onTap: () async {});
          }
          return const SizedBox.shrink();
        });
  }

  Widget _mountEditNameField() {
    return StreamBuilder<SafeStream<UserEntity>>(
        stream: controller.userController.stream,
        builder: (context, snapshot) {
          switch (snapshot.data?.status) {
            case Status.loading:
              return const SafeLoading();
            case Status.error:
              showDialog(
                context: context,
                builder: (context) => SafeDialog(
                  primaryBtn: SafeButton(
                      title: S.current.textSafeDialogTypeError,
                      size: ButtonSize.large,
                      state: ButtonState.disabled,
                      onTap: () async {}),
                  type: SafeDialogType.error,
                  message: snapshot.data!.message.toString(),
                ),
              );
              break;
            case Status.done:
              // controller.nameController.text = name!;
              return Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  Padding(
                    padding: const EdgeInsets.only(left: 8.0),
                    child: Text(
                      S.current.textName,
                      style: TextStyles.subtitle1(),
                    ),
                  ),
                  const SizedBox(height: 8),
                  SafeTextFormField(
                    controller: controller.nameController,
                    labelText: S.current.textName,
                    keyboardType: TextInputType.name,
                    validator: (value) => controller.validateTextField(value),
                    onChanged: (value) => controller.toogleUpdateButton(),
                  )
                ],
              );

            default:
              return Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  Padding(
                    padding: const EdgeInsets.only(left: 8.0),
                    child: Text(
                      S.current.textName,
                      style: TextStyles.subtitle1(),
                    ),
                  ),
                  const SizedBox(height: 8),
                  const SafeLoading(),
                ],
              );
          }
          return const SizedBox.shrink();
        });
  }

  Widget _mountEditNickNameField() {
    return StreamBuilder<SafeStream<UserEntity>>(
        stream: controller.userController.stream,
        builder: (context, snapshot) {
          switch (snapshot.data?.status) {
            case Status.loading:
              return const SafeLoading();
            case Status.error:
              showDialog(
                context: context,
                builder: (context) => SafeDialog(
                  primaryBtn: SafeButton(
                      title: S.current.textSafeDialogTypeError,
                      size: ButtonSize.large,
                      state: ButtonState.disabled,
                      onTap: () async {}),
                  type: SafeDialogType.error,
                  message: snapshot.data!.message.toString(),
                ),
              );
              break;
            case Status.done:
              return Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    Padding(
                      padding: const EdgeInsets.only(left: 8.0),
                      child: Text(
                        S.current.textUsername,
                        style: TextStyles.subtitle1(),
                      ),
                    ),
                    const SizedBox(height: 8),
                    SafeTextFormField(
                      controller: controller.usernameController,
                      labelText: S.current.textUsername,
                      keyboardType: TextInputType.name,
                      onChanged: (value) => controller.toogleUpdateButton(),
                      validator: (value) => controller.validateTextField(value),
                    ),
                  ]);
            default:
              return Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  Padding(
                    padding: const EdgeInsets.only(left: 8.0),
                    child: Text(
                      S.current.textUsername,
                      style: TextStyles.subtitle1(),
                    ),
                  ),
                  const SizedBox(height: 8),
                  const SafeLoading(),
                ],
              );
          }
          return const SizedBox.shrink();
        });
  }

  Widget _mountEditPronoun() {
    return StreamBuilder<SafeStream<UserEntity>>(
        stream: controller.userController.stream,
        builder: (context, snapshot) {
          switch (snapshot.data?.status) {
            case Status.loading:
              return const SafeLoading();
            case Status.error:
              showDialog(
                context: context,
                builder: (context) => SafeDialog(
                  primaryBtn: SafeButton(
                      title: S.current.textSafeDialogTypeError,
                      size: ButtonSize.large,
                      state: ButtonState.disabled,
                      onTap: () async {}),
                  type: SafeDialogType.error,
                  message: snapshot.data!.message.toString(),
                ),
              );
              break;
            case Status.done:
              return Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  Padding(
                    padding: const EdgeInsets.only(left: 8.0),
                    child: Text(
                      S.current.textPronouns,
                      style: TextStyles.subtitle1(),
                    ),
                  ),
                  const SizedBox(height: 8),
                  SafeTextFormField(
                    controller: controller.pronounController,
                    labelText: S.current.textPronouns,
                    keyboardType: TextInputType.name,
                    validator: (value) => controller.validateTextField(value),
                    onChanged: (value) => controller.toogleUpdateButton(),
                  )
                ],
              );

            default:
              return Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  Padding(
                    padding: const EdgeInsets.only(left: 8.0),
                    child: Text(
                      S.current.textPronouns,
                      style: TextStyles.subtitle1(),
                    ),
                  ),
                  const SizedBox(height: 8),
                  const SafeLoading(),
                ],
              );
          }
          return const SizedBox.shrink();
        });
  }

  @override
  void initState() {
    super.initState();
    SafeLogUtil.instance.route(Modular.to.path);
  }
}
