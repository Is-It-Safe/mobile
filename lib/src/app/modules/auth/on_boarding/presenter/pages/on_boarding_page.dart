import 'package:flutter/material.dart';
import 'package:flutter_modular/flutter_modular.dart';
import 'package:is_it_safe_app/generated/l10n.dart';
import 'package:is_it_safe_app/src/components/style/colors/safe_colors.dart';
import 'package:is_it_safe_app/src/components/style/text/text_styles.dart';
import 'package:is_it_safe_app/src/app/modules/auth/login/presenter/pages/login_page.dart';
import 'package:is_it_safe_app/src/app/modules/auth/on_boarding/presenter/bloc/on_boarding_bloc.dart';
import 'package:is_it_safe_app/src/app/modules/auth/on_boarding/presenter/widgets/on_boarding_widget.dart';
import 'package:is_it_safe_app/src/core/constants/assets_constants.dart';
import 'package:is_it_safe_app/src/core/constants/string_constants.dart';
import 'package:is_it_safe_app/src/core/util/log_util.dart';
import 'package:smooth_page_indicator/smooth_page_indicator.dart';

class OnBoardingPage extends StatefulWidget {
  static const route = '/onBoarding';
  const OnBoardingPage({Key? key}) : super(key: key);

  @override
  State<OnBoardingPage> createState() => _OnBoardingPageState();
}

class _OnBoardingPageState
    extends ModularState<OnBoardingPage, OnBoardingBloc> {
  @override
  void initState() {
    super.initState();
    LogUtil().route(Modular.to.path);
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Stack(
        children: [
          _mountOnBoardingPages(),
          _mountPageIndicator(),
        ],
      ),
    );
  }

  PageView _mountOnBoardingPages() {
    return PageView(
      controller: controller.onBoardingPageController,
      children: [
        OnBoardingWidget(
          backgroundImage: AssetConstants.onBoarding1,
          text: _mountTextOnBoarding1(),
        ),
        OnBoardingWidget(
          backgroundImage: AssetConstants.onBoarding2,
          text: _mountTextOnBoarding2(),
        ),
        OnBoardingWidget(
          backgroundImage: AssetConstants.onBoarding3,
          text: _mountTextOnBoarding3(),
          isButtonVisible: true,
          onButtonPressed: () {
            controller.saveUserOnBoardingUseCase(true);
            Modular.to.navigate(LoginPage.route);
          },
        ),
      ],
    );
  }

  Align _mountPageIndicator() {
    return Align(
      alignment: Alignment.bottomCenter,
      child: Padding(
        padding: const EdgeInsets.all(30.0),
        child: SmoothPageIndicator(
          controller: controller.onBoardingPageController,
          count: 3,
          effect: ExpandingDotsEffect(
            activeDotColor:
                SafeColors.componentsColors.smoothPageIndicatorColor,
            dotColor: SafeColors.componentsColors.smoothPageIndicatorColor,
          ),
        ),
      ),
    );
  }

  RichText _mountTextOnBoarding1() {
    return RichText(
      text: TextSpan(
        children: [
          TextSpan(
            text: S.of(context).textOnBoarding1_0 + StringConstants.space,
            style: TextStyles.headline2(
              fontWeight: FontWeight.normal,
              color: SafeColors.textColors.white,
            ),
          ),
          TextSpan(
            text: S.of(context).textOnBoarding1_1 + StringConstants.space,
            style: TextStyles.headline2(
              color: SafeColors.textColors.white,
            ),
          ),
          TextSpan(
            text: S.of(context).textOnBoarding1_2 + StringConstants.space,
            style: TextStyles.headline2(
              fontWeight: FontWeight.normal,
              color: SafeColors.textColors.white,
            ),
          ),
          TextSpan(
            text: S.of(context).textOnBoarding1_3 + StringConstants.dot,
            style: TextStyles.headline2(
              color: SafeColors.textColors.white,
            ),
          ),
        ],
      ),
    );
  }

  RichText _mountTextOnBoarding2() {
    return RichText(
      text: TextSpan(
        children: [
          TextSpan(
            text: S.of(context).textOnBoarding2_0 + StringConstants.space,
            style: TextStyles.headline2(
              fontWeight: FontWeight.normal,
              color: SafeColors.textColors.white,
            ),
          ),
          TextSpan(
            text: S.of(context).textOnBoarding2_1 + StringConstants.dot,
            style: TextStyles.headline2(
              color: SafeColors.textColors.white,
            ),
          ),
        ],
      ),
    );
  }

  RichText _mountTextOnBoarding3() {
    return RichText(
      text: TextSpan(
        children: [
          TextSpan(
            text: S.of(context).textOnBoarding3_0 + StringConstants.space,
            style: TextStyles.headline2(
              color: SafeColors.textColors.white,
            ),
          ),
          TextSpan(
            text: S.of(context).textOnBoarding3_1 + StringConstants.space,
            style: TextStyles.headline2(
              color: SafeColors.textColors.white,
            ),
          ),
          TextSpan(
            text: S.of(context).textOnBoarding3_2 + StringConstants.dot,
            style: TextStyles.headline2(
              color: SafeColors.textColors.white,
            ),
          ),
        ],
      ),
    );
  }
}
