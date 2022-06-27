import 'package:flutter/material.dart';
import 'package:flutter_svg/svg.dart';
import 'package:is_it_safe_app/src/components/style/text/text_styles.dart';
import 'package:is_it_safe_app/src/core/constants/assets_constants.dart';

class AccountInfoButton extends StatelessWidget {
  final String text;
  final Function()? onTap;
  final EdgeInsets? padding;
  const AccountInfoButton({
    Key? key,
    required this.text,
    this.onTap,
    this.padding = const EdgeInsets.symmetric(horizontal: 33),
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return ListTile(
      contentPadding: padding,
      onTap: onTap ?? () {},
      title: Text(
        text,
        style: TextStyles.subtitle1(),
      ),
      trailing: SvgPicture.asset(
        AssetConstants.icons.arrowFoward,
      ),
    );
  }
}
