import 'package:flutter/material.dart';
import 'package:flutter_svg/flutter_svg.dart';
import 'package:is_it_safe_app/generated/l10n.dart';
import 'package:is_it_safe_app/src/app/modules/location/domain/entities/response/response_get_location_by_id.dart';
import 'package:is_it_safe_app/src/app/modules/location/domain/entities/response/response_location_review.dart';
import 'package:is_it_safe_app/src/components/style/colors/safe_colors.dart';
import 'package:is_it_safe_app/src/components/style/text/text_styles.dart';
import 'package:is_it_safe_app/src/components/widgets/safe_emotion_graphic/safe_emotion_graphic_status.dart';
import 'package:is_it_safe_app/src/core/constants/assets_constants.dart';
import 'package:is_it_safe_app/src/core/constants/string_constants.dart';

class SafeEmotionGrapic extends StatelessWidget {
  final double averageGrade;
  final int avaliationCount;
  final List<ResponseLocationReview>? grade;
  final List<ReviewChart>? reviewChart;
  const SafeEmotionGrapic({
    Key? key,
    required this.averageGrade,
    required this.avaliationCount,
    required this.reviewChart,
    this.grade,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    final size = MediaQuery.of(context).size;
    return Stack(
      clipBehavior: Clip.none,
      children: [
        Container(
          padding: EdgeInsets.only(
            left: size.width * .076,
            right: size.width * .040,
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
                emotionalStatusAvaliations: reviewChart![0].value ?? 0,
                sumOfAvaliations: avaliationCount,
                statusGrade: averageGrade,
              ),
              SafeEmotionGraphicStatus(
                emotionalStatus: S.current.textUpset,
                emotionalStatusAvaliations: reviewChart![1].value ?? 0,
                sumOfAvaliations: avaliationCount,
                statusGrade: averageGrade,
              ),
              SafeEmotionGraphicStatus(
                emotionalStatus: S.current.textRegular,
                emotionalStatusAvaliations: reviewChart![2].value ?? 0,
                sumOfAvaliations: avaliationCount,
                statusGrade: averageGrade,
              ),
              SafeEmotionGraphicStatus(
                emotionalStatus: S.current.textSatisfied,
                emotionalStatusAvaliations: reviewChart![3].value ?? 0,
                sumOfAvaliations: avaliationCount,
                statusGrade: averageGrade,
              ),
              SafeEmotionGraphicStatus(
                emotionalStatus: S.current.textIncredible,
                emotionalStatusAvaliations: reviewChart![4].value ?? 0,
                sumOfAvaliations: avaliationCount,
                statusGrade: averageGrade,
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
                averageGrade == 0.0 ? StringConstants.empty : "$averageGrade",
                style: TextStyles.headline3(
                  fontWeight: FontWeight.w700,
                ).copyWith(fontSize: 22),
              ),
            ],
          ),
        ),
      ],
    );
  }
}
