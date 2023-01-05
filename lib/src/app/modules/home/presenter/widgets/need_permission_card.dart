import 'package:flutter/material.dart';

import '../../../../../components/widgets/safe_button.dart';
import '../../../../../components/widgets/safe_empty_card.dart';
import '../../../../../core/constants/assets_constants.dart';

class NeedPermissionCard extends StatelessWidget {
  final Function onTapButton;
  final String text;
  final String buttonText;
  const NeedPermissionCard(
      {Key? key,
      required this.onTapButton,
      required this.text,
      required this.buttonText})
      : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Column(
      children: [
        SafeEmptyCard(
          image: AssetConstants.empty.home,
          text: text,
        ),
        const SizedBox(height: 20),
        SafeButton(
          title: buttonText,
          size: ButtonSize.small,
          onTap: onTapButton as void Function(),
        ),
      ],
    );
  }
}
