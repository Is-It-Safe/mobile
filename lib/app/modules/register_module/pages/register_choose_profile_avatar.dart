import 'package:flutter/material.dart';
import 'package:flutter_modular/flutter_modular.dart';
import 'package:is_it_safe_app/app/modules/register_module/register_bloc.dart';
import 'package:is_it_safe_app/core/components/app_bar.dart';
import 'package:is_it_safe_app/app/modules/register_module/components/profile_avatar_item.dart';
import 'package:is_it_safe_app/core/components/secondary_button.dart';
import 'package:is_it_safe_app/core/utils/helper/log.dart';
import 'package:is_it_safe_app/core/utils/style/colors/general_colors.dart';
import 'package:is_it_safe_app/core/utils/style/themes/text_styles.dart';
import 'package:is_it_safe_app/generated/l10n.dart';

class RegisterChooseProfileAvatarWidget extends StatefulWidget {
  const RegisterChooseProfileAvatarWidget({Key? key}) : super(key: key);

  @override
  _RegisterChooseProfileAvatarWidgetState createState() =>
      _RegisterChooseProfileAvatarWidgetState();
}

class _RegisterChooseProfileAvatarWidgetState
    extends ModularState<RegisterChooseProfileAvatarWidget, RegisterBloc> {
  final _scaffoldKey = GlobalKey<ScaffoldState>();

  @override
  void initState() {
    _loadImages();
    super.initState();
    Log.route(Modular.to.path);
    //photoListen();
  }

  void _loadImages() async {
    await controller
        .readProfileAvatarFiles(context)
        .whenComplete(() => setState(() {}));
  }

  photoListen() {
    controller.profileAvatarController.stream.listen((event) async {
      setState(() {});
    });
  }

  void _onError() {
    ScaffoldMessenger.of(context).showSnackBar(
      SnackBar(
        content: Text(
          S.of(context).textErrorEmptyAvatar,
          style: TextStyles.helper(color: kColorPrimaryLight),
        ),
        backgroundColor: kColorStatusError,
      ),
    );
  }

  @override
  Widget build(BuildContext context) {
    var userAvatarPath = controller.selectedProfileAvatarPhoto;
    return Scaffold(
      key: _scaffoldKey,
      appBar: appBar(
        context: context,
        hasLeading: true,
        title: S.of(context).textAppBarChooseProfilePhotoPage,
      ),
      body: Padding(
        padding: const EdgeInsets.symmetric(horizontal: 30.0),
        child: Stack(
          children: [
            Padding(
              padding: const EdgeInsets.only(top: 4.0, bottom: 70),
              child: GridView.builder(
                shrinkWrap: true,
                gridDelegate: const SliverGridDelegateWithFixedCrossAxisCount(
                  crossAxisCount: 3,
                  crossAxisSpacing: 30,
                  mainAxisSpacing: 10,
                ),
                itemCount: controller.profileAvatarPaths.length,
                itemBuilder: (context, index) {
                  var avatarPaths = controller.profileAvatarPaths;
                  return ProfileAvatarItem(
                    path: avatarPaths[index],
                    isSelected: userAvatarPath == avatarPaths[index],
                    onTap: () => setState(() {
                      userAvatarPath = avatarPaths[index];
                      controller.setProfileAvatar(
                        path: userAvatarPath,
                      );
                    }),
                  );
                },
              ),
            ),
            Align(
              alignment: Alignment.bottomCenter,
              child: Container(
                height: 60,
                color: kColorBackgroundLight,
                child: Row(
                  mainAxisAlignment: MainAxisAlignment.spaceBetween,
                  children: [
                    SecondaryButton(
                      text: S.of(context).textCancel,
                      onTap: () => Modular.to.pop(),
                      borderColor: Colors.transparent,
                    ),
                    SecondaryButton(
                      text: S.of(context).textConfirm,
                      onTap: () {
                        if (controller.selectedProfileAvatarPhoto.isEmpty) {
                          _onError();
                        } else {
                          //photoListen();

                          Modular.to.pop(userAvatarPath);
                        }
                      },
                    ),
                  ],
                ),
              ),
            )
          ],
        ),
      ),
    );
  }
}
