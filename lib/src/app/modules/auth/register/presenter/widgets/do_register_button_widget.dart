import 'package:flutter/material.dart';
import 'package:flutter_modular/flutter_modular.dart';
import 'package:is_it_safe_app/src/app/modules/auth/register/presenter/pages/register_profile_page.dart';
import 'package:is_it_safe_app/src/components/widgets/safe_button.dart';
import 'package:is_it_safe_app/src/core/constants/string_constants.dart';
import 'package:is_it_safe_app/src/core/state/safe_builder.dart';
import 'package:is_it_safe_app/src/core/state/safe_stream.dart';
import 'package:is_it_safe_app/src/l10n/l10n.dart';

class DoRegisterButtonWidget extends StatefulWidget {
  final GlobalKey<FormState> formKey;
  final SafeStream<bool> isEnabledToRegister;
  const DoRegisterButtonWidget({
    Key? key,
    required this.formKey,
    required this.isEnabledToRegister,
  }) : super(key: key);

  @override
  State<DoRegisterButtonWidget> createState() => _DoRegisterButtonWidgetState();
}

class _DoRegisterButtonWidgetState extends State<DoRegisterButtonWidget> {
  @override
  Widget build(BuildContext context) {
    return SafeBuilder(
      stream: widget.isEnabledToRegister,
      builder: (isEnabledToRegister) {
        return SafeButton(
          title: S.current.textRegister,
          state: isEnabledToRegister == true
              ? ButtonState.rest
              : ButtonState.disabled,
          onTap: () async {
            widget.formKey.currentState?.validate();
            if (isEnabledToRegister == true) {
              Modular.to.pushNamed(
                StringConstants.dot + RegisterProfilePage.route,
              );
            }
          },
        );
      },
    );
  }
}
