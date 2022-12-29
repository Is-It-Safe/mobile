import 'package:flutter/material.dart';
import 'package:flutter_svg/flutter_svg.dart';
import 'package:is_it_safe_app/generated/l10n.dart';
import 'package:is_it_safe_app/src/components/style/colors/safe_colors.dart';
import 'package:is_it_safe_app/src/components/widgets/safe_emotion_graphic/safe_emotion_graphic_status.dart';
import 'package:is_it_safe_app/src/core/constants/assets_constants.dart';

///#///#///#///#///#//#// NOTES ///#///#///#///#///#//#//
///
/// Nota máxima 5 (100%)
///
/// Cálculo nota máxima: ((soma das notas) / (quantidade de avaliações)) * .1
/// Limite nota: 0 a 5 (0% a 100%)
///
/// Porcentagem notas:
/// 0 -> 0%
/// 1 -> 20%
/// 2 -> 40%
/// 3 -> 60%
/// 4 -> 80%
/// 5 -> 100%
///

class SafeEmotionGrapic extends StatelessWidget {
  const SafeEmotionGrapic({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    final size = MediaQuery.of(context).size;
    return Container(
      margin: EdgeInsets.symmetric(horizontal: size.width * .0845),
      height: size.height * .145,
      child: Stack(
        children: [
          Positioned(
            left: size.width * .058,
            top: 0,
            child: SvgPicture.asset(AssetConstants.icons.star),
          ),
          Container(
            height: size.height * .1363,
            decoration: BoxDecoration(
              border:
                  Border.all(width: 1, color: SafeColors.generalColors.primary),
              color: Colors.transparent,
              borderRadius: BorderRadius.circular(8),
            ),
            child: Column(
              children: [
                SafeEmotionGraphicStatus(
                  status: S.current.textAngry,
                  avaliations: 0,
                  statusGrade: 1.5,
                ),
                SafeEmotionGraphicStatus(
                  status: S.current.textUpset,
                  avaliations: 0,
                  statusGrade: 1.5,
                ),
                SafeEmotionGraphicStatus(
                  status: S.current.textRegular,
                  avaliations: 0,
                  statusGrade: 1.5,
                ),
                SafeEmotionGraphicStatus(
                  status: S.current.textSatisfied,
                  avaliations: 0,
                  statusGrade: 1.5,
                ),
                SafeEmotionGraphicStatus(
                  status: S.current.textIncredible,
                  avaliations: 0,
                  statusGrade: 1.5,
                ),
              ],
            ),
          ),
        ],
      ),
    );
  }
}
