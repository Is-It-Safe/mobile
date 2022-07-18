import 'package:flutter/material.dart';
import 'package:is_it_safe_app/core/utils/style/themes/text_styles.dart';

class SliderText extends StatefulWidget {
  final double lineWidth;
  final double actualValue;
  final double startValue;
  final double endValue;
  final String text01;
  final String text02;
  final String text03;
  final String text04;
  final String text05;

  const SliderText({
    Key? key,
    required this.lineWidth,
    required this.actualValue,
    required this.startValue,
    required this.endValue,
    required this.text01,
    required this.text02,
    required this.text03,
    required this.text04,
    required this.text05,
  }) : super(key: key);

  @override
  State<SliderText> createState() => _SliderTextState();
}

class _SliderTextState extends State<SliderText> {
  @override
  Widget build(BuildContext context) {
    return SizedBox(
      height: widget.lineWidth * 0.08,
      child: Padding(
        padding: EdgeInsets.only(
            left: ((widget.lineWidth * 0.78) * (widget.actualValue / 5))),
        child: Row(
          mainAxisAlignment: MainAxisAlignment.start,
          children: [
            if (1 > widget.actualValue)
              SizedBox(
                width: widget.lineWidth * 0.16,
                child: Center(
                  child: FittedBox(
                    fit: BoxFit.fitWidth,
                    child: Text(widget.text01,
                        style: TextStyles.bodyText1(
                            color: const Color(0xFF190A33))),
                  ),
                ),
              )
            else if (2 > widget.actualValue && widget.actualValue >= 1)
              SizedBox(
                width: widget.lineWidth * 0.16,
                child: Center(
                  child: FittedBox(
                    fit: BoxFit.fitWidth,
                    child: Text(widget.text02,
                        style: TextStyles.bodyText1(
                            color: const Color(0xFF190A33))),
                  ),
                ),
              )
            else if (3 > widget.actualValue && widget.actualValue >= 2)
              SizedBox(
                width: widget.lineWidth * 0.16,
                child: Center(
                  child: FittedBox(
                    fit: BoxFit.fitWidth,
                    child: Text(widget.text03,
                        style: TextStyles.bodyText1(
                            color: const Color(0xFF190A33))),
                  ),
                ),
              )
            else if (4 > widget.actualValue && widget.actualValue >= 3)
              SizedBox(
                width: widget.lineWidth * 0.16,
                child: Center(
                  child: FittedBox(
                        fit: BoxFit.fitWidth,
                        child: Text(widget.text04,
                        style: TextStyles.bodyText1(color: const Color(0xFF190A33))),
                  ),
                ),
              )
            else if (widget.actualValue >= 4)
              SizedBox(
                width: widget.lineWidth * 0.16,
                child: Center(
                  child: FittedBox(
                            fit: BoxFit.fitWidth,
                            child: Text(widget.text05,
                        style: TextStyles.bodyText1(color: const Color(0xFF190A33))),
                  ),
                ),
              )
          ],
        ),
      ),
    );
  }
}
