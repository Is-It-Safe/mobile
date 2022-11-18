import 'package:flutter/material.dart';
import 'package:flutter_modular/flutter_modular.dart';
import 'package:is_it_safe_app/generated/l10n.dart';
import 'package:is_it_safe_app/src/app/modules/configuration/account/presenter/bloc/account_bloc.dart';
import 'package:is_it_safe_app/src/app/modules/configuration/account/presenter/widgets/account_info_button.dart';
import 'package:is_it_safe_app/src/app/modules/configuration/account/presenter/widgets/account_info_tile.dart';
import 'package:is_it_safe_app/src/app/modules/configuration/account/presenter/widgets/account_section_banner.dart';
import 'package:is_it_safe_app/src/app/modules/configuration/account/presenter/widgets/edit_account_banner.dart';
import 'package:is_it_safe_app/src/app/modules/configuration/account/presenter/widgets/edit_account_filed.dart';
import 'package:is_it_safe_app/src/components/widgets/safe_app_bar.dart';
import 'package:is_it_safe_app/src/components/widgets/safe_button.dart';
import 'package:is_it_safe_app/src/components/widgets/safe_dialogs.dart';
import 'package:is_it_safe_app/src/components/widgets/safe_loading.dart';
import 'package:is_it_safe_app/src/components/widgets/safe_profile_header.dart';
import 'package:is_it_safe_app/src/components/widgets/safe_snack_bar.dart';
import 'package:is_it_safe_app/src/components/widgets/safe_text_button.dart';
import 'package:is_it_safe_app/src/components/widgets/safe_text_form_field.dart';
import 'package:is_it_safe_app/src/domain/entity/user_entity.dart';
import 'package:is_it_safe_app/src/components/config/safe_event.dart';

class EditAccountPage extends StatefulWidget {
  static const route = '/edit-account/';

  const EditAccountPage({Key? key}) : super(key: key);

  @override
  State<EditAccountPage> createState() => _EditAccountPageState();
}

class _EditAccountPageState extends ModularState<EditAccountPage, AccountBloc> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: SafeAppBar(
        title: S.current.textConfiguration,
      ),
      body: SingleChildScrollView(
        // padding: const EdgeInsets.symmetric(vertical: 20),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            EditAccountBanner(text: S.current.textEditPersonalInformation),
            const SizedBox(height: 20),
            EditAccountField(
              title: S.current.textName,
              value: S.current.textName,
            ),
            const SizedBox(height: 20),
            EditAccountField(
              title: S.current.textNickName,
              value: S.current.textNickName,
            ),
            const SizedBox(height: 20),
            EditAccountField(
              title: S.current.textDateOfBirth,
              value: S.current.textDateOfBirth,
            ),
            const SizedBox(height: 20),
            EditAccountField(
              title: S.current.textSexualOrientation,
              value: S.current.textSexualOrientation,
            ),
            const SizedBox(height: 20),
            EditAccountField(
              title: S.current.textGender,
              value: S.current.textGender,
            ),
            const SafeButton(title: "Atualizar"),

            // _mountPersonalInfo(),
            // const SizedBox(height: 20),
            // _mountEditProfileButton(),
            // const SizedBox(height: 20),
            // AccountSextionBanner(text: S.current.textAccountInformation),
            // const SizedBox(height: 10),
            // _mountChangeEmailButton(),
            // const SizedBox(height: 20),
            // _mountChangePasswordButton(),
            // const SizedBox(height: 20),
            // _mountDisableAccountButton(),
            // const SizedBox(height: 20),
            // _mountLogoutButton(),
          ],
        ),
      ),
    );
  }

  Widget _mountPersonalInfo() {
    return StreamBuilder<SafeEvent<UserEntity>>(
        stream: controller.userController.stream,
        builder: (context, snapshot) {
          final user = snapshot.data?.data;
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
              return Padding(
                padding: const EdgeInsets.symmetric(horizontal: 33),
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    const SizedBox(height: 20),
                    AccountInfoTile(
                      title: S.current.textName,
                      value: user?.name,
                    ),
                    const SizedBox(height: 20),
                    AccountInfoTile(
                      title: S.current.textUsername,
                      value: user?.nickname,
                    ),
                    const SizedBox(height: 20),
                    AccountInfoTile(
                      title: S.current.textPronouns,
                      value: user?.pronoun,
                    ),
                    const SizedBox(height: 20),
                    AccountInfoTile(
                      title: S.current.textDateOfBirth,
                      value: user?.birthDate,
                    ),
                    const SizedBox(height: 20),
                    AccountInfoTile(
                      title: S.current.textSexualOrientation,
                      value: user?.orientation,
                    ),
                    const SizedBox(height: 20),
                    AccountInfoTile(
                      title: S.current.textGender,
                      value: user?.gender,
                    ),
                  ],
                ),
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

  Widget _mountLogoutButton() {
    return AccountInfoButton(
      text: S.current.textLogout,
      onTap: controller.doLogout,
    );
  }
}
