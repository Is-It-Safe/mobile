import 'package:flutter/material.dart';
import 'package:is_it_safe_app/app_widget.dart';
import 'package:is_it_safe_app/src/app/components/theme/theme_state.dart';
import 'package:provider/provider.dart';

void main() => runApp(
      ChangeNotifierProvider<ThemeState>(
        create: (context) => ThemeState(),
        child: const AppWidget(),
      ),
    );
