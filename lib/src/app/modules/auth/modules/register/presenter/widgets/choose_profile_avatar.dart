import 'package:flutter/material.dart';
import 'package:flutter_modular/flutter_modular.dart';
import 'package:is_it_safe_app/generated/l10n.dart';
import 'package:is_it_safe_app/src/components/style/text/text_styles.dart';
import 'package:is_it_safe_app/src/components/widgets/safe_profile_avatar.dart';
import 'package:is_it_safe_app/src/core/constants/string_constants.dart';
import 'package:is_it_safe_app/src/core/state/safe_builder.dart';
import 'package:is_it_safe_app/src/core/state/safe_stream.dart';
import '../pages/register_profile_picture_page.dart';

class ChooseProfileAvatar extends StatefulWidget {
  final SafeStream<String> selectedProfilePhoto;
  final Function(String value) onSelectProfilePhoto;

  const ChooseProfileAvatar({
    Key? key,
    required this.selectedProfilePhoto,
    required this.onSelectProfilePhoto,
  }) : super(key: key);

  @override
  State<ChooseProfileAvatar> createState() => _ChooseProfileAvatarState();
}

class _ChooseProfileAvatarState extends State<ChooseProfileAvatar> {
  void _goToProfilePicturePage() {
    Modular.to
        .pushNamed(StringConstants.dot + RegisterProfilePicturePage.route)
        .then((value) {
      if (value != null) widget.onSelectProfilePhoto('$value');
    });
  }

  @override
  Widget build(BuildContext context) {
    return Center(
      child: Column(
        children: [
          SafeBuilder<String>(
            stream: widget.selectedProfilePhoto,
            builder: (selectedProfilePhoto) {
              if (selectedProfilePhoto.isNotEmpty) {
                return SafeProfileAvatar(
                  image: selectedProfilePhoto,
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
}
