import 'package:flutter/material.dart';
import 'package:is_it_safe_app/src/components/style/text/text_styles.dart';
import 'package:is_it_safe_app/src/core/constants/string_constants.dart';
import 'package:is_it_safe_app/src/l10n/l10n.dart';

class LoginPageTitleWidget extends StatelessWidget {
  const LoginPageTitleWidget({
    Key? key,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return RichText(
      text: TextSpan(
        children: [
          TextSpan(
            text: S.current.textPageTitleLogin + StringConstants.breakLine,
            style: TextStyles.headline1(),
          ),
          TextSpan(
            text: S.current.textPageSubtitleLogin,
            style: TextStyles.headline2(),
          ),
        ],
      ),
    );
  }
}
