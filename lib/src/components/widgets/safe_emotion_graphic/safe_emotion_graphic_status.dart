import 'package:flutter/material.dart';
import 'package:is_it_safe_app/src/components/style/colors/safe_colors.dart';
import 'package:is_it_safe_app/src/components/style/text/text_styles.dart';

class SafeEmotionGraphicStatus extends StatelessWidget {
  final String emotionalStatus;
  final int emotionalStatusAvaliations;
  final int sumOfAvaliations;
  final double statusGrade;
  const SafeEmotionGraphicStatus({
    Key? key,
    required this.emotionalStatus,
    required this.emotionalStatusAvaliations,
    required this.sumOfAvaliations,
    required this.statusGrade,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    final size = MediaQuery.of(context).size;
    return Container(
      margin: const EdgeInsets.only(bottom: 8),
      child: Row(
        mainAxisAlignment: MainAxisAlignment.end,
        children: [
          Flexible(
            flex: 3,
            child: Text(
              emotionalStatus,
              textAlign: TextAlign.right,
              style: TextStyles.emotionalStatus(),
            ),
          ),
          SizedBox(width: size.width * .044),
          Text("$emotionalStatusAvaliations"),
          SizedBox(width: size.width * .017),
          Flexible(
            flex: 6,
            child: _GraphicGradePercentLine(
              grade: statusGrade,
              avaliations: emotionalStatusAvaliations,
              sumOfAvaliations: sumOfAvaliations,
              size: size,
            ),
          ),
        ],
      ),
    );
  }
}

class _GraphicGradePercentLine extends StatelessWidget {
  final double grade;
  final int avaliations;
  final int sumOfAvaliations;
  final Size size;
  const _GraphicGradePercentLine({
    Key? key,
    required this.grade,
    required this.avaliations,
    required this.sumOfAvaliations,
    required this.size,
  })  : assert(grade >= 0 && grade <= 5),
        super(key: key);

  @override
  Widget build(BuildContext context) {
    double fullSize = size.width * .5;

    return Stack(
      alignment: AlignmentDirectional.centerStart,
      children: [
        Container(
          height: 10,
          // width: fullSize / 2,
          width: (grade == 0 || avaliations == 0 || sumOfAvaliations == 0)
              ? 1
              : (((avaliations / sumOfAvaliations)) * fullSize),
          color: SafeColors.componentsColors.emotionStatusColor,
        ),
        Container(
          height: .5,
          width: fullSize,
          color: SafeColors.componentsColors.emotionStatusColor,
        ),
      ],
    );
  }
}
