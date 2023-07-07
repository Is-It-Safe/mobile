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
    return Row(
      mainAxisAlignment: MainAxisAlignment.spaceBetween,
      children: [
        SafeButton(
          title: S.current.textAdvance,
          hasBackground: false,
          size: ButtonSize.small,
          onTap: () => onRegister(isAdvanceButton: true),
        ),
        SafeButton(
          title: S.current.textFinish,
          size: ButtonSize.small,
          onTap: () => onRegister(),
        ),
      ],
    );
  }
}
