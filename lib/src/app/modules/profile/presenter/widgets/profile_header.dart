import 'package:flutter/material.dart';
import 'package:is_it_safe_app/src/core/state/safe_builder.dart';
import 'package:is_it_safe_app/src/core/state/safe_stream.dart';

import '../../../../../components/widgets/safe_profile_header.dart';
import '../../../../../domain/entity/user_entity.dart';

class ProfileHeader extends StatelessWidget {
  final SafeStream<UserEntity> user;
  const ProfileHeader({Key? key, required this.user}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return SafeBuilder<UserEntity>(
      stream: user,
      builder: (user) {
        return SafeProfileHeader(
          showProfilePicture: false,
          nickname: user.nickname,
          pronoun: user.pronoun,
          gender: user.gender,
          sexualOrientation: user.orientation,
        );
      },
    );
  }
}
