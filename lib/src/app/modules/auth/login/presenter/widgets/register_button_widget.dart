import 'package:flutter/material.dart';
import 'package:flutter_modular/flutter_modular.dart';
import 'package:is_it_safe_app/src/app/modules/auth/register/presenter/pages/register_page.dart';
import 'package:is_it_safe_app/src/components/style/colors/safe_colors.dart';
import 'package:is_it_safe_app/src/components/style/text/text_styles.dart';
import 'package:is_it_safe_app/src/l10n/l10n.dart';

class RegisterButtonWidget extends StatelessWidget {
  const RegisterButtonWidget({
    Key? key,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Row(
      mainAxisAlignment: MainAxisAlignment.center,
      children: [
        Text(
          S.current.textButtonDontHaveAccount,
          style: TextStyles.button(),
        ),
        TextButton(
          onPressed: () => Modular.to.pushNamed(RegisterPage.route),
          child: Text(
            S.current.textSignUp,
            style: TextStyles.button(
              color: SafeColors.buttonColors.primary,
              textDecoration: TextDecoration.underline,
            ),
          ),
        )
      ],
    );
  }
}
