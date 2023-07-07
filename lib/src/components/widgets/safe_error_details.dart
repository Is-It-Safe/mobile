import 'package:flutter/foundation.dart';
import 'package:flutter/material.dart';
import 'package:flutter_modular/flutter_modular.dart';
import 'package:is_it_safe_app/generated/l10n.dart';
import 'package:is_it_safe_app/src/app/modules/configuration/configuration_module.dart';
import 'package:is_it_safe_app/src/app/modules/configuration/contact/presenter/pages/contact_page.dart';
import 'package:is_it_safe_app/src/components/style/colors/safe_colors.dart';
import 'package:is_it_safe_app/src/components/style/text/text_styles.dart';
import 'package:is_it_safe_app/src/components/widgets/safe_button.dart';

class SafeErrorDetails extends StatelessWidget {
  final FlutterErrorDetails errorDetails;

  const SafeErrorDetails({
    Key? key,
    required this.errorDetails,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Material(
      color: SafeColors.generalColors.background,
      child: Center(
        child: SingleChildScrollView(
          child: Padding(
            padding: const EdgeInsets.only(top: 24.0, left: 24.0, right: 24.0),
            child: Column(
              children: [
                Padding(
                  padding: const EdgeInsets.only(bottom: 12.0),
                  child: Text(
                    S.current.textCriticalErrorPageTitle,
                    style: TextStyles.headline3(),
                  ),
                ),
                Padding(
                  padding: const EdgeInsets.only(bottom: 24.0),
                  child: Text(
                    S.current.textCriticalErrorPageBody,
                    style: TextStyles.bodyText1(),
                    textAlign: TextAlign.center,
                  ),
                ),
                Offstage(
                  offstage: kDebugMode,
                  child: Padding(
                    padding: const EdgeInsets.only(bottom: 48.0),
                    child: SafeButton(
                      title: S.current.textCriticalErrorPageGoToReport,
                      size: ButtonSize.small,
                      onTap: () => Modular.to.pushNamed(
                        ConfigurationModule.route + ContactPage.route,
                      ),
                    ),
                  ),
                ),
                Text(errorDetails.summary.value.toString())
              ],
            ),
          ),
        ),
      ),
    );
  }
}
