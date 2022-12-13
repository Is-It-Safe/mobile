import 'package:flutter/material.dart';
import 'package:flutter_modular/flutter_modular.dart';
import 'package:is_it_safe_app/generated/l10n.dart';
import 'package:is_it_safe_app/src/app/modules/configuration/account/presenter/bloc/edit_account_bloc.dart';
import 'package:is_it_safe_app/src/app/modules/configuration/account/presenter/widgets/edit_account_banner.dart';
import 'package:is_it_safe_app/src/components/style/text/text_styles.dart';
import 'package:is_it_safe_app/src/components/widgets/safe_app_bar.dart';
import 'package:is_it_safe_app/src/components/widgets/safe_button.dart';
import 'package:is_it_safe_app/src/components/widgets/safe_dialogs.dart';
import 'package:is_it_safe_app/src/components/widgets/safe_dropdown.dart';
import 'package:is_it_safe_app/src/components/widgets/safe_loading.dart';
import 'package:is_it_safe_app/src/components/widgets/safe_text_form_field.dart';
import 'package:is_it_safe_app/src/domain/entity/gender_entity.dart';
import 'package:is_it_safe_app/src/domain/entity/sexual_orientation_entity.dart';
import 'package:is_it_safe_app/src/domain/entity/user_entity.dart';
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
      body: SingleChildScrollView(
        padding: const EdgeInsets.only(left: 20, right: 20),
        child: Form(
          key: _formKey,
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              EditAccountBanner(text: S.current.textEditPersonalInformation),
              const SizedBox(height: 16),
              _mountEditNameField(),
              const SizedBox(height: 16),
              _mountEditNickNameField(),
              const SizedBox(height: 16),
              _mountEditBirthdateField(),
              const SizedBox(height: 16),
              _mountSexualOrientationsDropdown(),
              const SizedBox(height: 16),
              _mountGenderDropdown(),
              const SizedBox(height: 24),
              _mountUpdateUserButton(),
              const SizedBox(height: 20),
            ],
          ),
        ),
      ),
    );
  }

  submit() {
    _formKey.currentState?.validate();
    Modular.to.pop(context);
  }

  Widget _mountUpdateUserButton() {
    return StreamBuilder<bool>(
      stream: controller.upDateButtonController.stream,
      initialData: false,
      builder: (context, snapshot) {
        return SafeButton(
          title: S.current.textUpdateInformation,
          size: ButtonSize.large,
          state:
              snapshot.data == true ? ButtonState.rest : ButtonState.disabled,
          onTap: () async {
            _formKey.currentState?.validate();
            if (snapshot.data == true) {
              // await controller.save();
            }
          },
        );
      },
    );
  }

  Widget _mountEditNameField() {
    return StreamBuilder<SafeEvent<UserEntity>>(
        stream: controller.userController.stream,
        builder: (context, snapshot) {
          final name = snapshot.data?.data!.name;
          switch (snapshot.data?.status) {
            case Status.loading:
              return const SafeLoading();
            case Status.error:
              showDialog(
                context: context,
                builder: (context) => SafeDialogs.error(
                  message: snapshot.data?.message,
                ),
              );
              break;
            case Status.done:
              controller.nameController.text = name!;
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
                    onChanged: (value) => controller.toogleUpdateButton(),
                  )
                ],
              );

            default:
              return const Padding(
                padding: EdgeInsets.only(top: 20.0),
                child: SafeLoading(),
              );
          }
          return const SizedBox.shrink();
        });
  }

  Widget _mountEditNickNameField() {
    return StreamBuilder<SafeEvent<UserEntity>>(
        stream: controller.userController.stream,
        builder: (context, snapshot) {
          final nickname = snapshot.data?.data!.nickname;

          switch (snapshot.data?.status) {
            case Status.loading:
              return const SafeLoading();
            case Status.error:
              showDialog(
                context: context,
                builder: (context) => SafeDialogs.error(
                  message: snapshot.data?.message,
                ),
              );
              break;
            case Status.done:
              controller.usernameController.text = nickname!;
              return Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    Padding(
                      padding: const EdgeInsets.only(left: 8.0),
                      child: Text(
                        S.current.textNickName,
                        style: TextStyles.subtitle1(),
                      ),
                    ),
                    const SizedBox(height: 8),
                    SafeTextFormField(
                      controller: controller.usernameController,
                      labelText: S.current.textUsername,
                      keyboardType: TextInputType.name,
                      onChanged: (value) => controller.toogleUpdateButton(),
                    ),
                  ]);
            default:
              return const Padding(
                padding: EdgeInsets.only(top: 20.0),
                child: SafeLoading(),
              );
          }
          return const SizedBox.shrink();
        });
  }

  Widget _mountEditBirthdateField() {
    return StreamBuilder<SafeEvent<UserEntity>>(
        stream: controller.userController.stream,
        builder: (context, snapshot) {
          final birthDate = snapshot.data?.data!.birthDate;
          switch (snapshot.data?.status) {
            case Status.loading:
              return const SafeLoading();
            case Status.error:
              showDialog(
                context: context,
                builder: (context) => SafeDialogs.error(
                  message: snapshot.data?.message,
                ),
              );
              break;
            case Status.done:
              controller.birthdateController.text = birthDate!;
              return Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  Padding(
                    padding: const EdgeInsets.only(left: 8.0),
                    child: Text(
                      S.current.textDateOfBirth,
                      style: TextStyles.subtitle1(),
                    ),
                  ),
                  const SizedBox(height: 8),
                  SafeTextFormField(
                    controller: controller.birthdateController,
                    labelText: S.current.textDateOfBirth,
                    inputFormatters: [controller.birthdayInputMask],
                    keyboardType: TextInputType.number,
                    // validator: (value) => controller.validateBirthdate(value),
                    onChanged: (value) => controller.toogleUpdateButton(),
                  )
                ],
              );
            default:
              return const Padding(
                padding: EdgeInsets.only(top: 20.0),
                child: SafeLoading(),
              );
          }
          return const SizedBox.shrink();
        });
  }
  // Column(
  //   crossAxisAlignment: CrossAxisAlignment.start,
  //   children: [
  //     Padding(
  //       padding: const EdgeInsets.only(left: 8.0),
  //       child: Text(
  //         S.current.textDateOfBirth,
  //         style: TextStyles.subtitle1(),
  //       ),
  //     ),
  //     const SizedBox(height: 8),
  //     SafeTextFormField(
  //       controller: controller.birthdateController,
  //       labelText: S.current.textDateOfBirth,
  //       inputFormatters: [controller.birthdayInputMask],
  //       keyboardType: TextInputType.number,
  //       validator: (value) => controller.validateBirthdate(value),
  //     )
  //   ],
  // );
  // }

  Widget _mountSexualOrientationsDropdown() {
    return StreamBuilder<SafeEvent<List<SexualOrientationEntity>>>(
      stream: controller.sexualOrientationsController.stream,
      builder: (context, snapshot) {
        if (snapshot.hasData) {
          switch (snapshot.data?.status ?? Status.loading) {
            case Status.done:
              return Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  Padding(
                    padding: const EdgeInsets.only(left: 8.0),
                    child: Text(
                      S.current.textSexualOrientation,
                      style: TextStyles.subtitle1(),
                    ),
                  ),
                  const SizedBox(height: 8),
                  SafeDropDown(
                    title: S.current.textSexualOrientation,
                    controller: controller.sexualOrientationController,
                    values: snapshot.data?.data ?? [],
                    isExapanded: isSexualOrientationDropdownExpanded,
                  )
                ],
              );

            case Status.loading:
              return Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  Padding(
                    padding: const EdgeInsets.only(left: 8.0),
                    child: Text(
                      S.current.textSexualOrientation,
                      style: TextStyles.subtitle1(),
                    ),
                  ),
                  const SizedBox(height: 8),
                  const SafeTextFormField(
                    dropdownType: DropdownType.loading,
                  )
                ],
              );

            case Status.error:
              return Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  Padding(
                    padding: const EdgeInsets.only(left: 8.0),
                    child: Text(
                      S.current.textSexualOrientation,
                      style: TextStyles.subtitle1(),
                    ),
                  ),
                  const SizedBox(height: 8),
                  const SafeTextFormField(
                    dropdownType: DropdownType.error,
                  )
                ],
              );
          }
        }
        return Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Padding(
              padding: const EdgeInsets.only(left: 8.0),
              child: Text(
                S.current.textSexualOrientation,
                style: TextStyles.subtitle1(),
              ),
            ),
            const SizedBox(height: 8),
            const SafeTextFormField(
              dropdownType: DropdownType.loading,
            )
          ],
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
                return Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    Padding(
                      padding: const EdgeInsets.only(left: 8.0),
                      child: Text(
                        S.current.textGender,
                        style: TextStyles.subtitle1(),
                      ),
                    ),
                    const SizedBox(height: 8),
                    SafeDropDown(
                      title: S.current.textGender,
                      controller: controller.sexualOrientationController,
                      values: snapshot.data?.data ?? [],
                      isExapanded: isGenderDropdownExpanded,
                    )
                  ],
                );

              case Status.loading:
                return Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    Padding(
                      padding: const EdgeInsets.only(left: 8.0),
                      child: Text(
                        S.current.textGender,
                        style: TextStyles.subtitle1(),
                      ),
                    ),
                    const SizedBox(height: 8),
                    const SafeTextFormField(
                      dropdownType: DropdownType.loading,
                    )
                  ],
                );

              case Status.error:
                return Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    Padding(
                      padding: const EdgeInsets.only(left: 8.0),
                      child: Text(
                        S.current.textGender,
                        style: TextStyles.subtitle1(),
                      ),
                    ),
                    const SizedBox(height: 8),
                    const SafeTextFormField(
                      dropdownType: DropdownType.error,
                    )
                  ],
                );
            }
          }
          return Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              Padding(
                padding: const EdgeInsets.only(left: 8.0),
                child: Text(
                  S.current.textGender,
                  style: TextStyles.subtitle1(),
                ),
              ),
              const SizedBox(height: 8),
              const SafeTextFormField(
                dropdownType: DropdownType.loading,
              )
            ],
          );
        });
  }

  @override
  void initState() {
    super.initState();
    SafeLogUtil.instance.route(Modular.to.path);
    controller.getGenders();
    controller.getSexualOrientations();
  }
}