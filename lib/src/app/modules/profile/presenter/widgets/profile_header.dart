import 'package:flutter/material.dart';
import 'package:is_it_safe_app/src/app/modules/profile/presenter/bloc/profile_bloc.dart';

import '../../../../../components/config/safe_event.dart';
import '../../../../../components/config/safe_layout.dart';
import '../../../../../components/widgets/safe_profile_header.dart';
import '../../../../../domain/entity/user_entity.dart';

class ProfileHeader extends StatelessWidget {
  final ProfileBloc controller;
  const ProfileHeader({Key? key, required this.controller}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return StreamBuilder<SafeStream<UserEntity>>(
        stream: controller.userController.stream,
        builder: (context, snapshot) {
          final user = snapshot.data?.data;
          return SafeLayout(
            snapshot: snapshot,
            showErrorDialog: false,
            onEmpty: const SafeProfileHeader(),
            onError: const SafeProfileHeader(),
            //TODO salvar o usuário no shared preferences
            onCompleted: SafeProfileHeader(
              nickname: user?.nickname,
              //TODO descomentar a foto
              //photo: user?.profilePhoto,
              pronoun: user?.pronoun,
              gender: user?.gender,
              sexualOrientation: user?.orientation,
            ),
          );
        });
  }
}
