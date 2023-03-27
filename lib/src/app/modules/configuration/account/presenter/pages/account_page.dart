import 'package:flutter/material.dart';
import 'package:flutter_modular/flutter_modular.dart';
import 'package:is_it_safe_app/generated/l10n.dart';
import 'package:is_it_safe_app/src/app/modules/configuration/account/presenter/bloc/account_bloc.dart';
import 'package:is_it_safe_app/src/app/modules/configuration/account/presenter/pages/change_password_page.dart';
import 'package:is_it_safe_app/src/app/modules/configuration/account/presenter/pages/edit_account_page.dart';
import 'package:is_it_safe_app/src/app/modules/configuration/account/presenter/widgets/account_info_button.dart';
import 'package:is_it_safe_app/src/app/modules/configuration/account/presenter/widgets/account_section_banner.dart';
import 'package:is_it_safe_app/src/app/modules/configuration/account/presenter/widgets/personal_information.dart';
import 'package:is_it_safe_app/src/components/widgets/safe_app_bar.dart';
import 'package:is_it_safe_app/src/core/state/safe_state.dart';
import '../../../../../../core/constants/string_constants.dart';
import '../../../configuration_module.dart';
import 'account_header.dart';
import 'change_email_page.dart';

class AccountPage extends StatefulWidget {
  static const route = '/account/';

  const AccountPage({Key? key}) : super(key: key);

  @override
  State<AccountPage> createState() => _AccountPageState();
}

class _AccountPageState extends SafeState<AccountPage, AccountBloc> {
  @override
  Widget build(BuildContext context) {
    super.build(context);
    return Scaffold(
      appBar: SafeAppBar(
        title: S.current.textDrawerMyAccount,
      ),
      body: SingleChildScrollView(
        padding: const EdgeInsets.symmetric(vertical: 20),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            AccountHeader(
              user: bloc.user,
              navigateToChangeProfilePicture:
                  bloc.navigateToChangeProfilePicture,
            ),
            const SizedBox(height: 52),
            AccountSectionBanner(text: S.current.textPersonalInformation),
            PersonalInformation(user: bloc.user),
            const SizedBox(height: 20),
            AccountInfoButton(
                text: S.current.textEditProfile,
                onTap: () => Modular.to.pushNamed(
                    ConfigurationModule.route + EditAccountPage.route)),
            const SizedBox(height: 20),
            AccountSectionBanner(text: S.current.textAccountInformation),
            const SizedBox(height: 10),
            AccountInfoButton(
              text: S.current.textChangeEmail,
              onTap: () async {
                await Modular.to.pushNamed(
                  StringConstants.dot + ChangeEmailPage.route,
                  arguments: bloc,
                );
              },
            ),
            const SizedBox(height: 20),
            AccountInfoButton(
              text: S.current.textChangePassword,
              onTap: () async {
                await Modular.to
                    .pushNamed(StringConstants.dot + ChangePasswordPage.route);
              },
            ),
            const SizedBox(height: 20),
            AccountInfoButton(
              text: S.current.textDisableAccount,
              onTap: () => bloc.safeSnackBar.info(
                S.current.textFeatureAvailableSoon,
              ),
            ),
            const SizedBox(height: 20),
            AccountInfoButton(
              text: S.current.textLogout,
              onTap: bloc.doLogout,
            ),
          ],
        ),
      ),
    );
  }
}
