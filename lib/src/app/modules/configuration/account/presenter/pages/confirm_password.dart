import 'dart:async';

import 'package:flutter/material.dart';
import 'package:flutter_modular/flutter_modular.dart';
import 'package:is_it_safe_app/src/app/modules/configuration/account/presenter/bloc/change_password_bloc.dart';
import 'package:is_it_safe_app/src/components/style/text/text_styles.dart';
import 'package:is_it_safe_app/generated/l10n.dart';
import 'package:is_it_safe_app/src/components/widgets/safe_app_bar.dart';
import 'package:is_it_safe_app/src/components/widgets/safe_button.dart';
import 'package:is_it_safe_app/src/components/widgets/safe_text_form_field.dart';

import '../../../../../../components/widgets/safe_show_field_button.dart';
import 'change_password_page.dart';

class ConfirmPassword extends StatefulWidget {
  const ConfirmPassword({Key? key}) : super(key: key);

  @override
  State<ConfirmPassword> createState() => _ConfirmPasswordState();
}

class _ConfirmPasswordState extends State<ConfirmPassword> {
  final controller = Modular.get<ChangePasswordBloC>();

  Timer? debounce;

  @override
  void initState() {
    super.initState();
    controller.confirmPasswordText.addListener(() async {
      if (debounce?.isActive ?? false) debounce?.cancel();
      debounce = Timer(const Duration(milliseconds: 700), () async {
        if (controller.confirmPasswordText.text.isNotEmpty ||
            controller.confirmPasswordText.value.text.isNotEmpty) {
          await controller.confirmPassword(
              password: controller.confirmPasswordText.text);
          if (controller.validated) {
            setState(() {});
          }
        }
      });
    });
  }

  final _formKey = GlobalKey<FormState>();

  final _scaffoldKey = Modular.get<GlobalKey<ScaffoldState>>();

  bool _showPassword = true;
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      key: _scaffoldKey,
      appBar: SafeAppBar(
        title: S.current.textConfiguration,
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
                S.current.textConfirmPassword,
                style: TextStyles.headline2(),
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
                key: _formKey,
                child: SafeTextFormField(
                  controller: controller.confirmPasswordText,
                  labelText: S.current.textPassword,
                  obscureText: _showPassword,
                  obscuringCharacter: '*',
                  suffixIcon: SafeShowFieldButton(
                    value: _showPassword,
                    onTap: () => setState(() {
                      _showPassword = !_showPassword;
                    }),
                  ),
                ),
              ),
              const SizedBox(height: 200),
              Row(
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
                      state:
                          !controller.validated ? ButtonState.disabled : null,
                      onTap: () async {
                        await Modular.to
                            .pushNamed('././.${ChangePasswordPage.route}');
                      },
                      hasBorder: true,
                      hasBackground: false,
                      size: ButtonSize.small,
                    ),
                  ),
                ],
              ),
            ],
          ),
        ),
      ),
    );
  }
}
