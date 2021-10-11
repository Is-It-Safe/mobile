import 'package:flutter/material.dart';
import 'package:flutter_modular/flutter_modular.dart';
import 'package:is_it_safe_app/core/components/on_boarding_page_template.dart';
import 'package:is_it_safe_app/generated/l10n.dart';
import 'package:smooth_page_indicator/smooth_page_indicator.dart';

import 'on_boarding_bloc.dart';

class OnBoardingWidget extends StatefulWidget {
  const OnBoardingWidget({Key? key}) : super(key: key);

  @override
  _OnBoardingWidgetState createState() => _OnBoardingWidgetState();
}

class _OnBoardingWidgetState
    extends ModularState<OnBoardingWidget, OnBoardingBloc> {
  final PageController _pageController = PageController(initialPage: 0);
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
            style: Theme.of(context).textTheme.headline4!.copyWith(
                  color: Colors.white,
                ),
          ),
          TextSpan(
            text: "${S.of(context).textOnBoarding1_1} ",
            style: Theme.of(context).textTheme.headline4!.copyWith(
                  color: Colors.white,
                  fontWeight: FontWeight.bold,
                ),
          ),
          TextSpan(
            text: "${S.of(context).textOnBoarding1_2} ",
            style: Theme.of(context).textTheme.headline4!.copyWith(
                  color: Colors.white,
                ),
          ),
          TextSpan(
            text: "${S.of(context).textOnBoarding1_3}.",
            style: Theme.of(context).textTheme.headline4!.copyWith(
                  fontWeight: FontWeight.bold,
                  color: Colors.white,
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
            style: Theme.of(context).textTheme.headline4!.copyWith(
                  color: Colors.white,
                ),
          ),
          TextSpan(
            text: "${S.of(context).textOnBoarding2_1}.",
            style: Theme.of(context).textTheme.headline4!.copyWith(
                  fontWeight: FontWeight.bold,
                  color: Colors.white,
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
            style: Theme.of(context).textTheme.headline4!.copyWith(
                  color: Colors.white,
                ),
          ),
          TextSpan(
            text: "${S.of(context).textOnBoarding3_1} ",
            style: Theme.of(context).textTheme.headline4!.copyWith(
                  color: Colors.white,
                  fontWeight: FontWeight.bold,
                ),
          ),
          TextSpan(
            text: "${S.of(context).textOnBoarding3_2}.",
            style: Theme.of(context).textTheme.headline4!.copyWith(
                  color: Colors.white,
                ),
          ),
        ],
      ),
    );
  }
}
