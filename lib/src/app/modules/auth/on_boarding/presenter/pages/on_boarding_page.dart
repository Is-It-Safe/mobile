import 'package:flutter/material.dart';
import 'package:is_it_safe_app/src/app/modules/auth/on_boarding/presenter/widgets/on_boarding_text_widget.dart';
import 'package:is_it_safe_app/src/core/state/safe_state.dart';
import 'package:is_it_safe_app/src/components/style/colors/safe_colors.dart';
import 'package:is_it_safe_app/src/app/modules/auth/on_boarding/presenter/bloc/on_boarding_bloc.dart';
import 'package:is_it_safe_app/src/app/modules/auth/on_boarding/presenter/widgets/on_boarding_widget.dart';
import 'package:is_it_safe_app/src/core/constants/assets_constants.dart';
import 'package:smooth_page_indicator/smooth_page_indicator.dart';

class OnBoardingPage extends StatefulWidget {
  static const route = '/onBoarding/';
  const OnBoardingPage({Key? key}) : super(key: key);

  @override
  State<OnBoardingPage> createState() => _OnBoardingPageState();
}

class _OnBoardingPageState extends SafeState<OnBoardingPage, OnBoardingBloc> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Stack(
        children: [
          PageView(
            controller: bloc.onBoardingPageController,
            children: [
              OnBoardingWidget(
                backgroundImage: AssetConstants.general.onBoarding1,
                text: const TextOnBoarding1(),
                onButtonPressed: bloc.onSkipButtonPressed,
              ),
              OnBoardingWidget(
                backgroundImage: AssetConstants.general.onBoarding2,
                text: const TextOnBoarding2(),
                onButtonPressed: bloc.onSkipButtonPressed,
              ),
              OnBoardingWidget(
                backgroundImage: AssetConstants.general.onBoarding3,
                text: const TextOnBoarding3(),
                isButtonVisible: true,
                onButtonPressed: bloc.onSkipButtonPressed,
              ),
            ],
          ),
          Align(
            alignment: Alignment.bottomCenter,
            child: Padding(
              padding: const EdgeInsets.all(30.0),
              child: SmoothPageIndicator(
                controller: bloc.onBoardingPageController,
                count: 3,
                effect: ExpandingDotsEffect(
                  activeDotColor:
                      SafeColors.componentsColors.smoothPageIndicatorColor,
                  dotColor:
                      SafeColors.componentsColors.smoothPageIndicatorColor,
                ),
              ),
            ),
          ),
        ],
      ),
    );
  }
}
