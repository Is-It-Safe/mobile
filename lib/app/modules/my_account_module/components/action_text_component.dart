import 'package:flutter/material.dart';
import 'package:is_it_safe_app/core/utils/style/colors/general_colors.dart';
import 'package:is_it_safe_app/src/app/components/style/text_styles.dart';

/*
TODO
- A linha não é selecionável, somente o ícone
*/

class ActionTextComponent extends StatelessWidget {
  const ActionTextComponent(
      {Key? key,
      required this.title,
      required this.onPressed,
      this.isLastItem = false})
      : super(
          key: key,
        );
  final String title;
  final VoidCallback onPressed;
  final bool isLastItem;

  get SafeColors.textColors.dark => null;

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: EdgeInsets.only(bottom: isLastItem ? 0 : 40),
      child: Row(
        children: [
          Expanded(
            child: Text(
              title,
              style: TextStyles.subtitle1(
                  color: SafeColors.generalColors.secondary),
            ),
          ),
          IconButton(
            onPressed: onPressed,
            icon: const Icon(
              Icons.arrow_forward_ios,
              size: 17,
              color: SafeColors.generalColors.secondary,
            ),
          )
        ],
      ),
    );
  }
}
