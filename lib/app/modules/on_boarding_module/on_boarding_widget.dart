import 'package:flutter/material.dart';
import 'package:flutter_modular/flutter_modular.dart';
import 'package:is_it_safe_app/app/modules/on_boarding_module/components/on_boarding_page_template.dart';
import 'package:is_it_safe_app/core/utils/style/themes/text_styles.dart';
import 'package:is_it_safe_app/generated/l10n.dart';
import 'package:smooth_page_indicator/smooth_page_indicator.dart';

import 'on_boarding_bloc.dart';
import 'dart:developer' as dev;

class OnBoardingWidget extends StatefulWidget {
  const OnBoardingWidget({Key? key}) : super(key: key);

  @override
  _OnBoardingWidgetState createState() => _OnBoardingWidgetState();
}

class _OnBoardingWidgetState
    extends ModularState<OnBoardingWidget, OnBoardingBloc> {
  final PageController _pageController = PageController(initialPage: 0);

  @override
  void initState() {
    super.initState();
    dev.log(Modular.to.path, name: "PATH");
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Stack(
        children: [
          PageView(
            controller: _pageController,
            children: [
              OnBoardingPageTemplate(
                imagePath: "images/app/on_boarding/onBoarding1.png",
                text: _textPage1(),
                haveButton: false,
              ),
              OnBoardingPageTemplate(
                imagePath: "images/app/on_boarding/onBoarding2.png",
                text: _textPage2(),
                haveButton: false,
              ),
              OnBoardingPageTemplate(
                imagePath: "images/app/on_boarding/onBoarding3.png",
                text: _textPage3(),
                haveButton: true,
              ),
            ],
          ),
          Align(
            alignment: Alignment.bottomCenter,
            child: Padding(
              padding: const EdgeInsets.all(30.0),
              child: SmoothPageIndicator(
                controller: _pageController,
                effect: const ExpandingDotsEffect(
                  activeDotColor: Color(0xFFE9E9E9),
                  dotColor: Color(0xFFE9E9E9),
                ),
                count: 3,
              ),
            ),
          ),
        ],
      ),
    );
  }

  RichText _textPage1() {
    return RichText(
      text: TextSpan(
        children: [
          TextSpan(
            text: "${S.of(context).textOnBoarding1_0} ",
            style: TextStyles.custom(
              color: Colors.white,
              fontSize: 34,
            ),
          ),
          TextSpan(
            text: "${S.of(context).textOnBoarding1_1} ",
            style: TextStyles.custom(
              color: Colors.white,
              fontWeight: FontWeight.bold,
              fontSize: 34,
            ),
          ),
          TextSpan(
            text: "${S.of(context).textOnBoarding1_2} ",
            style: TextStyles.custom(
              color: Colors.white,
              fontSize: 34,
            ),
          ),
          TextSpan(
            text: "${S.of(context).textOnBoarding1_3}.",
            style: TextStyles.custom(
              color: Colors.white,
              fontWeight: FontWeight.bold,
              fontSize: 34,
            ),
          ),
        ],
      ),
    );
  }

  RichText _textPage2() {
    return RichText(
      text: TextSpan(
        children: [
          TextSpan(
            text: "${S.of(context).textOnBoarding2_0} ",
            style: TextStyles.custom(
              color: Colors.white,
              fontSize: 34,
            ),
          ),
          TextSpan(
            text: "${S.of(context).textOnBoarding2_1}.",
            style: TextStyles.custom(
              color: Colors.white,
              fontWeight: FontWeight.bold,
              fontSize: 34,
            ),
          ),
        ],
      ),
    );
  }

  RichText _textPage3() {
    return RichText(
      text: TextSpan(
        children: [
          TextSpan(
            text: "${S.of(context).textOnBoarding3_0} ",
            style: TextStyles.custom(
              color: Colors.white,
              fontSize: 34,
            ),
          ),
          TextSpan(
            text: "${S.of(context).textOnBoarding3_1} ",
            style: TextStyles.custom(
              color: Colors.white,
              fontWeight: FontWeight.bold,
              fontSize: 34,
            ),
          ),
          TextSpan(
            text: "${S.of(context).textOnBoarding3_2}.",
            style: TextStyles.custom(
              color: Colors.white,
              fontSize: 34,
            ),
          ),
        ],
      ),
    );
  }
}
