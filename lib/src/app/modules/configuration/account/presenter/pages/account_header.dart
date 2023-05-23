import 'package:flutter/material.dart';
import 'package:is_it_safe_app/src/components/widgets/safe_profile_header.dart';
import 'package:is_it_safe_app/src/core/state/safe_builder.dart';
import 'package:is_it_safe_app/src/core/state/safe_stream.dart';
import 'package:is_it_safe_app/src/app/modules/profile/domain/models/user_entity.dart';

class AccountHeader extends StatefulWidget {
  final SafeStream<UserEntity> user;
  final Function() navigateToChangeProfilePicture;
  const AccountHeader({
    super.key,
    required this.user,
    required this.navigateToChangeProfilePicture,
  });

  @override
  State<AccountHeader> createState() => _AccountHeaderState();
}

class _AccountHeaderState extends State<AccountHeader> {
  @override
  Widget build(BuildContext context) {
    return SafeBuilder<UserEntity>(
      stream: widget.user,
      builder: (user) {
        return SafeProfileHeader(
          nickname: user.nickname,
          photo: user.profilePhoto,
          pronoun: user.pronoun,
          gender: user.gender,
          sexualOrientation: user.orientation,
          isEditable: true,
          onPhotoTap: () => widget.navigateToChangeProfilePicture(),
        );
      },
    );
  }
}
