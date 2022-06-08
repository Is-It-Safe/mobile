import 'package:flutter/material.dart';
import 'package:is_it_safe_app/src/components/style/text/text_styles.dart';
import 'package:is_it_safe_app/src/components/widgets/safe_profile_avatar.dart';
import 'package:is_it_safe_app/src/core/constants/assets_constants.dart';
import 'package:is_it_safe_app/src/core/constants/string_constants.dart';

class HomeDrawer extends StatelessWidget {
  final String? image;
  final String? name;
  const HomeDrawer({
    Key? key,
    this.image = PlaceHolderAssets.profileAvatar,
    this.name,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return SafeArea(
      child: Drawer(
        child: SingleChildScrollView(
          padding: const EdgeInsets.symmetric(
            horizontal: 42,
            vertical: 60,
          ),
          child: Column(
            children: [
              _mountHeader(),
              const SizedBox(height: 25),
            ],
          ),
        ),
      ),
    );
  }

  Widget _mountHeader() {
    return Row(
      mainAxisAlignment: MainAxisAlignment.center,
      crossAxisAlignment: CrossAxisAlignment.center,
      children: [
        SafeProfileAvatar(
          image: image!,
          size: 60,
        ),
        const SizedBox(width: 25),
        Visibility(
          visible: name != null,
          child: Expanded(
            child: Text(
              name ?? StringConstants.empty,
              style: TextStyles.subtitle1(),
              maxLines: 2,
              overflow: TextOverflow.ellipsis,
            ),
          ),
        )
      ],
    );
  }
}
