import 'package:flutter/material.dart';
import 'package:is_it_safe_app/src/app/modules/auth/register/presenter/bloc/register_profile_bloc.dart';
import 'package:is_it_safe_app/src/app/modules/auth/register/presenter/widgets/register_profile_button_widget.dart';
import 'package:is_it_safe_app/src/core/state/safe_builder.dart';
import 'package:is_it_safe_app/src/core/state/safe_state.dart';
import 'package:is_it_safe_app/src/l10n/l10n.dart';
import 'package:is_it_safe_app/src/app/modules/auth/register/presenter/widgets/choose_profile_avatar.dart';
import 'package:is_it_safe_app/src/app/modules/auth/register/presenter/widgets/stream_safe_dropdown.dart';
import 'package:is_it_safe_app/src/components/widgets/safe_app_bar.dart';
import 'package:is_it_safe_app/src/components/widgets/safe_text_form_field.dart';
import 'package:is_it_safe_app/src/domain/entity/gender_entity.dart';
import 'package:is_it_safe_app/src/domain/entity/register_entity.dart';
import 'package:is_it_safe_app/src/domain/entity/sexual_orientation_entity.dart';

class RegisterProfilePage extends StatefulWidget {
  static const route = '/register-profile';
  const RegisterProfilePage({Key? key}) : super(key: key);

  @override
  State<RegisterProfilePage> createState() => _RegisterProfilePageState();
}

class _RegisterProfilePageState
    extends SafeState<RegisterProfilePage, RegisterProfileBloc> {
  final _scaffoldKey = GlobalKey<ScaffoldState>();
  final _formKey = GlobalKey<FormState>();

  bool isDropdownExpanded = false;

  @override
  Widget build(BuildContext context) {
    super.build(context);
    return Scaffold(
      key: _scaffoldKey,
      appBar: SafeAppBar(
        title: S.current.textAppBarProfileRegisterPage,
        hasLeading: false,
      ),
      body: SafeArea(
        child: SingleChildScrollView(
          padding: const EdgeInsets.symmetric(horizontal: 30.0),
          child: SafeBuilder<RegisterEntity?>(
            stream: bloc.store.registerEntity,
            builder: (registerEntity) {
              return Form(
                key: _formKey,
                child: Column(
                  children: [
                    ChooseProfileAvatar(
                      selectedProfilePhoto: bloc.store.selectedProfilePhoto,
                      onSelectProfilePhoto: (value) => bloc.setProfilePicture(
                        value,
                      ),
                    ),
                    const SizedBox(height: 30),
                    SafeTextFormField(
                      controller: bloc.store.birthdateTextController,
                      labelText: S.current.textDateOfBirth,
                      inputFormatters: [bloc.store.birthdayInputMask],
                      keyboardType: TextInputType.number,
                      validator: (value) => bloc.validateBirthdate(value),
                    ),
                    const SizedBox(height: 30),
                    StreamSafeDropdown<GenderEntity>(
                      items: bloc.store.listGender,
                      textController: bloc.store.genderTextController,
                      isDropdownExpanded: bloc.isDropdownExpanded,
                      title: S.current.textGender,
                    ),
                    const SizedBox(height: 30),
                    StreamSafeDropdown<SexualOrientationEntity>(
                      items: bloc.store.listSexualOrientation,
                      textController:
                          bloc.store.sexualOrientationTextController,
                      isDropdownExpanded: bloc.isDropdownExpanded,
                      title: S.current.textSexualOrientation,
                    ),
                    const SizedBox(height: 30),
                    RegisterProfileButtonWidget(
                      onRegister: ({isAdvanceButton}) => bloc.doRegister(
                        isAdvanceButton: isAdvanceButton ?? false,
                      ),
                    ),
                  ],
                ),
              );
            },
          ),
        ),
      ),
    );
  }
}
