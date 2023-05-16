import 'dart:async';

import 'package:flutter/material.dart';
import 'package:flutter_modular/flutter_modular.dart';
import 'package:is_it_safe_app/src/app/modules/configuration/account/presenter/bloc/change_password_bloc.dart';
import 'package:is_it_safe_app/src/components/style/text/text_styles.dart';
import 'package:is_it_safe_app/generated/l10n.dart';
import 'package:is_it_safe_app/src/components/widgets/safe_app_bar.dart';
import 'package:is_it_safe_app/src/components/widgets/safe_button.dart';
import 'package:is_it_safe_app/src/components/widgets/safe_show_field_button.dart';
import 'package:is_it_safe_app/src/components/widgets/safe_text_form_field.dart';
import 'package:is_it_safe_app/src/core/constants/string_constants.dart';
import 'package:is_it_safe_app/src/core/state/safe_builder.dart';
import 'package:is_it_safe_app/src/core/state/safe_state.dart';

class ConfirmPassword extends StatefulWidget {
  const ConfirmPassword({Key? key}) : super(key: key);

  @override
  State<ConfirmPassword> createState() => _ConfirmPasswordState();
}

class _ConfirmPasswordState
    extends SafeState<ConfirmPassword, ChangePasswordBloC> {
  final _formKey = GlobalKey<FormState>();
  final _scaffoldKey = Modular.get<GlobalKey<ScaffoldState>>();
  bool _showPassword = true;
  Timer? debounce;

  @override
  void initState() {
    super.initState();
    _confirmPasswordListener();
  }

  Future<void> _confirmPasswordListener() async {
    bloc.confirmPasswordText.addListener(() async {
      if (debounce?.isActive ?? false) debounce?.cancel();
      debounce = Timer(const Duration(milliseconds: 700), () async {
        if (bloc.confirmPasswordText.text.isNotEmpty ||
            bloc.confirmPasswordText.value.text.isNotEmpty) {
          await bloc.confirmPassword(password: bloc.confirmPasswordText.text);
          if (bloc.isPasswordValid.data) {
            setState(() {});
          }
        }
      });
    });
  }

  @override
  Widget build(BuildContext context) {
    super.build(context);
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
                    style: TextStyles.subtitle1(),
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
                  controller: bloc.confirmPasswordText,
                  labelText: S.current.textPassword,
                  obscureText: _showPassword,
                  obscuringCharacter: StringConstants.asterisk,
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
                  SafeBuilder<bool>(
                    stream: bloc.isPasswordValid,
                    builder: (isPasswordValid) {
                      return SizedBox(
                        child: SafeButton(
                          title: S.current.textAdvance,
                          state: isPasswordValid
                              ? ButtonState.rest
                              : ButtonState.disabled,
                          onTap: isPasswordValid
                              ? () => bloc.navigateToChangePassword()
                              : () {},
                          hasBorder: true,
                          hasBackground: false,
                          size: ButtonSize.small,
                        ),
                      );
                    },
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
