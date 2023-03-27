import 'package:flutter/material.dart';
import 'package:flutter_modular/flutter_modular.dart';
import 'package:is_it_safe_app/generated/l10n.dart';
import 'package:is_it_safe_app/src/components/style/colors/safe_colors.dart';
import 'package:is_it_safe_app/src/components/widgets/safe_app_bar.dart';
import 'package:is_it_safe_app/src/components/widgets/safe_button.dart';
import 'package:is_it_safe_app/src/components/widgets/safe_profile_avatar.dart';
import 'package:is_it_safe_app/src/components/widgets/safe_profile_picture/bloc/safe_profile_picture_bloc.dart';
import 'package:is_it_safe_app/src/core/util/safe_log_util.dart';

class SafeProfilePicturePage extends StatefulWidget {
  static const route = '/profile-picture';
  const SafeProfilePicturePage({Key? key}) : super(key: key);

  @override
  State<SafeProfilePicturePage> createState() => _SafeProfilePicturePageState();
}

class _SafeProfilePicturePageState extends State<SafeProfilePicturePage> {
  final controller = Modular.get<SafeProfilePictureBloC>();
  final _scaffoldKey = GlobalKey<ScaffoldState>();
  late String userAvatarPath;

  @override
  void initState() {
    super.initState();
    SafeLogUtil.instance.route(Modular.to.path);
    _getProfilePictures();
  }

  void _getProfilePictures() async {
    await controller
        .getProfilePicturePathsList(context)
        .whenComplete(() => setState(() {}));
  }

  @override
  Widget build(BuildContext context) {
    userAvatarPath = controller.selectedProfilePhoto;
    return Scaffold(
      key: _scaffoldKey,
      appBar: SafeAppBar(
        title: S.current.textAppBarChooseProfilePhotoPage,
      ),
      body: Padding(
        padding: const EdgeInsets.symmetric(horizontal: 30.0),
        child: Stack(
          children: [
            GridView.builder(
              shrinkWrap: true,
              padding: const EdgeInsets.only(bottom: 100),
              gridDelegate: const SliverGridDelegateWithFixedCrossAxisCount(
                crossAxisCount: 3,
                crossAxisSpacing: 30,
                mainAxisSpacing: 10,
              ),
              itemCount: controller.listProfilePicturePaths.length,
              itemBuilder: (context, index) {
                var avatarPaths = controller.listProfilePicturePaths;
                return SafeProfileAvatar(
                  image: avatarPaths[index],
                  isSelected: userAvatarPath == avatarPaths[index],
                  type: ProfileAvatarType.animated,
                  onTap: () => setState(() {
                    userAvatarPath = avatarPaths[index];
                    controller.setProfilePicture(userAvatarPath);
                  }),
                );
              },
            ),
            _mountButtons(),
          ],
        ),
      ),
    );
  }

  Widget _mountButtons() {
    return Align(
      alignment: Alignment.bottomCenter,
      child: Container(
        height: 100,
        alignment: Alignment.center,
        color: SafeColors.generalColors.background,
        child: Row(
          mainAxisAlignment: MainAxisAlignment.spaceBetween,
          children: [
            _mountCancelButton(),
            _mountConfirmButton(),
          ],
        ),
      ),
    );
  }

  Widget _mountConfirmButton() {
    return SafeButton(
      title: S.current.textConfirm,
      size: ButtonSize.small,
      onTap: () {
        if (controller.selectedProfilePhoto.isEmpty) {
          controller.safeSnackBar.error(S.current.textSelectAPicture);
        } else {
          Modular.to.pop(userAvatarPath);
        }
      },
    );
  }

  Widget _mountCancelButton() {
    return SafeButton(
      title: S.current.textCancel,
      hasBackground: false,
      size: ButtonSize.small,
      onTap: () => Modular.to.pop(),
    );
  }
}
