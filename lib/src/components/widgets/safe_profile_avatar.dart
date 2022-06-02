import 'package:flutter/material.dart';
import 'package:is_it_safe_app/src/components/style/colors/safe_colors.dart';
import 'package:is_it_safe_app/src/core/constants/assets_constants.dart';

enum ProfileAvatarType {
  main,
  animated,
}

class SafeProfileAvatar extends StatelessWidget {
  final Function()? onTap;
  final String image;
  final bool isEditable;
  final double size;
  final bool isSelected;
  final ProfileAvatarType type;
  const SafeProfileAvatar({
    Key? key,
    this.onTap,
    this.image = AssetConstants.profilePicturePlaceholder,
    this.isEditable = false,
    this.isSelected = false,
    this.type = ProfileAvatarType.main,
    this.size = 120,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return GestureDetector(
      onTap: onTap,
      child: Stack(
        children: [
          _getAvatarType(),
          _mountEditButton(),
        ],
      ),
    );
  }

  Widget _getAvatarType() {
    switch (type) {
      case ProfileAvatarType.main:
        return _mountMainProfileAvatar();
      case ProfileAvatarType.animated:
        return _mountAnimatedProfileAvatar();
    }
  }

  Widget _mountAnimatedProfileAvatar() {
    return AnimatedContainer(
      height: size,
      width: size,
      duration: const Duration(milliseconds: 300),
      decoration: BoxDecoration(
        shape: BoxShape.circle,
        color: isSelected
            ? SafeColors.buttonColors.secondary
            : SafeColors.generalColors.primary,
        image: DecorationImage(
          image: AssetImage(image),
          alignment: Alignment.topCenter,
          fit: BoxFit.cover,
        ),
      ),
    );
  }

  Widget _mountMainProfileAvatar() {
    return Container(
      height: size,
      width: size,
      decoration: BoxDecoration(
        color: SafeColors.buttonColors.secondary,
        shape: BoxShape.circle,
        image: DecorationImage(
          fit: BoxFit.cover,
          alignment: Alignment.topCenter,
          image: AssetImage(image),
        ),
      ),
    );
  }

  Widget _mountEditButton() {
    return Visibility(
      visible: isEditable,
      child: Positioned(
        bottom: 0,
        right: 0,
        child: Container(
          height: 40,
          width: 40,
          decoration: BoxDecoration(
            color: SafeColors.componentsColors.iconColors.main,
            shape: BoxShape.circle,
          ),
          child: Icon(
            Icons.edit,
            color: SafeColors.generalColors.white,
          ),
        ),
      ),
    );
  }
}
