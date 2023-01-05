import 'package:flutter/material.dart';
import 'package:is_it_safe_app/src/components/style/colors/safe_colors.dart';
import 'package:is_it_safe_app/src/components/style/text/text_styles.dart';
import 'package:is_it_safe_app/src/components/widgets/safe_check_box.dart';
import 'package:is_it_safe_app/src/core/constants/string_constants.dart';
import 'package:is_it_safe_app/src/core/state/safe_builder.dart';
import 'package:is_it_safe_app/src/core/state/safe_stream.dart';
import 'package:is_it_safe_app/src/l10n/l10n.dart';

class RegisterTermsAndConditionsWidget extends StatefulWidget {
  final SafeStream<bool> isTermsAndConditionsChecked;
  final void Function(bool? value) onChanged;
  final Function() navigateToTermsAndConditions;
  const RegisterTermsAndConditionsWidget({
    Key? key,
    required this.isTermsAndConditionsChecked,
    required this.onChanged,
    required this.navigateToTermsAndConditions,
  }) : super(key: key);

  @override
  State<RegisterTermsAndConditionsWidget> createState() =>
      _RegisterTermsAndConditionsWidgetState();
}

class _RegisterTermsAndConditionsWidgetState
    extends State<RegisterTermsAndConditionsWidget> {
  @override
  Widget build(BuildContext context) {
    return SafeBuilder<bool>(
        stream: widget.isTermsAndConditionsChecked,
        builder: (isTermsAndConditionsChecked) {
          return Row(
            mainAxisAlignment: MainAxisAlignment.center,
            children: [
              SafeCheckBox(
                value: isTermsAndConditionsChecked,
                onChanged: widget.onChanged,
              ),
              const SizedBox(width: 10),
              Text(
                S.current.textIReadAndAcceptThe,
                style: TextStyles.helper(),
              ),
              GestureDetector(
                onTap: widget.navigateToTermsAndConditions,
                child: Text(
                  S.current.textTermsAndConditions + StringConstants.asterisk,
                  style: TextStyles.helper(
                    color: SafeColors.statusColors.active,
                  ),
                ),
              ),
            ],
          );
        });
  }
}
