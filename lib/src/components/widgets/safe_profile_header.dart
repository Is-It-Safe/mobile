import 'package:flutter/material.dart';
import 'package:is_it_safe_app/src/components/style/colors/safe_colors.dart';
import 'package:is_it_safe_app/src/components/style/text/text_styles.dart';
import 'package:is_it_safe_app/src/components/widgets/safe_profile_avatar.dart';
import 'package:is_it_safe_app/src/core/constants/assets_constants.dart';
import 'package:is_it_safe_app/src/core/constants/string_constants.dart';

class SafeProfileHeader extends StatelessWidget {
  final String? photo;
  final String? nickname;
  final String? pronoun;
  final String? gender;
  final String? sexualOrientation;
  final bool? isEditabled;
  final bool showProfilePicture;
  final Function()? onPhotoTap;
  const SafeProfileHeader({
    Key? key,
    this.photo = PlaceHolderAssets.profileAvatar,
    this.nickname = StringConstants.empty,
    this.pronoun = StringConstants.empty,
    this.gender = StringConstants.empty,
    this.sexualOrientation = StringConstants.empty,
    this.isEditabled = false,
    this.showProfilePicture = true,
    this.onPhotoTap,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Center(
      child: Column(
        children: [
          if (showProfilePicture)
            SafeProfileAvatar(
              size: 88,
              image: photo!,
              isSelected: true,
              isEditable: isEditabled ?? false,
              onTap: onPhotoTap,
            ),
          const SizedBox(height: 10),
          Offstage(
            offstage: nickname == StringConstants.empty &&
                pronoun == StringConstants.empty,
            child: Text(
              _getNicknameAndPronounText(),
              style: TextStyles.bodyText1(),
            ),
          ),
          const SizedBox(height: 10),
          Offstage(
            offstage: gender == StringConstants.empty &&
                sexualOrientation == StringConstants.empty,
            child: Text(
              _getGenderAndOrientationText(),
              style: TextStyles.caption(
                color: SafeColors.textColors.dark,
              ),
            ),
          ),
        ],
      ),
    );
  }

  String _getNicknameAndPronounText() {
    if (nickname == StringConstants.empty && pronoun == StringConstants.empty) {
      return StringConstants.empty;
    }

    if (nickname == StringConstants.empty) return '($pronoun)';

    if (pronoun == StringConstants.empty) return '@$nickname';
    return '@$nickname ($pronoun)';
  }

  String _getGenderAndOrientationText() {
    if (gender == StringConstants.empty &&
        sexualOrientation == StringConstants.empty) {
      return StringConstants.empty;
    }

    if (sexualOrientation == StringConstants.empty) return '$sexualOrientation';

    if (gender == StringConstants.empty) return '$gender';
    return '$gender - $sexualOrientation';
  }
}
