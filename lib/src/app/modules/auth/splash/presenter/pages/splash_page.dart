import 'package:flutter/material.dart';
import 'package:is_it_safe_app/src/core/state/safe_state.dart';
import 'package:is_it_safe_app/src/l10n/l10n.dart';
import 'package:is_it_safe_app/src/components/animations/fade_animation.dart';
import 'package:is_it_safe_app/src/components/style/colors/safe_colors.dart';
import 'package:is_it_safe_app/src/components/style/text/text_styles.dart';
import 'package:is_it_safe_app/src/app/modules/auth/splash/presenter/bloc/splash_bloc.dart';
import 'package:is_it_safe_app/src/core/constants/assets_constants.dart';

class SplashPage extends StatefulWidget {
  static const route = '/splash';

  const SplashPage({Key? key}) : super(key: key);

  @override
  State<SplashPage> createState() => _SplashPageState();
}

class _SplashPageState extends SafeState<SplashPage, SplashBloc> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: SafeColors.generalColors.backgroundSplash,
      body: Center(
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            FadeAnimation(
              delay: 1,
              child: Padding(
                padding: const EdgeInsets.only(bottom: 10),
                child: Image.asset(
                  AssetConstants.general.logo,
                  height: MediaQuery.of(context).size.height * 0.2,
                ),
              ),
            ),
            FadeAnimation(
              delay: 2,
              child: Text(
                S.current.textIsItSafe,
                textAlign: TextAlign.center,
                style: TextStyles.headline1(
                  color: SafeColors.generalColors.primary,
                ),
              ),
            ),
          ],
        ),
      ),
    );
  }
}
