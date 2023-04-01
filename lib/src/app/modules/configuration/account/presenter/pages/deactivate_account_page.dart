import 'package:flutter/material.dart';
import 'package:is_it_safe_app/generated/l10n.dart';
import 'package:is_it_safe_app/src/components/style/text/text_styles.dart';
import 'package:is_it_safe_app/src/components/widgets/safe_app_bar.dart';
import 'package:is_it_safe_app/src/components/widgets/safe_button.dart';

class DeactivateAccountPage extends StatelessWidget {
  static const String route = "/deactivateAccountPage";

  const DeactivateAccountPage({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: SafeAppBar(
        title: S.current.textDrawerMyAccount,
      ),
      body: Container(
        padding: const EdgeInsets.symmetric(horizontal: 30),
        child: SingleChildScrollView(
          child: Column(
            mainAxisAlignment: MainAxisAlignment.start,
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              const SizedBox(height: 85),
              Text(
                S.current.textWantDeactivateAccount,
                style: TextStyles.headline2(),
              ),
              Padding(
                padding: const EdgeInsets.only(top: 4),
                child: Text(
                  S.current.textWantDeactivateAccount,
                  style: TextStyles.subtitle1(),
                ),
              ),
              const SizedBox(height: 100),
              SafeButton(
                title: S.current.textDeactivateAccount,
                size: ButtonSize.large,
                onTap: () async {},
              ),
            ],
          ),
        ),
      ),
    );
  }
}
