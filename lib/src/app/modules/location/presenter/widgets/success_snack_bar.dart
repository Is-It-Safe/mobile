import 'package:flutter/material.dart';
import 'package:flutter_modular/flutter_modular.dart';
import '../../../../../../generated/l10n.dart';
import '../../../../../components/style/colors/safe_colors.dart';
import '../../../../../components/style/text/text_styles.dart';
import '../../../../../components/widgets/safe_button.dart';

class SuccessSnackBar extends StatelessWidget {
  final String message;

  const SuccessSnackBar({
    super.key,
    required this.message,
  });

  @override
  Widget build(BuildContext context) {
    return AlertDialog(
      alignment: Alignment.bottomCenter,
      insetPadding: const EdgeInsets.only(bottom: 40, left: 16, right: 16),
      content: Container(
        height: 250,
        width: MediaQuery.of(context).size.width,
        decoration: BoxDecoration(
          color: SafeColors.generalColors.white,
          borderRadius: BorderRadius.circular(8),
        ),
        child: Column(
          mainAxisAlignment: MainAxisAlignment.spaceEvenly,
          children: [
            Row(
              children: [
                Icon(
                  Icons.check_circle_rounded,
                  color: SafeColors.statusColors.success,
                ),
                Padding(
                  padding: const EdgeInsets.only(left: 16.0),
                  child: Text(
                    S.current.textSafeDialogTypeSucces,
                    style: TextStyles.headline3(
                      color: SafeColors.statusColors.success,
                    ),
                  ),
                )
              ],
            ),
            Text(
              message,
              style: TextStyles.bodyText2(color: SafeColors.textColors.label),
            ),
            SafeButton(
              title: S.current.textExploreOtherLocations,
              state: ButtonState.rest,
              onTap: () => Modular.to.pop(),
            ),
          ],
        ),
      ),
    );
  }
}
