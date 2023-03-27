import 'package:flutter/material.dart';
import 'package:is_it_safe_app/generated/l10n.dart';
import 'package:is_it_safe_app/src/core/state/safe_builder.dart';
import 'package:is_it_safe_app/src/core/state/safe_stream.dart';
import 'package:is_it_safe_app/src/domain/entity/user_entity.dart';

import 'account_info_tile.dart';

class PersonalInformation extends StatelessWidget {
  final SafeStream<UserEntity> user;
  const PersonalInformation({
    Key? key,
    required this.user,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return SafeBuilder<UserEntity>(
      stream: user,
      builder: (user) {
        return Padding(
          padding: const EdgeInsets.symmetric(horizontal: 33),
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              const SizedBox(height: 20),
              AccountInfoTile(
                title: S.current.textName,
                value: user.name,
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
      },
    );
  }
}
