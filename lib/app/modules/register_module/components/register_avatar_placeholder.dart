import 'package:flutter/material.dart';

class RegisterAvatarPlaceholder extends StatelessWidget {
  final Function()? onTap;
  const RegisterAvatarPlaceholder({
    Key? key,
    this.onTap,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return GestureDetector(
      onTap: onTap,
      child: Container(
        height: 120,
        decoration: const BoxDecoration(
          image: DecorationImage(
            image: AssetImage(
              'images/app/profile_pictures/placeholder/placeholder_avatar_light.png',
            ),
          ),
        ),
      ),
    );
  }
}
