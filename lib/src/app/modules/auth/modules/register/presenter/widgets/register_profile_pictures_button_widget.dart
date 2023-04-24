import 'package:flutter/material.dart';
import 'package:flutter_modular/flutter_modular.dart';
import 'package:is_it_safe_app/src/components/style/colors/safe_colors.dart';
import 'package:is_it_safe_app/src/components/widgets/safe_button.dart';
import 'package:is_it_safe_app/generated/l10n.dart';

class RegisterProfilePictureButtonsWidget extends StatelessWidget {
  final String selectedProfilePhoto;
  final Function() onSavePhotoError;
  final Function() onSavePhotoSuccess;
  final Function() onCanceled;
  const RegisterProfilePictureButtonsWidget({
    Key? key,
    required this.selectedProfilePhoto,
    required this.onSavePhotoError,
    required this.onSavePhotoSuccess,
    required this.onCanceled,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Align(
      alignment: Alignment.bottomCenter,
      child: Container(
        height: 100,
        alignment: Alignment.center,
        color: SafeColors.generalColors.background,
        child: Row(
          mainAxisAlignment: MainAxisAlignment.spaceBetween,
          children: [
            SafeButton(
              title: S.current.textCancel,
              hasBackground: false,
              size: ButtonSize.small,
              onTap: () {
                onCanceled();
                Modular.to.pop();
              },
            ),
            SafeButton(
              title: S.current.textConfirm,
              size: ButtonSize.small,
              onTap: () {
                if (selectedProfilePhoto.isEmpty) {
                  onSavePhotoError();
                } else {
                  onSavePhotoSuccess();
                  Modular.to.pop();
                }
              },
            ),
          ],
        ),
      ),
    );
  }
}
