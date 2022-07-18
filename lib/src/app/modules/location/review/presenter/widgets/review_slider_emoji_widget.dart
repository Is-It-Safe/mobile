import 'package:flutter/material.dart';

class SliderEmoji extends StatefulWidget {
  final double lineWidth;
  final double actualValue;
  final double startValue;
  final double endValue;
  final String image01;
  final String image02;
  final String image03;
  final String image04;
  final String image05;

  const SliderEmoji({
    Key? key,
    required this.lineWidth,
    required this.actualValue,
    required this.startValue,
    required this.endValue,
    required this.image01,
    required this.image02,
    required this.image03,
    required this.image04,
    required this.image05,
  }) : super(key: key);

  @override
  State<SliderEmoji> createState() => _SliderEmojiState();
}

class _SliderEmojiState extends State<SliderEmoji> {
  @override
  Widget build(BuildContext context) {
    return SizedBox(
      height: widget.lineWidth*0.16,
      child: Padding(
        padding: EdgeInsets.only(
            left: ((widget.lineWidth*0.79) *
                (widget.actualValue / widget.endValue))),
        child: Row(
          mainAxisAlignment: MainAxisAlignment.start,
          children: [
            if (1 > widget.actualValue)
              Container(
                width: widget.lineWidth * 0.14,
                decoration: BoxDecoration(
                  image: DecorationImage(
                    image: Image.asset(
                            ('images/app/review_module/${widget.image01}'))
                        .image,
                    fit: BoxFit.contain,
                  ),
                ),
              )
            else if (2 > widget.actualValue && widget.actualValue >= 1)
              Container(
                width: widget.lineWidth * 0.14,
                decoration: BoxDecoration(
                  image: DecorationImage(
                    image: Image.asset(
                            ('images/app/review_module/${widget.image02}'))
                        .image,
                    fit: BoxFit.contain,
                  ),
                ),
              )
            else if (3 > widget.actualValue && widget.actualValue >= 2)
              Container(
                width: widget.lineWidth * 0.14,
                decoration: BoxDecoration(
                  image: DecorationImage(
                    image: Image.asset(
                            ('images/app/review_module/${widget.image03}'))
                        .image,
                    fit: BoxFit.contain,
                  ),
                ),
              )
            else if (4 > widget.actualValue && widget.actualValue >= 3)
              Container(
                width: widget.lineWidth * 0.14,
                decoration: BoxDecoration(
                  image: DecorationImage(
                    image: Image.asset(
                            ('images/app/review_module/${widget.image04}'))
                        .image,
                    fit: BoxFit.contain,
                  ),
                ),
              )
            else if (widget.actualValue >= 4)
              Container(
                width: widget.lineWidth * 0.16,
                decoration: BoxDecoration(
                  image: DecorationImage(
                    image: Image.asset(
                            ('images/app/review_module/${widget.image05}'))
                        .image,
                    fit: BoxFit.contain,
                  ),
                ),
              )
          ],
        ),
      ),
    );
  }
}
