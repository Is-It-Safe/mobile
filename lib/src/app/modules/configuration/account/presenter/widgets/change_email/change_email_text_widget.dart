import 'package:flutter/material.dart';
import 'package:is_it_safe_app/generated/l10n.dart';
import 'package:is_it_safe_app/src/components/style/text/text_styles.dart';
import 'package:is_it_safe_app/src/core/state/safe_builder.dart';
import 'package:is_it_safe_app/src/core/state/safe_stream.dart';

class ChangeEmailTextWidget extends StatelessWidget {
  final SafeStream<String?> getEmailStream;

  const ChangeEmailTextWidget({
    super.key,
    required this.getEmailStream,
  });

  @override
  Widget build(BuildContext context) {
    return SafeBuilder<String?>(
      stream: getEmailStream,
      builder: (email) {
        return Padding(
          padding: const EdgeInsets.only(top: 4),
          child: Text.rich(
            TextSpan(
              text: "${S.current.textYourCurrentEmailIs} $email\n",
              style: TextStyles.subtitle1(),
              children: [
                TextSpan(
                  text: S.current.textWhatWillBeYourEmailAddress,
                ),
              ],
            ),
          ),
        );
      },
    );
  }
}
