import 'package:flutter/material.dart';
import 'package:flutter_modular/flutter_modular.dart';
import 'package:is_it_safe_app/generated/l10n.dart';
import 'package:is_it_safe_app/src/app/modules/configuration/account/presenter/bloc/account_bloc.dart';
import 'package:is_it_safe_app/src/app/modules/configuration/account/presenter/widgets/account_info_button.dart';
import 'package:is_it_safe_app/src/app/modules/configuration/account/presenter/widgets/account_info_tile.dart';
import 'package:is_it_safe_app/src/app/modules/configuration/account/presenter/widgets/account_section_banner.dart';
import 'package:is_it_safe_app/src/components/widgets/safe_app_bar.dart';
import 'package:is_it_safe_app/src/components/widgets/safe_button.dart';
import 'package:is_it_safe_app/src/components/widgets/safe_dialogs.dart';
import 'package:is_it_safe_app/src/components/widgets/safe_loading.dart';
import 'package:is_it_safe_app/src/components/widgets/safe_profile_header.dart';
import 'package:is_it_safe_app/src/components/widgets/safe_snack_bar.dart';
import 'package:is_it_safe_app/src/domain/entity/user_entity.dart';
import 'package:is_it_safe_app/src/components/config/safe_event.dart';
import 'package:is_it_safe_app/src/service/api/modules/profile/request/resquest_update_user.dart';
import '../../../../../../components/widgets/safe_profile_picture/safe_profile_picture_page.dart';
import '../../../../../../core/constants/string_constants.dart';
import 'confirm_password.dart';

class AccountPage extends StatefulWidget {
  static const route = '/account/';

  const AccountPage({Key? key}) : super(key: key);

  @override
  State<AccountPage> createState() => _AccountPageState();
}

class _AccountPageState extends ModularState<AccountPage, AccountBloc> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: SafeAppBar(
        title: S.current.textDrawerMyAccount,
      ),
      body: SingleChildScrollView(
        padding: const EdgeInsets.symmetric(vertical: 20),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            _mountHeader(),
            const SizedBox(height: 52),
            AccountSextionBanner(text: S.current.textPersonalInformation),
            _mountPersonalInfo(),
            const SizedBox(height: 20),
            _mountEditProfileButton(),
            const SizedBox(height: 20),
            AccountSextionBanner(text: S.current.textAccountInformation),
            const SizedBox(height: 10),
            _mountChangeEmailButton(),
            const SizedBox(height: 20),
            _mountChangePasswordButton(),
            const SizedBox(height: 20),
            _mountDisableAccountButton(),
            const SizedBox(height: 20),
            _mountLogoutButton(),
          ],
        ),
      ),
    );
  }

  Widget _mountHeader() {
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
                builder: (context) => SafeDialog(
                  message:
                      snapshot.data?.message ?? S.current.textErrorDropdown,
                  primaryBtn: SafeButton(
                    title: S.current.textOk,
                  ),
                  type: SafeDialogType.error,
                ),
              );
              break;
            case Status.done:
              //TODO salvar o usuário no shared preferences
              return SafeProfileHeader(
                  nickname: user?.nickname,
                  photo: user?.profilePhoto,
                  pronoun: user?.pronoun,
                  gender: user?.gender,
                  sexualOrientation: user?.orientation,
                  isEditabled: true,
                  onPhotoTap: () {
                    Modular.to
                        .pushNamed(
                            StringConstants.dot + SafeProfilePicturePage.route)
                        .then((value) async {
                      if (value != null) {
                        setState(() {
                          controller.safeProfilePictureBloc
                              .setProfitePicture(value.toString());
                        });
                        SafeSnackBar(
                                type: SnackBarType.success,
                                message: S.current.textAvatarSuccessUpated)
                            .show(context);

                        controller.userController.stream.handleError((x) {
                          SafeSnackBar(
                                  type: SnackBarType.error,
                                  message: S.current.textFailedToUpdateAvatar)
                              .show(context);
                        });

                        await controller
                            .updateUser(RequestUpdateUser(
                          id: user!.id,
                          profilePhoto: value.toString(),
                        ))
                            .then((_) async {
                          await controller.getUser();
                        });
                      }
                    });
                  });
            default:
              return const SafeProfileHeader();
          }
          return const SafeProfileHeader();
        });
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
                builder: (context) => SafeDialog(
                  message:
                      snapshot.data?.message ?? S.current.textErrorDropdown,
                  primaryBtn: SafeButton(
                    title: S.current.textOk,
                  ),
                  type: SafeDialogType.error,
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
                      value: user!.name,
                    ),
                    const SizedBox(height: 20),
                    AccountInfoTile(
                      title: S.current.textUsername,
                      value: user.nickname,
                    ),
                    const SizedBox(height: 20),
                    AccountInfoTile(
                      title: S.current.textPronouns,
                      value: user.pronoun,
                    ),
                    const SizedBox(height: 20),
                    AccountInfoTile(
                      title: S.current.textDateOfBirth,
                      value: user.birthDate,
                    ),
                    const SizedBox(height: 20),
                    AccountInfoTile(
                      title: S.current.textSexualOrientation,
                      value: user.orientation,
                    ),
                    const SizedBox(height: 20),
                    AccountInfoTile(
                      title: S.current.textGender,
                      value: user.gender,
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

  Widget _mountEditProfileButton() {
    return AccountInfoButton(
      text: S.current.textEditProfile,
      //TODO substituir por: navegação para tela de editar conta
      onTap: () => SafeSnackBar(
        message: S.current.textFeatureAvailableSoon,
        type: SnackBarType.info,
      ).show(context),
    );
  }

  Widget _mountLogoutButton() {
    return AccountInfoButton(
      text: S.current.textLogout,
      onTap: controller.doLogout,
    );
  }

  Widget _mountChangeEmailButton() {
    return AccountInfoButton(
      text: S.current.textChangeEmail,
      //TODO substituir por: navegação para tela de editar conta//
      onTap: () => SafeSnackBar(
        message: S.current.textFeatureAvailableSoon,
        type: SnackBarType.info,
      ).show(context),
    );
  }

  Widget _mountChangePasswordButton() {
    return AccountInfoButton(
      text: S.current.textChangePassword,
      //TODO substituir por: navegação para tela de editar conta
      onTap: () => Modular.to.push(
        MaterialPageRoute(
          builder: (_) => const ConfirmPassword(),
        ),
      ),
    );
  }

  Widget _mountDisableAccountButton() {
    return AccountInfoButton(
      text: S.current.textDisableAccount,
      //TODO substituir por: navegação para tela de editar conta
      onTap: () => SafeSnackBar(
        message: S.current.textFeatureAvailableSoon,
        type: SnackBarType.info,
      ).show(context),
    );
  }
}
