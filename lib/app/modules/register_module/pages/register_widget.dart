import 'package:flutter/gestures.dart';
import 'package:flutter/material.dart';
import 'package:flutter_modular/flutter_modular.dart';
import 'package:is_it_safe_app/app/modules/register_module/register_bloc.dart';
import 'package:is_it_safe_app/core/components/app_bar.dart';
import 'package:is_it_safe_app/core/components/main_button.dart';
import 'package:is_it_safe_app/core/components/main_text_field.dart';
import 'package:is_it_safe_app/core/components/show_field_button.dart';
import 'package:is_it_safe_app/core/utils/constants/routes.dart';
import 'package:is_it_safe_app/core/utils/helper/helpers.dart';
import 'package:is_it_safe_app/core/utils/style/colors/dark_theme_colors.dart';
import 'package:is_it_safe_app/core/utils/style/colors/general_colors.dart';
import 'package:is_it_safe_app/core/utils/style/colors/light_theme_colors.dart';
import 'package:is_it_safe_app/generated/l10n.dart';

import 'dart:developer' as dev;

class RegisterWidget extends StatefulWidget {
  const RegisterWidget({Key? key}) : super(key: key);

  @override
  _RegisterWidgetState createState() => _RegisterWidgetState();
}

class _RegisterWidgetState extends ModularState<RegisterWidget, RegisterBloc> {
  final _scaffoldKey = GlobalKey<ScaffoldState>();
  final _formKey = GlobalKey<FormState>();
  bool _obscurePassword = true;

