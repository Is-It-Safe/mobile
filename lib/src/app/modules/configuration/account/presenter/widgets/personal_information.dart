import 'package:flutter/material.dart';
import 'package:is_it_safe_app/generated/l10n.dart';
import 'package:is_it_safe_app/src/app/modules/configuration/account/presenter/bloc/account_bloc.dart';
import 'package:is_it_safe_app/src/components/config/safe_event.dart';
import 'package:is_it_safe_app/src/components/widgets/safe_button.dart';
import 'package:is_it_safe_app/src/components/widgets/safe_dialogs.dart';
import 'package:is_it_safe_app/src/components/widgets/safe_loading.dart';
import 'package:is_it_safe_app/src/domain/entity/user_entity.dart';

import 'account_info_tile.dart';

class PersonalInformation extends StatelessWidget {
  final AccountBloc controller;
  const PersonalInformation({
    Key? key,
    required this.controller,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
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
}
