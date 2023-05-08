import 'package:flutter/material.dart';
import 'package:flutter_flavor/flutter_flavor.dart';
import 'package:flutter_localizations/flutter_localizations.dart';
import 'package:flutter_modular/flutter_modular.dart';
import 'package:is_it_safe_app/generated/l10n.dart';
import 'package:is_it_safe_app/src/components/theme/light_theme.dart';
import 'package:is_it_safe_app/src/core/util/flavor_util.dart';

class AppWidget extends StatelessWidget {
  const AppWidget({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return FlavorBanner(
      color: FlavorUtil.instance.bannerColor,
      location: FlavorUtil.instance.bannerLocation,
      child: MaterialApp.router(
        routerDelegate: Modular.routerDelegate,
        routeInformationParser: Modular.routeInformationParser,
        debugShowCheckedModeBanner: true,
        title: FlavorUtil.instance.appName,
        theme: lightTheme,
        supportedLocales: S.delegate.supportedLocales,
        localizationsDelegates: const [
          S.delegate,
          GlobalMaterialLocalizations.delegate,
          GlobalWidgetsLocalizations.delegate,
          GlobalCupertinoLocalizations.delegate,
        ],
      ),
    );
  }
}