  @override
  void initState() {
    super.initState();
    dev.log(Modular.to.path, name: "PATH");
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      key: _scaffoldKey,
      appBar: appBar(
        context: context,
        hasLeading: true,
        title: S.of(context).textAppBarSignUp,
      ),
      body: SafeArea(
        child: SingleChildScrollView(
          child: Padding(
            padding: const EdgeInsets.symmetric(horizontal: 30.0),
            child: Form(
              key: _formKey,
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  // ThemeSwitch(),

                  /// Title and Subtitle
                  Padding(
                    padding: const EdgeInsets.only(top: 30, bottom: 24),
                    child: RichText(
                      text: TextSpan(
                        children: [
                          TextSpan(
                            text: '${S.of(context).textWelcome}\n',
                            style:
                                Theme.of(context).textTheme.headline4!.copyWith(
                                      fontWeight: FontWeight.bold,
                                    ),
                          ),
                          TextSpan(
                            text: S.of(context).textMeetingYouWillBeAPleasure,
                            style: Theme.of(context).textTheme.headline5!,
                          ),
                        ],
                      ),
                    ),
                  ),

                  ///Name Field
                  MainTextField(
                    padding: const EdgeInsets.only(bottom: 18),
                    controller: controller.nameController,
                    hintText: "${S.of(context).textName}*",
                    changeLabelColor: false,
                    validator: (value) {
                      if (value == null) {
                        return S.of(context).textErrorEmptyField;
                      }
                      if (!Helpers.validateName(value)) {
                        return S.of(context).textErrorEmptyField;
                      } else {
                        return null;
                      }
                    },
                    onChanged: (value) {
                      controller.enableRegisterButton();
                    },
                  ),

                  ///Username Field
                  MainTextField(
                    padding: const EdgeInsets.only(bottom: 8),
                    controller: controller.userNameController,
                    changeLabelColor: false,
                    hintText: "${S.of(context).textUsername}*",
                    validator: (value) {
                      if (value == null) {
                        return S.of(context).textErrorEmptyField;
                      }
                      if (!Helpers.validateName(value)) {
                        return S.of(context).textErrorEmptyField;
                      } else {
                        return null;
                      }
                    },
                    onChanged: (value) {
                      controller.enableRegisterButton();
                    },
                  ),

                  ///Dont be afraid to be creative
                  Align(
                    alignment: Alignment.centerRight,
                    child: Padding(
                      padding: const EdgeInsets.only(top: 8.0),
                      child: Text(
                        S.of(context).textDontBeAfraidToBeCreative,
                        style: Theme.of(context).textTheme.bodyText1!.copyWith(
                              fontWeight: FontWeight.w500,
                              fontSize: 12,
                              color: Helpers.getColorFromTheme(
                                context: context,
                                darkModeColor: primaryTextColorDark,
                                lightModeColor: greyTextColorLight,
                              ),
                            ),
                      ),
                    ),
                  ),

                  ///Pronouns Field
                  MainTextField(
                    padding: const EdgeInsets.only(top: 20),
                    controller: controller.pronoumsController,
                    hintText: S.of(context).textPronouns,
                    validator: (value) {},
                    onChanged: (value) {
                      controller.enableRegisterButton();
                    },
                    labelText: S.of(context).textExamplePronouns,
                    changeLabelColor: true,
                  ),

                  ///How do you prefer people refer to you?
                  Align(
                    alignment: Alignment.centerRight,
                    child: Padding(
                      padding: const EdgeInsets.only(top: 16.0),
                      child: Text(
                        S.of(context).textHowDoYouPreferWeReferToYou,
                        textAlign: TextAlign.end,
                        style: Theme.of(context).textTheme.bodyText1!.copyWith(
                              fontWeight: FontWeight.w500,
                              fontSize: 12,
                              color: Helpers.getColorFromTheme(
                                context: context,
                                darkModeColor: primaryTextColorDark,
                                lightModeColor: greyTextColorLight,
                              ),
                            ),
                      ),
                    ),
                  ),

                  ///Email field
                  MainTextField(
                    padding: const EdgeInsets.only(top: 20),
                    controller: controller.emailController,
                    changeLabelColor: false,
                    hintText: "${S.of(context).textEmailAddress}*",
                    validator: (value) {
                      if (value == null) {
                        return S.of(context).textErrorEmail;
                      }
                      if (!Helpers.validateEmail(value)) {
                        return S.of(context).textErrorEmail;
                      } else {
                        return null;
                      }
                    },
                    onChanged: (value) {
                      controller.enableRegisterButton();
                    },
                  ),

                  ///Password field
                  MainTextField(
                    padding: const EdgeInsets.only(top: 20),
                    controller: controller.passwordController,
                    hintText: "${S.of(context).textPassword}*",
                    validator: (value) {
                      if (value == null) {
                        return S.of(context).textErrorLoginPassword;
                      }
                      if (!Helpers.validatePassword(value)) {
                        return S.of(context).textErrorLoginPassword;
                      } else {
                        return null;
                      }
                    },
                    onChanged: (value) => controller.enableRegisterButton(),
                    changeLabelColor: false,
                    isObscure: _obscurePassword,
                    suffixIcon: ShowFieldButton(
                      isDisplayed: _obscurePassword,
                      onTap: () => setState(() {
                        _obscurePassword = !_obscurePassword;
                      }),
                    ),
                  ),

                  ///We care about your safety, so...
                  Align(
                    alignment: Alignment.centerRight,
                    child: Padding(
                      padding: const EdgeInsets.only(top: 16),
                      child: RichText(
                        textAlign: TextAlign.end,
                        text: TextSpan(
                          children: [
                            TextSpan(
                              text: S.of(context).textWeCareAboutYourSafety,
                              style: Theme.of(context)
                                  .textTheme
                                  .bodyText1!
                                  .copyWith(
                                    fontWeight: FontWeight.w500,
                                    fontSize: 12,
                                    color: Helpers.getColorFromTheme(
                                      context: context,
                                      darkModeColor: primaryTextColorDark,
                                      lightModeColor: greyTextColorLight,
                                    ),
                                  ),
                            ),
                            TextSpan(
                              text:
                                  '\n- ${S.of(context).textAtLeast8Characteres}',
                              style: Theme.of(context)
                                  .textTheme
                                  .bodyText1!
                                  .copyWith(
                                    fontWeight: FontWeight.w500,
                                    fontSize: 12,
                                    color: Helpers.getColorFromTheme(
                                      context: context,
                                      darkModeColor: primaryTextColorDark,
                                      lightModeColor: greyTextColorLight,
                                    ),
                                  ),
                            ),
                            TextSpan(
                              text:
                                  '\n- ${S.of(context).textLettersAndNumbers}',
                              style: Theme.of(context)
                                  .textTheme
                                  .bodyText1!
                                  .copyWith(
                                    fontWeight: FontWeight.w500,
                                    fontSize: 12,
                                    color: Helpers.getColorFromTheme(
                                      context: context,
                                      darkModeColor: primaryTextColorDark,
                                      lightModeColor: greyTextColorLight,
                                    ),
                                  ),
                            ),
                          ],
                        ),
                      ),
                    ),
                  ),

                  ///Confirm password Field
                  MainTextField(
                    padding: const EdgeInsets.only(top: 24),
                    controller: controller.confirmPasswordController,
                    hintText: "${S.of(context).textPasswordConfirmation}*",
                    validator: (value) {
                      if (value == null) {
                        return S.of(context).textErrorDifferentPasswords;
                      }
                      if (!Helpers.validatePassword(value) ||
                          controller.passwordController.text !=
                              controller.confirmPasswordController.text) {
                        return S.of(context).textErrorDifferentPasswords;
                      } else {
                        return null;
                      }
                    },
                    onChanged: (value) {
                      controller.enableRegisterButton();
                    },
                    changeLabelColor: false,
                    isObscure: _obscurePassword,
                    suffixIcon: ShowFieldButton(
                      isDisplayed: _obscurePassword,
                      onTap: () => setState(() {
                        _obscurePassword = !_obscurePassword;
                      }),
                    ),
                  ),

                  ///I've read and accept the terms
                  Padding(
                    padding: const EdgeInsets.only(top: 30),
                    child: Row(
                      children: [
                        Checkbox(
                          value: controller.termsAndConditionsCheckbox,
                          activeColor: Theme.of(context).primaryColor,
                          side: BorderSide(
                            color: Helpers.getColorFromTheme(
                                context: context,
                                darkModeColor: primaryTextColorDark,
                                lightModeColor: greyTextColorLight),
                            width: 2,
                          ),
                          onChanged: (value) => setState(() {
                            controller.termsAndConditionsCheckbox =
                                !controller.termsAndConditionsCheckbox;
                            controller.enableRegisterButton();
                          }),
                        ),
                        Expanded(
                          child: RichText(
                            overflow: TextOverflow.fade,
                            text: TextSpan(
                              children: [
                                TextSpan(
                                  text: S.of(context).textIReadAndAcceptThe,
                                  style: Theme.of(context)
                                      .textTheme
                                      .bodyText1!
                                      .copyWith(
                                        fontWeight: FontWeight.w500,
                                        fontSize: 12,
                                        color: Helpers.getColorFromTheme(
                                          context: context,
                                          darkModeColor: primaryTextColorDark,
                                          lightModeColor: greyTextColorLight,
                                        ),
                                      ),
                                ),
                                TextSpan(
                                  recognizer: TapGestureRecognizer()
                                    ..onTap = () {
                                      //TODO Navegação para termos de uso e condições
                                    },
                                  text: S.of(context).textTermsAndConditions +
                                      "*",
                                  style: Theme.of(context)
                                      .textTheme
                                      .bodyText1!
                                      .copyWith(
                                        fontWeight: FontWeight.w500,
                                        fontSize: 12,
                                        decoration: TextDecoration.underline,
                                        color: Helpers.getColorFromTheme(
                                          context: context,
                                          darkModeColor: inputFocusedColor,
                                          lightModeColor: inputFocusedColor,
                                        ),
                                      ),
                                ),
                              ],
                            ),
                          ),
                        ),
                      ],
                    ),
                  ),

                  ///Register Buttom
                  Padding(
                    padding: const EdgeInsets.only(top: 24, bottom: 16),
                    child: StreamBuilder<bool>(
                        stream: controller.registerButtonController.stream,
                        initialData: false,
                        builder: (context, snapshot) {
                          return MainButton(
                              text: S.of(context).textRegister,
                              color: snapshot.data == false
                                  ? Theme.of(context).disabledColor
                                  : null,
                              onTap: () {
                                _formKey.currentState?.validate();
                                if (snapshot.data == true) {
                                  Modular.to.pushNamed(kRouteRegisterProfile);
                                }
                              });
                        }),
                  ),
                ],
              ),
            ),
          ),
        ),
      ),
    );
  }
}
