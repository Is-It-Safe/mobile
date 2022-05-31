import 'package:flutter/material.dart';
import 'package:is_it_safe_app/src/components/style/colors/safe_colors.dart';

class RegisterProfilePictureItem extends StatelessWidget {
  final Function() onTap;
  final String path;
  final bool isSelected;
  final double height;
  const RegisterProfilePictureItem({
    Key? key,
    required this.onTap,
    required this.path,
    required this.isSelected,
    this.height = 50,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return GestureDetector(
      onTap: onTap,
      child: AnimatedContainer(
        height: height,
        duration: const Duration(milliseconds: 300),
        decoration: BoxDecoration(
          shape: BoxShape.circle,
          color: isSelected
              ? SafeColors.buttonColors.secondary
              : SafeColors.generalColors.primary,
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
