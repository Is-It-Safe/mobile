import 'package:flutter/material.dart';
import 'package:is_it_safe_app/src/components/widgets/safe_profile_header.dart';
import 'package:is_it_safe_app/src/core/state/safe_builder.dart';
import 'package:is_it_safe_app/src/core/state/safe_stream.dart';
import 'package:is_it_safe_app/src/domain/entity/user_entity.dart';

class ProfileHeaderWidget extends StatefulWidget {
  final SafeStream<UserEntity?> user;
  const ProfileHeaderWidget({
    Key? key,
    required this.user,
  }) : super(key: key);

  @override
  State<ProfileHeaderWidget> createState() => _ProfileHeaderWidgetState();
}

class _ProfileHeaderWidgetState extends State<ProfileHeaderWidget> {
  @override
  Widget build(BuildContext context) {
    return SafeBuilder<UserEntity?>(
      stream: widget.user,
      onError: (_) => const SafeProfileHeader(),
      builder: (user) {
        if (user == null) {
          return const SafeProfileHeader();
        }
        return SafeProfileHeader(
          nickname: user.nickname,
          //TODO descomentar a foto
          //photo: user.profilePhoto,
          pronoun: user.pronoun,
          gender: user.gender,
          sexualOrientation: user.orientation,
        );
      },
    );
  }
}
