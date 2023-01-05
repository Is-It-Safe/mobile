import 'package:flutter/material.dart';
import 'package:is_it_safe_app/src/app/modules/auth/register/presenter/bloc/register_profile_picture_bloc.dart';
import 'package:is_it_safe_app/src/app/modules/auth/register/presenter/widgets/register_profile_pictures_button_widget.dart';
import 'package:is_it_safe_app/src/core/state/safe_builder.dart';
import 'package:is_it_safe_app/src/core/state/safe_state.dart';
import 'package:is_it_safe_app/src/l10n/l10n.dart';
import 'package:is_it_safe_app/src/components/widgets/safe_app_bar.dart';
import 'package:is_it_safe_app/src/components/widgets/safe_profile_avatar.dart';

class RegisterProfilePicturePage extends StatefulWidget {
  static const route = '/profile-picture';
  const RegisterProfilePicturePage({Key? key}) : super(key: key);

  @override
  State<RegisterProfilePicturePage> createState() =>
      _RegisterProfilePicturePageState();
}

class _RegisterProfilePicturePageState
    extends SafeState<RegisterProfilePicturePage, RegisterProfilePictureBloc> {
  final _scaffoldKey = GlobalKey<ScaffoldState>();

  @override
  void initState() {
    super.initState();
    bloc.getProfilePicturePathsList(context);
  }

  @override
  Widget build(BuildContext context) {
    super.build(context);
    return Scaffold(
      key: _scaffoldKey,
      appBar: SafeAppBar(
        title: S.current.textAppBarChooseProfilePhotoPage,
      ),
      body: SafeBuilder3<List<String>, String, String>(
          stream1: bloc.store.listProfilePicturePaths,
          stream2: bloc.store.selectedProfilePhoto,
          stream3: bloc.store.temporarySelectedProfilePhoto,
          builder: (
            listProfilePicturePaths,
            selectedProfilePhoto,
            tempSelectedProfilePhoto,
          ) {
            //tempSelectedProfilePhoto = selectedProfilePhoto;
            return Padding(
              padding: const EdgeInsets.symmetric(horizontal: 30.0),
              child: Stack(
                children: [
                  GridView.builder(
                    shrinkWrap: true,
                    padding: const EdgeInsets.only(bottom: 100),
                    gridDelegate:
                        const SliverGridDelegateWithFixedCrossAxisCount(
                      crossAxisCount: 3,
                      crossAxisSpacing: 30,
                      mainAxisSpacing: 10,
                    ),
                    itemCount: listProfilePicturePaths.length,
                    itemBuilder: (context, index) {
                      return SafeProfileAvatar(
                        image: listProfilePicturePaths[index],
                        isSelected: tempSelectedProfilePhoto ==
                            listProfilePicturePaths[index],
                        type: ProfileAvatarType.animated,
                        onTap: () => bloc.setTempProfilePicture(
                          listProfilePicturePaths[index],
                        ),
                      );
                    },
                  ),
                  RegisterProfilePictureButtonsWidget(
                    selectedProfilePhoto: tempSelectedProfilePhoto,
                    onSavePhotoSuccess: () {
                      bloc.setProfilePicture(tempSelectedProfilePhoto);
                      bloc.setTempProfilePicture(tempSelectedProfilePhoto);
                    },
                    onSavePhotoError: () => bloc.safeSnackBar.alert(
                      S.current.textSelectAPicture,
                    ),
                    onCanceled: () => bloc.setTempProfilePicture(
                      selectedProfilePhoto,
                    ),
                  ),
                ],
              ),
            );
          }),
    );
  }
}
