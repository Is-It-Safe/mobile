import 'package:flutter/material.dart';
import 'package:flutter_modular/flutter_modular.dart';
import 'package:is_it_safe_app/generated/l10n.dart';
import 'package:is_it_safe_app/src/components/animations/fade_animation.dart';
import 'package:is_it_safe_app/src/components/style/colors/safe_colors.dart';
import 'package:is_it_safe_app/src/components/style/text/text_styles.dart';
import 'package:is_it_safe_app/src/app/modules/auth/login/presenter/pages/login_page.dart';
import 'package:is_it_safe_app/src/app/modules/auth/on_boarding/presenter/pages/on_boarding_page.dart';
import 'package:is_it_safe_app/src/app/modules/auth/splash/presenter/bloc/splash_bloc.dart';
import 'package:is_it_safe_app/src/core/constants/assets_constants.dart';
import 'package:is_it_safe_app/src/core/util/log_util.dart';

class SplashPage extends StatefulWidget {
  static const route = '/splash';

  const SplashPage({Key? key}) : super(key: key);

  @override
  State<SplashPage> createState() => _SplashPageState();
}

class _SplashPageState extends ModularState<SplashPage, SplashBloc> {
  @override
  void initState() {
    super.initState();
    LogUtil().route(Modular.to.path);
    if (controller.isUserLogged) {
      goToHome();
    } else {
      goToOnBoarding();
    }
  }

  void goToHome() async {
    await Future.delayed(const Duration(seconds: 4));
    //TODO Navigate to Home
  }

  void goToOnBoarding() async {
    await Future.delayed(const Duration(seconds: 4));
    if (controller.isUserOnBoarding) {
      goToLogin();
    } else {
      Modular.to.navigate(OnBoardingPage.route);
    }
  }

  void goToLogin() async {
    Modular.to.navigate(LoginPage.route);
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: SafeColors.generalColors.backgroundSplash,
      body: Center(
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            _mountLogo(context),
            _mountTitle(),
          ],
        ),
      ),
    );
  }

  FadeAnimation _mountLogo(BuildContext context) {
    return FadeAnimation(
      delay: 1,
      child: Padding(
        padding: const EdgeInsets.only(bottom: 10),
        child: Image.asset(
          AssetConstants.logo,
          height: MediaQuery.of(context).size.height * 0.2,
        ),
      ),
    );
  }

  FadeAnimation _mountTitle() {
    return FadeAnimation(
      delay: 2,
      child: Text(
        S.current.textIsItSafe,
        textAlign: TextAlign.center,
        style: TextStyles.headline1(
          color: SafeColors.generalColors.primary,
        ),
      ),
    );
  }
}
