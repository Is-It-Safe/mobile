import 'package:flutter/material.dart';
import 'package:is_it_safe_app/src/components/widgets/safe_button.dart';
import 'package:is_it_safe_app/generated/l10n.dart';

class RegisterProfileButtonWidget extends StatelessWidget {
  final Function({bool? isAdvanceButton}) onRegister;
  const RegisterProfileButtonWidget({
    Key? key,
    required this.onRegister,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return SafeButton(
      title: S.current.textFinish,
      size: ButtonSize.large,
      onTap: () => onRegister(),
    );
  }
}
