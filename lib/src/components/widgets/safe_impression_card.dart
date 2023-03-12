import 'package:flutter/material.dart';
import 'package:flutter_svg/svg.dart';
import 'package:is_it_safe_app/generated/l10n.dart';
import 'package:is_it_safe_app/src/components/style/colors/safe_colors.dart';
import 'package:is_it_safe_app/src/components/style/text/text_styles.dart';
import 'package:is_it_safe_app/src/core/constants/assets_constants.dart';

enum SafeImpressionEnum {
  success,
  alert,
  danger,
}

extension SafeImpressionEnumString on SafeImpressionEnum {
  String get message {
    switch (this) {
      case SafeImpressionEnum.success:
        return S.current.textMostPeopleSafePlace;

      case SafeImpressionEnum.alert:
        return S.current.textMostPeopleAlertPlace;

      case SafeImpressionEnum.danger:
        return S.current.textMostPeopleDangerPlace;
    }
  }

  String get icon {
    switch (this) {
      case SafeImpressionEnum.success:
        return AssetConstants.impression.safe;

      case SafeImpressionEnum.alert:
        return AssetConstants.impression.warning;

      case SafeImpressionEnum.danger:
        return AssetConstants.impression.danger;
    }
  }
}

class SafeImpressionCard extends StatelessWidget {
  const SafeImpressionCard({Key? key, required this.type}) : super(key: key);
  final SafeImpressionEnum type;

  @override
  Widget build(BuildContext context) {
    return Container(
      height: MediaQuery.of(context).size.height * .16,
      width: MediaQuery.of(context).size.width * .9,
      decoration: BoxDecoration(
        borderRadius: BorderRadius.circular(8.0),
        gradient: LinearGradient(
          begin: Alignment.topLeft,
          end: Alignment.bottomRight,
          colors: <Color>[
            SafeColors.materialcardColors.secondary,
            SafeColors.materialcardColors.primary,
          ],
        ),
      ),
      child: Stack(
        children: [
          Positioned(
            left: 250,
            top: 30,
            child: SvgPicture.asset(type.icon),
          ),
          Padding(
            padding: const EdgeInsets.only(left: 16, top: 33, bottom: 32),
            child: Text(
              type.message,
              style: TextStyles.bodyText2(
                color: SafeColors.materialcardColors.text,
              ),
              overflow: TextOverflow.visible,
            ),
          ),
        ],
      ),
    );
  }
}
