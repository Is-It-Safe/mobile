import 'package:flutter/material.dart';
import 'package:flutter_svg/flutter_svg.dart';
import 'package:is_it_safe_app/src/l10n/l10n.dart';
import 'package:is_it_safe_app/src/components/style/colors/safe_colors.dart';
import 'package:is_it_safe_app/src/components/style/text/text_styles.dart';
import 'package:is_it_safe_app/src/components/widgets/safe_emotion_graphic/safe_emotion_graphic_status.dart';
import 'package:is_it_safe_app/src/core/constants/assets_constants.dart';

class SafeEmotionGrapic extends StatelessWidget {
  final double grade;
  final int avaliationCount;
  const SafeEmotionGrapic(
      {Key? key, required this.grade, required this.avaliationCount})
      : super(key: key);

  @override
  Widget build(BuildContext context) {
    final size = MediaQuery.of(context).size;
    return Container(
      margin: EdgeInsets.symmetric(horizontal: size.width * .0845),
      child: Stack(
        clipBehavior: Clip.none,
        children: [
          LayoutBuilder(builder: (context, constraints) {
            return Container(
              padding: EdgeInsets.only(
                left: size.width * .076,
                right: size.width * .055,
                top: size.height * .023,
                bottom: size.height * .018,
              ),
              decoration: BoxDecoration(
                border: Border.all(
                    width: 1, color: SafeColors.generalColors.primary),
                color: Colors.transparent,
                borderRadius: BorderRadius.circular(8),
              ),
              child: Column(
                children: [
                  Row(
                    children: [
                      Text(
                        "$grade",
                        style: TextStyles.headline3(
                          fontWeight: FontWeight.w700,
                        ).copyWith(fontSize: 22),
                      ),
                      SizedBox(width: size.width * .115),
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
                    status: S.current.textAngry,
                    avaliations: 0,
                    sumOfAvaliations: avaliationCount,
                    statusGrade: 0,
                  ),
                  SafeEmotionGraphicStatus(
                    status: S.current.textUpset,
                    avaliations: 1,
                    sumOfAvaliations: avaliationCount,
                    statusGrade: 1,
                  ),
                  SafeEmotionGraphicStatus(
                    status: S.current.textRegular,
                    avaliations: 6,
                    sumOfAvaliations: avaliationCount,
                    statusGrade: 2,
                  ),
                  SafeEmotionGraphicStatus(
                    status: S.current.textSatisfied,
                    avaliations: 9,
                    sumOfAvaliations: avaliationCount,
                    statusGrade: 3,
                  ),
                  SafeEmotionGraphicStatus(
                    status: S.current.textIncredible,
                    avaliations: 20,
                    sumOfAvaliations: avaliationCount,
                    statusGrade: 4,
                  ),
                ],
              ),
            );
          }),
          Positioned(
            left: size.width * .058,
            top: -(size.height * .02),
            child: SvgPicture.asset(AssetConstants.icons.star),
          ),
        ],
      ),
    );
  }
}
