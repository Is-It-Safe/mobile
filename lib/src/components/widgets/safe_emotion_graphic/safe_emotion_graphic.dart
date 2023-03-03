import 'package:flutter/material.dart';
import 'package:flutter_svg/flutter_svg.dart';
import 'package:is_it_safe_app/generated/l10n.dart';
import 'package:is_it_safe_app/src/components/style/colors/safe_colors.dart';
import 'package:is_it_safe_app/src/components/style/text/text_styles.dart';
import 'package:is_it_safe_app/src/components/widgets/safe_emotion_graphic/safe_emotion_graphic_status.dart';
import 'package:is_it_safe_app/src/core/constants/assets_constants.dart';

class SafeEmotionGrapic extends StatelessWidget {
  final double grade;
  final int avaliationCount;
  const SafeEmotionGrapic({
    Key? key,
    required this.grade,
    required this.avaliationCount,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    final size = MediaQuery.of(context).size;
    return Container(
      margin: EdgeInsets.symmetric(horizontal: size.width * .0844),
      child: Stack(
        clipBehavior: Clip.none,
        children: [
          Container(
            padding: EdgeInsets.only(
              left: size.width * .076,
              right: size.width * .055,
              top: size.height * .023,
              bottom: size.height * .018,
            ),
            decoration: BoxDecoration(
              border:
                  Border.all(width: 1, color: SafeColors.generalColors.primary),
              color: Colors.white,
              borderRadius: BorderRadius.circular(8),
            ),
            child: Column(
              children: [
                Row(
                  children: [
                    // Text(
                    //   "$grade",
                    //   style: TextStyles.headline3(
                    //     fontWeight: FontWeight.w700,
                    //   ).copyWith(fontSize: 22),
                    // ),
                    SizedBox(width: size.width * .21),
                    Flexible(
                      child: Column(
                        crossAxisAlignment: CrossAxisAlignment.start,
                        children: [
                          Text(
                            S.current.textHowDoPeopleFellAboutThisPlace,
                            textAlign: TextAlign.left,
                            style: TextStyles.bodyText1().copyWith(
                              fontWeight: FontWeight.w700,
                              overflow: TextOverflow.clip,
                            ),
                          ),
                          SizedBox(height: size.height * .007),
                          Text(
                            "$avaliationCount avaliações",
                            style: TextStyles.label(
                              fontWeight: FontWeight.w500,
                            ),
                          ),
                        ],
                      ),
                    ),
                  ],
                ),
                SizedBox(height: size.height * .02),
                SafeEmotionGraphicStatus(
                  emotionalStatus: S.current.textAngry,
                  emotionalStatusAvaliations: 0,
                  sumOfAvaliations: avaliationCount,
                  statusGrade: 0,
                ),
                SafeEmotionGraphicStatus(
                  emotionalStatus: S.current.textUpset,
                  emotionalStatusAvaliations: 2,
                  sumOfAvaliations: avaliationCount,
                  statusGrade: 1,
                ),
                SafeEmotionGraphicStatus(
                  emotionalStatus: S.current.textRegular, // Neutro
                  emotionalStatusAvaliations: 0,
                  sumOfAvaliations: avaliationCount,
                  statusGrade: 2,
                ),
                SafeEmotionGraphicStatus(
                  emotionalStatus: S.current.textSatisfied, // Contente
                  emotionalStatusAvaliations: 0,
                  sumOfAvaliations: avaliationCount,
                  statusGrade: 3,
                ),
                SafeEmotionGraphicStatus(
                  emotionalStatus: S.current.textIncredible,
                  emotionalStatusAvaliations: 0,
                  sumOfAvaliations: avaliationCount,
                  statusGrade: 4,
                ),
              ],
            ),
          ),
          Positioned(
            left: size.width * .060,
            top: -(size.height * .02),
            child: Column(
              children: [
                SvgPicture.asset(
                  AssetConstants.icons.star,
                  width: size.width * .15,
                ),
                Text(
                  "$grade",
                  style: TextStyles.headline3(
                    fontWeight: FontWeight.w700,
                  ).copyWith(fontSize: 22),
                ),
              ],
            ),
          ),
        ],
      ),
    );
  }
}
