import 'package:flutter/material.dart';
import 'package:flutter_modular/flutter_modular.dart';
import 'package:is_it_safe_app/app/modules/register_module/register_bloc.dart';
import 'package:is_it_safe_app/core/components/app_bar.dart';
import 'package:is_it_safe_app/core/components/profile_avatar_item.dart';
import 'package:is_it_safe_app/generated/l10n.dart';

import 'dart:developer' as dev;

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
    loadImages();
    super.initState();
    dev.log(Modular.to.path, name: "PATH");
  }

  void loadImages() async {
    await controller
        .readProfileAvatarFiles(context)
        .whenComplete(() => setState(() {}));
  }

  void onError() {
    ScaffoldMessenger.of(context).showSnackBar(
      SnackBar(
        content: Text(
          S.of(context).textErrorEmptyAvatar,
          style: Theme.of(context)
              .textTheme
              .bodyText1!
              .copyWith(fontWeight: FontWeight.w600),
        ),
        backgroundColor: Theme.of(context).primaryColor,
      ),
    );
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      key: _scaffoldKey,
      appBar: appBar(
        context: context,
        hasLeading: true,
        title: S.of(context).textAppBarChooseProfilePhotoPage,
      ),
      body: Padding(
        padding: const EdgeInsets.only(left: 30.0, right: 30.0),
        child: Stack(
          children: [
            /// Selection of avatars here.
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
                  var userAvatarPath = controller.selectedProfileAvatarPhoto;
                  return ProfileAvatarItem(
                    path: avatarPaths[index],
                    isSelected: userAvatarPath == avatarPaths[index],
                    onTap: () => setState(() {
                      controller.setProfileAvatar(
                        path: avatarPaths[index],
                      );
                    }),
                  );
                },
              ),
            ),

            /// Confirmation of avatar.
            Align(
              alignment: Alignment.bottomCenter,
              child: Container(
                height: 60,
                color: Theme.of(context).scaffoldBackgroundColor,
                child: Row(
                  mainAxisAlignment: MainAxisAlignment.spaceBetween,
                  children: [
                    TextButton(
                      onPressed: () => Modular.to.pop(),
                      child: Text(
                        S.of(context).textCancel.toUpperCase(),
                        style: Theme.of(context).textTheme.subtitle2,
                      ),
                    ),
                    TextButton(
                      onPressed: () {
                        if (controller.selectedProfileAvatarPhoto.isEmpty) {
                          onError();
                        } else {
                          Modular.to.pop();
                        }
                      },
                      child: Text(
                        S.of(context).textConfirm.toUpperCase(),
                        style: Theme.of(context).textTheme.subtitle2,
                      ),
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
