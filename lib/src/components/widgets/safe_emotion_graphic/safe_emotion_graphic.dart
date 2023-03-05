import 'package:flutter/material.dart';
import 'package:flutter_svg/flutter_svg.dart';
import 'package:is_it_safe_app/generated/l10n.dart';
import 'package:is_it_safe_app/src/components/style/colors/safe_colors.dart';
import 'package:is_it_safe_app/src/components/style/text/text_styles.dart';
import 'package:is_it_safe_app/src/components/widgets/safe_emotion_graphic/safe_emotion_graphic_status.dart';
import 'package:is_it_safe_app/src/core/constants/assets_constants.dart';
import 'package:is_it_safe_app/src/service/api/modules/location/response/response_location_review.dart';

class SafeEmotionGrapic extends StatelessWidget {
  final double averageGrade;
  final int avaliationCount;
  final List<ResponseLocationReview>? grade;
  const SafeEmotionGrapic({
    Key? key,
    required this.averageGrade,
    required this.avaliationCount,
    this.grade,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    int angry = 0;
    int sad = 0;
    int regular = 0;
    int satisfied = 0;
    int incredible = 0;

    for (int i = 0; i < grade!.length; i++) {
      if (grade?[i].myGrade == 1.0) {
        angry += 1;
      }
      if (grade?[i].myGrade == 2.0) {
        sad += 1;
      }
      if (grade?[i].myGrade == 3.0) {
        regular += 1;
      }
      if (grade?[i].myGrade == 4.0) {
        satisfied += 1;
      }
      if (grade?[i].myGrade == 5.0) {
        incredible += 1;
      }
    }

    final size = MediaQuery.of(context).size;
    return Container(
      margin: EdgeInsets.symmetric(horizontal: size.width * .0844),
      child: Stack(
        clipBehavior: Clip.none,
        children: [
          Container(
            padding: EdgeInsets.only(
              left: size.width * .076,
              right: size.width * .035,
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
                    SizedBox(width: size.width * .22),
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
                  emotionalStatusAvaliations: angry,
                  sumOfAvaliations: avaliationCount,
                  statusGrade: 0,
                ),
                SafeEmotionGraphicStatus(
                  emotionalStatus: S.current.textUpset,
                  emotionalStatusAvaliations: sad,
                  sumOfAvaliations: avaliationCount,
                  statusGrade: 1,
                ),
                SafeEmotionGraphicStatus(
                  emotionalStatus: S.current.textRegular,
                  emotionalStatusAvaliations: regular,
                  sumOfAvaliations: avaliationCount,
                  statusGrade: 2,
                ),
                SafeEmotionGraphicStatus(
                  emotionalStatus: S.current.textSatisfied,
                  emotionalStatusAvaliations: satisfied,
                  sumOfAvaliations: avaliationCount,
                  statusGrade: 3,
                ),
                SafeEmotionGraphicStatus(
                  emotionalStatus: S.current.textIncredible,
                  emotionalStatusAvaliations: incredible,
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
                  "$averageGrade",
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
