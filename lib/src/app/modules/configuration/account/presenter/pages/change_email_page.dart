import 'package:flutter/material.dart';
import 'package:flutter_modular/flutter_modular.dart';
import 'package:is_it_safe_app/generated/l10n.dart';
import 'package:is_it_safe_app/src/app/modules/configuration/account/presenter/bloc/change_email_bloc.dart';
import 'package:is_it_safe_app/src/app/modules/configuration/account/presenter/widgets/change_email/change_email_text_widget.dart';
import 'package:is_it_safe_app/src/components/style/text/text_styles.dart';
import 'package:is_it_safe_app/src/components/widgets/safe_app_bar.dart';
import 'package:is_it_safe_app/src/components/widgets/safe_button.dart';
import 'package:is_it_safe_app/src/components/widgets/safe_text_form_field.dart';
import 'package:is_it_safe_app/src/core/state/safe_state.dart';

class ChangeEmailPage extends StatefulWidget {
  static String route = "/changeEmail";
  const ChangeEmailPage({
    Key? key,
  }) : super(key: key);

  @override
  State<ChangeEmailPage> createState() => _ChangeEmailPageState();
}

class _ChangeEmailPageState
    extends SafeState<ChangeEmailPage, ChangeEmailBloc> {
  @override
  void initState() {
    super.initState();
    bloc.getUserEmail();

    bloc.emailAddressText.addListener(() {
      setState(() {});
    });
  }

  @override
  Widget build(BuildContext context) {
    super.build(context);
    return Scaffold(
      key: Modular.get<GlobalKey<ScaffoldState>>(),
      resizeToAvoidBottomInset: false,
      appBar: SafeAppBar(
        title: S.current.textConfiguration,
      ),
      body: Container(
        padding: const EdgeInsets.symmetric(horizontal: 30),
        child: Column(
          mainAxisAlignment: MainAxisAlignment.start,
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            const SizedBox(height: 85),
            Text(
              S.current.textChangeEmail,
              style: TextStyles.headline2(),
            ),
            ChangeEmailTextWidget(
              getEmailStream: bloc.getEmailStream,
            ),
            const SizedBox(height: 69),
            SafeTextFormField(
              controller: bloc.emailAddressText,
              labelText: S.current.textEmailAddress,
              validator: (value) {
                return bloc.validateEmail(value: value);
              },
            ),
            const Spacer(),
            Row(
              mainAxisAlignment: MainAxisAlignment.spaceBetween,
              children: [
                SizedBox(
                  child: SafeButton(
                    size: ButtonSize.small,
                    title: S.current.textCancel,
                    hasBackground: false,
                    onTap: () {
                      bloc.emailAddressText.clear();
                      Modular.to.pop();
                    },
                  ),
                ),
                SizedBox(
                  child: SafeButton(
                    title: S.current.textChange,
                    state: !bloc.emailValidated ? ButtonState.disabled : null,
                    onTap: () async {
                      await bloc.changeUserEmail(bloc.emailAddressText.text);
                    },
                    hasBorder: true,
                    hasBackground: false,
                    size: ButtonSize.small,
                  ),
                ),
              ],
            ),
            const SizedBox(height: 30),
          ],
        ),
      ),
    );
  }
}
