import 'package:flutter/material.dart';
import 'package:flutter_modular/flutter_modular.dart';
import 'package:is_it_safe_app/src/app/modules/auth/register/presenter/bloc/register_bloc.dart';
import 'package:is_it_safe_app/src/components/style/text/text_styles.dart';
import 'package:is_it_safe_app/src/components/widgets/safe_profile_avatar.dart';
import 'package:is_it_safe_app/src/core/constants/string_constants.dart';
import 'package:is_it_safe_app/src/l10n/l10n.dart';
import '../pages/register_profile_picture_page.dart';

class ChooseProfileAvatar extends StatelessWidget {
  final RegisterBloc controller;
  const ChooseProfileAvatar({Key? key, required this.controller})
      : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Center(
      child: Column(
        children: [
          StreamBuilder<String>(
            stream: controller.profilePictureController.stream,
            builder: (context, snapshot) {
              if (snapshot.hasData) {
                return SafeProfileAvatar(
                  image: controller.selectedProfilePhoto,
                  onTap: _goToProfilePicturePage,
                );
              } else {
                return SafeProfileAvatar(
                  isEditable: true,
                  onTap: _goToProfilePicturePage,
                );
              }
            },
          ),
          const SizedBox(height: 20),
          Text(
            S.current.textPageTitleProfileRegisterPage,
            style: TextStyles.subtitle2(),
          ),
          const SizedBox(height: 4),
          Text(
            S.current.textYourRepresentationHereInside,
            style: TextStyles.helper(),
          ),
        ],
      ),
    );
  }

  void _goToProfilePicturePage() {
    Modular.to
        .pushNamed(StringConstants.dot + RegisterProfilePicturePage.route)
        .then((value) {
      if (value != null) {
        controller.setProfitePicture(value.toString());
      }
    });
  }
}
