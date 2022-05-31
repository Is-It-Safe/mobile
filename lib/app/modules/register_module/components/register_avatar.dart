import 'package:flutter/material.dart';
import 'package:is_it_safe_app/src/components/style/colors/safe_colors.dart';

class RegisterAvatar extends StatelessWidget {
  final Function()? onTap;
  final String path;
  const RegisterAvatar({
    Key? key,
    this.onTap,
    required this.path,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return GestureDetector(
      onTap: onTap,
      child: Container(
        height: 120,
        width: 120,
        decoration: BoxDecoration(
          color: SafeColors.buttonColors.secondary,
          shape: BoxShape.circle,
          image: DecorationImage(
            fit: BoxFit.cover,
            alignment: Alignment.topCenter,
            image: AssetImage(path),
          ),
        ),
      ),
    );
  }
}
