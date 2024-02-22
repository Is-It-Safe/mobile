import 'package:flutter/material.dart';
import 'package:is_it_safe_app/generated/l10n.dart';
import 'package:is_it_safe_app/src/app/modules/auth/modules/register/presenter/widgets/stream_safe_dropdown.dart';
import 'package:is_it_safe_app/src/app/modules/configuration/account/modules/edit_account_module/presenter/bloc/edit_account_bloc.dart';
import 'package:is_it_safe_app/src/app/modules/configuration/account/modules/edit_account_module/presenter/widgets/edit_account_banner.dart';
import 'package:is_it_safe_app/src/components/style/text/text_styles.dart';
import 'package:is_it_safe_app/src/components/widgets/safe_app_bar.dart';
import 'package:is_it_safe_app/src/components/widgets/safe_button.dart';
import 'package:is_it_safe_app/src/components/widgets/safe_loading.dart';
import 'package:is_it_safe_app/src/components/widgets/safe_text_form_field.dart';
import 'package:is_it_safe_app/src/app/modules/profile/domain/models/user_entity.dart';
import 'package:is_it_safe_app/src/core/state/safe_builder.dart';
import 'package:is_it_safe_app/src/core/state/safe_state.dart';
import 'package:is_it_safe_app/src/core/state/safe_stream.dart';
import 'package:is_it_safe_app/src/domain/entity/gender_entity.dart';
import 'package:is_it_safe_app/src/domain/entity/sexual_orientation_entity.dart';

class EditAccountPage extends StatefulWidget {
  static const route = '/edit-account/';

  const EditAccountPage({Key? key}) : super(key: key);

  @override
  State<EditAccountPage> createState() => _EditAccountPageState();
}

final _scaffoldKey = GlobalKey<ScaffoldState>();
final _formKey = GlobalKey<FormState>();

class _EditAccountPageState
    extends SafeState<EditAccountPage, EditAccountBloc> {
  @override
  Widget build(BuildContext context) {
    super.build(context);
    return Scaffold(
      key: _scaffoldKey,
      appBar: SafeAppBar(title: S.current.textEditAccount),
      body: SingleChildScrollView(
        padding: const EdgeInsets.only(left: 20, right: 20),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            EditAccountBanner(text: S.current.textEditPersonalInformation),
            SafeBuilder<UserEntity?>(
              stream: bloc.user,
              builder: (user) {
                if (user == null) return const SafeLoading();
                return Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    const SizedBox(height: 16),
                    Text(
                      S.current.textName,
                      style: TextStyles.subtitle1(),
                    ),
                    const SizedBox(height: 8),
                    SafeTextFormField(
                      controller: bloc.nameController,
                      labelText: S.current.textName,
                      keyboardType: TextInputType.name,
                      validator: (value) => bloc.validateTextField(value),
                      onChanged: (value) => bloc.toogleUpdateButton(),
                    ),
                    const SizedBox(height: 16),
                    Text(
                      S.current.textUsername,
                      style: TextStyles.subtitle1(),
                    ),
                    const SizedBox(height: 8),
                    SafeTextFormField(
                      controller: bloc.usernameController,
                      labelText: S.current.textUsername,
                      keyboardType: TextInputType.name,
                      onChanged: (value) => bloc.toogleUpdateButton(),
                      validator: (value) => bloc.validateTextField(value),
                    ),
                    const SizedBox(height: 16),
                    Text(
                      S.current.textPronouns,
                      style: TextStyles.subtitle1(),
                    ),
                    const SizedBox(height: 8),
                    SafeTextFormField(
                      controller: bloc.pronounController,
                      labelText: S.current.textPronouns,
                      keyboardType: TextInputType.name,
                      validator: (value) => bloc.validateTextField(value),
                      onChanged: (value) => bloc.toogleUpdateButton(),
                    )
                  ],
                );
              },
            ),
            const SizedBox(height: 16),
            Text(
              S.current.textSexualOrientation,
              style: TextStyles.subtitle1(),
            ),
            const SizedBox(height: 8),
            SafeBuilder<List<SexualOrientationEntity>>(
              stream: bloc.listSexualOrientations,
              builder: (listSexualOrientations) {
                if (listSexualOrientations == []) {
                  return const SafeLoading();
                }
                return StreamSafeDropdown(
                  items: bloc.listSexualOrientations,
                  textController: bloc.sexualOrientationController,
                  isDropdownExpanded: bloc.isSexualOrientationDropdownExpanded,
                  title: S.current.textSexualOrientation,
                  onChangedTitle: () => bloc.toogleUpdateButton(),
                );
              },
            ),
            const SizedBox(height: 16),
            Text(
              S.current.textGender,
              style: TextStyles.subtitle1(),
            ),
            const SizedBox(height: 8),
            SafeBuilder<List<GenderEntity>>(
              stream: bloc.listGenders,
              builder: (listGenders) {
                if (listGenders == []) {
                  return const SafeLoading();
                }
                return StreamSafeDropdown(
                  items: bloc.listGenders,
                  textController: bloc.genderController,
                  isDropdownExpanded: bloc.isGenderDropdownExpanded,
                  title: S.current.textGender,
                  onChangedTitle: () => bloc.toogleUpdateButton(),
                );
              },
            ),
            const SizedBox(height: 24),
            _UpdateUserButtonWidget(
              isButtonEnabled: bloc.isButtonEnabled,
              onTap: () async {
                _formKey.currentState?.save();
                await bloc.updateUser();
              },
            ),
            const SizedBox(height: 20),
          ],
        ),
      ),
    );
  }
}

class _UpdateUserButtonWidget extends StatelessWidget {
  final SafeStream<bool> isButtonEnabled;
  final Future<void> Function() onTap;

  const _UpdateUserButtonWidget({
    required this.onTap,
    required this.isButtonEnabled,
  });

  @override
  Widget build(BuildContext context) {
    return SafeBuilder<bool>(
      stream: isButtonEnabled,
      builder: (buttonEnabled) {
        return SafeButton(
          title: S.current.textUpdateInformation,
          size: ButtonSize.large,
          state: buttonEnabled ? ButtonState.rest : ButtonState.disabled,
          onTap: buttonEnabled ? onTap : null,
        );
      },
    );
  }
}
