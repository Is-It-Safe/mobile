import 'package:flutter/material.dart';
import 'package:is_it_safe_app/src/components/style/colors/safe_colors.dart';

class SafeEmotionGraphicStatus extends StatelessWidget {
  final String status;
  final int avaliations;
  final int sumOfAvaliations;
  final double statusGrade;
  const SafeEmotionGraphicStatus({
    Key? key,
    required this.status,
    required this.avaliations,
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
          Text(status),
          SizedBox(width: size.width * .044),
          Text("$avaliations"),
          SizedBox(width: size.width * .01744),
          _GraphicGradePercentLine(
              grade: statusGrade,
              avaliations: avaliations,
              sumOfAvaliations: sumOfAvaliations,
              size: size),
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
    double fullSize = size.width * .45;

    return Stack(
      alignment: AlignmentDirectional.centerStart,
      children: [
        Container(
          height: .5,
          width: fullSize,
          color: SafeColors.componentsColors.emotionStatusColor,
        ),
        Container(
          height: 10,
          width: grade == 0
              ? 1
              : ((grade * (avaliations / sumOfAvaliations)) * fullSize) / 5,
          color: SafeColors.componentsColors.emotionStatusColor,
        ),
      ],
    );
  }
}
