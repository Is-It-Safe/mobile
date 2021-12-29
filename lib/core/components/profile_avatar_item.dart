import 'package:flutter/material.dart';
import 'package:is_it_safe_app/core/utils/helper/helpers.dart';
import 'package:is_it_safe_app/core/utils/style/colors/general_colors.dart';

class ProfileAvatarItem extends StatelessWidget {
  final Function() onTap;
  final String path;
  final bool isSelected;
  const ProfileAvatarItem({
    Key? key,
    required this.onTap,
    required this.path,
    required this.isSelected,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return GestureDetector(
      onTap: onTap,
      child: AnimatedContainer(
        height: 50,
        duration: const Duration(milliseconds: 300),
        decoration: BoxDecoration(
          shape: BoxShape.circle,
          color: isSelected ? kColorPrimaryLight : kColorButtonSecondary,
          image: DecorationImage(
            image: AssetImage(path),
            alignment: Alignment.topCenter,
            fit: BoxFit.cover,
          ),
        ),
      ),
    );
  }
}
