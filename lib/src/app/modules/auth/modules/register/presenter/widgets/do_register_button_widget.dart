import 'package:flutter/material.dart';
import 'package:flutter_modular/flutter_modular.dart';
import 'package:is_it_safe_app/src/app/modules/auth/modules/register/presenter/pages/register_profile_page.dart';
import 'package:is_it_safe_app/src/components/widgets/safe_button.dart';
import 'package:is_it_safe_app/src/core/constants/string_constants.dart';
import 'package:is_it_safe_app/src/core/state/safe_builder.dart';
import 'package:is_it_safe_app/src/core/state/safe_stream.dart';
import 'package:is_it_safe_app/generated/l10n.dart';

class DoRegisterButtonWidget extends StatefulWidget {
  final GlobalKey<FormState> formKey;
  final SafeStream<bool> isEnabledToRegister;
  final SafeStream<bool> isAcceptedTerms;

  const DoRegisterButtonWidget({
    Key? key,
    required this.formKey,
    required this.isEnabledToRegister,
    required this.isAcceptedTerms,
  }) : super(key: key);

  @override
  State<DoRegisterButtonWidget> createState() => _DoRegisterButtonWidgetState();
}

class _DoRegisterButtonWidgetState extends State<DoRegisterButtonWidget> {
  @override
  Widget build(BuildContext context) {
    return SafeBuilder2<bool, bool>(
      stream1: widget.isEnabledToRegister,
      stream2: widget.isAcceptedTerms,
      builder: (isEnabledToRegister, isAcceptedTerms) {
        return SafeButton(
          title: S.current.textRegister,
          state: isEnabledToRegister && isAcceptedTerms
              ? ButtonState.rest
              : ButtonState.disabled,
          onTap: () async {
            if (widget.formKey.currentState?.validate() == true &&
                isEnabledToRegister == true) {
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
