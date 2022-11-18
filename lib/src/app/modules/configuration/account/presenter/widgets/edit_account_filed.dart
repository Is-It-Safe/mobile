import 'package:flutter/material.dart';
import 'package:is_it_safe_app/src/components/style/colors/safe_colors.dart';
import 'package:is_it_safe_app/src/components/style/text/text_styles.dart';
import 'package:is_it_safe_app/src/components/widgets/safe_text_form_field.dart';
import 'package:is_it_safe_app/src/core/constants/string_constants.dart';

class EditAccountField extends StatelessWidget {
  final String title;
  final String? value;
  const EditAccountField({
    Key? key,
    required this.title,
    this.value = StringConstants.hyphen,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        Text(
          title,
          style: TextStyles.subtitle1(),
        ),
        const SizedBox(height: 2),
        SafeTextFormField(
            // hintText: value!,
            )
      ],
    );
  }
}
