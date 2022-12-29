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



 extension SafeImpressionCardEnum on SafeImpressionEnum {
  Widget? get card => {
    SafeImpressionEnum.success: _successCard(),
    SafeImpressionEnum.alert: _alertCard(),
    SafeImpressionEnum.danger: _dangerCard(),
 }[this];

  static Widget get success => _successCard();
  static Widget get alert => _alertCard();
  static Widget get danger => _dangerCard();
 }

class SafeImpressionCard extends StatefulWidget {
  const SafeImpressionCard({Key? key, required this.card}) : super(key: key);
  final Widget card;


  @override
  State<SafeImpressionCard> createState() => _SafeImpressionCardState();
}

class _SafeImpressionCardState extends State<SafeImpressionCard> {
  @override
  Widget build(BuildContext context) {

   return Center(child: widget.card);



  }

}

//TODO falta colocar o MediaQuery

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
        Positioned(
          left: 250,
          top: 30,
          child: SvgPicture.asset(AssetConstants.impression.safe),
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
          child: SvgPicture.asset(AssetConstants.impression.warning),
        ),
      ],
    ),
  );
}

Widget _dangerCard() {
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
          child: SvgPicture.asset(AssetConstants.impression.danger),
        ),
      ],
    ),
  );
}

