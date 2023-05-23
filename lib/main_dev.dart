import 'package:catcher/catcher.dart';
import 'package:flutter/material.dart';
import 'package:flutter_modular/flutter_modular.dart';
import 'package:is_it_safe_app/src/app/app_module.dart';
import 'package:is_it_safe_app/src/app/app_widget.dart';
import 'package:is_it_safe_app/src/components/widgets/safe_error_details.dart';
import 'package:is_it_safe_app/src/core/util/flavor_util.dart';
import 'package:overlay_support/overlay_support.dart';

import 'package:provider/provider.dart';

import 'src/components/theme/theme_state.dart';

void main() {
  WidgetsFlutterBinding.ensureInitialized();

  FlavorUtil.setup(FlavorUtil.dev);

  CatcherOptions debugOptions = CatcherOptions(SilentReportMode(), [
    ConsoleHandler(
      enableApplicationParameters: true,
      enableDeviceParameters: false,
      enableStackTrace: true,
    ),
  ]);

  /// Substituindo tela vermelha/cinza por widget customizado.
  ErrorWidget.builder = (details) => SafeErrorDetails(errorDetails: details);

  Catcher(
    runAppFunction: () => runApp(
      ChangeNotifierProvider<ThemeState>(
        create: (context) => ThemeState(),
        child: OverlaySupport.global(
          child: ModularApp(
            module: AppModule(),
            child: const AppWidget(),
          ),
        ),
      ),
    ),
    debugConfig: debugOptions,
  );
}