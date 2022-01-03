import 'package:flutter/material.dart';
import 'package:flutter_localizations/flutter_localizations.dart';
import 'package:flutter_modular/flutter_modular.dart';
import 'package:is_it_safe_app/core/utils/style/themes/dark_theme.dart';
import 'package:is_it_safe_app/core/utils/style/themes/light_theme.dart';
import 'package:is_it_safe_app/core/utils/style/themes/theme_state.dart';
import 'package:is_it_safe_app/generated/l10n.dart';
import 'package:provider/provider.dart';

class AppWidget extends StatelessWidget {
  const AppWidget({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      debugShowCheckedModeBanner: false,
      title: 'Is It Safe?',
      theme:
          // Provider.of<ThemeState>(context).theme == ThemeType.DARK
          //     ? darkTheme
          //     :
          lightTheme,
      localizationsDelegates: const [
        S.delegate,
        GlobalMaterialLocalizations.delegate,  
        GlobalWidgetsLocalizations.delegate,
        GlobalCupertinoLocalizations.delegate,
      ],
      supportedLocales: const [
        Locale('pt', 'BR'),
      ],
    ).modular();
  }
}
