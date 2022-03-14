import 'package:flutter/material.dart';
import 'package:is_it_safe_app/core/utils/style/colors/general_colors.dart';
import 'package:is_it_safe_app/core/utils/style/themes/text_styles.dart';

class CustomHeaderDrawer extends StatelessWidget {
  final String name;
  final String? profileImagePath;
  const CustomHeaderDrawer(
      {Key? key, required this.name, this.profileImagePath})
      : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.symmetric(horizontal: 20, vertical: 50),
      child: Row(
        mainAxisAlignment: MainAxisAlignment.spaceBetween,
        children: [
          profileImagePath != null
              ? Container(
                  height: 60,
                  width: 60,
                  decoration: BoxDecoration(
                    shape: BoxShape.circle,
                    color: kColorButtonSecondary,
                    image: DecorationImage(
                      image: AssetImage(profileImagePath!),
                      alignment: Alignment.topCenter,
                      fit: BoxFit.cover,
                    ),
                  ),
                )
              : const SizedBox.shrink(),
          const SizedBox(width: 5),
          Expanded(
            child: Container(
              margin: const EdgeInsets.symmetric(horizontal: 10),
              child: Text(
                name,
                maxLines: 3,
                style: TextStyles.subtitle1(),
              ),
            ),
          ),
        ],
      ),
    );
  }
}
