import 'package:flutter/material.dart';
import 'package:is_it_safe_app/src/components/style/colors/safe_colors.dart';
import 'package:is_it_safe_app/src/components/widgets/safe_empty_card.dart';
import 'package:is_it_safe_app/src/components/widgets/safe_text_button.dart';
import 'package:is_it_safe_app/src/l10n/l10n.dart';

class SearchEmptyCard extends StatelessWidget {
  final Function() onTapAction;
  const SearchEmptyCard({
    Key? key,
    required this.onTapAction,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Column(
      children: [
        SafeEmptyCard.search(),
        SafeTextButton(
          text: S.current.textCreateHere,
          textColor: SafeColors.statusColors.active,
          onTap: onTapAction,
        ),
      ],
    );
  }
}
