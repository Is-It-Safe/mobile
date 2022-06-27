import 'package:flutter/material.dart';
import 'package:flutter_modular/flutter_modular.dart';
import 'package:is_it_safe_app/src/app/app_module.dart';
import 'package:is_it_safe_app/src/app/app_widget.dart';

import 'package:provider/provider.dart';

import 'src/components/theme/theme_state.dart';

void main() => runApp(
      ChangeNotifierProvider<ThemeState>(
        create: (context) => ThemeState(),
        child: ModularApp(
          module: AppModule(),
          child: const AppWidget(),
        ),
      ),
    );
