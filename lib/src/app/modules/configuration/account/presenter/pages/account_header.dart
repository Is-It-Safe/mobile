import 'package:flutter/material.dart';
import 'package:flutter_modular/flutter_modular.dart';
import 'package:is_it_safe_app/generated/l10n.dart';
import 'package:is_it_safe_app/src/app/modules/configuration/account/presenter/bloc/account_bloc.dart';
import 'package:is_it_safe_app/src/components/config/safe_event.dart';
import 'package:is_it_safe_app/src/components/widgets/safe_button.dart';
import 'package:is_it_safe_app/src/components/widgets/safe_dialogs.dart';
import 'package:is_it_safe_app/src/components/widgets/safe_loading.dart';
import 'package:is_it_safe_app/src/components/widgets/safe_profile_header.dart';
import 'package:is_it_safe_app/src/components/widgets/safe_profile_picture/safe_profile_picture_page.dart';
import 'package:is_it_safe_app/src/core/constants/string_constants.dart';
import 'package:is_it_safe_app/src/domain/entity/user_entity.dart';
import 'package:is_it_safe_app/src/service/api/modules/profile/request/resquest_update_user.dart';

class AccountHeader extends StatefulWidget {
  final AccountBloc controller;
  const AccountHeader({
    Key? key,
    required this.controller,
  }) : super(key: key);

  @override
  State<AccountHeader> createState() => _AccountHeaderState();
}

class _AccountHeaderState extends State<AccountHeader> {
  @override
  Widget build(BuildContext context) {
    return StreamBuilder<SafeStream<UserEntity>>(
        stream: widget.controller.userController.stream,
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
                          widget.controller.safeProfilePictureBloc
                              .setProfitePicture(value.toString());
                        });
                        widget.controller.safeSnackBar
                            .success(S.current.textAvatarSuccessUpated);

                        widget.controller.userController.stream
                            .handleError((x) {
                          widget.controller.safeSnackBar
                              .error(S.current.textFailedToUpdateAvatar);
                        });

                        await widget.controller
                            .updateUser(RequestUpdateUser(
                          id: user!.id,
                          profilePhoto: value.toString(),
                        ))
                            .then((_) async {
                          await widget.controller
                              .updateUserImage(value.toString());
                          await widget.controller.getUser();
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
}
