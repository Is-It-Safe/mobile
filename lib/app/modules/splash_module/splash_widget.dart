import 'package:flutter/material.dart';
import 'package:flutter_modular/flutter_modular.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:is_it_safe_app/app/modules/splash_module/splash_bloc.dart';
import 'package:is_it_safe_app/core/utils/config/custom_shared_preferences.dart';
import 'package:is_it_safe_app/core/utils/constants/routes.dart';
import 'package:is_it_safe_app/core/utils/helper/log.dart';
import 'package:is_it_safe_app/core/utils/style/animations/fade_animation.dart';
import 'package:is_it_safe_app/core/utils/style/colors/general_colors.dart';
import 'package:is_it_safe_app/generated/l10n.dart';

import 'dart:developer' as dev;

class SplashWidget extends StatefulWidget {
  const SplashWidget({Key? key}) : super(key: key);

  @override
  _SplashWidgetState createState() => _SplashWidgetState();
}

class _SplashWidgetState extends ModularState<SplashWidget, SplashBloc> {
  @override
  void initState() {
    super.initState();
    dev.log(Modular.to.path, name: "PATH");
    controller.getUsuarioLogin();
    controller.splashStream.listen(
      (event) async {
        if (event) {
          Log.log(event.toString(), name: "IS USER LOGGED?");

          await Future.delayed(const Duration(seconds: 4));
          // Modular.to.navigate(kRouteHome);
        } else {
          _loadData();
        }
      },
    );
  }

  _loadData() async {
    await Future.delayed(const Duration(seconds: 4));
    await CustomSharedPreferences.readUsuarioOnBoarding().then(
      (value) async {
        Log.log(value.toString(), name: "DID USER SEE ONBOARDING?");
        if (value) {
          Modular.to.navigate(kRouteLogin);
        } else {
          Modular.to.navigate(kRouteOnBoarding);
        }
      },
    );
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: const Color(0xFF190A33),
      body: Center(
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            FadeAnimation(
              delay: 1,
              child: Padding(
                padding: const EdgeInsets.only(bottom: 10),
                child: Image.asset(
                  'images/app_icon.png',
                  height: MediaQuery.of(context).size.height * 0.3,
                ),
              ),
            ),
            FadeAnimation(
              delay: 2,
              child: Text(
                S.of(context).textIsItSafe,
                textAlign: TextAlign.center,
                style: GoogleFonts.poppins(
                  color: kColorPrimaryLight,
                  fontSize: 30,
                  fontWeight: FontWeight.bold,
                ),
              ),
            ),
          ],
        ),
      ),
    );
  }
}
