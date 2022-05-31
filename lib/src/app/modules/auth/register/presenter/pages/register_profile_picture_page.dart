import 'package:flutter/material.dart';
import 'package:flutter_modular/flutter_modular.dart';
import 'package:is_it_safe_app/generated/l10n.dart';
import 'package:is_it_safe_app/src/app/modules/auth/register/presenter/bloc/register_bloc.dart';
import 'package:is_it_safe_app/src/app/modules/auth/register/presenter/widgets/register_profile_picture_item.dart';
import 'package:is_it_safe_app/src/components/style/colors/safe_colors.dart';
import 'package:is_it_safe_app/src/components/widgets/safe_app_bar.dart';
import 'package:is_it_safe_app/src/components/widgets/safe_button.dart';
import 'package:is_it_safe_app/src/core/util/log_util.dart';

class RegisterProfilePicturePage extends StatefulWidget {
  static const route = '/profile-picture';
  const RegisterProfilePicturePage({Key? key}) : super(key: key);

  @override
  State<RegisterProfilePicturePage> createState() =>
      _RegisterProfilePicturePageState();
}

class _RegisterProfilePicturePageState
    extends ModularState<RegisterProfilePicturePage, RegisterBloc> {
  final _scaffoldKey = GlobalKey<ScaffoldState>();
  late String userAvatarPath;

  @override
  void initState() {
    super.initState();
    LogUtil().route(Modular.to.path);
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
            _mountPhotosGridView(),
            _mountButtons(),
          ],
        ),
      ),
    );
  }

  Widget _mountPhotosGridView() {
    return Padding(
      padding: const EdgeInsets.only(top: 4.0, bottom: 70),
      child: GridView.builder(
        shrinkWrap: true,
        gridDelegate: const SliverGridDelegateWithFixedCrossAxisCount(
          crossAxisCount: 3,
          crossAxisSpacing: 30,
          mainAxisSpacing: 10,
        ),
        itemCount: controller.listProfilePicturePaths.length,
        itemBuilder: (context, index) {
          var avatarPaths = controller.listProfilePicturePaths;
          return RegisterProfilePictureItem(
            path: avatarPaths[index],
            isSelected: userAvatarPath == avatarPaths[index],
            onTap: () => setState(() {
              userAvatarPath = avatarPaths[index];
              controller.setProfitePicture(userAvatarPath);
            }),
          );
        },
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
          //TODO Error snackbar
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
