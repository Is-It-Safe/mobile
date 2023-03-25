import 'package:flutter/material.dart';
import 'package:is_it_safe_app/src/components/style/text/text_styles.dart';
import 'package:is_it_safe_app/src/core/constants/string_constants.dart';
import 'package:is_it_safe_app/generated/l10n.dart';

class RegisterWelcomeTextWidget extends StatelessWidget {
  const RegisterWelcomeTextWidget({
    Key? key,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return RichText(
      text: TextSpan(
        children: [
          TextSpan(
            text: S.current.textWelcome + StringConstants.breakLine,
            style: TextStyles.headline1(),
          ),
          TextSpan(
            text: S.current.textMeetingYouWillBeAPleasure,
            style: TextStyles.headline2(),
          ),
        ],
      ),
    );
  }
}
