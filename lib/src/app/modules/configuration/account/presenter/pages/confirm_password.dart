import 'package:flutter/material.dart';
import 'package:flutter_modular/flutter_modular.dart';
import 'package:is_it_safe_app/src/components/style/text/text_styles.dart';
import 'package:is_it_safe_app/src/l10n/l10n.dart';
import 'package:is_it_safe_app/src/components/widgets/safe_app_bar.dart';
import 'package:is_it_safe_app/src/components/widgets/safe_button.dart';
import 'package:is_it_safe_app/src/components/widgets/safe_snack_bar.dart';
import 'package:is_it_safe_app/src/components/widgets/safe_text_form_field.dart';

import '../../../../../../components/widgets/safe_show_field_button.dart';

class ConfirmPassword extends StatefulWidget {
  const ConfirmPassword({Key? key}) : super(key: key);

  @override
  State<ConfirmPassword> createState() => _ConfirmPasswordState();
}

class _ConfirmPasswordState extends State<ConfirmPassword> {
  final _formKey = GlobalKey<FormState>();
  bool _showPassword = true;
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: SafeAppBar(
        title: S.current.textConfiguration,
      ),
      body: Padding(
        padding: const EdgeInsets.symmetric(horizontal: 30),
        child: Column(
          mainAxisAlignment: MainAxisAlignment.start,
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Padding(
              padding: const EdgeInsets.only(top: 114),
              child: Text(
                S.current.textConfirmPassword,
                style: TextStyles.headline2(),
              ),
            ),
            Padding(
              padding: const EdgeInsets.only(top: 4),
              child: Text.rich(
                TextSpan(
                  text: "${S.current.textReenterPassword1_0}\n",
                  style: TextStyles.subtitle1(), // default text style
                  children: <TextSpan>[
                    TextSpan(
                      text: S.current.textReenterPassword1_1,
                    ),
                  ],
                ),
              ),
            ),
            Padding(
              padding: const EdgeInsets.only(top: 46, bottom: 9.29),
              child: Text(
                S.current.textConfirmCurrentPassword,
                style: TextStyles.bodyText1(),
              ),
            ),
            Form(
              child: Form(
                key: _formKey,
                child: _mountPasswordField(),
              ),
            ),
            Padding(
              padding: const EdgeInsets.only(top: 250),
              child: Row(
                mainAxisAlignment: MainAxisAlignment.spaceBetween,
                children: [
                  SizedBox(
                    child: SafeButton(
                      size: ButtonSize.small,
                      title: S.current.textCancel,
                      hasBackground: false,
                      onTap: () => Modular.to.pop(),
                    ),
                  ),
                  SizedBox(
                    child: SafeButton(
                      title: S.current.textAdvance,
                      onTap: () {
                        if (context == context) {
                          SafeSnackBar(
                            message: S.current.textErrorConfirmPassword,
                            type: SnackBarType.error,
                          ).show(context);
                        }
                        Modular.to.pop();
                      },
                      hasBorder: true,
                      hasBackground: false,
                      size: ButtonSize.small,
                    ),
                  ),
                ],
              ),
            ),
          ],
        ),
      ),
    );
  }

  Widget _mountPasswordField() {
    return SafeTextFormField(
      labelText: S.current.textPassword,
      obscureText: _showPassword,
      suffixIcon: SafeShowFieldButton(
        value: _showPassword,
        onTap: () => setState(() {
          _showPassword = !_showPassword;
        }),
      ),
    );
  }
}
