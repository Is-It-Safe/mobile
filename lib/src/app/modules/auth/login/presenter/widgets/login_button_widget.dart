import 'package:flutter/material.dart';
import 'package:is_it_safe_app/src/components/widgets/safe_button.dart';
import 'package:is_it_safe_app/src/core/state/safe_builder.dart';
import 'package:is_it_safe_app/src/core/state/safe_stream.dart';
import 'package:is_it_safe_app/src/l10n/l10n.dart';

class LoginButtonWidget extends StatefulWidget {
  final SafeStream loginButtonStream;
  final GlobalKey<FormState> formKey;
  final Function() doLogin;
  const LoginButtonWidget({
    super.key,
    required this.loginButtonStream,
    required this.formKey,
    required this.doLogin,
  });

  @override
  State<LoginButtonWidget> createState() => _LoginButtonWidgetState();
}

class _LoginButtonWidgetState extends State<LoginButtonWidget> {
  @override
  Widget build(BuildContext context) {
    return SafeBuilder(
      stream: widget.loginButtonStream,
      builder: (isEnableToLogin) {
        return SafeButton(
          title: S.current.textLogin,
          state:
              isEnableToLogin == true ? ButtonState.rest : ButtonState.disabled,
          onTap: () async {
            widget.formKey.currentState?.validate();
            if (isEnableToLogin == true) {
              await widget.doLogin();
            }
          },
        );
      },
    );
  }
}
