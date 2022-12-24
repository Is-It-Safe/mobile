import 'package:flutter/material.dart';
import 'package:flutter_svg/svg.dart';
import 'package:is_it_safe_app/generated/l10n.dart';
import 'package:is_it_safe_app/src/components/style/colors/safe_colors.dart';
import 'package:is_it_safe_app/src/components/style/text/text_styles.dart';

enum Cards {
  success,
  alert,
  error,
}

class SafeImpressionCard extends StatefulWidget {
  const SafeImpressionCard({Key? key}) : super(key: key);

  @override
  State<SafeImpressionCard> createState() => _SafeImpressionCardState();
}

class _SafeImpressionCardState extends State<SafeImpressionCard> {
  @override
  Widget build(BuildContext context) {
    double height = 128;
    double width = 344;

    Cards card = Cards.alert;

    switch (card) {
      case Cards.success:
        return Center(
          child: SizedBox(
            height: height,
            width: width,
            child: _successCard(),
          ),
        );

      case Cards.alert:
        return Center(
          child: SizedBox(
            height: height,
            width: width,
            child: _alertCard(),
          ),
        );

      case Cards.error:
        return Center(
          child: SizedBox(
            height: height,
            width: width,
            child: _errorCard(),
          ),
        );
    }
  }
}

Widget _successCard() {
  return Container(
    height: 128,
    width: 344,
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
        Padding(
          padding: const EdgeInsets.only(left: 16, top: 33, bottom: 32),
          child: Text(S.current.textMostPeopleSafePlace, style: TextStyles.bodyText2(
            color: SafeColors.materialcardColors.text,
          ),),
                 ),
        Stack(
          children: [
            Positioned(
              top: 18,
              left: 246,
              child: SvgPicture.asset('images/modules/review/vector1.svg'),
            ),
            Positioned(
              top: 36,
              left: 264,
              child: SvgPicture.asset('images/modules/review/vector2.svg'),
            ),
            Positioned(
              top: 55,
              left: 282,
              child: SvgPicture.asset('images/modules/review/vector3.svg'),
            ),
            Positioned(
              top: 74,
              left: 301,
              child: SvgPicture.asset('images/modules/review/vector4.svg'),
            ),
          ],
        ),
      ],
    ),
  );
}

Widget _alertCard() {
  return Container(
    height: 128,
    width: 344,
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
        Padding(
          padding: const EdgeInsets.only(left: 16, top: 22, bottom: 22),
          child: Text(S.current.textMostPeopleAlertPlace, style: TextStyles.bodyText2(
            color: SafeColors.materialcardColors.text),
                    ),
        ),
        Positioned(
          left: 250,
          top: 30,
          child: SvgPicture.asset('images/modules/review/subtract.svg'),
        ),
      ],
    ),
  );
}

Widget _errorCard() {
  return Container(
    height: 128,
    width: 344,
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
        Padding(
          padding: const EdgeInsets.only(left: 16, top: 22, bottom: 22),
          child: Text(S.current.textMostPeopleDangerPlace, style: TextStyles.bodyText2(
              color: SafeColors.materialcardColors.text),),
        ),
        Positioned(
          left: 228,
          top: 4,
          child: SvgPicture.asset('images/modules/review/union.svg'),
        ),
      ],
    ),
  );
}
