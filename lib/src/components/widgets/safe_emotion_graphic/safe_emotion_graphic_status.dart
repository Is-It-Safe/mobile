import 'package:flutter/material.dart';
import 'package:is_it_safe_app/src/components/style/colors/safe_colors.dart';

class SafeEmotionGraphicStatus extends StatelessWidget {
  final String status;
  final int avaliations;
  final double statusGrade;
  const SafeEmotionGraphicStatus({
    Key? key,
    required this.status,
    required this.avaliations,
    required this.statusGrade,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    final size = MediaQuery.of(context).size;
    return Row(
      children: [
        Text(status),
        Text("$avaliations"),
        _GraphicGradePercentLine(grade: statusGrade, size: size),
      ],
    );
  }
}

class _GraphicGradePercentLine extends StatelessWidget {
  final double grade;
  final Size size;
  const _GraphicGradePercentLine({
    Key? key,
    required this.grade,
    required this.size,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    double fullSize = size.width * .6;

    return Stack(
      alignment: AlignmentDirectional.centerStart,
      children: [
        Container(
          height: .5,
          width: fullSize,
          color: SafeColors.componentsColors.emotionStatusColor,
        ),
        Container(
          height: .5,
          width: (grade / fullSize),
          color: SafeColors.componentsColors.emotionStatusColor,
        ),
      ],
    );
  }
}
