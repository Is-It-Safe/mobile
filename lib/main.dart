import 'package:catcher_2/catcher_2.dart';
import 'package:flutter/material.dart';
import 'package:flutter_modular/flutter_modular.dart';
import 'package:is_it_safe_app/src/app/app_module.dart';
import 'package:is_it_safe_app/src/app/app_widget.dart';
import 'package:is_it_safe_app/src/components/widgets/safe_error_details.dart';
import 'package:is_it_safe_app/src/core/util/flavor_util.dart';
import 'package:is_it_safe_app/src/service/api/constants/api_constants.dart';
import 'package:overlay_support/overlay_support.dart';
import 'package:firebase_core/firebase_core.dart';
import 'firebase_options.dart';

import 'package:provider/provider.dart';

import 'src/components/theme/theme_state.dart';

Future<void> main() async {
  WidgetsFlutterBinding.ensureInitialized();
  await Firebase.initializeApp(
    options: DefaultFirebaseOptions.currentPlatform,
  );

  FlavorUtil.setup(FlavorUtil.prod);

  Catcher2Options releaseOptions = Catcher2Options(SilentReportMode(), [
    DiscordHandler(
      ApiConstants.kDiscordMonitoringWebhook,
      enableStackTrace: false,
      enableApplicationParameters: true,
      enableDeviceParameters: true,
    ),
  ]);

  /// Substituindo tela vermelha/cinza por widget customizado.
  ErrorWidget.builder = (details) => SafeErrorDetails(errorDetails: details);

  Catcher2(
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
    releaseConfig: releaseOptions,
  );
}
