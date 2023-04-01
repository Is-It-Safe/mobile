import 'package:flutter/material.dart';
import 'package:flutter_modular/flutter_modular.dart';
import 'package:is_it_safe_app/generated/l10n.dart';
import 'package:is_it_safe_app/src/app/modules/configuration/account/presenter/bloc/deactivate_account_bloc.dart';
import 'package:is_it_safe_app/src/components/style/text/text_styles.dart';
import 'package:is_it_safe_app/src/components/widgets/safe_app_bar.dart';
import 'package:is_it_safe_app/src/components/widgets/safe_button.dart';
import 'package:is_it_safe_app/src/core/state/safe_state.dart';

class DeactivateAccountPage extends StatefulWidget {
  static const String route = "/deactivateAccountPage";

  const DeactivateAccountPage({super.key});

  @override
  State<DeactivateAccountPage> createState() => _DeactivateAccountPageState();
}

class _DeactivateAccountPageState
    extends SafeState<DeactivateAccountPage, DeactivateAccountBloc> {
  @override
  Widget build(BuildContext context) {
    super.build(context);
    return Scaffold(
      key: Modular.get<GlobalKey<ScaffoldState>>(),
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
                  S.current.textDeactivateAccountWarnning,
                  style: TextStyles.subtitle1(),
                ),
              ),
              const SizedBox(height: 100),
              SafeButton(
                title: S.current.textDeactivateAccount,
                size: ButtonSize.large,
                onTap: () async {
                  await bloc.deactivateAccount();
                },
              ),
            ],
          ),
        ),
      ),
    );
  }
}
